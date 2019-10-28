Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74270CA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B7F21783
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403791AbfJ1Qhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:37:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46138 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbfJ1Qhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:37:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id q21so5826559plr.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 09:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hSfuAznZxA5rdJvI94A+k5BryWZerPhQfUDajRhfjAw=;
        b=BvMkvQXGqhbznp+6Q7/yM2t3RcSb+fY3FWXlhZPR7tHpu4ppbIjtxEjxbDJrAxECpf
         R8+Z/zvGs+lLq8jIIaouNdibHh6eyocmy/ICuPPRcswFui+nqkleyT2a9sfJVrZY6cKQ
         BzZNOzsow1tnnvSIca7dZXbrNZdLVbUC0JrpzNTLow1bYQcwlVf3mDd8qxg1kIv3Yb8j
         recTNHjYxy9sxs/hhMy5ed5I0ZLn3qlrFVPuMycsOpvQp5nCgTOan3Sz2gx8IP/wWnnZ
         EKy+Xw8jmXmK7Rzdi+EvzxzRpFkmJ6WQSV1ANmwaDNh6mhxTujiG6dUAuj6+4L6QtEs2
         OwZg==
X-Gm-Message-State: APjAAAVesKoDJI4QoFDiB/5nO/lsY/N7hCXPfWLMhOu053pLBNb10P/V
        HWuHMhVxu2T2FIAzbB2ODU7PjS/ZCJo=
X-Google-Smtp-Source: APXvYqzZfL3J2rVdugH6hx8bfpsdY/8CKLD3t52km/9oju4mlWcnZ4Hv3GI6asNH89zV6oogfQ9Glg==
X-Received: by 2002:a17:902:8f83:: with SMTP id z3mr225260plo.190.1572280654346;
        Mon, 28 Oct 2019 09:37:34 -0700 (PDT)
Received: from sultan-box.localdomain ([104.200.129.62])
        by smtp.gmail.com with ESMTPSA id i123sm13394020pfe.145.2019.10.28.09.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:37:33 -0700 (PDT)
Date:   Mon, 28 Oct 2019 09:37:32 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ming Lei <ming.lei@redhat.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scatterlist: Speed up for_each_sg() loop macro
Message-ID: <20191028163732.GA32763@sultan-box.localdomain>
References: <20191025213359.7538-1-sultan@kerneltoast.com>
 <20191028141734.GD29652@ziepe.ca>
 <20191028161848.GA32593@sultan-box.localdomain>
 <20191028162320.GF29652@ziepe.ca>
 <20191028162816.GA17182@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028162816.GA17182@infradead.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 09:28:16AM -0700, Christoph Hellwig wrote:
> And there is nothing forcing a particular layout, there just happens
> to be a layout that the generic allocator gives you.  I'm not even
> sure the original patch handles the SCSI case of small inlines segments
> properly.

I'm doubtful; are there really sg users that craft their own sglists and then
use for_each_sg() on them? But like I mentioned in the email I sent a
few minutes ago, this can be alleviated with a more comprehensive version of
this patch that alters all for_each_sg() users and thus ensures that only
sg_table pointers can be used with the macro. Anyone who would munge their own
sg_table together would simply be insane :)

Or there could be a separate macro for iterating through each sg in an sg_table.
There are lots of ways to go about this.

Sultan
