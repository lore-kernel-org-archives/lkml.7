Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A521C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDD42072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfKOH7b convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 02:59:31 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:34002 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOH7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 02:59:30 -0500
Received: from marcel-macbook.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id DF3C9CED16;
        Fri, 15 Nov 2019 09:08:34 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH v5 1/4] Bluetooth: hci_bcm: Disallow set_baudrate for
 BCM4354
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191114180959.v5.1.I8ed714e23fdf42fa35588cfee2877b53d781df12@changeid>
Date:   Fri, 15 Nov 2019 08:59:28 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-bluetooth@vger.kernel.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <43FDCD41-50CE-4A4B-BC57-6466FE4090F8@holtmann.org>
References: <20191115021008.32926-1-abhishekpandit@chromium.org>
 <20191114180959.v5.1.I8ed714e23fdf42fa35588cfee2877b53d781df12@changeid>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

> Without updating the patchram, the BCM4354 does not support a higher
> operating speed. The normal bcm_setup follows the correct order
> (init_speed, patchram and then oper_speed) but the serdev driver will
> set the operating speed before calling the hu->setup function. Thus,
> for the BCM4354, don't set the operating speed before patchram.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
> drivers/bluetooth/hci_bcm.c | 31 +++++++++++++++++++++++++++++--
> 1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 0f851c0dde7f..ee40003008d8 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -47,6 +47,14 @@
> 
> #define BCM_NUM_SUPPLIES 2
> 
> +/**
> + * struct bcm_device_data - device specific data
> + * @no_early_set_baudrate: Disallow set baudrate before driver setup()
> + */
> +struct bcm_device_data {
> +	bool	no_early_set_baudrate;
> +};
> +
> /**
>  * struct bcm_device - device driver resources
>  * @serdev_hu: HCI UART controller struct
> @@ -79,6 +87,7 @@
>  * @hu: pointer to HCI UART controller struct,
>  *	used to disable flow control during runtime suspend and system sleep
>  * @is_suspended: whether flow control is currently disabled
> + * @no_early_set_baudrate: don't set_baudrate before setup()
>  */
> struct bcm_device {
> 	/* Must be the first member, hci_serdev.c expects this. */
> @@ -112,6 +121,7 @@ struct bcm_device {
> 	struct hci_uart		*hu;
> 	bool			is_suspended;
> #endif
> +	bool			no_early_set_baudrate;
> };
> 
> /* generic bcm uart resources */
> @@ -447,7 +457,13 @@ static int bcm_open(struct hci_uart *hu)
> 	if (bcm->dev) {
> 		hci_uart_set_flow_control(hu, true);
> 		hu->init_speed = bcm->dev->init_speed;
> -		hu->oper_speed = bcm->dev->oper_speed;
> +
> +		/* If oper_speed is set, ldisc/serdev will set the baudrate
> +		 * before calling setup()
> +		 */
> +		if (!bcm->dev->no_early_set_baudrate)
> +			hu->oper_speed = bcm->dev->oper_speed;
> +
> 		err = bcm_gpio_set_power(bcm->dev, true);
> 		hci_uart_set_flow_control(hu, false);
> 		if (err)
> @@ -565,6 +581,8 @@ static int bcm_setup(struct hci_uart *hu)
> 	/* Operational speed if any */
> 	if (hu->oper_speed)
> 		speed = hu->oper_speed;
> +	else if (bcm->dev && bcm->dev->oper_speed)
> +		speed = bcm->dev->oper_speed;
> 	else if (hu->proto->oper_speed)
> 		speed = hu->proto->oper_speed;
> 	else
> @@ -1374,6 +1392,7 @@ static struct platform_driver bcm_driver = {
> static int bcm_serdev_probe(struct serdev_device *serdev)
> {
> 	struct bcm_device *bcmdev;
> +	const struct bcm_device_data *data;
> 	int err;
> 
> 	bcmdev = devm_kzalloc(&serdev->dev, sizeof(*bcmdev), GFP_KERNEL);
> @@ -1408,6 +1427,10 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
> 	if (err)
> 		dev_err(&serdev->dev, "Failed to power down\n");
> 
> +	data = device_get_match_data(bcmdev->dev);
> +	if (data)
> +		bcmdev->no_early_set_baudrate = data->no_early_set_baudrate;
> +
> 	return hci_uart_register_device(&bcmdev->serdev_hu, &bcm_proto);
> }
> 
> @@ -1419,12 +1442,16 @@ static void bcm_serdev_remove(struct serdev_device *serdev)
> }
> 
> #ifdef CONFIG_OF
> +struct bcm_device_data bcm4354_device_data = {
> +	.no_early_set_baudrate = true,
> +};
> +
> static const struct of_device_id bcm_bluetooth_of_match[] = {
> 	{ .compatible = "brcm,bcm20702a1" },
> 	{ .compatible = "brcm,bcm4345c5" },
> 	{ .compatible = "brcm,bcm4330-bt" },
> 	{ .compatible = "brcm,bcm43438-bt" },
> -	{ .compatible = "brcm,bcm43540-bt" },
> +	{ .compatible = "brcm,bcm43540-bt", .data = &bcm4354_device_data },

this looks good to me. Can some users of the other devices test this patch so we ensure that it won’t break other devices.

Regards

Marcel

