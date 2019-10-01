Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02301ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E2421855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="IBJrEzgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbfJARu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:50:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56926 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfJARuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:50:25 -0400
Received: from zn.tnic (p200300EC2F0A2D0054E20F556F04115F.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2d00:54e2:f55:6f04:115f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6C11E1EC026F;
        Tue,  1 Oct 2019 19:50:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569952224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tl/8FCep/r5LFElzzqi/+XXE28b3old3u7uSFqNXBJs=;
        b=IBJrEzgE3SKKAe1jMYmRFlIkTF+nwqSQqc/z6xR3ilEf/YN0u3c5KcK5vqOjpk40TklPSu
        FGBDAVmK20Q1xcz/E7DS4bPrKOewnmM3dTBOgof6dRDJfZTpOR9NnAc5/z8Mv1xOfPGVL8
        v6VXF4IYt5Ezz9eDgyRJ9Nvb4ciYxf4=
Date:   Tue, 1 Oct 2019 19:50:23 +0200
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
Subject: [PATCH] char/random: Add a newline at the end of the file
Message-ID: <20191001175023.GE5390@zn.tnic>
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
 <CAHk-=wi0vxLmwEBn2Xgu7hZ0U8z2kN4sgCax+57ZJMVo3huDaQ@mail.gmail.com>
 <CAHk-=whKhD-GniDqpRhhF=V2cSxThX56NAdkAUoBkbp0mW5=LA@mail.gmail.com>
 <20190930061014.GC29694@zn.tnic>
 <CAHk-=wjfLfnOyGkHM+ZRn6bc6JD6CU3Ewix3cJDqCqjbMO5PNA@mail.gmail.com>
 <20191001135108.GD5390@zn.tnic>
 <CAHk-=wh-rUBFjJ-p-65DhX+uOHuoUcf2=XtxwEUOPqojw7vEUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wh-rUBFjJ-p-65DhX+uOHuoUcf2=XtxwEUOPqojw7vEUw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 10:14:40AM -0700, Linus Torvalds wrote:
> The previous state of the file didn't have that 0xa at the end, so you get that
> 
> 
>   -EXPORT_SYMBOL_GPL(add_bootloader_randomness);
>   \ No newline at end of file
>   +EXPORT_SYMBOL_GPL(add_bootloader_randomness);
> 
> which is "the '-' line doesn't have a newline, the '+' line does" marker.

Aaha, that makes total sense, thanks for explaining. Oh well, let's fix
it then so that people don't scratch heads like me.

---
From: Borislav Petkov <bp@suse.de>
Date: Tue, 1 Oct 2019 19:39:14 +0200
Subject: [PATCH] char/random: Add a newline at the end of the file

git denotes files without newline at their end with

"\ No newline at end of file"

when displaying diffs. Due to

  428826f5358c ("fdt: add support for rng-seed")

that file doesn't have a newline (0xa) at its end so whenever an editor
which adds those newlines by default touches it, the below hunk gets
added in addition to other changes.

Fix that separately so that people don't wonder like me what's going on.

No functional changes.

Debugged-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index c2f7de9dc543..de434feb873a 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2520,4 +2520,4 @@ void add_bootloader_randomness(const void *buf, unsigned int size)
 	else
 		add_device_randomness(buf, size);
 }
-EXPORT_SYMBOL_GPL(add_bootloader_randomness);
\ No newline at end of file
+EXPORT_SYMBOL_GPL(add_bootloader_randomness);
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
