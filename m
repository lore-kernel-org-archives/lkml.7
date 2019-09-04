Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C6DC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E3D22CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbfIDOXc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 10:23:32 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52632 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730880AbfIDOXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:23:31 -0400
Received: from marcel-macbook.fritz.box (p4FEFC197.dip0.t-ipconnect.de [79.239.193.151])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8C9A6CECB0;
        Wed,  4 Sep 2019 16:32:17 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Bluetooth: btusb: Use cmd_timeout to reset Realtek device
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190903094103.GA10714@laptop-alex>
Date:   Wed, 4 Sep 2019 16:23:29 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Chou <max.chou@realtek.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <989DBD04-B5DC-4733-8784-93B45BA9FF15@holtmann.org>
References: <20190903094103.GA10714@laptop-alex>
To:     Alex Lu <alex_lu@realsil.com.cn>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

> Realtek Bluetooth controller provides a BT_DIS reset pin for hardware
> reset of it. The cmd_timeout is helpful on Realtek bluetooth controller
> where the firmware gets stuck.
> 
> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> ---
> drivers/bluetooth/btusb.c | 29 +++++++++++++++++++++--------
> 1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 31d3febed187..a626de3a3f4c 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -489,16 +489,19 @@ struct btusb_data {
> 	int (*setup_on_usb)(struct hci_dev *hdev);
> 
> 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
> -	unsigned cmd_timeout_cnt;
> +	unsigned int cmd_timeout_cnt;
> +	unsigned int cmd_timeout_max;
> +	unsigned int reset_msecs;
> +	int reset_gpio_value;
> };
> 
> 
> -static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
> +static void btusb_cmd_timeout(struct hci_dev *hdev)
> {
> 	struct btusb_data *data = hci_get_drvdata(hdev);
> 	struct gpio_desc *reset_gpio = data->reset_gpio;
> 
> -	if (++data->cmd_timeout_cnt < 5)
> +	if (++data->cmd_timeout_cnt < data->cmd_timeout_max)
> 		return;
> 
> 	if (!reset_gpio) {
> @@ -519,9 +522,9 @@ static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
> 	}
> 
> 	bt_dev_err(hdev, "Initiating HW reset via gpio");
> -	gpiod_set_value_cansleep(reset_gpio, 1);
> -	msleep(100);
> -	gpiod_set_value_cansleep(reset_gpio, 0);
> +	gpiod_set_value_cansleep(reset_gpio, data->reset_gpio_value);
> +	msleep(data->reset_msecs);
> +	gpiod_set_value_cansleep(reset_gpio, !data->reset_gpio_value);
> }

I really prefer that no Realtek specifics end up in a callback that is meant for Intel hardware. So this needs to be split.

So can you just provide a btusb_rtl_cmd_timeout callback and set it in case of Realtek hardware.

Regards

Marcel

