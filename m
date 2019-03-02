Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8ADC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 16:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6330520838
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 16:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfCBQqw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 11:46:52 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:53489 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfCBQqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 11:46:51 -0500
Received: from marcel-macpro.fritz.box (p4FF9F361.dip0.t-ipconnect.de [79.249.243.97])
        by mail.holtmann.org (Postfix) with ESMTPSA id 48389CF352;
        Sat,  2 Mar 2019 17:54:46 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] net/bluetooth: Fix bound check in event handling
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190228195939.30685-1-tomasbortoli@gmail.com>
Date:   Sat, 2 Mar 2019 17:46:49 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
Content-Transfer-Encoding: 8BIT
Message-Id: <8F6AC5BF-F50B-4C30-A73B-98526AF181EB@holtmann.org>
References: <20190228195939.30685-1-tomasbortoli@gmail.com>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomas,

> hci_inquiry_result_with_rssi_evt() can perform out of bound reads
> on skb->data as a bound check is missing.
> 
> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> Reported-by: syzbot+cec7a50c412a2c03f8f5@syzkaller.appspotmail.com
> Reported-by: syzbot+660883c56e2fa65d4497@syzkaller.appspotmail.com
> ---
> Syzkaler reports:
> https://syzkaller.appspot.com/bug?id=d708485af9edc3af35f3b4d554e827c6c8bf6b0f
> https://syzkaller.appspot.com/bug?id=3acd1155d48a5acc5d76711568b04926945a6885
> 
> net/bluetooth/hci_event.c | 4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index ac2826ce162b..aa953d23bb72 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3983,6 +3983,10 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
> 		for (; num_rsp; num_rsp--, info++) {
> 			u32 flags;
> 
> +			if ((void *)(info + sizeof(info)) >
> +			   (void *)(skb->data + skb->len))
> +				break;
> +

first of all, the loop exists twice here. If one is vulnerable, then the second is a well. And second, can we not just do this inside the for-condition check or a lot simpler than this void casting fun.

Regards

Marcel

