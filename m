Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFD6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC56120830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l2N2llbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfCYNy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:54:57 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:42003 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729275AbfCYNyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:54:54 -0400
Received: by mail-vk1-f196.google.com with SMTP id j195so1954047vkj.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 06:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OY8WEisT05W3FWbLcHkMS2iHB9tj4RvJF+Rsv+/ieGg=;
        b=l2N2llbzpOSfmUe6dzd+DRFsMc2AaM+9ldarqCzBRDeINz8szsRwtw9N3wum9q37Ud
         f6Ngmxyx/xMM63ImL/REnJ7vFqEEMGLPo+CbHTYDorexpRaJgoZEnbIWLsLJg06le1mO
         ztoUNFsxjvnfbFI1wPheGNg7sC9UqHMErvX4YDoUKInKFfAyVK4magggyjVs62JrRiHT
         qGenQhylgJjJZpBLSJRVfdWz78lM8D0KoBMnmcq5bhaeSBYuAM/rK7a+jX0Hi48ojufB
         0TcyrXDTWhQnIYC1T62TrzKw0ip+wLb1aiHHSw0lZ2Bi4LMRkzuZ0mrsKU2qmsXq36Fq
         hMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OY8WEisT05W3FWbLcHkMS2iHB9tj4RvJF+Rsv+/ieGg=;
        b=bZMT6ts5Bn7fcqM/Efdr1gcLsKoszSkTP/WI7RDtFAV4Puw6EIcPGgVTLKnRYRj2jE
         0mERF947Hezs71VpGKfFCTbp/l0JUawIWDVFBaiewFT1yxMiH9GQu3CtMwpE4KRRABkQ
         df9glYrZnrz6Rq8UN2nyToeSRrSQ4yLkL110mbyfM3bGCfbqrxBjdwoDW8QqaQx1IFtg
         4mUXBpu1A5sxp7TbBLCXHMy1uhJGmTFOy2/Mmw/wCp5UQwIgOCPCQOcYorbP1sRvJuHQ
         s7AZLWAC1oQiSIbLbZN84DhLX7VcVJFCu32vARU4CHY1sWTRXtruxARY4jmZUydeQ4iM
         5DoA==
X-Gm-Message-State: APjAAAWxoskZVHkjrIjXmpdm6iTyq5c5bwzwairpJRzmOumhFMskD+Ov
        FZ3riuS6D3HdiZTf5DF87Jdlr/3K/DQ691ct+MiTXw==
X-Google-Smtp-Source: APXvYqwHKdOkTnJ+AMaAugQjQ0Tb6R5TE6uPP+fSM0aESr5wO2nnB7j3OtmloxW/aWKkRowhMUY/s9UaINcATmGkDgU=
X-Received: by 2002:a1f:3458:: with SMTP id b85mr3804716vka.4.1553522092858;
 Mon, 25 Mar 2019 06:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190322113808.16858-1-christoph.muellner@theobroma-systems.com>
 <20190322113808.16858-2-christoph.muellner@theobroma-systems.com>
 <CAPDyKFrDq-zBsqqe23hj4ynfYnrGxAr0tWxvYEJu8Kvh0i=h9A@mail.gmail.com> <2D2515D6-1E11-4EA3-B016-EC37A9E3091D@theobroma-systems.com>
In-Reply-To: <2D2515D6-1E11-4EA3-B016-EC37A9E3091D@theobroma-systems.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 Mar 2019 14:54:16 +0100
Message-ID: <CAPDyKFrPBY14bvG7ZLON2xTTWEc2a1JjLdeDSkGmtdAZy5hokQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mmc: sdhci-of-arasan: Add DTS property to disable DCMDs.
To:     =?UTF-8?Q?Christoph_M=C3=BCllner?= 
        <christoph.muellner@theobroma-systems.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Tony Xie <tony.xie@rock-chips.com>,
        Randy Li <ayaka@soulik.info>,
        Vicente Bergas <vicencb@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 at 14:39, Christoph M=C3=BCllner
<christoph.muellner@theobroma-systems.com> wrote:
>
>
> > On 25.03.2019, at 14:27, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Fri, 22 Mar 2019 at 12:39, Christoph Muellner
> > <christoph.muellner@theobroma-systems.com> wrote:
> >>
> >> Direct commands (DCMDs) are an optional feature of eMMC 5.1's command
> >> queue engine (CQE). The Arasan eMMC 5.1 controller uses the CQHCI,
> >> which exposes a control register bit to enable the feature.
> >> The current implementation sets this bit unconditionally.
> >>
> >> This patch allows to suppress the feature activation,
> >> by specifying the property disable-cqe-dcmd.
> >>
> >> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-system=
s.com>
> >> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> >> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >
> > Applied for next, thanks!
> >
> > Perhaps both patch1 and patch2 should be tagged for stable? Then
> > please tell me and I can add a tag.
>
> Hi Ulf,
>
> yes tagging for stable would be nice.
> I guess, the following would fit:
>
> Fixes: 84362d79f436 ("mmc: sdhci-of-arasan: Add CQHCI support for arasan,=
sdhci-5.1")
>

Great, I have added that to both of the commits and a stable tag. Thanks!

[...]

Kind regards
Uffe
