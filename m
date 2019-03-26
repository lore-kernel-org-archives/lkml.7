Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B461C10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247B820657
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gy8qsIjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733022AbfCZXoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:44:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37228 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731824AbfCZXoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:44:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id 8so8802362pfr.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 16:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GxlmyXaXjzdj8x33dzr7hkXjfNPCIskY3a7a6mH5B+M=;
        b=gy8qsIjNyECjoKfSaF6rGs+qWjp0X+gXq1YQvk7JYuWr6TcHpBFxDRxAvb7fsNP7oZ
         4Jctd6qT+Bt+xNma3BzQo/6drEG6UImYrjw2Cs5zVnncY7dkaViBa8g+iaxPEvkAZSxD
         HTx8TDeru+Cew18zL5zxBhmh5QPTMptT/lLzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GxlmyXaXjzdj8x33dzr7hkXjfNPCIskY3a7a6mH5B+M=;
        b=SsQUsAjMa0B0lAMT9c8doMCQzPQ9xIHrt1FOd3wUP16edczg1XbZpJFbsGk1ztr63R
         IDRcfie14Z42RXj11/r9PKdEbXvqaqAlm3FioqxbPGZBQ8w/5U3As/x6iwWesY1YPzaj
         ndYvTyw8dXFCaEuUU3atEZiM4NVGsiFwSlvhyN1tmPtVkNNpH+6S2FsYs3dhwXwimNEt
         aBedNiLniAW9C92RnAWmel/WvLec5mqURRAnb5BFw9inr7Mr8BpdL8NBAja16g5eHkde
         puM6Wea0RRfkZAoZDvn4SE5YL6qljATgCkVZ9znUmklOUF600FezFNjoTEZXrk3/af/u
         qX5Q==
X-Gm-Message-State: APjAAAXotzEWDIOi493Cy811+bHm5Wu0Obdf6jSZMXwXmsI4qn+VKMFO
        sKQyXwS2wDvE/TjLufEblTj90g==
X-Google-Smtp-Source: APXvYqwdSG3qcGyJTZa5ZYLtaee3WSJeL+yUwoHEE0HDFJCSF8u5DXgBKoR87V83kqQ63KTHSW0qgQ==
X-Received: by 2002:a63:c10b:: with SMTP id w11mr31779378pgf.39.1553643844990;
        Tue, 26 Mar 2019 16:44:04 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id d3sm26803122pfc.125.2019.03.26.16.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 16:44:04 -0700 (PDT)
Date:   Tue, 26 Mar 2019 16:44:03 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Harish Bandi <c-hbandi@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, anubhavg@codeaurora.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org
Subject: Re: [PATCH v5 1/2] Bluetooth: hci_qca: Added support for WCN3998
Message-ID: <20190326234403.GZ112750@google.com>
References: <1553600756-8264-1-git-send-email-c-hbandi@codeaurora.org>
 <1553600756-8264-2-git-send-email-c-hbandi@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1553600756-8264-2-git-send-email-c-hbandi@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 05:15:55PM +0530, Harish Bandi wrote:
