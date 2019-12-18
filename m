Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C977C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F041D2072B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Yc9HL4dm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfLRVLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:11:15 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36064 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfLRVLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:11:14 -0500
Received: by mail-ed1-f68.google.com with SMTP id j17so2842554edp.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hr7toINHw/iAnDrTVS41gqcv0IO9jGOGlaJRRX6HtRc=;
        b=Yc9HL4dmvuVtA1hqpH3w649GWiSriaIdkvI8nXwcp2OqH8ZA710XQUf7rzqbIvmvSs
         wIQ2X1WO0b68Wrbnx34fUtBQ4DUY9+cutDhxyPRLLXCzDzQgIlSmRi88M4J7y5OTFAdf
         utyUH6R7V4Wg6zCugkdFlYh+oiEMcrcthwzghhD8AeCnoCByKEw/uRG4Khy9wPOpXezo
         LVA1NJynvisLO8eCsjUz5L222tAGwjRM+e+BzIAeK379y0NcuXcnvHZ3PW8pguMmhDm5
         /oUXQ4+shDdOnc0H1rtFMsxegKAuoDq2jO7t51FvxpHfoVPyfJ96EjLF8IOi51I8dG3H
         sfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hr7toINHw/iAnDrTVS41gqcv0IO9jGOGlaJRRX6HtRc=;
        b=Vzj4UmP13AVuB0ZhHS9WqmdH2cN6SM3GCwIH61bu6h1VnoKGPREnBQCLTvpgHAzcFf
         umhxK2o2jMb3GhmNH2UGWy88aNsuINWGerA3N7imgpFz38TmrjVKf3Cp8wCCiWxII7LJ
         1l1pMBq2nteBzQkLuMfHOvZzR3114Yjs7pREYeQvp/9RnTc0R4rIgeN0BzStzUg/+WP9
         98KmhnFKH0/tB4om5hK4565EXC7463dUN1394u6dmau79/P2yh1TmvJNkzBn2iP8K55r
         IrA/vY9RScZN/60snGSlR2RA7kEiS9bh6mTPfGhdsnlV5moJ14gRbILG/JEdeAlCgyC9
         Ssag==
X-Gm-Message-State: APjAAAW9wcDHfysot9nYxKX9LlQxI2BncOUN/NDjEc/nnD0zuO0BAmmY
        yNpAUymOalUgL9CPTidW477T8cdwqyzThg9MHyVi4g==
X-Google-Smtp-Source: APXvYqxUveWYs+R5UGAvJL5Zp/Pe1Egw5UoWu7yq5s55Vn88PgYlF8axZ/QOJSQ2OANQC2UMBMt8bropFYpNPNkUfOs=
X-Received: by 2002:a05:6402:1cbb:: with SMTP id cz27mr4984720edb.227.1576703472972;
 Wed, 18 Dec 2019 13:11:12 -0800 (PST)
MIME-Version: 1.0
References: <20191204232058.2500117-1-pasha.tatashin@soleen.com>
 <20191204232058.2500117-2-pasha.tatashin@soleen.com> <c5dcf342-90f4-beb5-d2b1-4a37ccedfe42@xen.org>
In-Reply-To: <c5dcf342-90f4-beb5-d2b1-4a37ccedfe42@xen.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 18 Dec 2019 16:11:02 -0500
Message-ID: <CA+CK2bDySpttFq1ro2QK9jPoRi5unXz6bx-6Qv1OpoNimMd6Ug@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] arm/arm64/xen: hypercall.h add includes guards
To:     Julien Grall <julien@xen.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, steve.capper@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Stefan Agner <stefan@agner.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        xen-devel@lists.xenproject.org,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >       /*
> > -      * Whenever we re-enter userspace, the domains should always be
> > +      * Whenever we re-enter kernel, the domains should always be
>
> This feels unrelated from the rest of the patch and probably want an
> explanation. So I think this want to be in a separate patch.

I will simply remove this comment fix, since I do not change anything
else in this file anymore.

> The rest of the patch looks good to me.

Thank you Julien.

>
> Cheers,
>
> --
> Julien Grall
