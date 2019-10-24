Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1220CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D825F20856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WsVMmVTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438183AbfJXI03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 04:26:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36081 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfJXI02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:26:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id w18so24467068wrt.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 01:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iA8rnha9mtyoi6ioF93JoEJEpTtmN445x+IcHqPDVEc=;
        b=WsVMmVTs5afSXPK5AtLu8vC5zxAK90MRe1AVDo+TWW2PefFV/5LIfXpd01x08eKGUP
         qf3WrHd6I1rEXsvhkZXZmulyDKlwehsL4Mk6XntcOhOeqcdW8RSpB9F1UmwbHJRlKzry
         7TO2RjGsvBM+TFWQnO8MLmTjp85la1Zjt/tI5MBMxFn1AZvKs92V4ER+h6cKaAeJPbd8
         cXDJ1m56FPbloDPc5g7K6ttEZjrdPC8Os09S/SS5zwasdw3WUzzeB0QFOcSWFnGFCrrA
         O7ZA5g7ZWafR5OXdpP0x5La7eooMlen51xPnGfcAAd45wyz7NbFOmVw3uXCFSlFGRPXy
         hKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iA8rnha9mtyoi6ioF93JoEJEpTtmN445x+IcHqPDVEc=;
        b=sCwGsHA+s3asi0ucS9iowzTcmeLTeHdRgiBiHrdvcoQaKXNjZEET3diq3U0DVxhS1Q
         BU3CJGPyNzLjFDWpSrdf5GRPctPUGqTvfSmzjynQIo0Lv4eObmhdG1VapRYL/vblo1lL
         RODdz8tnPRknRxLO2Rpcu9yLHqCccNuatyq9+iKS7MYib8qEFgnZLDlPCLCGC5Ju/mXG
         5pKUGtCvwnSr74lkeCOosgKhY/rjJtJytCCrRxlWvm+HagiO0IR+CW9Rsl9E++fkjLkT
         mkgr/aXx/3cyRylqj9UbUUNNYBED2Rur8xlXw+ClEfcniOQZVgs30AwF/G1gNYzKha4k
         am4Q==
X-Gm-Message-State: APjAAAUquSWo05lGKVi+XGLfKfsRfu2sWXSPNpKBgyrxd4N7FZK/9XOH
        GuMRSl0qGOCkIpOr4JbFcHeIRw==
X-Google-Smtp-Source: APXvYqyWnXOBj5OdVaRqahDjN6ixk3Hyp4yaNekREtOtQfuDW1V7NGEodxiGvks+oDuvlwwRd4Xqgw==
X-Received: by 2002:adf:e542:: with SMTP id z2mr2459639wrm.338.1571905585910;
        Thu, 24 Oct 2019 01:26:25 -0700 (PDT)
Received: from dell ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id v6sm28034467wru.72.2019.10.24.01.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 01:26:25 -0700 (PDT)
Date:   Thu, 24 Oct 2019 09:26:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v4] mfd: mt6360: add pmic mt6360 driver
Message-ID: <20191024082623.GK15843@dell>
References: <1571749359-15752-1-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1571749359-15752-1-git-send-email-gene.chen.richtek@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfram,

Would you be kind enough to see below please?

I'd like to know if it looks sane to you.

On Tue, 22 Oct 2019, Gene Chen wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> Add mfd driver for mt6360 pmic chip include
> Battery Charger/USB_PD/Flash LED/RGB LED/LDO/Buck
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com
> ---
>  drivers/mfd/Kconfig                |  12 +
>  drivers/mfd/Makefile               |   1 +
>  drivers/mfd/mt6360-core.c          | 457 +++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mt6360-private.h | 279 ++++++++++++++++++++++
>  include/linux/mfd/mt6360.h         |  32 +++
>  5 files changed, 781 insertions(+)
>  create mode 100644 drivers/mfd/mt6360-core.c
>  create mode 100644 include/linux/mfd/mt6360-private.h
>  create mode 100644 include/linux/mfd/mt6360.h
> 
> changelogs between v1 & v2
> - include missing header file
> 
> changelogs between v2 & v3
> - add changelogs
> 
> changelogs between v3 & v4
> - fix Kconfig description
> - replace mt6360_pmu_info with mt6360_pmu_data
> - replace probe with probe_new
> - remove unnecessary irq_chip variable
> - remove annotation
> - replace MT6360_MFD_CELL with OF_MFD_CELL

[...]

> +	for (i = 0; i < MT6360_SLAVE_MAX; i++) {
> +		if (mt6360_slave_addr[i] == client->addr) {
> +			mpd->i2c[i] = client;
> +			continue;
> +		}
> +		mpd->i2c[i] = i2c_new_dummy(client->adapter,
> +					    mt6360_slave_addr[i]);
> +		if (!mpd->i2c[i]) {
> +			dev_err(&client->dev, "new i2c dev [%d] fail\n", i);
> +			ret = -ENODEV;
> +			goto out;
> +		}
> +		i2c_set_clientdata(mpd->i2c[i], mpd);
> +	}
> +
> +	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO,
> +				   mt6360_devs, ARRAY_SIZE(mt6360_devs), NULL,
> +				   0, regmap_irq_get_domain(mpd->irq_data));
> +	if (ret < 0) {
> +		dev_err(&client->dev, "mfd add cells fail\n");
> +		goto out;
> +	}
> +
> +	return 0;
> +out:
> +	while (--i >= 0) {
> +		if (mpd->i2c[i]->addr == client->addr)
> +			continue;
> +		i2c_unregister_device(mpd->i2c[i]);
> +	}
> +
> +	return ret;
> +}
> +
> +static int mt6360_pmu_remove(struct i2c_client *client)
> +{
> +	struct mt6360_pmu_data *mpd = i2c_get_clientdata(client);
> +	int i;
> +
> +	for (i = 0; i < MT6360_SLAVE_MAX; i++) {
> +		if (mpd->i2c[i]->addr == client->addr)
> +			continue;
> +		i2c_unregister_device(mpd->i2c[i]);
> +	}
> +
> +	return 0;
> +}

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
