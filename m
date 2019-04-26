Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A30EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4112084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POxsyX3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfDZAAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:00:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39857 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfDZAAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 20:00:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id q10so1223280ljc.6;
        Thu, 25 Apr 2019 17:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xopw6scoY8m69fGtQCLNxKBU4lVmXTJmtD/S5txEm8w=;
        b=POxsyX3lPLAOzigv0zF0gMxbogHXm6apiwkxGZpgZegq1cdTZknM8TsxshClJM64o4
         V/BGr57OiHHV3jOFVkfS/af4V+uGWrlabZsrKY7TDW1UKZzsjNHT1wQCHhteMwuiVCT3
         pykmf38z56NYDPpR4D7M9dZaL0XEO/sLzWhwlhrFvTJMwKv71DYXMb9oNwSReWpenTlI
         dxsIJicarRltZ80m/SrdWywXB6Nu0vxu3Q8A4T28/qE4WJNpMHnWi0WaKfKyBqEZ4h+x
         ex0cNJp+CqfSDs3QcO4eYuJqaMgprjsE4Wz/jjwEw+7Lzns9KPPVq9RXM9ssXqlE+FAh
         chvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xopw6scoY8m69fGtQCLNxKBU4lVmXTJmtD/S5txEm8w=;
        b=YRxBuDyLl/hDcf+op/e6JDTAhevJbzlVDXzqC/pRFFk37nxnSUYxWwDLAMdKBiUGbU
         P1YPiXK+8NLrWqUu8TjPt4hJqwlQKQGc/OJUQ/fESIuXP38rk/bSO3JE2XpV7c/Kpc08
         Djh7H1SF6UTYN2RNIAfs2OFt6bL7Yf9WC3XxPjco4KGwamT8v2nXPXxwzPpPoTKnEe73
         gzL19qqLrkIYNNg/ftJkU5xzrYiLNvcxutLp5hNCftfRAbW8yTFuXTdqVUEj8e7oO20C
         ZPvbvYoyzJ0Zpr+DgxGipiQxW5w9SPRGde+3/8HtaYMnwRFjeLAEBjvT7cMXMXA1HR/Y
         /Igg==
X-Gm-Message-State: APjAAAVHIBLzv7hUW2nwahlbgEyGuKmtF49iCPp/+2HwuFZ/CQNQa5Of
        rs461TH64jd1uq6eHhiqzyQ=
X-Google-Smtp-Source: APXvYqzlZFunU266yZ4pdZvz52IUxSs+hesamVoPNnAMxJhgsO23ZBhTFgWZyowIGHidvZoPhr6UrA==
X-Received: by 2002:a2e:9941:: with SMTP id r1mr7162693ljj.168.1556236839893;
        Thu, 25 Apr 2019 17:00:39 -0700 (PDT)
Received: from mobilestation ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id m23sm4893350ljh.93.2019.04.25.17.00.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 17:00:38 -0700 (PDT)
Date:   Fri, 26 Apr 2019 03:00:36 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Huacai Chen <chenhc@lemote.com>,
        Stefan Agner <stefan@agner.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Juergen Gross <jgross@suse.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/12] mips: Reserve memory for the kernel image resources
Message-ID: <20190426000035.yfonfvrapmm4j3fg@mobilestation>
References: <20190423224748.3765-1-fancer.lancer@gmail.com>
 <20190423224748.3765-5-fancer.lancer@gmail.com>
 <20190424224343.4skr727fszycwksq@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424224343.4skr727fszycwksq@pburton-laptop>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 10:43:48PM +0000, Paul Burton wrote:
> Hi Serge,
> 
> On Wed, Apr 24, 2019 at 01:47:40AM +0300, Serge Semin wrote:
> > The reserved_end variable had been used by the bootmem_init() code
> > to find a lowest limit of memory available for memmap blob. The original
> > code just tried to find a free memory space higher than kernel was placed.
> > This limitation seems justified for the memmap ragion search process, but
> > I can't see any obvious reason to reserve the unused space below kernel
> > seeing some platforms place it much higher than standard 1MB.
> 
> There are 2 reasons I'm aware of:
> 
>  1) Older systems generally had something like an ISA bus which used
>     addresses below the kernel, and bootloaders like YAMON left behind
>     functions that could be called right at the start of RAM. This sort
>     of thing should be accounted for by /memreserve/ in DT or similar
>     platform-specific reservations though rather than generically, and
>     at least Malta & SEAD-3 DTs already have /memreserve/ entries for
>     it. So this part I think is OK. Some other older platforms might
>     need updating, but that's fine.
> 

Regarding ISA. As far as I remember devices on that bus can DMA only to the
lowest 16MB. So in case if kernel is too big or placed pretty much high,
they may be left even without reachable memory at all in current
implementation.

>  2) trap_init() only allocates memory for the exception vector if using
>     a vectored interrupt mode. In other cases it just uses CAC_BASE
>     which currently gets reserved as part of this region between
>     PHYS_OFFSET & _text.
> 
>     I think this behavior is bogus, and we should instead:
> 
>     - Allocate the exception vector memory using memblock_alloc() for
>       CPUs implementing MIPSr2 or higher (ie. CPUs with a programmable
>       EBase register). If we're not using vectored interrupts then
>       allocating one page will do, and we already have the size
>       calculation for if we are.
> 
>     - Otherwise use CAC_BASE but call memblock_reserve() on the first
>       page.
> 
>     I think we should make that change before this one goes in. I can
>     try to get to it tomorrow, but feel free to beat me to it.
> 

As far as I understood you and the code this should be enough to fix
the problem:
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 98ca55d62201..f680253e2617 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2326,6 +2326,8 @@ void __init trap_init(void)
 				ebase += (read_c0_ebase() & 0x3ffff000);
 			}
 		}
+
+		memblock_reserve(ebase, PAGE_SIZE);
 	}
 
 	if (cpu_has_mmips) {
---

Allocation has already been implemented in the if-branch under the
(cpu_has_veic || cpu_has_vint) condition. So we don't need to change
there anything.
In case if vectored interrupts aren't supported the else-clause is
taken and we need to reserve whatever is set in the exception base
address variable.

I'll add this patch between 3d and 4th ones if you are ok with it.

-Sergey

> Thanks,
>     Paul
