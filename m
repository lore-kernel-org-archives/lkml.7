Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5793C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F24D21924
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568729730;
	bh=+B3sRZPhkAukMdMBAYVICiPGgK/51bRCH3pDovTUbwo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xXL3IvdMqBm6sb/VcBU/19btR6MLkEKMeKqCwJLtfCk2GosrzX3kSWXxqhk/X66aG
	 NAUxRO7Qw+PC1bzdYiZLPWcXTRN6JuuHr8FedGfoKmjf/FG7947EYc2Lrjhnnqj/Gi
	 xNBPfhfDQ/vGFtdi/FvYKrkDIg7MBo6vCKPtXb2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfIQOPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbfIQOP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 10:15:29 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA2FE218AE;
        Tue, 17 Sep 2019 14:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568729728;
        bh=+B3sRZPhkAukMdMBAYVICiPGgK/51bRCH3pDovTUbwo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=w4/ghrVGz+s1Xa8HKjmbSv+EFYoQomNvEU6uW/JCHc+xPgFpAla3Ef1Xc5bXWrW5B
         jhuTmBt1NGRBsA9acQjl2Py4L2JmtbGWUEhiSdVFNBg8ihClrjcR+9TNLOGfO7bkGE
         k+2UvRiT6gdfnian3dWHLECSTFJD+KRDO8Ckiw2M=
Received: by mail-qt1-f178.google.com with SMTP id j1so4638400qth.1;
        Tue, 17 Sep 2019 07:15:28 -0700 (PDT)
X-Gm-Message-State: APjAAAUUZ/2DvB1V88mYEGb6tOZw/fMgjmjwZRQLduMS63SAiaLuXnSa
        ieo3kaS/dqyP08UUeVhn23j3U+bwVrcFxE+ujw==
X-Google-Smtp-Source: APXvYqzA95YGsDAHuNNPxRimcQ6KIo1Xu3z8j8WHVokwnL8nyFMsfVMoZXe73MnOTmOXNpjhJW2nI4GI0hnrbY/hLoI=
X-Received: by 2002:ac8:31b3:: with SMTP id h48mr4019256qte.300.1568729727989;
 Tue, 17 Sep 2019 07:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190917120634eucas1p20addfc4e369468561714f3c44d3d8bf5@eucas1p2.samsung.com>
 <20190917111413.22711-1-m.falkowski@samsung.com> <20190917120627.28357-1-m.falkowski@samsung.com>
In-Reply-To: <20190917120627.28357-1-m.falkowski@samsung.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 17 Sep 2019 09:15:16 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLwkVQ6VFYtUfOErA8vG2qnE+nquo_m5s0zLRqgn+bJLg@mail.gmail.com>
Message-ID: <CAL_JsqLwkVQ6VFYtUfOErA8vG2qnE+nquo_m5s0zLRqgn+bJLg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: sound: Convert Samsung SMDK audio complex
To:     Maciej Falkowski <m.falkowski@samsung.com>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 7:06 AM Maciej Falkowski
<m.falkowski@samsung.com> wrote:
>
> Convert Samsung SMDK audio complex to newer dt-schema format.
>
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v2:
> - Added missing Signed-off-by certificate
> ---
>  .../bindings/sound/samsung,smdk-wm8994.txt    | 14 -------
>  .../bindings/sound/samsung,smdk-wm8994.yaml   | 38 +++++++++++++++++++
>  2 files changed, 38 insertions(+), 14 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
