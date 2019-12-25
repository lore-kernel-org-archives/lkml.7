Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89D3C2D0D2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 06:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8A92071E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 06:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="YAWbgbcD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfLYGGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 01:06:45 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:55942 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726196AbfLYGGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 01:06:44 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577254004; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=uF/H7RqOd6615exg5HgD2G2EtWcxz1r5d/hhmXY1gmA=;
 b=YAWbgbcDvxkkfvIiimYSMFRIBXz/9KsSX9DS6XCLvotov8hVRdRzhSfeS1yhMNJfybMZuE7M
 6AAT1crnN+Oza0Xpq+udc5uCYmYrJ9IjWX9c0py4ix54cyKeQKZD7JIE8lwwm3vYuk18hp6g
 DRCPLi7r2NMsFpp1THGpcVwSAjc=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e02fc71.7fe1883c3618-smtp-out-n03;
 Wed, 25 Dec 2019 06:06:41 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C2986C43383; Wed, 25 Dec 2019 06:06:40 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rjliao)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3E928C433CB;
        Wed, 25 Dec 2019 06:06:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 25 Dec 2019 14:06:40 +0800
From:   rjliao@codeaurora.org
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Add poweroff support during hci
 down for QCA Rome
In-Reply-To: <20191219040334.15355-1-rjliao@codeaurora.org>
References: <20191219040334.15355-1-rjliao@codeaurora.org>
Message-ID: <52b233716cc5bd39b67c49ad2e45d899@codeaurora.org>
X-Sender: rjliao@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ingnore this patch, I have just sent the new set of patches.

在 2019-12-19 12:03，Rocky Liao 写道：
> This patch enables power off support for hci down and power on support
> for hci up. As QCA Rome power sources are ignited by bt_en GPIO, we 
> will
> pull it down during hci down, i.e. an complete power off of QCA Rome.
> So while hci up, will pull up the bt_en GPIO again to power on the 
> chip,
> requests BT chip version and download the firmware.
> 
> Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
> ---
>  drivers/bluetooth/hci_qca.c | 34 ++++++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index b602ed01505b..1cb706acdef6 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1257,6 +1257,7 @@ static int qca_setup(struct hci_uart *hu)
>  {
>  	struct hci_dev *hdev = hu->hdev;
>  	struct qca_data *qca = hu->priv;
> +	struct qca_serdev *qcadev;
>  	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
>  	enum qca_btsoc_type soc_type = qca_soc_type(hu);
>  	const char *firmware_name = qca_get_firmware_name(hu);
> @@ -1293,6 +1294,17 @@ static int qca_setup(struct hci_uart *hu)
>  			return ret;
>  	} else {
>  		bt_dev_info(hdev, "ROME setup");
> +		if (hu->serdev) {
> +			/* Enable NON_PERSISTENT_SETUP QUIRK to ensure to
> +			 * execute setup for every hci up.
> +			 */
> +			set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
> +			qcadev = serdev_device_get_drvdata(hu->serdev);
> +			hu->hdev->shutdown = qca_power_off;
> +			gpiod_set_value_cansleep(qcadev->bt_en, 1);
> +			/* Controller needs time to bootup. */
> +			msleep(150);
> +		}
>  		qca_set_speed(hu, QCA_INIT_SPEED);
>  	}
> 
> @@ -1413,13 +1425,27 @@ static void qca_power_shutdown(struct hci_uart 
> *hu)
>  static int qca_power_off(struct hci_dev *hdev)
>  {
>  	struct hci_uart *hu = hci_get_drvdata(hdev);
> +	struct qca_serdev *qcadev;
> +	enum qca_btsoc_type soc_type = qca_soc_type(hu);
> 
> -	/* Perform pre shutdown command */
> -	qca_send_pre_shutdown_cmd(hdev);
> +	if (qca_is_wcn399x(soc_type)) {
> +		/* Perform pre shutdown command */
> +		qca_send_pre_shutdown_cmd(hdev);
> 
> -	usleep_range(8000, 10000);
> +		usleep_range(8000, 10000);
> +
> +		qca_power_shutdown(hu);
> +	} else {
> +		if (hu->serdev) {
> +
> +			qcadev = serdev_device_get_drvdata(hu->serdev);
> +
> +			gpiod_set_value_cansleep(qcadev->bt_en, 0);
> +
> +			usleep_range(8000, 10000);
> +		}
> +	}
> 
> -	qca_power_shutdown(hu);
>  	return 0;
>  }
