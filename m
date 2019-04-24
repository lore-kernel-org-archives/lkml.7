Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F99C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9F7208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556094045;
	bh=yG3qsSuduz/nKvqukmeETxhK6K+WkAcjlRfQsAPIcA8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OEh3TtzTVxDSR4531eAOsFRdxQvzIZ6G1+6vij/WdL74pBQDeSIeqgJpu7C/Dp82G
	 oAA2emlZGA+Y7sUB7RRmPsoKbdZATr6EOw0rr9xdTB3X7qk5/WLhcj3+VTijMmvqNr
	 q9Jri/jtXDGn1hidbFvvYUrXiE6RQAmhwva7atbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbfDXIUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:20:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727361AbfDXIUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:20:43 -0400
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 885FE21900;
        Wed, 24 Apr 2019 08:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556094042;
        bh=yG3qsSuduz/nKvqukmeETxhK6K+WkAcjlRfQsAPIcA8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uPJD37YjrmMc5NTVk/xzL8Ct8XKGCU9sIy8D1vudcaM5xq2o2TykyKPv8jq800u+K
         Xt6++QfG5TGp43iD/5+gzcM05OvX2U+U/40QLlbf886dPFvlw4cE4P5SNLcJ+8gCw5
         kg7sbZ5l26YT9p2r9tf1zGUbEApQZFOvzE4JS7EA=
Received: by mail-lj1-f175.google.com with SMTP id l7so16010349ljg.6;
        Wed, 24 Apr 2019 01:20:42 -0700 (PDT)
X-Gm-Message-State: APjAAAUqUjxw1GNcZqX84rIWOPZK+iNNzl0GsO+6nNpCrP5EcMmS62To
        dtP6AmpncVt9IeVoEIRoMGDz13NcJ3iGcWGS2u4=
X-Google-Smtp-Source: APXvYqz0QQCfkQWF8GHTgJb6Xefaj1UkUoI/L264WgOkOhCM2Jwp1aNY0ukYeAI0a+IaVfECGzzmY7mVxWCPu4HhL7o=
X-Received: by 2002:a2e:9895:: with SMTP id b21mr16561939ljj.183.1556094040764;
 Wed, 24 Apr 2019 01:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190404172238epcas2p21ef28f46b728127dcd6e8ee72752a1b8@epcas2p2.samsung.com>
 <20190404171735.12815-1-s.nawrocki@samsung.com> <20190404171735.12815-5-s.nawrocki@samsung.com>
 <CAJKOXPc9v8bcQs9HmiDWECCkfQCh-Ktzk9Vqq01ccUm7UG54uQ@mail.gmail.com> <1d2238be-1758-2413-42f1-d571706de766@samsung.com>
In-Reply-To: <1d2238be-1758-2413-42f1-d571706de766@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 24 Apr 2019 10:20:29 +0200
X-Gmail-Original-Message-ID: <CAJKOXPccFqZv6nopRThi1+G1-5LWtFQu53rDXcsO2QXu2DWtwA@mail.gmail.com>
Message-ID: <CAJKOXPccFqZv6nopRThi1+G1-5LWtFQu53rDXcsO2QXu2DWtwA@mail.gmail.com>
Subject: Re: [PATCH RFC 4/8] soc: samsung: Add Exynos Adaptive Supply Voltage driver
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        pankaj.dubey@samsung.com,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019 at 10:10, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> On 4/23/19 12:50, Krzysztof Kozlowski wrote:
> >> +static int exynos5422_asv_get_table(void)
> >> +{
> >> +       unsigned int reg = exynos_chipid_read(EXYNOS_CHIPID_REG_PKG_ID);
> >
> > One more thought: you read this register multiple times in the same
> > function. I think it is not needed - just read once, store the value
> > and use the helpers to parse it.
>
> Yes, I have noticed that as well. I'm not sure though if it is worth
> to additionally cache registers manually like this when we use the
> regmap.  I have already converted that code to use the regmap API for
> v2.  And these are barely few registers reads at the driver
> initialization time, not any hot path.

By default regmap does not use caching so there is no benefit out of
it. In the same time reading with regmap involves its layer of
abstraction with locks, indirect calls etc... I agree that there is no
point for implementing specific "caching" but with the same code
readability/simplicity you can have it without multiple regmap
accesses one after another. Consider this:
    unsigned int pkgid = exynos_chipid_read(EXYNOS_CHIPID_REG_PKG_ID);
    asv->table = exynos5422_asv_get_table(pkgid);
    asv->is_bin2 = exynos5422_asv_check_bin2(pkgid);
(and probably renaming the helpers)
The code is equivalent. The same readability.

Best regards,
Krzysztof
