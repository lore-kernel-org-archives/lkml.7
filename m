Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C20C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF17A218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556183843;
	bh=1+9TecnmZY1CsIpTmmKvY3cI/w99A2wYCtQoladsem0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VJ7vDefPbNmTNHQ97oUY2XdFmwW+Ceja0dpUSiQUVYc5ZgsxHBXZTAO+mI5qFLAMq
	 5vsR4IMuxgxvFO0rT/e+kl9cscYwklapd0dvqq9s1MtJSxiA6MUkf3ZiyoJLHeJZU7
	 6UNd3ovThC0uqk7Es7MkPFBN1OMaCXJkyx9AJDSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfDYJRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:17:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35434 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfDYJRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:17:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so9480093wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 02:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+j9mNlt9w74SYKE++usks4iSxmaqCSgJRM75Nl+ensk=;
        b=R6sqV7jThA+bd0v+fG4EPXZBrt0+/Df018Tj4HTIKG1aip+jrQRHb/9k6DASH6SzLb
         HNgy+G1Mu1QhLMUcmztfbldnz1m8hbdDG+Z5T+1UZEbx7e56TufzwYOiklJjiSS2nphu
         PbAc4n7ff0l4FV5M/M/+6lDF+8/bLVEjU4PCxdFwwSSSZ2D4Jmb6DIxRBPoGZqL3x9ZZ
         S9+tT4fxe9awR5Cb51Iu5kRBln500p5imeTbPc59eaz9gBmTQEmVc0gt6k90fyRj2I32
         OZQoLHblHFXalSGNVT+Uzcs0KZ69Qqtlpui2OecR4txSkF4P1vuiO9M8O+geuwkaUVO5
         dAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+j9mNlt9w74SYKE++usks4iSxmaqCSgJRM75Nl+ensk=;
        b=H8K/9olHUZgsZYGozh3rORFfOzJJbYXpjx6BSNz+UsOeSlFFdlRvZhYLknK8N+UKPD
         R0ArFjTuk64uQ1M4JKlWCmAiczNk940Os/PPaPRb1wE1KnhEnS9re6xMvB2xKKL5jiKs
         m6Up/dO/i0Khj0K6QxUFEVJgD2HjnXMTqDGMhuGnvEqqsayv0+BzPNFd59zvCjidD+ll
         UjaR9EbROIX0TdsQbBIb8Qr0NjqFmbiwCLSVrqjkOnE/OLvc8PzcQZE9PHuj13JQsYpW
         5lmXWvZoasvRRYgtXjMWmNOoTQEa1+jQzPwTNRuOrWk0y8wdJld3aogqTHwZuvTf3HOJ
         auqg==
X-Gm-Message-State: APjAAAU6lYxiBgJL+/l6AGHEZux3IGWhqFT0pNhgPndw9rCXN5+KgU0F
        pgkdFqaW5o4ZNaliRgYekYY=
X-Google-Smtp-Source: APXvYqxi+jg7uBDVS+IWp0/JKM9QjoMqVfjkRTxZ8QGml4dQJL+G+/CLng9Xhzm0p5OtfV0h4wBRgw==
X-Received: by 2002:a05:600c:203:: with SMTP id 3mr2647670wmi.77.1556183840622;
        Thu, 25 Apr 2019 02:17:20 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c20sm27342984wre.28.2019.04.25.02.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 02:17:19 -0700 (PDT)
Date:   Thu, 25 Apr 2019 11:17:17 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH] x86/paravirt: Detect oversized patching bugs as they happen
 and BUG_ON() to avoid later crashes
Message-ID: <20190425091717.GA72229@gmail.com>
References: <20190424134115.091452807@linutronix.de>
 <20190424134223.690835713@linutronix.de>
 <20190425065209.GA89582@gmail.com>
 <alpine.DEB.2.21.1904250921010.1762@nanos.tec.linutronix.de>
 <20190425081012.GA115378@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425081012.GA115378@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> Third, beyond readability there's another advantage of my suggested 
> approach as well: for example that way we could verify the passed in 
> length with the patchlet length. Right now it's completely unverified:
> 
>         case PARAVIRT_PATCH(ops.m):                                     \
>                 return PATCH(data, ops##_##m, ibuf, len)
> 
> right now we don't check whether the 'len' passed in by the usage site 
> matches the actual structure field length.
> 
> Although maybe we could do that with your C space structure as well.

So I was wrong here, got confused by the 'len' name which doesn't mean 
what it suggests: it's not the length of the patchlet, but the 
maximum/original length of the patch site - which we trim down in 
paravirt_patch_insns():

unsigned paravirt_patch_insns(void *insnbuf, unsigned len,
                              const char *start, const char *end)
{
        unsigned insn_len = end - start;

        if (insn_len > len || start == NULL)
                insn_len = len;
        else
                memcpy(insnbuf, start, insn_len);

        return insn_len;
}

What is the logic behind silently returning 'len' here and not copying 
anything?

It basically means that we silently won't do any patching and the kernel 
will crash later on in mysterious ways, because paravirt patching is 
usually relied on.

Instead I think we should BUG_ON() that condition with the patch below - 
there's no way to continue successfully at that point.

I've tested this patch, with the vanilla kernel check never triggers, and 
if I intentionally increase the size of one of the patch templates to a 
too high value the assert triggers:

[    0.164385] kernel BUG at arch/x86/kernel/paravirt.c:167!

Without this patch a broken kernel randomly crashes in later places, 
after the silent patching failure.

Thanks,

	Ingo

Signed-off-by: Ingo Molnar <mingo@kernel.org>

--- tip.orig/arch/x86/kernel/paravirt.c
+++ tip/arch/x86/kernel/paravirt.c
@@ -163,10 +163,10 @@ unsigned paravirt_patch_insns(void *insn
 {
 	unsigned insn_len = end - start;
 
-	if (insn_len > len || start == NULL)
-		insn_len = len;
-	else
-		memcpy(insnbuf, start, insn_len);
+	/* Alternative instruction is too large for the patch site and we cannot continue: */
+	BUG_ON(insn_len > len || start == NULL);
+
+	memcpy(insnbuf, start, insn_len);
 
 	return insn_len;
 }