> Added new compatible for WCN3998 and corresponding voltage
> and current values to WCN3998 compatible.
> Changed driver code to support WCN3998
> 
> Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
> ---
> Changes in V5:
> - changed is_qca_soc_type_wcn399x_family to
> - qca_is_wcn399x helper function 
> - moved the qca_is_wcn399x function to btqca.c
> ---
>  drivers/bluetooth/btqca.c   | 13 +++++++++++--
>  drivers/bluetooth/btqca.h   |  8 +++++++-
>  drivers/bluetooth/hci_qca.c | 40 ++++++++++++++++++++++++++--------------
>  3 files changed, 44 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 6122685..383e99f 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -344,7 +344,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  
>  	/* Download rampatch file */
>  	config.type = TLV_TYPE_PATCH;
> -	if (soc_type == QCA_WCN3990) {
> +	if (qca_is_wcn399x(soc_type)) {
>  		/* Firmware files to download are based on ROM version.
>  		 * ROM version is derived from last two bytes of soc_ver.
>  		 */
> @@ -365,7 +365,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  
>  	/* Download NVM configuration */
>  	config.type = TLV_TYPE_NVM;
> -	if (soc_type == QCA_WCN3990)
> +	if (qca_is_wcn399x(soc_type))
>  		snprintf(config.fwname, sizeof(config.fwname),
>  			 "qca/crnv%02x.bin", rom_ver);
>  	else
> @@ -410,6 +410,15 @@ int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
>  }
>  EXPORT_SYMBOL_GPL(qca_set_bdaddr);
>  
> +bool qca_is_wcn399x(enum qca_btsoc_type soc_type)
> +{
> +	if ((soc_type == QCA_WCN3990) || (soc_type == QCA_WCN3998))
> +		return true;
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(qca_is_wcn399x);
> +
>  MODULE_AUTHOR("Ben Young Tae Kim <ytkim@qca.qualcomm.com>");
>  MODULE_DESCRIPTION("Bluetooth support for Qualcomm Atheros family ver " VERSION);
>  MODULE_VERSION(VERSION);
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index 6fdc25d..aca7b0d 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -132,7 +132,8 @@ enum qca_btsoc_type {
>  	QCA_INVALID = -1,
>  	QCA_AR3002,
>  	QCA_ROME,
> -	QCA_WCN3990
> +	QCA_WCN3990,
> +	QCA_WCN3998,
>  };
>  
>  #if IS_ENABLED(CONFIG_BT_QCA)
> @@ -142,6 +143,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  		   enum qca_btsoc_type soc_type, u32 soc_ver);
>  int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version);
>  int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
> +bool qca_is_wcn399x(enum qca_btsoc_type soc_type);
>  #else
>  
>  static inline int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
> @@ -165,4 +167,8 @@ static inline int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline bool qca_is_wcn399x(enum qca_btsoc_type soc_type)
> +{
> +	return -EOPNOTSUPP;

This function returns a bool, hence returning an error code is not
meaningful here. Just return false.

> +}
>  #endif
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 4ea995d..4af580a 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -521,7 +521,7 @@ static int qca_open(struct hci_uart *hu)
>  	if (hu->serdev) {
>  
>  		qcadev = serdev_device_get_drvdata(hu->serdev);
> -		if (qcadev->btsoc_type != QCA_WCN3990) {
> +		if (!qca_is_wcn399x(qcadev->btsoc_type)) {
>  			gpiod_set_value_cansleep(qcadev->bt_en, 1);
>  		} else {
>  			hu->init_speed = qcadev->init_speed;
> @@ -627,7 +627,7 @@ static int qca_close(struct hci_uart *hu)
>  
>  	if (hu->serdev) {
>  		qcadev = serdev_device_get_drvdata(hu->serdev);
> -		if (qcadev->btsoc_type == QCA_WCN3990)
> +		if (qca_is_wcn399x(qcadev->btsoc_type))
>  			qca_power_shutdown(hu);
>  		else
>  			gpiod_set_value_cansleep(qcadev->bt_en, 0);
> @@ -1008,7 +1008,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
>  		      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
>  
>  	/* Give the controller time to process the request */
> -	if (qca_soc_type(hu) == QCA_WCN3990)
> +	if (qca_is_wcn399x(qca_soc_type(hu)))
>  		msleep(10);
>  	else
>  		msleep(300);
> @@ -1084,7 +1084,7 @@ static unsigned int qca_get_speed(struct hci_uart *hu,
>  
>  static int qca_check_speeds(struct hci_uart *hu)
>  {
> -	if (qca_soc_type(hu) == QCA_WCN3990) {
> +	if (qca_is_wcn399x(qca_soc_type(hu))) {
>  		if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
>  		    !qca_get_speed(hu, QCA_OPER_SPEED))
>  			return -EINVAL;
> @@ -1116,7 +1116,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  		/* Disable flow control for wcn3990 to deassert RTS while
>  		 * changing the baudrate of chip and host.
>  		 */
> -		if (soc_type == QCA_WCN3990)
> +		if (qca_is_wcn399x(soc_type))
>  			hci_uart_set_flow_control(hu, true);
>  
>  		qca_baudrate = qca_get_baudrate_value(speed);
> @@ -1128,7 +1128,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  		host_set_baudrate(hu, speed);
>  
>  error:
> -		if (soc_type == QCA_WCN3990)
> +		if (qca_is_wcn399x(soc_type))
>  			hci_uart_set_flow_control(hu, false);
>  	}
>  
> @@ -1201,7 +1201,7 @@ static int qca_setup(struct hci_uart *hu)
>  	/* Patch downloading has to be done without IBS mode */
>  	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>  
> -	if (soc_type == QCA_WCN3990) {
> +	if (qca_is_wcn399x(soc_type)) {
>  		bt_dev_info(hdev, "setting up wcn3990");
>  
>  		/* Enable NON_PERSISTENT_SETUP QUIRK to ensure to execute
> @@ -1232,7 +1232,7 @@ static int qca_setup(struct hci_uart *hu)
>  		qca_baudrate = qca_get_baudrate_value(speed);
>  	}
>  
> -	if (soc_type != QCA_WCN3990) {
> +	if (!qca_is_wcn399x(soc_type)) {
>  		/* Get QCA version information */
>  		ret = qca_read_soc_version(hdev, &soc_ver);
>  		if (ret)
> @@ -1257,7 +1257,7 @@ static int qca_setup(struct hci_uart *hu)
>  	}
>  
>  	/* Setup bdaddr */
> -	if (soc_type == QCA_WCN3990)
> +	if (qca_is_wcn399x(soc_type))
>  		hu->hdev->set_bdaddr = qca_set_bdaddr;
>  	else
>  		hu->hdev->set_bdaddr = qca_set_bdaddr_rome;
> @@ -1280,7 +1280,7 @@ static int qca_setup(struct hci_uart *hu)
>  	.dequeue	= qca_dequeue,
>  };
>  
> -static const struct qca_vreg_data qca_soc_data = {
> +static const struct qca_vreg_data qca_soc_data_wcn3990 = {
>  	.soc_type = QCA_WCN3990,
>  	.vregs = (struct qca_vreg []) {
>  		{ "vddio",   1800000, 1900000,  15000  },
> @@ -1291,6 +1291,17 @@ static int qca_setup(struct hci_uart *hu)
>  	.num_vregs = 4,
>  };
>  
> +static const struct qca_vreg_data qca_soc_data_wcn3998 = {
> +	.soc_type = QCA_WCN3998,
> +	.vregs = (struct qca_vreg []) {
> +		{ "vddio",   1800000, 1900000,  10000  },
> +		{ "vddxo",   1800000, 1900000,  80000  },
> +		{ "vddrf",   1300000, 1352000,  300000 },
> +		{ "vddch0",  3300000, 3300000,  450000 },
> +	},
> +	.num_vregs = 4,
> +};
> +
>  static void qca_power_shutdown(struct hci_uart *hu)
>  {
>  	struct qca_data *qca = hu->priv;
> @@ -1424,8 +1435,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  	qcadev->serdev_hu.serdev = serdev;
>  	data = of_device_get_match_data(&serdev->dev);
>  	serdev_device_set_drvdata(serdev, qcadev);
> -	if (data && data->soc_type == QCA_WCN3990) {
> -		qcadev->btsoc_type = QCA_WCN3990;
> +	if (data && qca_is_wcn399x(data->soc_type)) {
> +		qcadev->btsoc_type = data->soc_type;
>  		qcadev->bt_power = devm_kzalloc(&serdev->dev,
>  						sizeof(struct qca_power),
>  						GFP_KERNEL);
> @@ -1489,7 +1500,7 @@ static void qca_serdev_remove(struct serdev_device *serdev)
>  {
>  	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
>  
> -	if (qcadev->btsoc_type == QCA_WCN3990)
> +	if (qca_is_wcn399x(qcadev->btsoc_type))
>  		qca_power_shutdown(&qcadev->serdev_hu);
>  	else
>  		clk_disable_unprepare(qcadev->susclk);
> @@ -1499,7 +1510,8 @@ static void qca_serdev_remove(struct serdev_device *serdev)
>  
>  static const struct of_device_id qca_bluetooth_of_match[] = {
>  	{ .compatible = "qcom,qca6174-bt" },
> -	{ .compatible = "qcom,wcn3990-bt", .data = &qca_soc_data},
> +	{ .compatible = "qcom,wcn3990-bt", .data = &qca_soc_data_wcn3990},
> +	{ .compatible = "qcom,wcn3998-bt", .data = &qca_soc_data_wcn3998},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);

Besides the return value in the qca_is_wcn399x() stub:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
