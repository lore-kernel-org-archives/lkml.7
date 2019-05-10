Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BFFC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 08:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7AC12175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 08:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HC9GwhY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfEJIwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 04:52:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36496 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfEJIwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 04:52:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id j187so6544606wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 01:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=aaM8432jFaEmhAAs5kJRzcW3PtFv9V/mPFGHY/gVINc=;
        b=HC9GwhY1KxcCvquoeRmAWTsEHBkGlMjC2GOSg6QgSOb4NqeO9tQazouSymWwoGOCjA
         9JWrMkzWVeVEGra7oAVM1kJhEEZM/PhqiogQbhTl6twBJtLpQ0/MPg56TCYYAt+Nvv1o
         mCJg3YB/RHexlJfjgBa+KFzqJ5FvXDDHsnnWtvdJONcsi/MDywBvcfou5mimKwOEo1iZ
         aCqw/BkOF0tmUEWP1PK3VYzCYHdrfLvr1cLVaGotwWbUkfqHza9nLRXR4qX182qhGhEq
         TKz1aA9ZIVvYWW+B6qEF292a80KFSQDyuElD+0kAVBqsrRz195OMy7ClsyOwrwFgKNTG
         4aNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=aaM8432jFaEmhAAs5kJRzcW3PtFv9V/mPFGHY/gVINc=;
        b=OX7uyNO8KuLe3LR45bxMSuTj4yW9anuudutg2ywjnSaSKg5qIXyKFIaUfscviB6mBe
         aXQwdPEf3WKXAvAoftN7htUEdbctMo9O4WvK0afOFsjV2k/332sJaSElkQt6Pe5OGsOa
         woTUv+Z6OeVOkORAKziVbvHynsHIGBlz/qJJ/yIux0bgmvgNXQyDOBKrYoDgRssssFxz
         vsQ9lys3AaCWxeMuQc8kmJRZ+oIY4azfNgNH/34XaHe3itaidtzW/22T59arOZZ0IbmQ
         clm843QQ5PXJDmrpQAFWxfk7J0xh84LZuGlnNLu+zg8OoMnajMTvOFcXg+G1+vhjPw83
         xYuA==
X-Gm-Message-State: APjAAAU7PaD1TDnU4cLKNNgCPaJZJJGs9XeZOyKy6VcT0xCTtaT0Sewi
        wPul/gShZu899oBwIilZfL4FHA==
X-Google-Smtp-Source: APXvYqykj1mHG44y8+cSJrOUjhNqzrgeo1uIXi5+tTVxFFhizSUvTXk2PbGt+OXdLaVSil5RdqYKuA==
X-Received: by 2002:a1c:80d7:: with SMTP id b206mr5910297wmd.48.1557478328921;
        Fri, 10 May 2019 01:52:08 -0700 (PDT)
Received: from boomer.baylibre.com (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d4sm12281121wrf.7.2019.05.10.01.52.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 10 May 2019 01:52:08 -0700 (PDT)
Message-ID: <331673da2c1cad1c72d61b45e0c614961445ec90.camel@baylibre.com>
Subject: Re: [PATCH v5 0/6] Add drive-strength in Meson pinctrl driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Guillaume La Roque <glaroque@baylibre.com>,
        linus.walleij@linaro.org, khilman@baylibre.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 10 May 2019 10:52:07 +0200
In-Reply-To: <20190510082324.21181-1-glaroque@baylibre.com>
References: <20190510082324.21181-1-glaroque@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-10 at 10:23 +0200, Guillaume La Roque wrote:
> The purpose of this patchset is to add drive-strength support in meson pinconf
> driver. This is a new feature that was added on the g12a. It is critical for us
> to support this since many functions are failing with default pad drive-strength.
> 
> The value achievable by the SoC are 0.5mA, 2.5mA, 3mA and 4mA and the DT property
> 'drive-strength' is expressed in mA.
> So this patch add another generic property "drive-strength-microamp". The change to do so
> would be minimal and could be benefit to other platforms later on.
> 
> Cheers
> Guillaume

Guillaume,

Several tags, such as Acked-by, Reviewed-by or Tested-by have been given on this
series.

Please remember to collect and add them to the commit description when posting newer
revision of a series

If you didn't already, please have a look at Documentation/process/submitting-patches.rst

Thanks

> 
> Changes since v4:
> - fix dt-binding documentation
> - rename drive-strength-uA to drive-strength-microamp in coverletter
> 
> Changes since v3:
> - remove dev_err in meson_get_drive_strength
> - cleanup code
> 
> Changes since v2:
> - rename driver-strength-uA property to drive-strength-microamp
> - rework patch series for better understanding
> - rework set_bias function
> 
> Changes since v1:
> - fix missing break
> - implement new pinctrl generic property "drive-strength-uA"
> 
> [1] https://lkml.kernel.org/r/20190314163725.7918-1-jbrunet@baylibre.com
> 
> Guillaume La Roque (6):
>   dt-bindings: pinctrl: add a 'drive-strength-microamp' property
>   pinctrl: generic: add new 'drive-strength-microamp' property support
>   dt-bindings: pinctrl: meson: Add drive-strength-microamp property
>   pinctrl: meson: Rework enable/disable bias part
>   pinctrl: meson: add support of drive-strength-microamp
>   pinctrl: meson: g12a: add DS bank value
> 
>  .../bindings/pinctrl/meson,pinctrl.txt        |   4 +
>  .../bindings/pinctrl/pinctrl-bindings.txt     |   3 +
>  drivers/pinctrl/meson/pinctrl-meson-g12a.c    |  36 ++--
>  drivers/pinctrl/meson/pinctrl-meson.c         | 180 ++++++++++++++----
>  drivers/pinctrl/meson/pinctrl-meson.h         |  18 +-
>  drivers/pinctrl/pinconf-generic.c             |   2 +
>  include/linux/pinctrl/pinconf-generic.h       |   3 +
>  7 files changed, 193 insertions(+), 53 deletions(-)


