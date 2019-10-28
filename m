Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2ECCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F0221479
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390878AbfJ1QSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:18:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38805 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732236AbfJ1QSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:18:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id w3so7197377pgt.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 09:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QpmthTIEs+c5yGXXMTwUSatMm4+bH1uRyJfRSy9ZDhk=;
        b=HpqRDQZrqVt9EqHu3x4UZ/uRUFpcNYunB8IUXcgGqTiG9mzrJumjlcjS5uKhFIpt81
         9hYfz2Rj7M5vP6PK3Mr8Uzimp1xbq0Mppt6lC7tDDTGQ7wGt1S4bBNUTyEU91oX0tVKS
         7yJiJsdFMQY1vvZCiYDXuojPj9iMisFHR+yi5CZMAm/eYpAP0OVsxA8CWOjpqJyB9x+d
         cF3ynxxAgLySJEADmovRM8nlosAWEpbiKIKtvMIi/UW1G0zibTLkcnW+JWQPzub8spQy
         S5nf+QXiPb03UcDdmI1CmFqQwg6n3BBfL9rjxWQnkYx2J6h6e+YXeZuN3oRzVYo2eFrQ
         QqeA==
X-Gm-Message-State: APjAAAU5k4lo8EpSvVqbGoQvQtoAvSj+12/CaxQUdQiZe5h3GrvlgDlm
        pRGD1js20UZje+E9ZPVLeyp5+79DS+k=
X-Google-Smtp-Source: APXvYqyd9jCSleQmDl9sJd8W1fU4Txw9Q/nHfaw1bZocKNgNJqUKMT3S9+BnYVhjiJ4rddR9kCuV8w==
X-Received: by 2002:a62:1c08:: with SMTP id c8mr21981759pfc.212.1572279531274;
        Mon, 28 Oct 2019 09:18:51 -0700 (PDT)
Received: from sultan-box.localdomain ([104.200.129.62])
        by smtp.gmail.com with ESMTPSA id f26sm5206592pgf.22.2019.10.28.09.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:18:50 -0700 (PDT)
Date:   Mon, 28 Oct 2019 09:18:48 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ming Lei <ming.lei@redhat.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scatterlist: Speed up for_each_sg() loop macro
Message-ID: <20191028161848.GA32593@sultan-box.localdomain>
References: <20191025213359.7538-1-sultan@kerneltoast.com>
 <20191028141734.GD29652@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028141734.GD29652@ziepe.ca>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 11:17:34AM -0300, Jason Gunthorpe wrote:
> This is a big change in the algorithm, why are you sure it is OK?

I'm sure it's OK because the test module I provided in the commit message
encapsulates all the possible edge cases of sg chaining:
-An sglist with >=1 && <=(SG_MAX_SINGLE_ALLOC-1) nents (no chaining, the last
 element in the array is unused)
-An sglist with SG_MAX_SINGLE_ALLOC nents (no chaining, the last element in the
 array isn't an sg chain link)
-An sglist with >SG_MAX_SINGLE_ALLOC && <=2*(SG_MAX_SINGLE_ALLOC-1) nents (there
 is one chain to another array, and the other array's last element is unused)
-An sglist with (2*SG_MAX_SINGLE_ALLOC)-1 nents (there is one chain to another
 array, and the other array's last element isn't an sg chain link)
-An sglist with 2*SG_MAX_SINGLE_ALLOC nents (there are two chains to other
 arrays, and the 3rd array contains 2 sgs & its last element is unused)
-An sglist with >2*SG_MAX_SINGLE_ALLOC && <(3*SG_MAX_SINGLE_ALLOC)-1 nents
 (there are two chains to other arrays, and the 3rd array's last element isn't
 an sg chain)

I just made my module test nents >=1 && <=3*SG_MAX_SINGLE_ALLOC for simplicity.
My proposed for_each_sg() also handles nents==0 the same as before by doing
nothing.

> Did you compare with just inlining sg_net?

Yes. Forcefully inlining sg_next() had no impact on performance.

Sultan
