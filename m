Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B7AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA541208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v7UG62hb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfHLHZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:25:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34538 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfHLHZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:25:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so103696640wrm.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=v3qFXuuCyhEZaSKmlx5nKQ+CnqDEnPPc+kBNB7h+EyI=;
        b=v7UG62hbv+/m4lw5vD/c3cbTFwsKCgmZxX+rl0srP2Bp4sOACsDJeUp2JKisxT2veD
         wrUEDTVCbdvqqFDBM3n8UOI/BF34giJv0IoCrT79zo3hOIJlKEmZTtZC1NgbWKfes7i2
         xdV952S1jHUzGQFD1UtZHZmK5mV7Aiv+ppXfzju6aLUf4DcgBQW8Ek/o0M3WvblUStmq
         D+BnqWg8cH8E2plNdkldhbPQlANtApkX6WKKxonKAlaHXl27rmNaFvpTjcD30d6+r7yg
         QRGbiYGOK8N/995PSnoX2QtvpjlTROKmdP1ovTwnTKQWn3H0QDkTxDj/7b4CVO7+V1we
         zkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=v3qFXuuCyhEZaSKmlx5nKQ+CnqDEnPPc+kBNB7h+EyI=;
        b=PiUuE5YMUJMf/lFsyYcmCb0zJbiM0clwCfeG3Tsr1hF/rbyuWZfIBoIo3JCj+nvdO6
         koOjq1rYHnUOyXXxfvL6PPR3tRxUNegQo75Fav2oyv02dd3txODatnNsMEzmjCmt5kJu
         cNfPCxy+LUXWdWnvgxuHDlcGgNKBm/PWfB3bO4qDIpoBg3Pf2M4IjJV6V1uTK2Qtet63
         uOBL6cT61EWi6iWARL1rYtLW0CuPuw7kGGEAK3PbgvBV4pe2g5Kt2e489CoUYOscMrhp
         tJi/AcSmPqq/VqN9nJDPWgHp5nKPHuysW3tJVj+N59oWsBHpTwa/uQOa8Kz0CIC7iipH
         VBiQ==
X-Gm-Message-State: APjAAAV8dgy7yXOQJDd9qlY/RoCNl0B0Xy4SGPLc/aS0f3tNSOyqqATO
        s+MHRkujS43dqd77IhvNlZGBoQ==
X-Google-Smtp-Source: APXvYqwMaoS8BMJV0Ww3ChpQ3NIMTHwkkhVXai+ddE36NNICg5Yf9MtdOvZ4Ibgenu/QmZin/+++vg==
X-Received: by 2002:a05:6000:42:: with SMTP id k2mr37673695wrx.80.1565594734003;
        Mon, 12 Aug 2019 00:25:34 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id w7sm119249660wrn.11.2019.08.12.00.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:25:33 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:25:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora kernel ML <kernel@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v5 07/11] mfd: cros_ec: Use kzalloc and
 cros_ec_cmd_xfer_status helper
Message-ID: <20190812072531.GK4594@dell>
References: <20190722133257.9336-1-enric.balletbo@collabora.com>
 <20190722133257.9336-8-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722133257.9336-8-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Enric Balletbo i Serra wrote:

> This patch makes use of cros_ec_cmd_xfer_status() instead of
> cros_ec_cmd_xfer() so we can remove some redundant code. It also uses
> kzalloc instead of kmalloc so we can remove more redundant code.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Tested-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/mfd/cros_ec_dev.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
