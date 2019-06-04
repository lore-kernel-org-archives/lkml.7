Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A0EC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC38C24AE7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfFDIjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:39:18 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37624 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfFDIjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:39:18 -0400
Received: by mail-lj1-f195.google.com with SMTP id 131so6296949ljf.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 01:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9xato1BCEq26RttB9WJaXFUtXlK3fwUaQ8EgAcw4Cho=;
        b=k2NP38zBrDhetwa2IOSywHBW1BYkbxJ6BpKTh8I7162p+nZBxyBUD8/GLsT+so4B/8
         QQ18HYXdKeS58yCH6B20uz4g+wTsJcZYcUZbTWxLqnS7SCWdZjDnF6sE96ALAUljDqjX
         E0gTiUFG2gMMfNbFxvxwPEFDG13dEn1b3p/dqr/resnP81jod7L8JQLGO7hEk4UwMbIJ
         9yPIXB+5rNwqbrtek40PuZ0BZoMKT3PNsBZ5P69b/9Bgqem210y2eA2otVquvCvKGEa6
         TizB32GLqNxiN12nLZPNEQVKa5SIzmEv04yEOKow2PFYdCwEm3n8tIfqqQaRUAAbr0ZB
         l0vg==
X-Gm-Message-State: APjAAAVbPYap2867HqZ5iRePOcbli7nkBrV/OVR7xTCAhoYD1+LKdoyQ
        JfYe2idBrDu2qL0fsKCKxHzOc1fyMYnAfyYNVYo=
X-Google-Smtp-Source: APXvYqxy7Ag7WV++nrHSaEzq0p+KiFQtOblkS7DO6Ef7a9NePpHD5Z2RcxES4a5vqvfAcHwawJrJHiYRzAsGy28OSwc=
X-Received: by 2002:a2e:8555:: with SMTP id u21mr15833923ljj.133.1559637556348;
 Tue, 04 Jun 2019 01:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <1559635284-21696-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1559635284-21696-1-git-send-email-krzk@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jun 2019 10:39:04 +0200
Message-ID: <CAMuHMdXT+mvKSnR7suUEA9pN6hsWKM_M+gGiOM8TdpBt4fF93w@mail.gmail.com>
Subject: Re: [PATCH] x86: configs: Remove useless UEVENT_HELPER_PATH
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 10:03 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Remove the CONFIG_UEVENT_HELPER_PATH because:
> 1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
>    CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
>    made default to 'n',
> 2. It is not recommended (help message: "This should not be used today
>    [...] creates a high system load") and was kept only for ancient
>    userland,
> 3. Certain userland specifically requests it to be disabled (systemd
>    README: "Legacy hotplug slows down the system and confuses udev").
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
