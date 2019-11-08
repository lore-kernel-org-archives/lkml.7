Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3BFC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 06:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B72214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 06:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbfKHGL0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 01:11:26 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:60241 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfKHGL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 01:11:26 -0500
Received: from marcel-macpro.fritz.box (p5B3D2BA4.dip0.t-ipconnect.de [91.61.43.164])
        by mail.holtmann.org (Postfix) with ESMTPSA id BDC44CED12;
        Fri,  8 Nov 2019 07:20:28 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH v2 2/4] Bluetooth: btbcm: Support pcm configuration
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191107232713.48577-3-abhishekpandit@chromium.org>
Date:   Fri, 8 Nov 2019 07:11:24 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-bluetooth@vger.kernel.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <95E7AD4E-E434-4249-9861-199375534CB1@holtmann.org>
References: <20191107232713.48577-1-abhishekpandit@chromium.org>
 <20191107232713.48577-3-abhishekpandit@chromium.org>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

> Add BCM vendor specific commands to configure PCM.

please be a bit more descriptive and you can also add the command decoding from btmon here if you like.

> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
> Changes in v2: None
> 
> drivers/bluetooth/btbcm.c | 35 +++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btbcm.h | 10 ++++++++++
> 2 files changed, 45 insertions(+)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index 2d2e6d862068..f052518f7b0c 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -105,6 +105,41 @@ int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
> }
> EXPORT_SYMBOL_GPL(btbcm_set_bdaddr);
> 
> +int btbcm_set_pcm_params(struct hci_dev *hdev,
> +			 const struct bcm_set_pcm_int_params *int_params,
> +			 const struct bcm_set_pcm_format_params *format_params)
> +{
> +	struct sk_buff *skb;
> +	int err;
> +
> +	if (int_params) {
> +		skb = __hci_cmd_sync(hdev, 0xfc1c, 5, int_params,
> +				     HCI_INIT_TIMEOUT);
> +		if (IS_ERR(skb)) {
> +			err = PTR_ERR(skb);
> +			bt_dev_err(hdev, "BCM: Set PCM int params failed (%d)",
> +				   err);
> +			return err;
> +		}
> +		kfree_skb(skb);
> +	}

Actually lets do btbcm_set_pcm_int_params and focus on the ones you are using right now.

Regards

Marcel

