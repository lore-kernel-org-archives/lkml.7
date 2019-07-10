Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA25C74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E798C2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562778128;
	bh=0A6ZTzIyBGFAfbsBGr87hqddBcLIH2KmFnUom+mbnfo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ze7y4ZO7LZQfakKhHlc2K6a3gJJxKVTEioaJF6qJSkTZ5LoGDTrqifgMCRV3vSuJE
	 nT0aeLpiOT4jrI5IOAt+XMFaznW/s/GOg0WY1Bx3B4ReA5BjHauVHeZmJ3a4Cjahgl
	 DxqWKX2g+zif9TsDTCaft797AXCGsb98HOfvxqbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfGJRCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 13:02:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfGJRCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 13:02:06 -0400
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B41421530;
        Wed, 10 Jul 2019 17:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562778124;
        bh=0A6ZTzIyBGFAfbsBGr87hqddBcLIH2KmFnUom+mbnfo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ncRNCFkT6ApV3yScc8XizT9TAOlzHY6AFXesiDEKdFwFYWV/1uFC9l+cI57EMhTTm
         s/6w+5Uqe14zOlEZ82f5B3CdBj31fd59ATeF0AOKRyIE1Kfa4xGCABJ1rPECrWmXAg
         5RVVOkut49aSxv6P2kQW5AgijYQYX0WaFLpmJX3I=
Received: by mail-lj1-f170.google.com with SMTP id p17so2839449ljg.1;
        Wed, 10 Jul 2019 10:02:04 -0700 (PDT)
X-Gm-Message-State: APjAAAVEWTWY6lxqcdVOdCa6i08oN2OHSwviAtmIVwSWLIdTVaw/MD3r
        OGdA7zvqTWw7kaMfiVtQrHdJ4nePwl7x5jBv5kg=
X-Google-Smtp-Source: APXvYqyWb8b/hmxoFrfvlDWU3IPgcVGPZ13o1DOOgNtiaOiFrg6Fmx//C+LLQngzv8et5vCS3ozwNOYtKG9OjsA1/0k=
X-Received: by 2002:a2e:8155:: with SMTP id t21mr17900333ljg.80.1562778122981;
 Wed, 10 Jul 2019 10:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190708141159eucas1p1751506975ff96a436e14940916623722@eucas1p1.samsung.com>
 <20190708141140.24379-1-k.konieczny@partner.samsung.com> <20190708141140.24379-2-k.konieczny@partner.samsung.com>
In-Reply-To: <20190708141140.24379-2-k.konieczny@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 10 Jul 2019 19:01:51 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfJ57RBYg_drzALChNqHD_ueVfNc-tAhOdLYdY2A4G2Tg@mail.gmail.com>
Message-ID: <CAJKOXPfJ57RBYg_drzALChNqHD_ueVfNc-tAhOdLYdY2A4G2Tg@mail.gmail.com>
Subject: Re: [PATCH 1/3] opp: core: add regulators enable and disable
To:     k.konieczny@partner.samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2019 at 16:12, <k.konieczny@partner.samsung.com> wrote:
>
> From: Kamil Konieczny <k.konieczny@partner.samsung.com>
>
> Add enable regulators to dev_pm_opp_set_regulators() and disable
> regulators to dev_pm_opp_put_regulators(). This prepares for
> converting exynos-bus devfreq driver to use dev_pm_opp_set_rate().
>
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> ---
>  drivers/opp/core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
