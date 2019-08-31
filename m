Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60174C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 05:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FC723774
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 05:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfHaFbt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 01:31:49 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:40167 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfHaFbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 01:31:48 -0400
Received: from marcel-macpro.fritz.box (p4FEFC580.dip0.t-ipconnect.de [79.239.197.128])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1A96ACECEA;
        Sat, 31 Aug 2019 07:40:33 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 2/2] Bluetooth: btrtl: Add firmware version print
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190830221356.GA9697@laptop-alex>
Date:   Sat, 31 Aug 2019 07:31:46 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Chou <max.chou@realtek.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <F9C706F1-F1A2-4F6B-854B-020AC5D8C7F0@holtmann.org>
References: <20190830221356.GA9697@laptop-alex>
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
> Changes in v2
>  - Re-order the code so that no forward declaration is needed
> 
> drivers/bluetooth/btrtl.c | 56 ++++++++++++++++++++++++---------------
> 1 file changed, 35 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index b7487ab99eed..e32ef7c60a22 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -178,6 +178,27 @@ static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev,
> 	return &ic_id_table[i];
> }
> 
> +static struct sk_buff *btrtl_read_local_version(struct hci_dev *hdev)
> +{
> +	struct sk_buff *skb;
> +
> +	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
> +			     HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		rtl_dev_err(hdev, "HCI_OP_READ_LOCAL_VERSION failed (%ld)\n",
> +			    PTR_ERR(skb));
> +		return skb;
> +	}
> +
> +	if (skb->len != sizeof(struct hci_rp_read_local_version)) {
> +		rtl_dev_err(hdev, "HCI_OP_READ_LOCAL_VERSION event length mismatch\n");
> +		kfree_skb(skb);
> +		return ERR_PTR(-EIO);
> +	}
> +
> +	return skb;
> +}
> +
> static int rtl_read_rom_version(struct hci_dev *hdev, u8 *version)
> {
> 	struct rtl_rom_version_evt *rom_version;
> @@ -368,6 +389,8 @@ static int rtl_download_firmware(struct hci_dev *hdev,
> 	int frag_len = RTL_FRAG_LEN;
> 	int ret = 0;
> 	int i;
> +	struct sk_buff *skb;
> +	struct hci_rp_read_local_version *rp;
> 
> 	dl_cmd = kmalloc(sizeof(struct rtl_download_cmd), GFP_KERNEL);
> 	if (!dl_cmd)
> @@ -406,6 +429,18 @@ static int rtl_download_firmware(struct hci_dev *hdev,
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

the rtl: prefix in the string is pointless. The rtl_dev_info already does that. So please remove that. And then send a patch that removes all the others from the rtl_dev_info users as well.

Regards

Marcel

