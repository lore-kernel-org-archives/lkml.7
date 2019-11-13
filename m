Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58422C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 00:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEB52196E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 00:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfKMAP0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:15:26 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:53699 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfKMAPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 19:15:25 -0500
Received: from marcel-macbook.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id D7FB5CECF4;
        Wed, 13 Nov 2019 01:24:28 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH v4 1/4] Bluetooth: hci_bcm: Disallow set_baudrate for
 BCM4354
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191112230944.48716-2-abhishekpandit@chromium.org>
Date:   Wed, 13 Nov 2019 01:15:23 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-bluetooth@vger.kernel.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <5DFA1A5A-0361-480F-8B26-5AAF7359F17F@holtmann.org>
References: <20191112230944.48716-1-abhishekpandit@chromium.org>
 <20191112230944.48716-2-abhishekpandit@chromium.org>
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
> for the BCM4354, disallow setting the operating speed before patchram.
> If set_baudrate is called before setup, it will return -EBUSY.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
> drivers/bluetooth/hci_bcm.c | 37 ++++++++++++++++++++++++++++++++++++-
> 1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 0f851c0dde7f..6134bff58748 100644
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
> + * @disallow_set_baudrate: don't allow set_baudrate
>  */
> struct bcm_device {
> 	/* Must be the first member, hci_serdev.c expects this. */
> @@ -112,6 +121,7 @@ struct bcm_device {
> 	struct hci_uart		*hu;
> 	bool			is_suspended;
> #endif
> +	bool			disallow_set_baudrate;
> };

call it no_early_set_baudrate here as well.

> 
> /* generic bcm uart resources */
> @@ -141,9 +151,13 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
> static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
> {
> 	struct hci_dev *hdev = hu->hdev;
> +	struct bcm_data *bcm = hu->priv;
> 	struct sk_buff *skb;
> 	struct bcm_update_uart_baud_rate param;
> 
> +	if (bcm && bcm->dev && bcm->dev->disallow_set_baudrate)
> +		return -EBUSY;
> +
> 	if (speed > 3000000) {
> 		struct bcm_write_uart_clock_setting clock;
> 
> @@ -551,6 +565,12 @@ static int bcm_setup(struct hci_uart *hu)
> 		goto finalize;
> 	}
> 
> +	/* If we disallow early set baudrate, we can re-enable it now that
> +	 * patchram is done
> +	 */
> +	if (bcm->dev && bcm->dev->disallow_set_baudrate)
> +		bcm->dev->disallow_set_baudrate = false;
> +

Lets not hack a different behavior of bcm_set_baudrate that magically changes based on a bool.

Actually wouldn’t be setting hu->oper_speed to 0 have the same affect and bcm_set_baudrate will not be called after setting the init speed. We should be ensuring that in the case where we do not want the baudrate change before calling ->setup() is somehow covered in hci_ldisc directly and not hacked into the ->set_baudrate callback.

> 	/* Init speed if any */
> 	if (hu->init_speed)
> 		speed = hu->init_speed;
> @@ -1371,6 +1391,15 @@ static struct platform_driver bcm_driver = {
> 	},
> };
> 
> +static void bcm_configure_device_data(struct bcm_device *bdev)
> +{
> +	const struct bcm_device_data *data = device_get_match_data(bdev->dev);
> +
> +	if (data) {
> +		bdev->disallow_set_baudrate = data->no_early_set_baudrate;
> +	}
> +}
> +
> static int bcm_serdev_probe(struct serdev_device *serdev)
> {
> 	struct bcm_device *bcmdev;
> @@ -1408,6 +1437,8 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
> 	if (err)
> 		dev_err(&serdev->dev, "Failed to power down\n");
> 
> +	bcm_configure_device_data(bcmdev);
> +

I would not split this out into a separate function. Lets do this in probe() right here.

> 	return hci_uart_register_device(&bcmdev->serdev_hu, &bcm_proto);
> }
> 
> @@ -1419,12 +1450,16 @@ static void bcm_serdev_remove(struct serdev_device *serdev)
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
> 	{ },
> };
> MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);

Regards

Marcel

