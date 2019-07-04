Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA31C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E209821882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="noWI4Xsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfGDHQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:16:25 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39752 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbfGDHQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:16:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id v18so5072889ljh.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 00:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CM3CA+ac86LStxn0A7zCf+sHc6gVIK+nURjGT/ZVURM=;
        b=noWI4Xsww4AJnpE58QFOvduhB9wBWDFkpSe+Vwy2fZ0AOCB5779/gGsN9l9X3L3+Vz
         2U5Mk11jDXkh5zK+rXiY70rSTYMLGD7BnXPYnyoCcVx8i4GKaFI7DmR0K3KNh6+ITsLa
         +ZIwOEF1CtSL/fsKuACAzNIn1sAWmf3FOy9180YbvETQeZ8FwqoZUTSzZJ38suahAHQ6
         2/pTGWkhA96+/1UdRfkOfONEpVlxYmnxyH5DD4tqyT6zU50JG5MO65uD+2RKBnlx17GQ
         u3caugrGFRIDPf3gx/miR319qEwsnJDN2icdIMupqu+FmXg/MqUQprrULNQponZsL/jF
         B9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CM3CA+ac86LStxn0A7zCf+sHc6gVIK+nURjGT/ZVURM=;
        b=dT1kO/Jqcig0OaiviuzNbOIpMkllA2PzcckNl3Vapq9tEItKrxNBdWuZVFpigRBWlO
         hCNsxGWzddKL/Z0pHP3j+OjNhTFIcu3NV8LjB6W0kK1UD67Nk395glgKv3BvzYB2kvgl
         Ntm2mzBzLUDcN8h2tJgiGdUacxUHkdA7WnrLmDa++N/i6TECQEMBJWGFfeIxpcO/qRSQ
         +AXMNRFjWNGnKKCcLC/I3h6wLNsF0DiZsQZcLCnUXBAQmx5JGFtnpgY+ZGcHvw4k0/8Q
         +c/ToGJgrr43A+K3p2Effcnx9xqdx1s0GPiqYPZw4Or4SUjRfcthvKsoK8xcJ3hbHUGN
         SPBQ==
X-Gm-Message-State: APjAAAWq8ht1GPErBTmwDH8jnYEFONuujyJedCEx4Oshf41M58dETeX3
        YB99Tnix51TcRYLjXqGWOhcwb43lykgC3em6B4956A==
X-Google-Smtp-Source: APXvYqzE9S7+MBd9cz3CLYgD2cxe0CiQIYN/YmMnO+BXFTBBIuqXEJP5eErh26Lm2r6+xg1JL2/RPnz20gM0wD6QESg=
X-Received: by 2002:a2e:8195:: with SMTP id e21mr5076509ljg.62.1562224582501;
 Thu, 04 Jul 2019 00:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190703171924.31801-1-paweldembicki@gmail.com> <20190703171924.31801-4-paweldembicki@gmail.com>
In-Reply-To: <20190703171924.31801-4-paweldembicki@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Jul 2019 09:16:10 +0200
Message-ID: <CACRpkdaLZ8XeyLhH_mzwb5phRNvuwuUgecWKBVa1Z7L0QqH_bw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] net: dsa: vsc73xx: add support for parallel mode
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        netdev <netdev@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pawel,

this looks overall good and the following is just
documentation nit-pick so feel free to add my
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

On Wed, Jul 3, 2019 at 7:21 PM Pawel Dembicki <paweldembicki@gmail.com> wrote:

> This patch add platform part of vsc73xx driver.
> It allows to use chip connected by parallel interface.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

I would elaborate on the fact that we're dealing with memory-mapped
I/O but perhaps even more important to do that in the source code file and
Kconfig so it is close to the users rather than in the changelog.

Write something about the address bus wireing making all
accesses big endian.

> +config NET_DSA_VITESSE_VSC73XX_PLATFORM
> +       tristate "Vitesse VSC7385/7388/7395/7398 Platform mode support"
> +       depends on HAS_IOMEM
> +       select NET_DSA_VITESSE_VSC73XX
> +       ---help---
> +         This enables support for the Vitesse VSC7385, VSC7388, VSC7395
> +         and VSC7398 SparX integrated ethernet switches in Platform managed mode.

I would insert something about memory-mapped I/O mode
over a CPU-attached address bus.

Yours,
Linus Walleij
