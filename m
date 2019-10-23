Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BE2CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D3321929
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCdeB54p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392026AbfJWNcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:32:11 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45304 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389224AbfJWNcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:32:10 -0400
Received: by mail-lj1-f196.google.com with SMTP id q64so21114333ljb.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 06:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wzxz1HRetKbtdZRIGFi+6T+sl+zIChdSBNVj624bN+w=;
        b=GCdeB54p3XbpLOICpXtiiEJFuVt9MpKDpi6YvUWuKBbDAgN771qopihE72xllMiaD0
         FOkJvk9HjcCoGYOX/YHNCZAa+pF94yMyAr8Q5iQTV2rq+q7dDZ/Zpvv2NwZFNYdV6tJN
         saw2Mthif5qLS0aZWjZthnwiS/3G+LEsm2uP/LKleo2jB+FeVIx/TjzV6xoCQeFt3mj0
         1yOg8MZtZi0exfVi+bEliec8hcB2ylXCc0i9SvkfbdfbgCbkFEJv8JUqmN9aXmn3uaFm
         D47LHSzMbVu2O47X72DZElqi8pfy89VAEkAkWy0f+2ARricY+OMSb1Mca/RiAQ4vG5dS
         L9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wzxz1HRetKbtdZRIGFi+6T+sl+zIChdSBNVj624bN+w=;
        b=unhmWI0ILjwuXN6H8Pb/udR88KBMpRLB+9WIM1zcu4fJN7ZSfL/Ak9S5GWkj8+YpVK
         McVoHLHYpTwaX7VJVuStqY8fvSe8I4T3m6ShjwVV+prLU9DfUTGo9zwL5i0u48BFFHQa
         kSXxipU5q8EGy4cWU/V9NnNnSAvSy0yrTJWFhGeLKCQ7CFIbAYE7za8bMpPR8v5ve97o
         Ew4JwdA9ChgjgqonIubcFaSLswVMowvs/7VZYHPu/zRvay+kvmisRWTunHdVi04gzLJM
         jIwCrinyUmCHsZVIHO/ux3DQ3md2MXEQ968Xxw4EcuoK7D5cW7SSkn0NpHxrTxOSPgfb
         Ewpw==
X-Gm-Message-State: APjAAAUUfW1t9PDib13fOln4not4WF8Cn1eg7AqcRtiNlhvC70x4oL3s
        laxUt8VQBFiBOj5okKIP/LtHexIB
X-Google-Smtp-Source: APXvYqzn95bg8bmQRTCowErfd7qdL378ZN0P2XfgbA2+CA2HDmORmBzR23ZYk69MHOFdrYZX5pNqVw==
X-Received: by 2002:a2e:9058:: with SMTP id n24mr5556839ljg.114.1571837526825;
        Wed, 23 Oct 2019 06:32:06 -0700 (PDT)
Received: from uranus.localdomain ([5.18.199.94])
        by smtp.gmail.com with ESMTPSA id x13sm4461769ljb.92.2019.10.23.06.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 06:32:05 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id A490D4610AC; Wed, 23 Oct 2019 16:32:04 +0300 (MSK)
Date:   Wed, 23 Oct 2019 16:32:04 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [BUG -tip] kmemleak and stacktrace cause page faul
Message-ID: <20191023133204.GH12121@uranus.lan>
References: <20191019114421.GK9698@uranus.lan>
 <20191022142325.GD12121@uranus.lan>
 <20191022145619.GE12121@uranus.lan>
 <alpine.DEB.2.21.1910231457400.2308@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910231457400.2308@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 03:21:05PM +0200, Thomas Gleixner wrote:
> On Tue, 22 Oct 2019, Cyrill Gorcunov wrote:
> > On Tue, Oct 22, 2019 at 05:23:25PM +0300, Cyrill Gorcunov wrote:
> > > 
> > > I presume the kmemleak tries to save stack trace too early when estack_pages are not
> > > yet filled.
> > 
> > Indeed, at this stage of boot the percpu_setup_exception_stacks has not been called
> > yet and estack_pages full of crap
> > 
> > [    0.157502] stk 0x1008 k 1 begin 0x0 end 0xd000 estack_pages 0xffffffff82014880 ep 0xffffffff82014888
> > [    0.159395] estack_pages[0] = 0x0
> > [    0.160046] estack_pages[1] = 0x5100000001000
> > [    0.160881] estack_pages[2] = 0x0
> > [    0.161530] estack_pages[3] = 0x6100000003000
> > [    0.162343] estack_pages[4] = 0x0
> > [    0.162962] estack_pages[5] = 0x0
> > [    0.163523] estack_pages[6] = 0x0
> > [    0.164065] estack_pages[7] = 0x8100000007000
> > [    0.164978] estack_pages[8] = 0x0
> > [    0.165624] estack_pages[9] = 0x9100000009000
> > [    0.166448] estack_pages[10] = 0x0
> > [    0.167064] estack_pages[11] = 0xa10000000b000
> > [    0.168055] estack_pages[12] = 0x0
> 
> Errm. estack_pages is statically initialized and it's an array of:.
> 
> struct estack_pages {
>         u32     offs;
>         u16     size;
>         u16     type;
> };
> 
> [0,2,4,5,6,8,10,12] are guard pages so 0 is not that crappy at all

Wait, Thomas, I might be wrong, but per-cpu is initialized to the pointer,
the memory for this estack_pages has not yet been allocated, no?

> The rest looks completely valid if you actually decode it proper.

The diff I made to fetch the values are

diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 753b8cfe8b8a..bf0d755b6079 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -101,8 +101,18 @@ static bool in_exception_stack(unsigned long *stack, struct stack_info *info)
 
 	/* Calc page offset from start of exception stacks */
 	k = (stk - begin) >> PAGE_SHIFT;
+
 	/* Lookup the page descriptor */
 	ep = &estack_pages[k];
+
+	printk("stk 0x%lx k %u begin 0x%lx end 0x%lx estack_pages 0x%lx ep 0x%lx\n",
+	       stk, k, begin, end, (long)(void *)&estack_pages[0], (long)(void *)ep);
+
+	for (k = 0; k < CEA_ESTACK_PAGES; k++) {
+		long v = *(long *)(void *)&estack_pages[k];
+		printk("estack_pages[%d] = 0x%lx\n", k, v);
+	}
+
 	/* Guard page? */
 	if (!ep->size)
 		return false;


> 
> e.g. 0x51000 00001000
> 
>      bit  0-31: 00001000		Offset 0x1000: 1 Page
>      bit 32-47: 1000			Size 0x1000:   1 Page
>      bit 48-63: 5			Type 5: STACK_TYPE_EXCEPTION + ESTACK_DF
> 
> So, no. This is NOT the problem.

I drop the left of your reply. True, I agreed with anything you said.
You know I didn't manage to dive more into this problem yesterday
but if time permits I'll continue today. It is easily triggering
under kvm (the kernel I'm building is almost without modules so
I simply upload bzImage into the guest). FWIW, the config I'm
using is https://gist.github.com/cyrillos/7cd5d2510a99af8ea872f07ac6f9095b
