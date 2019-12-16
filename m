Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8340AC2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E45206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfLPItV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 03:49:21 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:33031 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfLPItV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 03:49:21 -0500
Received: by mail-ot1-f50.google.com with SMTP id d17so8274140otc.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 00:49:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t3tpSwE7m7poBVzPd8EZu474xjqUfv4oG2KZ3IU+yZc=;
        b=BcDMLd0BosYKEPsNx6SbLfgHzIppqC23l4MUEV7F9RishE/dK+8kb8qtTpkTdGgiRf
         N6bk5DacCRn91mHbsj3DopRK0JYyCLrSZdpvQ54Zgxe9qclgvP+ZctOMlPylBcueqQoI
         Z34Ye11czpEasaQcgOAn9JN5NIia2d3Fy8QaFILrLHAgLX8fYqmJhvx2u4hQ4B8ANM7h
         39kHFGl3s/XGEOFCieVj0AJX+MpBHcnP/HUc/y2kWPq9Jt4bfEuvPJ9lEqBtQkKQ8m8z
         n9P3gG2yl2At5k7We+PdksfLAY4K6s4zATZQZSk01dA2NnklqYRVTB520Hu7g26AHbNg
         y3qw==
X-Gm-Message-State: APjAAAXK4mmv3uSo7XpsWzT/4dvRtZ8RKiGUFn2/k7ccNISmcYUvEwI1
        kmwtdK/4dI0mlaA/++mEXEJ1jR9ioT8LshAzu+a30FTB
X-Google-Smtp-Source: APXvYqzRKELwCr0XO/6x7gN8sFTvhH3qjoyCLrwzYNnLz1qIygqROXs6kzATz14rUugVvJ+VzO/0TaipbKfb6l72Q2k=
X-Received: by 2002:a9d:2073:: with SMTP id n106mr30701941ota.145.1576486159745;
 Mon, 16 Dec 2019 00:49:19 -0800 (PST)
MIME-Version: 1.0
References: <20191216083658.21386-1-geert@linux-m68k.org>
In-Reply-To: <20191216083658.21386-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 Dec 2019 09:49:08 +0100
Message-ID: <CAMuHMdUaRdyRigwS+fdju1_PQCahONVFPKu0DbX6hhb7=JXmLA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.5-rc2
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Dec 16, 2019 at 9:38 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v5.5-rc2[1] compared to v5.4[2].

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/d1eef1c619749b2a57e514a3fa67d9a516ffa919/ (all 232 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/219d54332a09e8d8741c1e1982f5eae56099de85/ (all 232 configs)

>   + /kisskb/src/arch/m68k/include/asm/string.h: warning: '__builtin_memcpy' forming offset [3, 4] is out of the bounds [0, 2] of object '__gu_val' with type 'short unsigned int' [-Warray-bounds]:  => 72:25

The upgrade from gcc 4.6.3 to 81.0 seems to have revealed a potential
issue in get_user() in arch/m68k/include/asm/uaccess_no.h.

        #define get_user(x, ptr)                                        \
        ({                                                              \
            int __gu_err = 0;                                           \
            typeof(x) __gu_val = 0;                                     \
            ^^^^^^^^^
            This is the type of the destination

            switch (sizeof(*(ptr))) {                                   \
            case 1:                                                     \
                __get_user_asm(__gu_err, __gu_val, ptr, b, "=d");       \
                break;                                                  \
            case 2:                                                     \
                __get_user_asm(__gu_err, __gu_val, ptr, w, "=r");       \
                break;                                                  \
            case 4:                                                     \
                __get_user_asm(__gu_err, __gu_val, ptr, l, "=r");       \
                break;                                                  \
            case 8:                                                     \
                memcpy((void *) &__gu_val, ptr, sizeof (*(ptr)));       \
                break;                                                  \
            default:                                                    \
                __gu_val = 0;                                           \
                __gu_err = __get_user_bad();                            \
                break;                                                  \
            }                                                           \
            (x) = (typeof(*(ptr))) __gu_val;                            \
            __gu_err;                                                   \
        })

ext2_ioctl() calls this like

        unsigned short rsv_window_size;
        if (get_user(rsv_window_size, (int __user *)arg)) { ... }

So a 32-bit value is being copied to an unsigned short value, leading
to the warning (for the memcpy() in the non-taken "case 8" branch).

Fortunately the compiler emits a register move for this, so no real harm
is done:

        | fs/ext2/ioctl.c:123:          if (get_user(rsv_window_size,
(int __user *)arg))
                move.l 48(%sp),%a0      | arg,
        #APP
        | 123 "fs/ext2/ioctl.c" 1
                movel (%a0),%d2 | *arg.32_43, __gu_val

The corresponding code in arch/m68k/include/asm/uaccess_mm.h
uses a temporary __gu_val of the right sized type based on the source
type to avoid this.


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
