Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF316C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5AC32190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CYZF+ist"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388125AbfGYOtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:49:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53084 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfGYOtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:49:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so45262383wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 07:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=3b3X8WfBqIW5LOW4V5TVp6ae4N5qP2OGB1HYZV9x7QM=;
        b=CYZF+istrGEAPBiAE0ogP75C5buboZkGqyOM5L/9I/3bnu/dHopK+cjGrEHepiV3O1
         dUVGk1Yy7Q9qNheRnqVKn48/a2KXDZytITvRzcqEuMieITUMWSIgvdJRQfn6gLPcgzS0
         13hYrFFuvaFvCRF+jdMAMNQ4/z8lZ5Yc7n5FRgMzaGaytfwK5AuN5YrwW0PmR+Wtxayj
         j47u0RHnSXMnk6ULmKR1KI1l1WQ94QMefCU+hXR8wr0f67iSfE3AYSCzjwXARHQFacIS
         bHbwD5rxoMiymF86Mg2rubifTzBXk3vUicbHfk81Gg1anQrVWpmTJsYpRtTIWX1NvUi5
         CGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3b3X8WfBqIW5LOW4V5TVp6ae4N5qP2OGB1HYZV9x7QM=;
        b=Nnghfxf8rW2ViBQLHFY7QBn2xAbFLwMo+Io4P3Xf30JiuXXMfGWWprZC7eoBuf4p8L
         ZraRsqSDmBJ4vw9vCIRhegISjUo4J4FO5cov/yYjaDQ0Qg0D8SKUOXvciD/XLeLsTW77
         +PsVoU+HKttCd7uBdZZakAz/0ZZTFLIbis381yZAxnG2ybqRvNN7cpLrLinT4wJvRRBt
         mKEmiY0ZhK9f6j0/s0RMBE9hd2TZ2sRCq3ebxcA6S3k0MsCHUQrxXXwReGHU7/N5ROEA
         e1tR3l/2sUjgRR0XC3nJdINOg99yxcviubPpv0oMOfkLUh+h5YlmcZpl9h51UqBIJuu5
         Py3g==
X-Gm-Message-State: APjAAAWUn8Jt6wmyU39n8qX9ESFdZlJy7vUEN7vLwvD4H9vKabfgeB/7
        JnOdGQIG5neQRPTZGroaYZtGiw==
X-Google-Smtp-Source: APXvYqzIwsQJYuxzT5dWpKHmTvybHpnoxkfBrMYfdmTdr8KgCK9iYKnYda5Yubj39ML7jNr8yVrQ1A==
X-Received: by 2002:a05:600c:da:: with SMTP id u26mr77769552wmm.108.1564066193002;
        Thu, 25 Jul 2019 07:49:53 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c11sm85376061wrq.45.2019.07.25.07.49.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 07:49:52 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     khilman@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH 3/8] clk: meson: gxbb: migrate to the new parent description method
In-Reply-To: <20190722095425.14193-4-amergnat@baylibre.com>
References: <20190722095425.14193-1-amergnat@baylibre.com> <20190722095425.14193-4-amergnat@baylibre.com>
Date:   Thu, 25 Jul 2019 16:49:51 +0200
Message-ID: <1j5znqxj74.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22 Jul 2019 at 11:54, Alexandre Mergnat <amergnat@baylibre.com> wrote:


> @@ -1592,13 +1737,29 @@ static struct clk_regmap gxbb_vid_pll_div = {
>  	.hw.init = &(struct clk_init_data) {
>  		.name = "vid_pll_div",
>  		.ops = &meson_vid_pll_div_ro_ops,
> -		.parent_names = (const char *[]){ "hdmi_pll" },
> +		.parent_data = &(const struct clk_parent_data) {
> +			/*
> +			 * This clock is declared here for GXL and GXBB SoC, so
> +			 * we must use string name to set this parent to avoid
> +			 * pointer issue.
> +			 */

I don't really get the issue with this comment.

How about:

/*
 * Note:
 * gxl and gxbb have different hdmi_plls (with different struct clk_hw).
 * We fallback to the global naming string mechanism so vid_pll_div picks
 * up the appropriate one.
 */

> +			.name = "hdmi_pll",
> +			.index = -1,
> +		},
>  		.num_parents = 1,
>  		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
>  	},
>  };
