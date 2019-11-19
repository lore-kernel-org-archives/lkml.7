Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C305C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397BC208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbfKSFoz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:44:55 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:43122 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730881AbfKSFor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:44:47 -0500
Received: from marcel-macbook.holtmann.net (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id C597FCECEE;
        Tue, 19 Nov 2019 06:53:52 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH v6 4/4] Bluetooth: hci_bcm: Support pcm params in dts
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191118110335.v6.4.I3e900de9478b68e5e4475e747d1c46fdd28313fa@changeid>
Date:   Tue, 19 Nov 2019 06:44:45 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-bluetooth@vger.kernel.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <963EC7CC-B81D-4667-A681-2CE49D17CB1E@holtmann.org>
References: <20191118192123.82430-1-abhishekpandit@chromium.org>
 <20191118110335.v6.4.I3e900de9478b68e5e4475e747d1c46fdd28313fa@changeid>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

> BCM chips may require configuration of PCM to operate correctly and
> there is a vendor specific HCI command to do this. Add support in the
> hci_bcm driver to parse this from devicetree and configure the chip.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
> Changes in v6:
> - Added btbcm_read_pcm_int_params and change pcm params to first read
>  the pcm params before setting it
> 
> Changes in v5:
> - Rename parameters to bt-* and read as integer instead of bytestring
> - Update documentation with defaults and put values in header
> - Changed patch order
> 
> Changes in v4:
> - Fix incorrect function name in hci_bcm
> 
> Changes in v3:
> - Change disallow baudrate setting to return -EBUSY if called before
>  ready. bcm_proto is no longer modified and is back to being const.
> - Changed btbcm_set_pcm_params to btbcm_set_pcm_int_params
> - Changed brcm,sco-routing to brcm,bt-sco-routing
> 
> Changes in v2:
> - Use match data to disallow baudrate setting
> - Parse pcm parameters by name instead of as a byte string
> - Fix prefix for dt-bindings commit
> 
> drivers/bluetooth/hci_bcm.c | 57 +++++++++++++++++++++++++++++++++++++
> 1 file changed, 57 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index ee40003008d8..2ce3fac2c5dd 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -25,6 +25,7 @@
> #include <linux/pm_runtime.h>
> #include <linux/serdev.h>
> 
> +#include <dt-bindings/bluetooth/brcm.h>
> #include <net/bluetooth/bluetooth.h>
> #include <net/bluetooth/hci_core.h>
> 
> @@ -88,6 +89,7 @@ struct bcm_device_data {
>  *	used to disable flow control during runtime suspend and system sleep
>  * @is_suspended: whether flow control is currently disabled
>  * @no_early_set_baudrate: don't set_baudrate before setup()
> + * @pcm_params: PCM and routing parameters
>  */
> struct bcm_device {
> 	/* Must be the first member, hci_serdev.c expects this. */
> @@ -122,6 +124,8 @@ struct bcm_device {
> 	bool			is_suspended;
> #endif
> 	bool			no_early_set_baudrate;
> +
> +	struct bcm_set_pcm_int_params	pcm_params;
> };
> 
> /* generic bcm uart resources */
> @@ -541,6 +545,7 @@ static int bcm_flush(struct hci_uart *hu)
> static int bcm_setup(struct hci_uart *hu)
> {
> 	struct bcm_data *bcm = hu->priv;
> +	struct bcm_set_pcm_int_params p;
> 	char fw_name[64];
> 	const struct firmware *fw;
> 	unsigned int speed;
> @@ -594,6 +599,31 @@ static int bcm_setup(struct hci_uart *hu)
> 			host_set_baudrate(hu, speed);
> 	}
> 
> +	/* PCM parameters if any*/
> +	err = btbcm_read_pcm_int_params(hu->hdev, &p);
> +	if (!err) {
> +		if (bcm->dev->pcm_params.routing == 0xff)
> +			bcm->dev->pcm_params.routing = p.routing;
> +		if (bcm->dev->pcm_params.rate == 0xff)
> +			bcm->dev->pcm_params.rate = p.rate;
> +		if (bcm->dev->pcm_params.frame_sync == 0xff)
> +			bcm->dev->pcm_params.frame_sync = p.frame_sync;
> +		if (bcm->dev->pcm_params.sync_mode == 0xff)
> +			bcm->dev->pcm_params.sync_mode = p.sync_mode;
> +		if (bcm->dev->pcm_params.clock_mode == 0xff)
> +			bcm->dev->pcm_params.clock_mode = p.clock_mode;

Frankly, I wouldn’t bother here. If the read HCI command failed, then we abort bcm_setup and fail the whole procedure. These commands have been around the first Broadcom chips and you can assume they are present. And if at some point they do fail, I want to know about it.

> +
> +		/* Write only when there are changes */
> +		if (memcmp(&p, &bcm->dev->pcm_params, sizeof(p)))
> +			err = btbcm_write_pcm_int_params(hu->hdev,
> +							 &bcm->dev->pcm_params);
> +
> +		if (err)
> +			bt_dev_warn(hu->hdev, "BCM: Write pcm params failed (%d)",
> +				    err);
> +	} else
> +		bt_dev_warn(hu->hdev, "BCM: Read pcm params failed (%d)", err);
> +
> finalize:
> 	release_firmware(fw);
> 
> @@ -1128,9 +1158,36 @@ static int bcm_acpi_probe(struct bcm_device *dev)
> }
> #endif /* CONFIG_ACPI */
> 
> +static int property_read_u8(struct device *dev, const char *prop, u8 *value)
> +{
> +	int err;
> +	u32 tmp;
> +
> +	err = device_property_read_u32(dev, prop, &tmp);
> +
> +	if (!err)
> +		*value = (u8)tmp;
> +
> +	return err;
> +}

I think this really needs to be done in the generic property code if this is wanted.

> +
> static int bcm_of_probe(struct bcm_device *bdev)
> {
> 	device_property_read_u32(bdev->dev, "max-speed", &bdev->oper_speed);
> +
> +	memset(&bdev->pcm_params, 0xff, sizeof(bdev->pcm_params));

Scrap this memset. We will read the values first.

> +
> +	property_read_u8(bdev->dev, "brcm,bt-sco-routing",
> +			 &bdev->pcm_params.routing);
> +	property_read_u8(bdev->dev, "brcm,bt-pcm-interface-rate",
> +			 &bdev->pcm_params.rate);
> +	property_read_u8(bdev->dev, "brcm,bt-pcm-frame-type",
> +			 &bdev->pcm_params.frame_sync);
> +	property_read_u8(bdev->dev, "brcm,bt-pcm-sync-mode",
> +			 &bdev->pcm_params.sync_mode);
> +	property_read_u8(bdev->dev, "brcm,bt-pcm-clock-mode",
> +			 &bdev->pcm_params.clock_mode);
> +
> 	return 0;
> }

Regards

Marcel

