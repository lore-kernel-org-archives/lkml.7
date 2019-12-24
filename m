Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333F3C2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 01:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042A32073A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 01:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577152793;
	bh=mZIM8/IGO6yj32EzkYlDoUvjeWHo1IO0ajLflWLHJ1E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GtXeNPWZR/jbxrMbJmh6Xjf6JrTgWd2K3TbSKoS08dhQ++a8BaA0Qvb2Tweh26eTN
	 BmoaWrLhmWCU8u65wd/iIBMGjFZ0PzlFx7k+pf94azi7DTo5ZGo/qmwXribiUT7q4e
	 Vt46hMnighF15vnIdakB/UJbqJK8me5GsajjlJR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfLXB7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 20:59:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:44522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbfLXB7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 20:59:51 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7C3A21927
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 01:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577152791;
        bh=mZIM8/IGO6yj32EzkYlDoUvjeWHo1IO0ajLflWLHJ1E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vE/azURLnH3qmHdn1hy96edh/OrB+2oiYVAPcoNChA1APgqTQyUag0cYd3A8FiQ3I
         z+MecPlyIZpolq5Y/HqAQ51oX17foKhSZtLpPUMoekuaY051HMxyJWgyQ6kFQpJYl/
         f4fGsUdpfoEdNSCX6ZJ9N8upAriGiQ56oRzvKg4s=
Received: by mail-wr1-f49.google.com with SMTP id g17so18583141wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 17:59:50 -0800 (PST)
X-Gm-Message-State: APjAAAVRhKg4vaq1t31aq6vp/o5AVYaq/7B6IY4cku5cWEJj89L6JK0y
        LeL6ft5b+JipcAdjlo17RpmmWAjr8KL155F3pYVxYQ==
X-Google-Smtp-Source: APXvYqxAMnRl94bz0dtBWu5DeU1T1h7ThWeUzu+q0KQ6Q4rmgmqNaGXBhJRposss35afzcm4hhvUi2inaUTSmKyfilU=
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr31723699wrp.111.1577152789083;
 Mon, 23 Dec 2019 17:59:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577111363.git.christophe.leroy@c-s.fr> <fdf1a968a8f7edd61456f1689ac44082ebb19c15.1577111367.git.christophe.leroy@c-s.fr>
In-Reply-To: <fdf1a968a8f7edd61456f1689ac44082ebb19c15.1577111367.git.christophe.leroy@c-s.fr>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 23 Dec 2019 17:59:36 -0800
X-Gmail-Original-Message-ID: <CALCETrUZ8rhvhJSYutypUoSf2tGBZPais79fx+8BHWH=Vk4dBw@mail.gmail.com>
Message-ID: <CALCETrUZ8rhvhJSYutypUoSf2tGBZPais79fx+8BHWH=Vk4dBw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/10] lib: vdso: Avoid duplication in __cvdso_clock_getres()
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 6:31 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> VDSO_HRES and VDSO_RAW clocks are handled the same way.
>
> Don't duplicate code.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-by: Andy Lutomirski <luto@kernel.org>
