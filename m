Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E19C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D0E20863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfCRQzj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:55:39 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42603 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfCRQzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:55:39 -0400
Received: from marcel-macpro.fritz.box (p4FEFC449.dip0.t-ipconnect.de [79.239.196.73])
        by mail.holtmann.org (Postfix) with ESMTPSA id D9450CF172;
        Mon, 18 Mar 2019 18:03:37 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] Bluetooth: mediatek: fix uninitialized symbol errors in
 btmtksdio_rx_packet
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <8fb8e6840a39127112597963d665fbe6c21d8b91.1552509647.git.sean.wang@mediatek.com>
Date:   Mon, 18 Mar 2019 17:55:37 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <93CB6259-6FB8-4D3D-9FF3-8EB59499A6A1@holtmann.org>
References: <8fb8e6840a39127112597963d665fbe6c21d8b91.1552509647.git.sean.wang@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> Fixed all the below warnings. They would probably cause the following
> error handling path would use the uninitialized value and then produce
> unexpected behavior.
> 
> drivers/bluetooth/btmtksdio.c:470:2: warning: ‘old_len’ may be used
> uninitialized in this function [-Wmaybe-uninitialized]
>  print_hex_dump(KERN_ERR, "err sdio rx: ", DUMP_PREFIX_NONE, 4, 1,
>  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          old_data, old_len, true);
>          ~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/bluetooth/btmtksdio.c:376:15: note: ‘old_len’ was declared here
>  unsigned int old_len;
>               ^~~~~~~
> drivers/bluetooth/btmtksdio.c:470:2: warning: ‘old_data’ may be used
> uninitialized in this function [-Wmaybe-uninitialized]
>  print_hex_dump(KERN_ERR, "err sdio rx: ", DUMP_PREFIX_NONE, 4, 1,
>  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          old_data, old_len, true);
>          ~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/bluetooth/btmtksdio.c:375:17: note: ‘old_data’ was declared here
>  unsigned char *old_data;
>                 ^~~~~~~~
> 
> Fixes: d74eef2834b5 ("Bluetooth: mediatek: add support for MediaTek MT7663S and MT7668S SDIO devices")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reported-by: Marcel Holtmann <marcel@holtmann.org>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> drivers/bluetooth/btmtksdio.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
> index b4b8320f279e..23cf63888bac 100644
> --- a/drivers/bluetooth/btmtksdio.c
> +++ b/drivers/bluetooth/btmtksdio.c
> @@ -372,8 +372,8 @@ static int btmtksdio_rx_packet(struct btmtksdio_dev *bdev, u16 rx_size)
> 	const struct h4_recv_pkt *pkts = mtk_recv_pkts;
> 	int pkts_count = ARRAY_SIZE(mtk_recv_pkts);
> 	struct mtkbtsdio_hdr *sdio_hdr;
> -	unsigned char *old_data;
> -	unsigned int old_len;
> +	unsigned char *old_data = NULL;
> +	unsigned int old_len = 0;
> 	int err, i, pad_size;
> 	struct sk_buff *skb;
> 	u16 dlen;

or instead just remove this whole old_len + old_data stuff anyway since it is rather pointless. Or at least introduce a proper error path for sdio_readsb since you know when it fails, there is no point in writing the SKB.

Regards

Marcel

