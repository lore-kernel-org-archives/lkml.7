Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF2AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 22:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99FD6217D4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 22:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DzvcegBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbfDDWzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 18:55:04 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37843 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729009AbfDDWzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 18:55:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id c16so3940410otn.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 15:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IdMAMLWMySzZoM2y9V5V7l1L+Kbq9iXYZN0/lJ9+Alo=;
        b=DzvcegBsnjFs328s5xju5h9GjY3Orpq91DpfSXEic6LpCpWqEVLaUdnaQANmMoM9VR
         XQNRa3XhCuUCzksbQ94dO6PwAlchSBQNKsd0TgIv/tQLvEFlxofqLtluRo4ra6UbeD5V
         RPWWVYL6wWYOxYx6+3UZ57+Jn4Q0rUDRteVkEgLtXas3Zjp7szHCAJkJKWVxX7zis0Se
         hKwrH26N4Fqy34QFeI//O8ZX6eQx8bzBrqUndS5ZiKQhIh2PHvxCxodoDwN/Gxthyak0
         cnl0GNY8ztSMhJuvMk9CK+IT3EeYQKRuv8BuwtoGzpFXth2pFafthGtkfudD4hON4N7h
         zeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IdMAMLWMySzZoM2y9V5V7l1L+Kbq9iXYZN0/lJ9+Alo=;
        b=U9rrMzn3RFRSr3SCb+KgH/GpgouBWyKsDsexW6xKuG/TDhfCwV6E0y90N6JCLh9878
         IrvAUcnwQ6YHw2c0aIwZhDA5YpBXcnGfz80/yWPcPvfBW3DwRtIJ0XIFDQXq28KrRYgC
         4YKg4Cg510JlhYtOcdFc+58/cJKCbYPv+d97IF3NOQXfHAUUuYkbxRIVbfbpr/tutzNk
         ijXaDhFDxy+LSqXCIF3sbgq9GhfMBNYmUkD/W3TUPqcYPX4/+tzU5D+Ky7tCEsTYHbQ5
         czWL06Ov54Q+f/0m4B+rwugbSQTjb2tpUSfavD+9ZDZGMKfLbOqF1lCkLalNDmQQwcD9
         hzcQ==
X-Gm-Message-State: APjAAAUyHmt5xqaCxZpwHPpqM3jljv5emcBGKNclHSvazGM6l2tHRXQh
        ta/PuPd67AOmKk4Nqindn0OoerDH2+9YXVw8oYbvqQ==
X-Google-Smtp-Source: APXvYqyZdhbcd14nD2Yw43Q5OASxcSRFDzY+0RUGLcfcYnoFha6W5EI/+DvlBGTXfGZ9SKedy8MEtcz/AvhcirUDWrM=
X-Received: by 2002:a9d:6d05:: with SMTP id o5mr6125227otp.175.1554418502777;
 Thu, 04 Apr 2019 15:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190404111128.131157-1-jannh@google.com> <20190404162753.GG22539@zn.tnic>
 <CAG48ez1wPdCZE07SeK_=yL3gWRnekLm3+YP3rvyw2YL_3+uNJw@mail.gmail.com> <20190404164741.GH22539@zn.tnic>
In-Reply-To: <20190404164741.GH22539@zn.tnic>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 5 Apr 2019 00:54:31 +0200
Message-ID: <CAG48ez3aExeF8Bg=TQxH4MxV7Dgr-oXFfCmSMPEfBJLNAhi7zQ@mail.gmail.com>
Subject: Re: [PATCH] x86/microcode: Refactor Intel microcode loading
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 6:47 PM Borislav Petkov <bp@alien8.de> wrote:
> On Thu, Apr 04, 2019 at 06:31:37PM +0200, Jann Horn wrote:
> > Uuuh. I *definitely* tested this. I ran this yesterday evening on my
> > home machine, on top of commit
> > 14c741de93861749dfb60b4964028541f5c506ca from Linus' tree, plus two
> > cherry-picked fixes for drm/ttm. I specifically made sure that I had
> > the old microcode version before reloading these ways and I had the
> > new version after reloading. And the verbose dmesg logs also looked
> > okay.
>
> How did you check the microcode revision before and after? /proc/cpuinfo?
>
> Because that old method doesn't say anything in dmesg if there's no
> debugging output, only the iucode_tool says something like the below if
> you enable verbose output:
>
> # iucode-tool -v --kernel=/dev/cpu/microcode /lib/firmware/intel-ucode/06-3a-09
> iucode-tool: processed 1 valid microcode(s), 1 signature(s), 1 unique signature(s)
> iucode-tool: selected 1 microcode(s), 1 signature(s)
> iucode-tool: Uploading selected microcodes to: /dev/cpu/microcode
> iucode-tool: /dev/cpu/microcode: 1 microcode entries uploaded, 13312 bytes

Ah, dammit. I'm re-testing it now, and as you said, the microcode
isn't actually loading. I was testing with
arch/x86/kernel/cpu/{core,intel}.c added to
/sys/kernel/debug/dynamic_debug/control, I guess I must have decided
that it worked when I saw this:

[  159.485550] microcode: CPU0 found a matching microcode update with
version 0x25 (current=0x19)
[  159.485588] microcode: CPU1 found a matching microcode update with
version 0x25 (current=0x19)
[  159.485615] microcode: CPU2 found a matching microcode update with
version 0x25 (current=0x19)
[  159.485640] microcode: CPU3 found a matching microcode update with
version 0x25 (current=0x19)
[  159.485664] microcode: CPU4 found a matching microcode update with
version 0x25 (current=0x19)
[  159.485689] microcode: CPU5 found a matching microcode update with
version 0x25 (current=0x19)
[  159.485713] microcode: CPU6 found a matching microcode update with
version 0x25 (current=0x19)
[  159.485731] microcode: CPU7 found a matching microcode update with
version 0x25 (current=0x19)

I thought I had checked /sys/devices/system/cpu/cpu0/microcode/version
afterwards. But apparently I didn't. Bleh. Sorry about that.
