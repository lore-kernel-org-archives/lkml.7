Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28698CA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15472086D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="DrBwmdA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfKAKMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 06:12:24 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38507 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfKAKMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 06:12:23 -0400
Received: by mail-qk1-f193.google.com with SMTP id e2so10137941qkn.5;
        Fri, 01 Nov 2019 03:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ND8y/KAJEHxe8vYu6nFNiGmvLZloLNx/Qhcmj2riyfs=;
        b=DrBwmdA2hyuypUMdqsxgKAPOBwvzb/c3z7uksP87rq82GzxeMEHhvZFCbdACHdfw8N
         vjkd6BctJNzkmDNGqy5YoXmnCNryXR+Cq3mWpEqQz0/vV6JZZg/cExsisJWSnJ5c3vig
         rwnuKfQ2s4VZLHbJovbnP2amAl6xDURhPW/7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ND8y/KAJEHxe8vYu6nFNiGmvLZloLNx/Qhcmj2riyfs=;
        b=d9/Ue5/w6UE+nmAtHjisD2Xj9eu2FJafoC4sPZc3psCbQllS8NP8y9ESTF9bKYsOK5
         TipoMGwaAysYtqIzZOmZsGmwonlFcmgBxlm6BM8YwxR2dUnVJMXmqxlORTFd41rmJl+v
         f45Nje1FZvb2e5GLXc1pvDd7Skew/SnGwWC85dSP1mAaF3rBqIu8cOqnjmVfJoRMFEuw
         TO7nNOkLTbMCGBBSEE4POB4Fp8Echusz/rH9YKNe7NYbMcPP890y/NKUcpdj61pAt5d6
         wQYD17rNEyduBA+dYBG0pwSFQ7FoXS2iTAajd79wVpvqO8HbalPrzTd7nCmtN0uX0N2i
         BMGQ==
X-Gm-Message-State: APjAAAWEJQyPS2lCbcI0Wadqx7oyQyIsPU4hYsgc/GW/VPiiwOH3Ce4p
        VbimnM+dxh0+OauoRaMLB57uVQJgxsrs5zUL0pU=
X-Google-Smtp-Source: APXvYqwoU1k7FEmT61Ivo0VZaveC+nWADRFHlsA0BlwLNyI+e6RuAdTXAbMLTDbS33RCVwVgM/jm6sohxZSvu01ohA8=
X-Received: by 2002:a37:5fc1:: with SMTP id t184mr2349520qkb.171.1572603142333;
 Fri, 01 Nov 2019 03:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20191021194820.293556-1-taoren@fb.com> <20191021194820.293556-2-taoren@fb.com>
In-Reply-To: <20191021194820.293556-2-taoren@fb.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 1 Nov 2019 10:12:10 +0000
Message-ID: <CACPK8XfebA9PcpyWkofCJ5fAZ9ddUjQ4ZeCf73KXb51+k_+N1Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] ARM: dts: aspeed: add dtsi for Facebook AST2500
 Network BMCs
To:     Tao Ren <taoren@fb.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 at 19:49, Tao Ren <taoren@fb.com> wrote:
>
> Introduce "facebook-netbmc-ast2500-common.dtsi" which is included by all
> Facebook AST2500 Network BMC platforms. The major purpose is to minimize
> duplicated device entries cross Facebook Network BMC dts files.
>

> +
> +&mac1 {
> +       status = "okay";
> +       no-hw-checksum;

Was this included to work around the IPv6 issue that Benh recently fixed?

If you can test your platform with
88824e3bf29a2fcacfd9ebbfe03063649f0f3254 applied and the
no-hw-checksum property removed, please send a follow up to remove
this property.

It's not doing any harm, but by cleaning it up there's less chance
others blindly copy the same thing.

Thanks,

Joel

> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
> +};
