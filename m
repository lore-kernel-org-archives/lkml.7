Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86401C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5583E20854
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r6rVR5OV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfDEDmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 23:42:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35920 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729810AbfDEDmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 23:42:39 -0400
Received: by mail-lf1-f65.google.com with SMTP id d18so3336532lfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 20:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=26A8KgxW0wiaw7kDVEFoSEgm1/Ol3slaJ6umBRIP4Ok=;
        b=r6rVR5OVXGkMx/Vke+zxtdM2S9GunQEZOkq6yhN68PBQXLPHmHP6kSCvc29S7qz6op
         dsYznWNETQCY1Dbnc5B16CJInzwyI6F1uYK9ERuRhZkIPRscBrD3a+ctLMFDmupZA5T+
         RngTSCgROGFnlFp2D1J1jTAx626fzxMxJHbSBuXxfBPIlAlOFmAnVopEkZCDK0rrHpUu
         nWoN8hkvreI5BqtmYpz92kmJwUS4uozyzh5qbbSPaM+lT3Bxm0wBf4R9kdyH792F7nzc
         VZljbScY2AT7wqrjPzrAbemyg1axQm7ag6fdKg8c7gEiveznfZojXWvkgH3WrNJnGpFx
         JhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=26A8KgxW0wiaw7kDVEFoSEgm1/Ol3slaJ6umBRIP4Ok=;
        b=kiEzUB0xy6tStxQeoISN+B5KpnHTORFF3loix+gcvmW8Ecywr26JUSJo5bsfYr1XdN
         iQEwJRoGHC2tEdeijEgYfo1xxi7jPBerzSgKo8ANAIQ4M/7gbeT1qd1l2kEAn70JOZT0
         OYxITmosyeR/ksb5yHFDmpaVDi7gcgOKh7HsRZijHElis6JtqElts5Wf4eulJZ5PNtWv
         5v5lkUXJZV4nk91FZc5BWgHvwYaHpC70KamU9LSgFY6qahALbgclIjOQ/MKCM2lJjlr9
         ub0Dnt3JZSDjRrp9s1R0kbE1Dj3AyOylBSuRPfBOPE5RQsUn7kkkgkUchc5IIAZOc11Q
         XLUA==
X-Gm-Message-State: APjAAAX4khkuwH+qAnwqgKI3CbIiFy3RJt0fGbon6JP6M1FRq2mKE285
        SRFfKlhw/QX8mOjiCZFnUwxFphHTkT/FSBzLMDy82w==
X-Google-Smtp-Source: APXvYqxclydzDGvq5BSCdcK0hxPO+0mhR9t98NVGdEfknwFfHG776GPRJ8zY6NHK9rfMZ6jb+YfThWRaHDNXY3lqSI8=
X-Received: by 2002:ac2:5479:: with SMTP id e25mr5220594lfn.121.1554435757804;
 Thu, 04 Apr 2019 20:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190401033535.16910-1-zhiyong.tao@mediatek.com> <20190401033535.16910-4-zhiyong.tao@mediatek.com>
In-Reply-To: <20190401033535.16910-4-zhiyong.tao@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 5 Apr 2019 10:42:26 +0700
Message-ID: <CACRpkdax_eH0j_sYhpHatmUNarrP7pP66UkfMOq==XzEUFru_A@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] arm64: dts: mt8183: add pinctrl device node
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>, srv_heupstream@mediatek.com,
        hui.liu@mediatek.com, huang eddie <eddie.huang@mediatek.com>,
        chuanjia.liu@mediatek.com, Biao Huang <biao.huang@mediatek.com>,
        Hongzhou Yang <hongzhou.yang@mediatek.com>,
        Erin Lo <erin.lo@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 10:35 AM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:

> The commit adds pinctrl device node for mt8183
>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
