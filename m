Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F99FC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 00:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468592068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 00:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="SwDeNapr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfKVAay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 19:30:54 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43104 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKVAax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 19:30:53 -0500
Received: by mail-ed1-f67.google.com with SMTP id w6so4425149edx.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 16:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p8S5GRxfxB7MPCj+Eww2v+N3SSDa3SwY872hQxbGyeE=;
        b=SwDeNapr8C2hZtNWi6QBd3lpU7IbLJ10rTgPoY37OuwGIIHILjqN8ZXIj83SFbbr7g
         YzAi6ZwttEnHRQxMLHdr0KR362IBbLpoJ5EQeuCtrhGYhqHmbxJ2UblkssOkCiA4sPgS
         Rml0Bkr1b8tqWCIvh+G9oBFMyxor3gMwJDbS/53jn8rJ3kmsZTBXA1PjvNfIKfTdTwLC
         wF3jnFSC3C9BdMkjWYAGvnrnEMotMC0HvDkDZ3uMzOkU+lr7w1aQmLJPPyOQb/OkjBFA
         PHVlsE9Glij+peO87AM8pBwdkmSWP8tNYMCmSsqv0mrQedYRcQNccHHzELqAuMzRn8/g
         566A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p8S5GRxfxB7MPCj+Eww2v+N3SSDa3SwY872hQxbGyeE=;
        b=CEIU/AhVR7k+Y1PUaLkaowExjkSgp89axzGMbYtZ8+Td8ADrA9T3bEqme1h7RCdyXc
         7wAL0eDypyf6n8N46/siV4XJE5R/LlV7wTv/2PUOIfLfKe7w6XgtY9l5ZQyf4b3tMqpt
         wgGCRi45HUZLNBKpW9VXO56him1fGWAlb9lpl1muJ446/4HTVbEZi33LNzQ+zoNZ3RfA
         uf7dL+km3m+z+Agopy/u78aKOOZM8nGtJ1YNhQhclOxBG7Di0CW0UbbKv3n9LRoeI+62
         5R4AGXlAUlQocIaBzQOsbUAQaXqM0iPbLHwVatkXtldPvhaMblNIpdHjcCeCjc0rU0ll
         QXeQ==
X-Gm-Message-State: APjAAAU2g4T04GL70CNeCSgxdAT72hIGEHKe76HkFg1YxCY+1scWNdIX
        EgLZ5KGgBRh4qVTPsSdHb5iNS6cfoQ+7nlzFj59IaA==
X-Google-Smtp-Source: APXvYqybAjsW4IBztIRMQztbxdt6s24fSxLSh87RJOD7czfT0URIvB2H9RrIUrGlfVNwROY40qStEmAhGA2156oOCE0=
X-Received: by 2002:a17:906:90b:: with SMTP id i11mr18003315ejd.109.1574382651825;
 Thu, 21 Nov 2019 16:30:51 -0800 (PST)
MIME-Version: 1.0
References: <20191121184805.414758-1-pasha.tatashin@soleen.com>
 <20191121184805.414758-2-pasha.tatashin@soleen.com> <20191122002258.GD25745@shell.armlinux.org.uk>
In-Reply-To: <20191122002258.GD25745@shell.armlinux.org.uk>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 21 Nov 2019 19:30:41 -0500
Message-ID: <CA+CK2bDtADA2eVwJAUEPhpic8vXWegh8yLjo6Q6WmXZDxAfJpA@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm/arm64/xen: use C inlines for privcmd_call
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, steve.capper@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        sstabellini@kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, stefan@agner.ch,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +#ifdef CONFIG_CPU_SW_DOMAIN_PAN
> > +static __always_inline void uaccess_enable(void)
> > +{
> > +     unsigned long val = DACR_UACCESS_ENABLE;
> > +
> > +     asm volatile("mcr p15, 0, %0, c3, c0, 0" : : "r" (val));
> > +     isb();
> > +}
> > +
> > +static __always_inline void uaccess_disable(void)
> > +{
> > +     unsigned long val = DACR_UACCESS_ENABLE;

Oops, should be DACR_UACCESS_DISABLE.

> > +
> > +     asm volatile("mcr p15, 0, %0, c3, c0, 0" : : "r" (val));
> > +     isb();
> > +}
>
> Rather than inventing these, why not use uaccess_save_and_enable()..
> uaccess_restore() around the Xen call?

Thank you for suggestion: uaccess_enable() and uaccess_disable() are
common calls with arm64, so I will need them, but I think I can use
set_domain() with DACR_UACCESS_DISABLE /DACR_UACCESS_ENABLE inside
these inlines.

Pasha
