Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB37C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B66A23403
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567107190;
	bh=QoL4AhSk6PvmPyMU8+/hG69E+MpudT9gZ5Nmid7lJuo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2ifHkJhEpdWeuyvlo7cyl2IazPO7xmkEkJb7Fjabp7ACyNYoS4euJ7OImVkmaeSqm
	 SZfBHxjysUjaX6iHhza5JowwfUjPIWraiqVkGhnmCQ6xE/vqAtR3nDFVozsj1UZsY6
	 ZCBDgj0FWoX5RcyWR9qNGfXRUu3jJat+im2QDeJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfH2TdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbfH2TdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:33:08 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C092C22CF5;
        Thu, 29 Aug 2019 19:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567107187;
        bh=QoL4AhSk6PvmPyMU8+/hG69E+MpudT9gZ5Nmid7lJuo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z2o0/F/sGZLbGd/0eLkgaTXJvJzSm3VSynu7kNCNIS7Bpm63dx4+vCt/1bIClhu0E
         i2jDMS7FmGzOAGh1hPUnbixOnTFicCuJRQVVhtBW9Mbqjm52GkC6IYCB0lq2fJ1q8h
         dgQffumchUDT2W/d+oWVP8Mw800fEfvJufEZr/ZI=
Received: by mail-qt1-f177.google.com with SMTP id a13so5049777qtj.1;
        Thu, 29 Aug 2019 12:33:07 -0700 (PDT)
X-Gm-Message-State: APjAAAWHG/Zgj79TXssaIAtAr44zCY22AIXYeKia9lj425ycZF648HLG
        lJ+ZiS2eNriIVEqa9QVehcIpKfn71q+lVWh43g==
X-Google-Smtp-Source: APXvYqwzMUwpK5mXNX8UIzE6GHqaVbELhdNykc41DBBvmTiFH2EnhhR64lsBglAOMBBEMcHhpwTjDb/5Y/mwd0COHQw=
X-Received: by 2002:ac8:44c4:: with SMTP id b4mr11577199qto.224.1567107187025;
 Thu, 29 Aug 2019 12:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190829163514.11221-1-srinivas.kandagatla@linaro.org> <20190829163514.11221-4-srinivas.kandagatla@linaro.org>
In-Reply-To: <20190829163514.11221-4-srinivas.kandagatla@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 29 Aug 2019 14:32:55 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKq228oWZzSWykBtGSy8qwwn48q-nYfExhiKMTAzj+-+g@mail.gmail.com>
Message-ID: <CAL_JsqKq228oWZzSWykBtGSy8qwwn48q-nYfExhiKMTAzj+-+g@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] dt-bindings: ASoC: Add WSA881x bindings
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Vinod <vkoul@kernel.org>,
        spapothi@codeaurora.org, Banajit Goswami <bgoswami@codeaurora.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 11:36 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> This patch adds bindings for WSA8810/WSA8815 Class-D Smart Speaker
> Amplifier. This Amplifier also has a simple thermal sensor for
> over temperature and speaker protection.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,wsa881x.yaml          | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
