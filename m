Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1409C2D0CA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE34214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AnD962j2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbfLLRnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:43:52 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44725 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730235AbfLLRnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:43:51 -0500
Received: by mail-pl1-f195.google.com with SMTP id az3so881328plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 09:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GuBEFzX5L/KmRFYdGw2tsnNnogFgZtYo6kJYMRL2d1I=;
        b=AnD962j2myid8WfZ47WNy9/d7nvicLmLtLcM+Pb2j1MmswRDY41Z8qerQylGnuKcr5
         n9tvb681VzrQjbF+0arWfQn+N+O37W/1PXmwDDI8BYmYA9DkSDcRhlrswW3j777R0Efv
         cooEe887dVu+x52URwUGFbOfmceut8N4hhUiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GuBEFzX5L/KmRFYdGw2tsnNnogFgZtYo6kJYMRL2d1I=;
        b=MThNdLppfTUlT9mvz30zIuWaH5Wlx00p3pYtIRT9+MUpnpPhOTOwgqBcnuDTyicyyR
         LL61Ag/rgy1Iws9Qu2ldorYzC1QfZVHO1Y74dG7b7AzmIW96jLPNxrz2rDO3KkxoEQAy
         t22SqrB6yWvnbKsWLn+QS0eWA/65Flt0/9PBKusYTP+5ybQ9Z3ibCRIjv8AqXPnBERrZ
         PFh2hfdYOp9GCJDjMiLKYAF3zV9lDl91FK+KTy5jUdCvTtUNG7J/eN3q8X7Lj3o+fdcS
         STh1huvglLq1Px6LTS4JfqCTT65lDbpstsHsqz8NaesGzUtzSbjAfElfnNTyIv2GW2nc
         6vmA==
X-Gm-Message-State: APjAAAXIcny370Poia0JND2GoKcIB2j8cvwC7OJEFFstrbYIw/hmCHSx
        YTU1PTGfOfkspH9qnBqz646U4w==
X-Google-Smtp-Source: APXvYqy85B8z0SRxDxoW/j7/NrrCzAIIIDx2u3ctp9q7gR3aMilopGNx5KCUBaUWfYYHV6RHzgNCmQ==
X-Received: by 2002:a17:90a:62ca:: with SMTP id k10mr11283072pjs.59.1576172630293;
        Thu, 12 Dec 2019 09:43:50 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id g18sm7986007pfo.123.2019.12.12.09.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 09:43:49 -0800 (PST)
Date:   Thu, 12 Dec 2019 09:43:48 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tientzu@chromium.org, seanpaul@chromium.org
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Enable clocks required for BT SOC
Message-ID: <20191212174348.GS228856@google.com>
References: <20191114081430.25427-1-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191114081430.25427-1-bgodavar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 01:44:30PM +0530, Balakrishna Godavarthi wrote:
> Instead of relying on other subsytem to turn ON clocks
> required for BT SoC to operate, voting them from the driver.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
>  drivers/bluetooth/hci_qca.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index f10bdf8e1fc5..dc95e378574b 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -164,6 +164,7 @@ struct qca_serdev {
>  };
>  
>  static int qca_regulator_enable(struct qca_serdev *qcadev);
> +static int qca_power_on(struct qca_serdev *qcadev);
>  static void qca_regulator_disable(struct qca_serdev *qcadev);
>  static void qca_power_shutdown(struct hci_uart *hu);
>  static int qca_power_off(struct hci_dev *hdev);
> @@ -528,7 +529,7 @@ static int qca_open(struct hci_uart *hu)
>  		} else {
>  			hu->init_speed = qcadev->init_speed;
>  			hu->oper_speed = qcadev->oper_speed;
> -			ret = qca_regulator_enable(qcadev);
> +			ret = qca_power_on(qcadev);
>  			if (ret) {
>  				destroy_workqueue(qca->workqueue);
>  				kfree_skb(qca->rx_skb);
> @@ -1214,7 +1215,7 @@ static int qca_wcn3990_init(struct hci_uart *hu)
>  	qcadev = serdev_device_get_drvdata(hu->serdev);
>  	if (!qcadev->bt_power->vregs_on) {
>  		serdev_device_close(hu->serdev);
> -		ret = qca_regulator_enable(qcadev);
> +		ret = qca_power_on(qcadev);
>  		if (ret)
>  			return ret;
>  
> @@ -1408,6 +1409,9 @@ static void qca_power_shutdown(struct hci_uart *hu)
>  	host_set_baudrate(hu, 2400);
>  	qca_send_power_pulse(hu, false);
>  	qca_regulator_disable(qcadev);
> +
> +	if (qcadev->susclk)
> +		clk_disable_unprepare(qcadev->susclk);
>  }
>  
>  static int qca_power_off(struct hci_dev *hdev)
> @@ -1423,6 +1427,20 @@ static int qca_power_off(struct hci_dev *hdev)
>  	return 0;
>  }
>  
> +static int qca_power_on(struct qca_serdev *qcadev)
> +{
> +	int err;
> +
> +	if (qcadev->susclk) {
> +		err = clk_prepare_enable(qcadev->susclk);
> +		if (err)
> +			return err;
> +	}
> +
> +	qca_regulator_enable(qcadev);
> +	return 0;
> +}
> +
>  static int qca_regulator_enable(struct qca_serdev *qcadev)
>  {
>  	struct qca_power *power = qcadev->bt_power;
> @@ -1523,6 +1541,15 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  
>  		qcadev->bt_power->vregs_on = false;
>  
> +		if (qcadev->btsoc_type == QCA_WCN3990 ||
> +		    qcadev->btsoc_type == QCA_WCN3991) {
> +			qcadev->susclk = devm_clk_get(&serdev->dev, NULL);
> +			if (IS_ERR(qcadev->susclk)) {
> +				dev_err(&serdev->dev, "failed to acquire clk\n");
> +				return PTR_ERR(qcadev->susclk);
> +			}

This will break existing users. Use devm_clk_get_optional() and at most
raise a warning if the clock doesn't exist.

It would also be nice to add the clock to the affected devices in the tree
if possible:

arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi:                compatible = "qcom,wcn3990-bt";
arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi:              compatible = "qcom,wcn3990-bt";
arch/arm64/boot/dts/qcom/qcs404-evb.dtsi:               compatible = "qcom,wcn3990-bt";
arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi:             compatible = "qcom,wcn3990-bt";
arch/arm64/boot/dts/qcom/sdm845-db845c.dts:             compatible = "qcom,wcn3990-bt";
arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts:           compatible = "qcom,wcn3990-bt";
