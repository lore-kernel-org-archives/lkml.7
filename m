Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517F1ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E0E21855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Pq9uNLT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388849AbfJANvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:51:12 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44560 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388706AbfJANvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:51:12 -0400
Received: from zn.tnic (p200300EC2F0A2D0011A0C0FEFCED0EBA.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2d00:11a0:c0fe:fced:eba])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F3C1B1EC03AD;
        Tue,  1 Oct 2019 15:51:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569937871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jWF7NUD3UG4zEl0CddlLEO+oeHhhgitXQGaScYypXro=;
        b=Pq9uNLT41EO/NKOX2eDfLDuzdhcEz39M+YEQgdg1fmeI29l0IubgvVStdbhcu/mNNKlLBq
        dOpiCIO5r8s+33d+fdYvbSar5pQQEtGzrUlX6Ztf2A91PyB1tSmfbYgSAooSVnNmvuGQ3I
        CQhu6feHC9g9szUkRyi0bT4LmnJXKyU=
Date:   Tue, 1 Oct 2019 15:51:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: x86/random: Speculation to the rescue
Message-ID: <20191001135108.GD5390@zn.tnic>
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
 <CAHk-=wi0vxLmwEBn2Xgu7hZ0U8z2kN4sgCax+57ZJMVo3huDaQ@mail.gmail.com>
 <CAHk-=whKhD-GniDqpRhhF=V2cSxThX56NAdkAUoBkbp0mW5=LA@mail.gmail.com>
 <20190930061014.GC29694@zn.tnic>
 <CAHk-=wjfLfnOyGkHM+ZRn6bc6JD6CU3Ewix3cJDqCqjbMO5PNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjfLfnOyGkHM+ZRn6bc6JD6CU3Ewix3cJDqCqjbMO5PNA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 09:06:36AM -0700, Linus Torvalds wrote:
> Obviously, that can be a problem if you then need sshd in order to get
> into a headless box, so my patch fixes things for you too, but at
> least your box doesn't show the problem that Ahmed had, and the boot
> completing presumably means that you got more entropy from other disk
> IO being done by the rest of the boot.

Right, another observation I did was that when it would wait for
entropy, if I press random keys, it would get done faster because
apparently it would collect entropy from the key presses too.

> If you want to test my hacky "do /dev/urandom too", it was this one-liner:
> 
>   --- a/drivers/char/random.c
>   +++ b/drivers/char/random.c
>   @@ -2027,6 +2027,7 @@ urandom_read(struct file *file, char __user
> *buf, size_t nbytes, loff_t *ppos)
>         static int maxwarn = 10;
>         int ret;
> 
>   +     if (!crng_ready()) try_to_generate_entropy();
>         if (!crng_ready() && maxwarn > 0) {
>                 maxwarn--;
>                 if (__ratelimit(&urandom_warning))
> 
> and that should get rid of the warnings.

So when I add this by hand and do git diff, it adds a second hunk:

---
diff --git a/drivers/char/random.c b/drivers/char/random.c
index c2f7de9dc543..93bad17bef98 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2027,6 +2027,7 @@ urandom_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 	static int maxwarn = 10;
 	int ret;
 
+	if (!crng_ready()) try_to_generate_entropy();
 	if (!crng_ready() && maxwarn > 0) {
 		maxwarn--;
 		if (__ratelimit(&urandom_warning))
@@ -2520,4 +2521,4 @@ void add_bootloader_randomness(const void *buf, unsigned int size)
 	else
 		add_device_randomness(buf, size);
 }
-EXPORT_SYMBOL_GPL(add_bootloader_randomness);
\ No newline at end of file
+EXPORT_SYMBOL_GPL(add_bootloader_randomness);
---

and I kinda get what it is trying to tell me but this is new. And when I
do

$ xxd drivers/char/random.c
..

000125e0: 646f 6d6e 6573 7329 3b0a                 domness);.

there's a 0xa at the end so what's git really trying to tell me?

Anyway, that does get rid of the warns too.

> Doing something like the above to /dev/urandom is likely the right
> thing to do eventually, but I didn't want to mix up "we can perhaps
> improve the urandom situation too" with the basic "let's fix the boot
> problem". The urandom behavior change would be a separate thing.

So make it a separate patch and let's hammer on it during the next weeks
and see what happens?

> Also, talking about "future changes". Right now
> "try_to_generate_entropy()" is actually uninterruptible once it gets
> started. I think we should add a test for signal_pending() too, but it

Wouldn't that even increase its entropy, which would be a good thing?

> should generally complete really fairly quickly so I left it without
> one just to see if anybody even notices.

Right.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
