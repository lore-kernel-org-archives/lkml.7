Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41349C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B3B216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561566705;
	bh=oU6jaBrSnygplxLUyMyEroKctG9J2Ei1tNH+gSDLVAk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rzKuTulBes9EIFslGcvSk5qx3ZWI8BgHGUkusPfRS12talhLtD69sg8kgK7kQt7Bh
	 SeUIYtWL3gQ5POn11AMR6w//n90Lh17Ls6Kwr0VnCwYMZUy2btkA6ZCG3nRtby0GtB
	 fzVmsM3gZqOgPQwTh/nPM4pdnyiKMlVzOiAwYqfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfFZQbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:31:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfFZQbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:31:42 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C2FA2182B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 16:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561566701;
        bh=oU6jaBrSnygplxLUyMyEroKctG9J2Ei1tNH+gSDLVAk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QgWp2Kq0om1VdQ9V/HwshKaxvMVEWZtAeUAw6z7hc0QFNz6whhSWt/PwQ0JGsE3PZ
         +seWqralH37FOI19PNx5AAKRJCdn/h7Umb8/kZtWR0QiWcUTx8j31mA0/W/+UCzOkE
         FS/1Ksn3MM2uhGyacJfoGf9ERdF+PN9RwHfbihTs=
Received: by mail-wm1-f54.google.com with SMTP id c6so2772998wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 09:31:41 -0700 (PDT)
X-Gm-Message-State: APjAAAW+OQVF19O4hsHQa3J3l/qfE5Xa3Khc7O3UNn1mpeelM/UgnvoC
        eERK7A2BqoPjF6dRcqlsMahLdE8CWpHgISzswXs4Bg==
X-Google-Smtp-Source: APXvYqx/2ylJRZBTN4py1K7MyVeOZWZ6QdrhNVtJzeb0bKAaChEP0NR5KWyGfaLK5cttoijS9AYPMt8eZnUj0uGv15Q=
X-Received: by 2002:a7b:c450:: with SMTP id l16mr3515337wmi.0.1561566697863;
 Wed, 26 Jun 2019 09:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de> <tip-e70980312a946a56173843cbc0104b3b0e57a0c7@git.kernel.org>
In-Reply-To: <tip-e70980312a946a56173843cbc0104b3b0e57a0c7@git.kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 26 Jun 2019 09:31:26 -0700
X-Gmail-Original-Message-ID: <CALCETrWaUEnnTiyh-xDoywji1GdfoeoSmy635MYcXMe9CgYkCA@mail.gmail.com>
Message-ID: <CALCETrWaUEnnTiyh-xDoywji1GdfoeoSmy635MYcXMe9CgYkCA@mail.gmail.com>
Subject: Re: [tip:timers/vdso] MAINTAINERS: Add entry for the generic VDSO library
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrey Vagin <avagin@openvz.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Safonov <dima@arista.com>,
        Peter Collingbourne <pcc@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Shuah Khan <shuah@kernel.org>,
        Shijith Thotton <sthotton@marvell.com>,
        Sasha Levin <sashal@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Huw Davies <huw@codeweavers.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 5:37 AM tip-bot for Thomas Gleixner
<tipbot@zytor.com> wrote:
>
> Commit-ID:  e70980312a946a56173843cbc0104b3b0e57a0c7
> Gitweb:     https://git.kernel.org/tip/e70980312a946a56173843cbc0104b3b0e57a0c7
> Author:     Thomas Gleixner <tglx@linutronix.de>
> AuthorDate: Mon, 24 Jun 2019 02:34:24 +0200
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Wed, 26 Jun 2019 07:28:11 +0200
>
> MAINTAINERS: Add entry for the generic VDSO library
>
> Assign the following folks in alphabetic order:
>
>  - Andy for being the VDSO wizard of x86 and in general. He's also the
>    performance monitor of choice and the code in the generic library is
>    heavily influenced by his previous x86 VDSO work.
>
>  - Thomas for being the dude who has to deal with any form of time(r)
>    nonsense anyway
>
>  - Vincenzo for being the poor sod who went through all the different
>    architecture implementations in order to unify them. A lot of knowledge
>    gained from VDSO implementation details to the intricacies of taming the
>    build system.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: linux-arch@vger.kernel.org
> Cc: LAK <linux-arm-kernel@lists.infradead.org>
> Cc: linux-mips@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Mark Salyzyn <salyzyn@android.com>
> Cc: Peter Collingbourne <pcc@google.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Huw Davies <huw@codeweavers.com>
> Cc: Shijith Thotton <sthotton@marvell.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Dmitry Safonov <dima@arista.com>
> Cc: Andrei Vagin <avagin@openvz.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Michael Kelley <mikelley@microsoft.com>
> Cc: Sasha Levin <sashal@kernel.org>
> Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de
>
> ---
>  MAINTAINERS | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d0ed735994a5..13ece5479167 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6664,6 +6664,18 @@ L:       kvm@vger.kernel.org
>  S:     Supported
>  F:     drivers/uio/uio_pci_generic.c
>
> +GENERIC VDSO LIBRARY:
> +M:     Andy Lutomirksi <luto@kernel.org>

s/ksi/ski :)

Yes, it's a mouthful.

--Andy
