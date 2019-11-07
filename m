Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE33C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C56A222C9
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573148456;
	bh=OYgQrmdZmNroAHb74sVUuSnpCtxolSUHgVGyEjv4V5Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=o7ZpSmct4ONkZHTObdTenk19wYCvUMNavG1GIvvUwk3Hl1WQ8M5991MW4h1kJV4p1
	 NbCg94Zs9y64mKX+4Hvw49/9YPXUfVullnaMtTOGwjbyHhzlK0AH024C/iMvFcjrIf
	 ErmpTUyehzKXXTLDaFqn2NlWnfqlHtiYLryWYWw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbfKGRkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:40:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:36254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbfKGRkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:40:55 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0F702084D;
        Thu,  7 Nov 2019 17:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573148454;
        bh=OYgQrmdZmNroAHb74sVUuSnpCtxolSUHgVGyEjv4V5Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rDltopZkGIFVN3tdTyMtIBC0/DHvpYC//97XoCxkCgL1Wprtj27pPVltzMEqfAnS9
         H4eUUc89erhUBoVs8OiiQr9GmEe8B6Hw/1e6dQBfKiDSw4lxtaIWMORzftVi5lU2bE
         OiHu70ENCi0eJ9yVREDlYILAWx4y/Po/OkXaHVvE=
Received: by mail-qt1-f170.google.com with SMTP id u22so3219324qtq.13;
        Thu, 07 Nov 2019 09:40:53 -0800 (PST)
X-Gm-Message-State: APjAAAWfQ2jvVcRlr9x0D9Rcemoo8XH0id4cDAfbo6KRn/LiBqMbg1V6
        XQAf0WxAYTqrUdYMhiOUmVgi8E11W7hnDgIBMg==
X-Google-Smtp-Source: APXvYqymGGkqABjYdF0xhvWYzF9gyZ7Mx6LFLCCgTmCamvcfGddIsg5zyOUpdwQsy7X4I+/2Uw4D8lnhSwngyNf7W74=
X-Received: by 2002:ac8:7612:: with SMTP id t18mr5129163qtq.143.1573148453179;
 Thu, 07 Nov 2019 09:40:53 -0800 (PST)
MIME-Version: 1.0
References: <20191029112700.14548-1-srinivas.kandagatla@linaro.org>
 <20191029112700.14548-2-srinivas.kandagatla@linaro.org> <20191105193100.GB4709@bogus>
 <315fd1f8-b6b5-5df7-604d-4ca92b31772c@linaro.org>
In-Reply-To: <315fd1f8-b6b5-5df7-604d-4ca92b31772c@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 7 Nov 2019 11:40:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ+EUe8TiNfUN30D9x4XNcUnevUSK2cM9zVQR=jDR1wQQ@mail.gmail.com>
Message-ID: <CAL_JsqJ+EUe8TiNfUN30D9x4XNcUnevUSK2cM9zVQR=jDR1wQQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] ASoC: dt-bindings: add dt bindings for
 WCD9340/WCD9341 audio codec
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vinod.koul@linaro.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        spapothi@codeaurora.org, Banajit Goswami <bgoswami@codeaurora.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 4:08 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
>
> On 05/11/2019 19:31, Rob Herring wrote:
> >> +  vdd-micbias-supply:
> >> +    description: A reference to the micbias supply
> >> +
> >> +  qcom,micbias1-microvolts:
> > The standard unit is 'microvolt', not 'microvolts'.
> >
> I started with microvolt but dt_bindings_check reported errors.
>
> looking at
> https://github.com/devicetree-org/dt-schema/blob/master/meta-schemas/vendor-props.yaml#L19
>   suggested microvolts should be used on vendor properties.
>
> Is this a typo in dt-schema ?

Yes, even the DT maintainer gets confused. :) It's fixed now.

Rob
