Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62B7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8136206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c7s0HgGG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Rh2IKcoY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfDDG4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 02:56:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46644 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfDDG4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 02:56:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 730456049C; Thu,  4 Apr 2019 06:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554360982;
        bh=ZcOYz2iLYsuN9Xpr09ZbI0cLZncn8oXwA9x0iyLO/3c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c7s0HgGG73VB43Uj+FONQeSlZ7B/MqpkpDTbUYxfGvj55pRL/UjOMDknUFX4KHng6
         w/AjjRzKh0TqRLf37AD3vlNr6Z5NaEsDzMeZUCRWSegoAwqxHVL2+fYOnDk4iwiYfG
         NGv8uvkgU+jwpW9HqMxg/5O3Wi8UdaARRkkB/a20=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C45D3602F2;
        Thu,  4 Apr 2019 06:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554360981;
        bh=ZcOYz2iLYsuN9Xpr09ZbI0cLZncn8oXwA9x0iyLO/3c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rh2IKcoYazYfGQxQW2OsahVpgBVFXXJE+iznYy4/uyoQIHUpljrXrECSm7+sPSwk4
         /55n5cNUozT72iJjuQDAakw5sznTIrhcqszkrzwFjDZCtrs0Gcbx1CdM7uhKDLfo6W
         u6OT0iCpLlv/hTdf8VziXLvCQ4isRyJu2ABzCt0c=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 04 Apr 2019 12:26:21 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Rocky Liao <rjliao@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, hemantg@codeaurora.org
Subject: Re: [PATCH] Bluetooth: hci_qca: Load customized NVM based on the
 device property
In-Reply-To: <1554359858-21049-1-git-send-email-rjliao@codeaurora.org>
References: <1554359858-21049-1-git-send-email-rjliao@codeaurora.org>
Message-ID: <55299fad8149676f26e5351a1abf0b0f@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rocky,

On 2019-04-04 12:07, Rocky Liao wrote:
> QCA BTSOC nvm is a customized file and different vendor/platoform may 
> want
> to have different BTSOC configuration via this file (e.g. Configure SCO 
> over
> PCM or I2S, Setting Tx power, etc.) This patch will allow vendors to 
> download
> different nvm file by reading a device property as the nvm file name 
> postfix.
> 

[Bala]: add the property which your reading to the documentation file.
         "Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt"

> Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
> ---
>  drivers/bluetooth/btqca.c   | 13 +++++++++----
>  drivers/bluetooth/btqca.h   |  4 ++--
>  drivers/bluetooth/hci_qca.c | 18 +++++++++++++++++-
>  3 files changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 6122685..81e42f3 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -332,7 +332,7 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev,
> const bdaddr_t *bdaddr)
>  EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
> 
>  int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> -		   enum qca_btsoc_type soc_type, u32 soc_ver)
> +		   enum qca_btsoc_type soc_type, u32 soc_ver, const char 
> *nvm_postfix)
>  {
>  	struct rome_config config;
>  	int err;
> @@ -368,9 +368,14 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t 
> baudrate,
>  	if (soc_type == QCA_WCN3990)
>  		snprintf(config.fwname, sizeof(config.fwname),
>  			 "qca/crnv%02x.bin", rom_ver);
> -	else
> -		snprintf(config.fwname, sizeof(config.fwname),
> -			 "qca/nvm_%08x.bin", soc_ver);
> +	else {
> +		if (NULL == nvm_postfix)
[Bala]:
        something like this is more readable.
                 if (nvm_postfix)
                     append the nvm postfix string.
                 else
                     go with an default name.

> +			snprintf(config.fwname, sizeof(config.fwname),
> +				 "qca/nvm_%08x.bin", soc_ver);
> +		else
> +			snprintf(config.fwname, sizeof(config.fwname),
> +				 "qca/nvm_%08x_%s.bin", soc_ver, nvm_postfix);
> +	}
> 
>  	err = qca_download_firmware(hdev, &config);
>  	if (err < 0) {
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index 6fdc25d..60a868f 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -139,7 +139,7 @@ enum qca_btsoc_type {
> 
>  int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr);
>  int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> -		   enum qca_btsoc_type soc_type, u32 soc_ver);
> +		   enum qca_btsoc_type soc_type, u32 soc_ver, const char 
> *nvm_postfix);
>  int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version);
>  int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
>  #else
> @@ -150,7 +150,7 @@ static inline int qca_set_bdaddr_rome(struct
> hci_dev *hdev, const bdaddr_t *bdad
>  }
> 
>  static inline int qca_uart_setup(struct hci_dev *hdev, uint8_t 
> baudrate,
> -				 enum qca_btsoc_type soc_type, u32 soc_ver)
> +				 enum qca_btsoc_type soc_type, u32 soc_ver, const char 
> *nvm_postfix)
>  {
>  	return -EOPNOTSUPP;
>  }
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 4ea995d..f495f3b 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -164,6 +164,7 @@ struct qca_serdev {
>  	struct hci_uart	 serdev_hu;
>  	struct gpio_desc *bt_en;
>  	struct clk	 *susclk;
> +	const char   *nvm_postfix;

[Bala]: nit: add the entry at last is preferred.

>  	enum qca_btsoc_type btsoc_type;
>  	struct qca_power *bt_power;
>  	u32 init_speed;
> @@ -189,6 +190,17 @@ static enum qca_btsoc_type qca_soc_type(struct
> hci_uart *hu)
>  	return soc_type;
>  }
> 
> +static const char *qca_get_nvm_postfix(struct hci_uart *hu)
> +{
> +	if (hu->serdev) {
> +		struct qca_serdev *qsd = serdev_device_get_drvdata(hu->serdev);
> +
> +		return qsd->nvm_postfix;
> +	} else {
> +		return NULL;
> +	}
> +}
> +
>  static void __serial_clock_on(struct tty_struct *tty)
>  {
>  	/* TODO: Some chipset requires to enable UART clock on client
> @@ -1191,6 +1203,7 @@ static int qca_setup(struct hci_uart *hu)
>  	struct qca_data *qca = hu->priv;
>  	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
>  	enum qca_btsoc_type soc_type = qca_soc_type(hu);
> +	const char *nvm_postfix = qca_get_nvm_postfix(hu);
>  	int ret;
>  	int soc_ver = 0;
> 
> @@ -1241,7 +1254,7 @@ static int qca_setup(struct hci_uart *hu)
> 
>  	bt_dev_info(hdev, "QCA controller version 0x%08x", soc_ver);
>  	/* Setup patch / NVM configurations */
> -	ret = qca_uart_setup(hdev, qca_baudrate, soc_type, soc_ver);
> +	ret = qca_uart_setup(hdev, qca_baudrate, soc_type, soc_ver, 
> nvm_postfix);
>  	if (!ret) {
>  		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>  		qca_debugfs_init(hdev);
> @@ -1462,6 +1475,9 @@ static int qca_serdev_probe(struct serdev_device 
> *serdev)
>  			return PTR_ERR(qcadev->bt_en);
>  		}
> 
> +		device_property_read_string(&serdev->dev, "nvm-postfix",
> +					 &qcadev->nvm_postfix);
> +
>  		qcadev->susclk = devm_clk_get(&serdev->dev, NULL);
>  		if (IS_ERR(qcadev->susclk)) {
>  			dev_err(&serdev->dev, "failed to acquire clk\n");

-- 
Regards
Balakrishna.
