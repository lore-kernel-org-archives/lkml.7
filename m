Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18C7C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C7021670
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfH3Mr5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 08:47:57 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48067 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfH3Mr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 08:47:57 -0400
Received: from marcel-macbook.fritz.box (p4FEFC580.dip0.t-ipconnect.de [79.239.197.128])
        by mail.holtmann.org (Postfix) with ESMTPSA id B7BB8CECDE;
        Fri, 30 Aug 2019 14:56:41 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 2/2] Bluetooth: btrtl: Add firmware version print
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190830120530.GA3299@laptop-alex>
Date:   Fri, 30 Aug 2019 14:47:54 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Chou <max.chou@realtek.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <5F48FCE3-E0AF-458D-8560-DF0B1DB10CC9@holtmann.org>
References: <20190830120530.GA3299@laptop-alex>
To:     Alex Lu <alex_lu@realsil.com.cn>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

> This patch is used to print fw version for debug convenience
> 
> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> ---
> drivers/bluetooth/btrtl.c | 16 ++++++++++++++++
> 1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index b7487ab99eed..7219eb98d02d 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -151,6 +151,8 @@ static const struct id_table ic_id_table[] = {
> 	  .cfg_name = "rtl_bt/rtl8822b_config" },
> 	};
> 
> +static struct sk_buff *btrtl_read_local_version(struct hci_dev *hdev);
> +
> static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev,
> 					     u8 hci_ver, u8 hci_bus)
> {
> @@ -368,6 +370,8 @@ static int rtl_download_firmware(struct hci_dev *hdev,
> 	int frag_len = RTL_FRAG_LEN;
> 	int ret = 0;
> 	int i;
> +	struct sk_buff *skb;
> +	struct hci_rp_read_local_version *rp;
> 
> 	dl_cmd = kmalloc(sizeof(struct rtl_download_cmd), GFP_KERNEL);
> 	if (!dl_cmd)
> @@ -406,6 +410,18 @@ static int rtl_download_firmware(struct hci_dev *hdev,
> 		data += RTL_FRAG_LEN;
> 	}
> 
> +	skb = btrtl_read_local_version(hdev);
> +	if (IS_ERR(skb)) {
> +		ret = PTR_ERR(skb);
> +		rtl_dev_err(hdev, "read local version failed");
> +		goto out;
> +	}
> +
> +	rp = (struct hci_rp_read_local_version *)skb->data;
> +	rtl_dev_info(hdev, "rtl: fw version 0x%04x%04x",
> +		     __le16_to_cpu(rp->hci_rev), __le16_to_cpu(rp->lmp_subver));
> +	kfree_skb(skb);
> +

if you really want to do this, then please re-order the code so that no forward declaration is needed.

Regards

Marcel

