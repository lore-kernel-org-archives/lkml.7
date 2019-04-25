Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2687C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DAC217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556189872;
	bh=eaVlZ8N3GWs1CEBdmQOH5Ogtl8u+mhqRs16WkXOw+tI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g4/4+wJ56wMHd5sf83SlOGdcXPgxKk0VB59KHhxF7mmWwaMQAUkBYX8k3jiEfJMh8
	 qn24McToxPPio6lJ6L7ZIEHM7HfsbNdXfEJJFK7RWQmltKIsIsGbpDj9geTkDJmuAZ
	 Fsh7MpahYVe15QKfIfBURFgGPYFBwkK1lUQaNyns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbfDYK5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:57:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42118 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730529AbfDYK5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:57:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so29644571wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 03:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e8/2tKwCpipacdDupHWNWjFErjsYGD1OSlqjsGXNll8=;
        b=GlQe4qUQNjiVWly3gGxorH39jhOEsnIC3sYAifh4l/Lkdd1fYsaeKco8QNWSnukd3O
         XatlbsnoA+B7yfgobw9tQRwEWfjAHBWSr0OdTBrpf5v+y7/ATh9PJYqpEZz4fpkcBb1P
         xCAHEI/y8jZrmWBQOanaprAdsdB7ojrQAlUbgdgKBXiEA6NtDJNzCGslfNFX1AJs2M/a
         Z2v2fIyx0UJi58EwGxXbkOS0awJY8j132SgoeoP7Mf81Zb+8tzftMOXW8MHd8ESkqfVM
         YNaPEyW+Zx9O448oUI+RW6jJCuwaQSBSRBDn3pqkz75JD71hqO6yjhEZJkY58eI/HsIw
         EBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=e8/2tKwCpipacdDupHWNWjFErjsYGD1OSlqjsGXNll8=;
        b=agD4U6u3xN+RkPX7VR2dNA0nxug6F33g+mHAfCFQ669cnwzC4TfxTSDXfPOxGCdfQP
         uMuzYxuzoJ4L98G77EwUAXVyStWU8s5wvbb0h5TxZvIxZo01x7Y8zSK9JsYrpYS2vlg6
         zahPQLlW5cBhVPTDQzr+Z87hSj6TDNSiVs7ZMvShyONi/dqvZjsBo+DwAJ07XsShXzfp
         L1FG+enc8UhkFxKt3JmIIw3hCrMWXLodnLhNl/LULUeYQgFBCWt/VONnDfShKuGYCBFU
         QUShXzrW4j+ETtRFIoD7RChn7KtXtu5KOdVxNddgkRzhFB6XoIuvmNvqGb3pQuhYc/RU
         7u6w==
X-Gm-Message-State: APjAAAUaSm+N71+iOG1G2BB4fzTcWYId+zN1glbOCwX6/rPSWhC8YE5K
        WA522vKCT3uHDD53MUzTz3Q=
X-Google-Smtp-Source: APXvYqwSXMSbhS9Z2K9rK7fywG63eecqYYeJ/OD+8nQw+8tvK894wr2J0aFQcIKVwBi1WHUH5OulLg==
X-Received: by 2002:a5d:6988:: with SMTP id g8mr4044912wru.117.1556189868754;
        Thu, 25 Apr 2019 03:57:48 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u15sm5796551wrt.40.2019.04.25.03.57.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 03:57:47 -0700 (PDT)
Date:   Thu, 25 Apr 2019 12:57:45 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: x86/paravirt: Detect over-sized patching bugs in
 paravirt_patch_call()
Message-ID: <20190425105745.GA29840@gmail.com>
References: <20190424134115.091452807@linutronix.de>
 <20190424134223.690835713@linutronix.de>
 <20190425065209.GA89582@gmail.com>
 <alpine.DEB.2.21.1904250921010.1762@nanos.tec.linutronix.de>
 <20190425081012.GA115378@gmail.com>
 <20190425091717.GA72229@gmail.com>
 <20190425092131.GL4038@hirez.programming.kicks-ass.net>
 <20190425095039.GC115378@gmail.com>
 <20190425102210.GM4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425102210.GM4038@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Apr 25, 2019 at 11:50:39AM +0200, Ingo Molnar wrote:
> > 
> > * Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Thu, Apr 25, 2019 at 11:17:17AM +0200, Ingo Molnar wrote:
> > > > It basically means that we silently won't do any patching and the kernel 
> > > > will crash later on in mysterious ways, because paravirt patching is 
> > > > usually relied on.
> > > 
> > > That's OK. The compiler emits an indirect CALL/JMP to the pv_ops
> > > structure contents. That _should_ stay valid and function correctly at
> > > all times.
> > 
> > It might result in a correctly executing kernel in terms of code 
> > generation, but it doesn't result in a viable kernel: some of the places 
> > rely on the patching going through and don't know what to do when it 
> > doesn't and misbehave or crash in interesting ways.
> > 
> > Guess how I know this. ;-)
> 
> What sites would that be? It really should work AFAIK.

So for example I tried to increasing the size of one of the struct 
patch_xxl members:

--- a/arch/x86/kernel/paravirt_patch.c
+++ b/arch/x86/kernel/paravirt_patch.c
@@ -28,7 +28,7 @@ struct patch_xxl {
 	const unsigned char	irq_restore_fl[2];
 # ifdef CONFIG_X86_64
 	const unsigned char	cpu_wbinvd[2];
-	const unsigned char	cpu_usergs_sysret64[6];
+	const unsigned char	cpu_usergs_sysret64[60];
 	const unsigned char	cpu_swapgs[3];
 	const unsigned char	mov64[3];
 # else

Which with the vanilla kernel crashes on boot much, much later:

[    2.478026] PANIC: double fault, error_code: 0x0

But in any case, even if many of the others will work if the patching 
fails silently, is there any case where we'd treat patching failure as an 
acceptable case?

BUG_ON() in paravirt kernels is an easily debuggable condition and beats 
the above kinds of symptoms. But I can turn it into a WARN_ON_ONCE() if 
you think that's better?

Thanks,

	Ingo
