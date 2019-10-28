Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA73CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD49214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PRb1nelP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390891AbfJ1QXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:23:23 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46724 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbfJ1QXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:23:22 -0400
Received: by mail-qt1-f194.google.com with SMTP id u22so15342613qtq.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 09:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ghgZezvv9fwHiSgWNtPdvDWZAZD8rMK2AMplAo4xWgQ=;
        b=PRb1nelPzdzhqbUuPITp7umzHmdI68Zlolt1BBrgB6GP9NL0KGRvLz+3qb8eRT7sgi
         OnzvEuEuTXR0/GSe8sCghrBNWKc1BE0vZOh9Ugt1zlB78YHk9GbQI+mMlOnv4/InT2Gc
         dte4+zTmWDAh21qVBIyDbqItXzczpEpLDTA5nvTOr/0ISA5bhi3RUOnAETK5XIwUzKoA
         iSelJESpTEO7fEBr8KzHAnJOYlrrB6xKMaexUuZf60QplGn+1Fh53yygF2wWlNXb2+kc
         2nv/4nlI/1AFQfS1YVxhUY6qQKavwhbdZi6jTwnL7PJ0SQU2ZGfvVaHctZmktjhmN3fw
         ERhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ghgZezvv9fwHiSgWNtPdvDWZAZD8rMK2AMplAo4xWgQ=;
        b=JxHufhZPmSMLW08D/qp6kIFE+kQ/kx3UDF+nNz2RRZsXuscB85POR7b8GbyGUR6wCQ
         XGahRZlGQXmFnSmBEj38TCyrIii3YjdnrSkyAbA69QbwSPFWxEPwLLEeW6+djbNSwA0z
         NIIPpSk8lbN1l74y3glvNu9UBWIJmXPfNNzE9dpYt371wDODnahBjDIRM5Z70TE/CAyt
         r40Qvcogy72C5wf4P5azagvBPKphk3MZoFWa6nEI1LiIpUF1k8dPa9vEWZiwu6LH7UEC
         GwS7FkOsBTYLxNPfrNY6Ha2p79EgtZPzNBTxDgPJriIcnDuvF+v8wHIbHR0oIz3rhdzE
         gS/g==
X-Gm-Message-State: APjAAAXfar5bXJmKn2bcKnGrmK4b+tjsyPx1Op13KKVFPbHzF86TWRnu
        4QcJmW3PK5MTuMqf0avFDvYA3w==
X-Google-Smtp-Source: APXvYqz+gHE/UC8z99TqP9Sm7kR3enSJlOQ6Yx/foEImpxSRBJUR1EEGFJdF9uOlFeaa1JsJr6G72w==
X-Received: by 2002:aed:21c4:: with SMTP id m4mr18180174qtc.342.1572279801690;
        Mon, 28 Oct 2019 09:23:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id q44sm8258257qtk.16.2019.10.28.09.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 09:23:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iP7nc-0004Ff-IA; Mon, 28 Oct 2019 13:23:20 -0300
Date:   Mon, 28 Oct 2019 13:23:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ming Lei <ming.lei@redhat.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scatterlist: Speed up for_each_sg() loop macro
Message-ID: <20191028162320.GF29652@ziepe.ca>
References: <20191025213359.7538-1-sultan@kerneltoast.com>
 <20191028141734.GD29652@ziepe.ca>
 <20191028161848.GA32593@sultan-box.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028161848.GA32593@sultan-box.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 09:18:48AM -0700, Sultan Alsawaf wrote:
> On Mon, Oct 28, 2019 at 11:17:34AM -0300, Jason Gunthorpe wrote:
> > This is a big change in the algorithm, why are you sure it is OK?
> 
> I'm sure it's OK because the test module I provided in the commit message
> encapsulates all the possible edge cases of sg chaining:
> -An sglist with >=1 && <=(SG_MAX_SINGLE_ALLOC-1) nents (no chaining, the last
>  element in the array is unused)
> -An sglist with SG_MAX_SINGLE_ALLOC nents (no chaining, the last element in the
>  array isn't an sg chain link)
> -An sglist with >SG_MAX_SINGLE_ALLOC && <=2*(SG_MAX_SINGLE_ALLOC-1) nents (there
>  is one chain to another array, and the other array's last element is unused)
> -An sglist with (2*SG_MAX_SINGLE_ALLOC)-1 nents (there is one chain to another
>  array, and the other array's last element isn't an sg chain link)
> -An sglist with 2*SG_MAX_SINGLE_ALLOC nents (there are two chains to other
>  arrays, and the 3rd array contains 2 sgs & its last element is unused)
> -An sglist with >2*SG_MAX_SINGLE_ALLOC && <(3*SG_MAX_SINGLE_ALLOC)-1 nents
>  (there are two chains to other arrays, and the 3rd array's last element isn't
>  an sg chain)

This testing is making assumptions about how 'nr' is used and the
construction of the sgl though

If any chains are partially populated, or for some reason the driver
starts at a different sgl, it will break. You'll need to somehow
show none of those possibilities are happening.

Jason
