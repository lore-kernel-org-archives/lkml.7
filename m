Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53914C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2336D2186A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfCRSCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:02:44 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:9362 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727113AbfCRSCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:02:40 -0400
X-UUID: fb778ddcda1c47c6892f8acbfe23e1f8-20190319
X-UUID: fb778ddcda1c47c6892f8acbfe23e1f8-20190319
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1653476042; Tue, 19 Mar 2019 02:02:33 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Mar 2019 02:02:31 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 19 Mar 2019 02:02:31 +0800
Message-ID: <1552932151.24944.12.camel@mtkswgap22>
Subject: Re: [PATCH] Bluetooth: mediatek: fix uninitialized symbol errors in
 btmtksdio_rx_packet
From:   Sean Wang <sean.wang@mediatek.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Tue, 19 Mar 2019 02:02:31 +0800
In-Reply-To: <93CB6259-6FB8-4D3D-9FF3-8EB59499A6A1@holtmann.org>
References: <8fb8e6840a39127112597963d665fbe6c21d8b91.1552509647.git.sean.wang@mediatek.com>
         <93CB6259-6FB8-4D3D-9FF3-8EB59499A6A1@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 4B749FC33B091D298E4652708FFE71F44A75E42ED23B674999364EEAF587ABDF2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-18 at 17:55 +0100, Marcel Holtmann wrote:
> Hi Sean,
> 
> > Fixed all the below warnings. They would probably cause the following
> > error handling path would use the uninitialized value and then produce
> > unexpected behavior.
> > 
> > drivers/bluetooth/btmtksdio.c:470:2: warning: ‘old_len’ may be used
> > uninitialized in this function [-Wmaybe-uninitialized]
> >  print_hex_dump(KERN_ERR, "err sdio rx: ", DUMP_PREFIX_NONE, 4, 1,
> >  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >          old_data, old_len, true);
> >          ~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/bluetooth/btmtksdio.c:376:15: note: ‘old_len’ was declared here
> >  unsigned int old_len;
> >               ^~~~~~~
> > drivers/bluetooth/btmtksdio.c:470:2: warning: ‘old_data’ may be used
> > uninitialized in this function [-Wmaybe-uninitialized]
> >  print_hex_dump(KERN_ERR, "err sdio rx: ", DUMP_PREFIX_NONE, 4, 1,
> >  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >          old_data, old_len, true);
> >          ~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/bluetooth/btmtksdio.c:375:17: note: ‘old_data’ was declared here
> >  unsigned char *old_data;
> >                 ^~~~~~~~
> > 
> > Fixes: d74eef2834b5 ("Bluetooth: mediatek: add support for MediaTek MT7663S and MT7668S SDIO devices")
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Reported-by: Marcel Holtmann <marcel@holtmann.org>
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> > drivers/bluetooth/btmtksdio.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
> > index b4b8320f279e..23cf63888bac 100644
> > --- a/drivers/bluetooth/btmtksdio.c
> > +++ b/drivers/bluetooth/btmtksdio.c
> > @@ -372,8 +372,8 @@ static int btmtksdio_rx_packet(struct btmtksdio_dev *bdev, u16 rx_size)
> > 	const struct h4_recv_pkt *pkts = mtk_recv_pkts;
> > 	int pkts_count = ARRAY_SIZE(mtk_recv_pkts);
> > 	struct mtkbtsdio_hdr *sdio_hdr;
> > -	unsigned char *old_data;
> > -	unsigned int old_len;
> > +	unsigned char *old_data = NULL;
> > +	unsigned int old_len = 0;
> > 	int err, i, pad_size;
> > 	struct sk_buff *skb;
> > 	u16 dlen;
> 
> or instead just remove this whole old_len + old_data stuff anyway since it is rather pointless. Or at least introduce a proper error path for sdio_readsb since you know when it fails, there is no point in writing the SKB.
> 
> Regards
> 

I will remove the old_len and old_data in the next version for the issue
because the error path for sdio_readsb seems wrong.

My initial purpose is that I would like to add a error path for these
packets which are successful at sdio_readsb but fail at packet format
parsing. I will update the error path for packet format error in
a separate patch.

> Marcel
> 


