Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49927C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 04:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DDD02175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 04:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="RLEt3tif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbfDEEKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 00:10:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46520 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbfDEEKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 00:10:38 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 33D4F1EC02D1;
        Fri,  5 Apr 2019 06:10:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554437436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wxV47DWj4vLfQ/1haMoePUR6PTgYz/3r3M4PHZsUk6Y=;
        b=RLEt3tifIh1ufADAjDahDdMyhXogVpRbzHMNVkVBCX/yKGJYtFgwt69W4sQtqDk5mLxj8N
        lJ10prTLzIIg4RHJWXcdNP/Tu+27xlhs/PSVJwCjAhQTk8yQuZU8TCKQHD+MGh3qV5d400
        npuvdFClGtca9TTdxW6o++t7WCEjdm0=
Date:   Fri, 5 Apr 2019 06:10:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH] x86/microcode: Refactor Intel microcode loading
Message-ID: <20190405041028.GA23348@zn.tnic>
References: <20190404111128.131157-1-jannh@google.com>
 <20190404162753.GG22539@zn.tnic>
 <CAG48ez1wPdCZE07SeK_=yL3gWRnekLm3+YP3rvyw2YL_3+uNJw@mail.gmail.com>
 <20190404164741.GH22539@zn.tnic>
 <CAG48ez3aExeF8Bg=TQxH4MxV7Dgr-oXFfCmSMPEfBJLNAhi7zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez3aExeF8Bg=TQxH4MxV7Dgr-oXFfCmSMPEfBJLNAhi7zQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 12:54:31AM +0200, Jann Horn wrote:
> [  159.485731] microcode: CPU7 found a matching microcode update with
> version 0x25 (current=0x19)

Yeah, that printk can be kinda misleading :)

> I thought I had checked /sys/devices/system/cpu/cpu0/microcode/version
> afterwards. But apparently I didn't. Bleh. Sorry about that.

No worries at all, now at least it is all clear what's happening. I was
beginning to recheck what I'm seeing here too.

And I can finally deprecate this ancient method which is just as
kaputtski because it is happening as late as the late loading method
when you do

echo 1 > /sys/devices/system/cpu/microcode/reload

---
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5ad92419be19..5a0a752f3ddd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1330,8 +1330,16 @@ config MICROCODE_AMD
 	  processors will be enabled.
 
 config MICROCODE_OLD_INTERFACE
-	def_bool y
+	bool "Ancient loading interface (DEPRECATED)"
+	default n
 	depends on MICROCODE
+	---help---
+	  DO NOT USE THIS! This is the ancient /dev/cpu/microcode interface
+	  which was used by userspace tools like iucode_tool and microcode.ctl.
+	  It is inadequate because it runs too late to be able to properly
+	  load microcode on a machine and it needs special tools. Instead, you
+	  should've switched to the early loading method with the initrd or
+	  builtin microcode by now: Documentation/x86/microcode.txt
 
 config X86_MSR
 	tristate "/dev/cpu/*/msr - Model-specific register support"
---

I'll test some more and post later.

Thx!

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
