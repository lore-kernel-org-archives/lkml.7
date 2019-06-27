Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F69C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BEA208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Twrm3tZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfF0SDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:03:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35805 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfF0SDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:03:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id s27so1372930pgl.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 11:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dSVmBke0G+Dn1r5o72Lsio2Nc6Y+VGkRek2GyEWlv1Y=;
        b=Twrm3tZCR5bcxA3sKzMt9LXwhFdDc9+denzp9LYr1wcJq7smxQRGHp2brrBoQkfirk
         Y7wCFbbB/owyKP4zfUGmnV7t0Ie6jYAUccbNF8Z/TunU7spLNyYQei1PH79kXELRYUpo
         hGt0DwSzcR0iGLxRVpSep6DXW0p3C8RNQA/RuDVb/UfLttWuR7RvyvxTnEEw0icSmNNT
         1qMjFF5o+e1T5QeEz3zFJFEPDkOSn6r0uSDTeBbacWq3enMF73azRz6Elr3eITFpPDgG
         O7mzCB3x8XcyvXaON0IIOKgOCdSsyMaKrMucaTSiK8uDPIPq6tZcnD5onjFEKwPlLMpN
         vGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dSVmBke0G+Dn1r5o72Lsio2Nc6Y+VGkRek2GyEWlv1Y=;
        b=SRlf2PKeHP5HrkU4SR51+VAOFkGxGXqhtOBUQSyQ1tzf9mDfgLcxOFBxww5Z8qYYmM
         i0uqcWXyZ1AngsG4ofibnC7LRhK0rIPd4aZauDEL4pUJsS8RHG8tqC2BoGE89YxUps3x
         BwXAiq+2M1eDlsxpxc4BulsMMizHVN+gq1wWK/uecpxY4wkVfkgElnhYXnJMaA2VbRJM
         i6Gcd8u5YkUVj+H9KEwuoAdE0enwkdKjMneWtTSA79XRwm7acX/LSC+puNCKo5CZaui7
         s9pqtSAVv+on/RPMycZPpXpbq2fVmNfcCXbe12AH7ZUVb6he+n+lXBs5YEuHt6HkulIM
         LOQQ==
X-Gm-Message-State: APjAAAVOxpI1UJruM9VRwa3WO1j+08e4Bbm8oIn5Uxl1OguNiwB/5mlz
        o1ZEg0Z/DmXme8mRe64qth3uH3FVyIZE8r78BuXF3Q==
X-Google-Smtp-Source: APXvYqzHTAtAN0b7eRnQzmgwJdfVEUyQltG/gLUMrfgaSST7BJe3gx7SB2VjSyVLdQqGkj4eXCRJWPxswi0ijICgBiI=
X-Received: by 2002:a63:78ca:: with SMTP id t193mr4921106pgc.10.1561658615016;
 Thu, 27 Jun 2019 11:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190617222034.10799-1-linux@rasmusvillemoes.dk>
 <20190617222034.10799-8-linux@rasmusvillemoes.dk> <CAKwvOdn5fhCTqtciKBwAj3vYQMhi06annzxcdC1GjKxri=dHnw@mail.gmail.com>
 <12bd1adc-2258-ad5d-f6c9-079fdf0821b8@rasmusvillemoes.dk> <CAKwvOdkqy8=V17qEM_SMDEAh=UX5Y2-nj9EUkC169nEiXc_JzA@mail.gmail.com>
 <70aa7b96-e19d-5f8b-1ff6-af15715623e5@rasmusvillemoes.dk> <CAKwvOdkWo5yG7LrtGL_ht-XHFgNqx_t6rP+hHhcPyb+Ud1N+HA@mail.gmail.com>
 <CAKwvOdnFt18ffO0BV-AZ9+mYuOBMroPObxrakXdV1v4iL3CS3Q@mail.gmail.com> <4e9d2103-2186-308b-c560-830c57ee3a6d@rasmusvillemoes.dk>
In-Reply-To: <4e9d2103-2186-308b-c560-830c57ee3a6d@rasmusvillemoes.dk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 27 Jun 2019 11:03:23 -0700
Message-ID: <CAKwvOdkQ5FmaKNSfDR39aC7P7UdU5f8ktzoBJDk=1aAXtYLaNQ@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] dynamic_debug: add asm-generic implementation for DYNAMIC_DEBUG_RELATIVE_POINTERS
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 4:52 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 27/06/2019 01.16, Nick Desaulniers wrote:
> > On Tue, Jun 25, 2019 at 3:18 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> >
> > The prints should show up in dmesg right, assuming you do something to
> > trigger them?  Can you provide more details for a test case that's
> > easy to trip? What's an easy case to reproduce from a limited
> > buildroot env (basic shell/toybox)?
> >
>
> Hm, I seemed to remember that those kobject events triggered all the
> time. Oh well, try this one:
>
> echo 'file ping.c +p' > control
> ping localhost
> dmesg | grep ping

I don't have guest networking setup from QEMU to host, so there's no
network available to ping. :(

but:

(initramfs) echo 'file drivers/tty/*.c +p' > /dfs/dynamic_debug/control
(initramfs) grep tty /dfs/dynamic_debug/control
...
drivers/tty/serial/8250/8250_core.c:113 [8250]serial8250_interrupt =p
"%s(%d): start\012"
drivers/tty/serial/8250/8250_core.c:139 [8250]serial8250_interrupt =p
"%s(%d): end\012"
...
(initramfs) dmesg
...
[  134.895846] serial8250_interrupt(4): start
[  134.895967] serial8250_interrupt(4): end
[  134.895970] serial8250_interrupt(4): start
[  134.895981] serial8250_interrupt(4): end
[  134.895998] serial8250_interrupt(4): start
[  134.896053] serial8250_interrupt(4): end

I then verified that nothing new appears in dmesg related to these
traces after running:
(initramfs) echo 'file drivers/tty/*.c -p' > /dfs/dynamic_debug/control

so if that's good enough, then for the series:
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks,
~Nick Desaulniers
