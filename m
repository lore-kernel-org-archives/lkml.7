Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F6EC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 06:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFD2214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 06:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfKHGIz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 01:08:55 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:39552 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfKHGIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 01:08:55 -0500
Received: from marcel-macpro.fritz.box (p5B3D2BA4.dip0.t-ipconnect.de [91.61.43.164])
        by mail.holtmann.org (Postfix) with ESMTPSA id DA6AECED12;
        Fri,  8 Nov 2019 07:17:57 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH v2 1/4] Bluetooth: hci_bcm: Disallow set_baudrate for
 BCM4354
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191107232713.48577-2-abhishekpandit@chromium.org>
Date:   Fri, 8 Nov 2019 07:08:53 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-bluetooth@vger.kernel.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <F01BD2DD-B11F-49F8-92D8-CF679C56CD40@holtmann.org>
References: <20191107232713.48577-1-abhishekpandit@chromium.org>
 <20191107232713.48577-2-abhishekpandit@chromium.org>
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
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
> Changes in v2: None
> 
> drivers/bluetooth/hci_bcm.c | 25 +++++++++++++++++++++++--
> 1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 0f851c0dde7f..2114df607cb3 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -1167,7 +1167,7 @@ static int bcm_remove(struct platform_device *pdev)
> 	return 0;
> }
> 
> -static const struct hci_uart_proto bcm_proto = {
> +static struct hci_uart_proto bcm_proto = {
> 	.id		= HCI_UART_BCM,
> 	.name		= "Broadcom",
> 	.manufacturer	= 15,
> @@ -1371,6 +1371,24 @@ static struct platform_driver bcm_driver = {
> 	},
> };
> 
> +#define BCM_QUIRK_DISALLOW_SET_BAUDRATE (1 << 0)
> +const u32 disallow_set_baudrate = BCM_QUIRK_DISALLOW_SET_BAUDRATE;
> +
> +static int bcm_check_disallow_set_baudrate(struct serdev_device *serdev)
> +{
> +	const u32 *quirks = device_get_match_data(&serdev->dev);
> +
> +	if (quirks) {
> +		/* BCM4354 can't run at full speed before patchram. Disallow
> +		 * externally setting operating speed.
> +		 */
> +		if (*quirks & BCM_QUIRK_DISALLOW_SET_BAUDRATE)
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
> static int bcm_serdev_probe(struct serdev_device *serdev)
> {
> 	struct bcm_device *bcmdev;
> @@ -1408,6 +1426,9 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
> 	if (err)
> 		dev_err(&serdev->dev, "Failed to power down\n");
> 
> +	if (bcm_check_disallow_set_baudrate(serdev))
> +		bcm_proto.set_baudrate = NULL;
> +

this change is not allowed since bcm_proto is on purpose const.

> 	return hci_uart_register_device(&bcmdev->serdev_hu, &bcm_proto);
> }
> 
> @@ -1424,7 +1445,7 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
> 	{ .compatible = "brcm,bcm4345c5" },
> 	{ .compatible = "brcm,bcm4330-bt" },
> 	{ .compatible = "brcm,bcm43438-bt" },
> -	{ .compatible = "brcm,bcm43540-bt" },
> +	{ .compatible = "brcm,bcm43540-bt", .data = &disallow_set_baudrate },
> 	{ },
> };
> MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);

So I would prefer if we do this in a more generic from that will make this easy to extend in the future. Similar to what hci_qca.c does actually with defining a separate struct for the module differences.

struct bcm_device_data (
	bool no_early_oper_speed;
};

static const struct bcm_device_data bcm43540_device {
	.no_early_oper_speed = true,
};

static const struct of_device_id bcm_bluetooth_of_match[] = {
	..
	{ .compatible = "brcm,bcm43540-bt", .data = &bcm43540_device },
	( },
};

And then load the struct in serdev probe as pointer and check its existence and add the struct bcm_device_data to struct bcm_device so it can be referenced when you change the baudrate.

Regards

Marcel

