Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD60C4740C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B0C20673
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wrdIO1Po"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407175AbfIWJbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 05:31:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50696 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405478AbfIWJbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 05:31:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id 5so9056635wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 02:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=x3JttSp0N6ofBW5LzQ0aulDXvYerTBb+rX2QpQHK3GA=;
        b=wrdIO1PoBF2ps/wgVPQ7uZgIs5Zg0O6ec2Mr5yDnG+hTFoHtn0Gydw0y2TxLNoO7RS
         uzvON/ffkt8vQQwgbhQdf3Dm1NkL2eTxSaLF3pVN9rRInxT2rs8wVgjagDecCPN3VvRv
         IUuyLvPkD1/PlRKdlyhxvW335/fBDsuKetZwZszZNU8n3cBX4CkiA/4RzSb/AsJnPJAZ
         rxQ8xZt3QRrn63KbNcrr2D9xv5NvUpA878d8d37TxTIwnW9UOhO5a92vPuLtccS/mDxw
         3sgvVDUOXZTePA1JrDwk3o6qSml1QB5fvshCdgkifFi0U2UzrXbkKAI6UDibIxNwIiQX
         sq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=x3JttSp0N6ofBW5LzQ0aulDXvYerTBb+rX2QpQHK3GA=;
        b=beYhBOfrV2ITgwYTh/+GHeXeEilQ6V2IY1sByUUDR+PWT1qGJRiI9xG3/Z6dLaudnt
         9K7/yHNdUfVZvbGeXfcAEArmL4I8MtWDs9VzBnwncCopkgq3f0Hc638rk53TmmKQeq55
         CV34jUHkV6PbZWLCwSFyO44ooBQQS/9ls6lOvur6H5QKBmaOH2J1IcuFY08Qyjk+f8VK
         fxOCo17JZKDTOVnyXHL0NMi0AXCUccUKBlsYm23NzjjwUeqj++spKfo5gWV0uYdkyQam
         8lKaBIHMYTK7XSb51sCcS5rHuOWmzsM5IRZ0tTAFT4igz2A0GbqiEqNPwn6VK5b+mTc8
         0kOQ==
X-Gm-Message-State: APjAAAWtdk6yQ966MshAJUW080S/KlkxO2YwIA1kIMorV/2mREsjXV8R
        4QeL4Rl0lY2lXEYUaQt9MQsa8Q==
X-Google-Smtp-Source: APXvYqyjmPFntItpiTfyGO7Ke1GU6GekG2Zcx3JJvC7jGTA2yTviIKEUlhQB4iQRI8K745mhVLBAxw==
X-Received: by 2002:a7b:c758:: with SMTP id w24mr11891113wmk.148.1569231102351;
        Mon, 23 Sep 2019 02:31:42 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v4sm15675554wrg.56.2019.09.23.02.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 02:31:41 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        narmstrong@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 4/5] clk: meson: meson8b: don't register the XTAL clock when provided via OF
In-Reply-To: <20190921151223.768842-5-martin.blumenstingl@googlemail.com>
References: <20190921151223.768842-1-martin.blumenstingl@googlemail.com> <20190921151223.768842-5-martin.blumenstingl@googlemail.com>
Date:   Mon, 23 Sep 2019 11:31:40 +0200
Message-ID: <1jwodzs6ir.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 21 Sep 2019 at 17:12, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> The XTAL clock is an actual crystal on the PCB. Thus the meson8b clock
> driver should not register the XTAL clock - instead it should be
> provided via .dts and then passed to the clock controller.
>
> Skip the registration of the XTAL clock if a parent clock is provided
> via OF. Fall back to registering the XTAL clock if this is not the case
> to keep support for old .dtbs.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/clk/meson/meson8b.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
> index b785b67baf2b..15ec14fde2a0 100644
> --- a/drivers/clk/meson/meson8b.c
> +++ b/drivers/clk/meson/meson8b.c
> @@ -3682,10 +3682,16 @@ static void __init meson8b_clkc_init_common(struct device_node *np,
>  		meson8b_clk_regmaps[i]->map = map;
>  
>  	/*
> -	 * register all clks
> -	 * CLKID_UNUSED = 0, so skip it and start with CLKID_XTAL = 1
> +	 * always skip CLKID_UNUSED and also skip XTAL if the .dtb provides the
> +	 * XTAL clock as input.
>  	 */
> -	for (i = CLKID_XTAL; i < CLK_NR_CLKS; i++) {
> +	if (of_clk_get_parent_count(np))

If we are going for this, I'd prefer if could explicity check for the
clock named "xtal" instead of just checking if DT has clocks.

> +		i = CLKID_PLL_FIXED;
> +	else
> +		i = CLKID_XTAL;
> +
> +	/* register all clks */
> +	for (; i < CLK_NR_CLKS; i++) {
>  		/* array might be sparse */
>  		if (!clk_hw_onecell_data->hws[i])
>  			continue;
> -- 
> 2.23.0
