Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159BDC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A012073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfKOHy3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 02:54:29 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:49349 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfKOHy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 02:54:28 -0500
Received: from marcel-macbook.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3E25CCED16;
        Fri, 15 Nov 2019 09:03:33 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH v5 2/4] Bluetooth: btbcm: Support pcm configuration
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191114180959.v5.2.I2a9640407d375f20c7c8f4afd1607db143ff0246@changeid>
Date:   Fri, 15 Nov 2019 08:54:27 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        dianders@chromium.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <32623E12-EAE0-44AD-A6C9-B5183EA2C0B0@holtmann.org>
References: <20191115021008.32926-1-abhishekpandit@chromium.org>
 <20191114180959.v5.2.I2a9640407d375f20c7c8f4afd1607db143ff0246@changeid>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

> Add BCM vendor specific command to configure PCM parameters. The new
> vendor opcode allows us to set the sco routing, the pcm interface rate,
> and a few other pcm specific options (frame sync, sync mode, and clock
> mode). See broadcom-bluetooth.txt in Documentation for more information
> about valid values for those settings.
> 
> Here is an example trace where this opcode was used to configure
> a BCM4354:
> 
>        < HCI Command: Vendor (0x3f|0x001c) plen 5
>                01 02 00 01 01
>> HCI Event: Command Complete (0x0e) plen 4
>        Vendor (0x3f|0x001c) ncmd 1
>                Status: Success (0x00)
> 
> We can read back the values as well with ocf 0x001d to confirm the
> values that were set:
>        $ hcitool cmd 0x3f 0x001d
>        < HCI Command: ogf 0x3f, ocf 0x001d, plen 0
>> HCI Event: 0x0e plen 9
>        01 1D FC 00 01 02 00 01 01
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
> drivers/bluetooth/btbcm.c | 19 +++++++++++++++++++
> drivers/bluetooth/btbcm.h |  8 ++++++++
> 2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index 2d2e6d862068..53fd66a96e69 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -105,6 +105,25 @@ int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
> }
> EXPORT_SYMBOL_GPL(btbcm_set_bdaddr);
> 
> +int btbcm_set_pcm_int_params(struct hci_dev *hdev,
> +			     const struct bcm_set_pcm_int_params *int_params)
> +{
> +	struct sk_buff *skb;
> +	int err;
> +
> +	/* Vendor ocf 0x001c sets the pcm parameters and 0x001d reads it */

drop this comment.

> +	skb = __hci_cmd_sync(hdev, 0xfc1c, 5, int_params, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		err = PTR_ERR(skb);
> +		bt_dev_err(hdev, "BCM: Set PCM int params failed (%d)", err);
> +		return err;
> +	}
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(btbcm_set_pcm_int_params);
> +

Lets introduce two function here. btbcm_write_pcm_int_param and btbcm_read_pcm_int_param.

Regards

Marcel

