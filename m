Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF271C2D0C0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 02:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A429920715
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 02:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577154476;
	bh=urdNwQ/OTeq2Z4hdgMEm4P258E+sy9JNDdnsxX/A+m0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rULlLledxWiG3h/7f+l6T0hghVRCc8st3bSGd2Zpw4nl3UWOLM3Dd/YJkURYeYeg0
	 qbIm9NO8t8MJIyfH31HupvGGUOTk+BSy+SR2AoPkuWZ410NYTnzZsD0CERtJtxsYB8
	 UbfyZTxs9oioJlGHDayD8SBkCbFw2lN2lbIrQYAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfLXC1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 21:27:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:51000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbfLXC1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 21:27:55 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B48720715
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 02:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577154474;
        bh=urdNwQ/OTeq2Z4hdgMEm4P258E+sy9JNDdnsxX/A+m0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e5/A2TMzWmvgBVcYJhSASriiw23lUwDkTKRRrtVzBPcnxYy86U7OFXx0HfahVlJoE
         gR4r6zzD7UbCJZ6hzzKPUkP9RiRaHMYXHegUwL+YEO5JXAbwTkd+koSfO5sdzwK5Kg
         cSsvwQzIEipkLbhYGIOw86xV4zgHkcuJxD1NzlXU=
Received: by mail-wr1-f43.google.com with SMTP id q6so18585593wro.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 18:27:54 -0800 (PST)
X-Gm-Message-State: APjAAAU/ULMqPSJPf6PLvzcqUmKJAUY4yjnQJdqksqczHs8r2lG0bZ22
        2yeREdtC1OZRO19cYqOeXGpXnVSB0wVd0r2Hs3B2Uw==
X-Google-Smtp-Source: APXvYqzX7Wx0WQQGQxSsSx/rylu702E8XhFQtmBzrPd/vN45dmJAZ0EePwEz406rgBkEgebEu04CDi9IHkjEhDWde+I=
X-Received: by 2002:adf:f20b:: with SMTP id p11mr31631213wro.195.1577154472974;
 Mon, 23 Dec 2019 18:27:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577111363.git.christophe.leroy@c-s.fr> <02861d0a05c2d48db4e9ee9093e2e2598093c372.1577111366.git.christophe.leroy@c-s.fr>
In-Reply-To: <02861d0a05c2d48db4e9ee9093e2e2598093c372.1577111366.git.christophe.leroy@c-s.fr>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 23 Dec 2019 18:27:40 -0800
X-Gmail-Original-Message-ID: <CALCETrW9hsrVVzudvRY22AqakcsrVzqp=SdwOTwW2zRBK+kEaA@mail.gmail.com>
Message-ID: <CALCETrW9hsrVVzudvRY22AqakcsrVzqp=SdwOTwW2zRBK+kEaA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/10] lib: vdso: get pointer to vdso data from the arch
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
> On powerpc, __arch_get_vdso_data() clobbers the link register,
> requiring the caller to set a stack frame in order to save it.
>
> As the parent function already has to set a stack frame and save
> the link register to call the C vdso function, retriving the
> vdso data pointer there is lighter.

I'm confused.  Can't you inline __arch_get_vdso_data()?  Or is the
issue that you can't retrieve the program counter on power without
clobbering the link register?

I would imagine that this patch generates worse code on any
architecture with PC-relative addressing modes (which includes at
least x86_64, and I would guess includes most modern architectures).

--Andy
