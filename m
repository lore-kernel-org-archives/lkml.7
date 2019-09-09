Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA782C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6E121479
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PVIe3K3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390883AbfIIK7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:59:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40383 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390755AbfIIK7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:59:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id t9so14102822wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 03:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cC4g9BRBEaf08E8q7Ceq+EDE6JFex4JwlziqyOjWmy0=;
        b=PVIe3K3q+MLvV9INLxU2fZYlQCC9Jc1EePTFLZast77owUaVemUSI1wYrcz+h1thcT
         /DU/8gPgn0DHHXvoBNfU9oEobDMKs3QGwxbmVTSpJl6oZaSDoJyZpnsiqcT945v+w/fz
         mJDJtD8l/7MHSRYQppq1Jdi+Z4kY06oBD/kg65+/MCD/YmxvzjTJ7gD/H7xy0vmBXiz1
         FP6c9+wIoz5/qyhzC5+uqESbx88b4zOeFtyaNfkWBrnRvGaoNVd01IgGSmUs93HKYmfU
         xbV7YqOoRdRUq9LLJv9mbAvGCpjbkOfC63THV2N7eFR5xusJYYpO+yQpmy5HKDgAakji
         ORYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cC4g9BRBEaf08E8q7Ceq+EDE6JFex4JwlziqyOjWmy0=;
        b=krSZGKtHWEt7ypRi6SBFdUM2rkKGSc8PZfxoIcvcpEkn0ALSpVs7FJ13gI1ijFt9OT
         iZ5hnsV5ZuUT3tLfzWz4DoOAV/qvVZpyOquT1ZTIb/u3PK+GwAD2xfl4hWKx/waPhkD2
         qkyQRhnpDsJKhFLRFoOXf7/68ttGLrGeyAG1rsFML7KZ0RwTNf+vOUNf+8DOj+Yk27y7
         +l7O6rYmXr4Mf0AStYAeFrfKJuPDZXuDLPRtN6kBbJ6gpQRODXQCN+Kyo+v1n8dWY5V5
         VgsZKgBBZ6Ia8PE8ySVxZjc0MJ29KywovvAI2IvL3xSA2RWpnAqQAV6sLGBPNI6SSOtz
         FWjw==
X-Gm-Message-State: APjAAAWSTCpK2E9i3QV3cUenjuFriL91qWedCtu0tOngjK7GdX91F4EF
        vB60/mYq7zQL94Aw7WDIO3RKqg==
X-Google-Smtp-Source: APXvYqzyqfA2w/Lqb9/5hfL+KB+09ziudbSV+CalqKx6i1gQ7KLdpqRoeuy4hGtJtvQV1S9tM22+/Q==
X-Received: by 2002:a05:600c:2105:: with SMTP id u5mr155367wml.150.1568026784923;
        Mon, 09 Sep 2019 03:59:44 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id s3sm10943664wmj.48.2019.09.09.03.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 03:59:44 -0700 (PDT)
Date:   Mon, 9 Sep 2019 11:59:42 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 2/2] dt-bindings: backlight: lm3630a: add enable_gpios
Message-ID: <20190909105942.pxwz6rtjg3cxlcnf@holly.lan>
References: <20190908203704.30147-1-andreas@kemnade.info>
 <20190908203704.30147-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908203704.30147-3-andreas@kemnade.info>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 10:37:04PM +0200, Andreas Kemnade wrote:
> add enable-gpios to describe HWEN pin
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Looks like patches are in the wrong order. Changes to bindings must
appear in patchsets *before* the Linux implementation of the bindings.


> ---
>  .../devicetree/bindings/leds/backlight/lm3630a-backlight.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> index dc129d9a329e..a9656d72b668 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> +++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> @@ -29,6 +29,10 @@ properties:
>    '#size-cells':
>      const: 0
>  
> +  enable-gpios:
> +    description: GPIO to use to enable/disable the backlight (HWEN pin).
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg

Please add enable-gpios to one of the examples.


Daniel.
