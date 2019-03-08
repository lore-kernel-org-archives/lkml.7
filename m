Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C943AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1CF20652
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfCHUyz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:54:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51571 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfCHUyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 15:54:54 -0500
Received: from c-67-160-6-8.hsd1.wa.comcast.net ([67.160.6.8] helo=famine.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <jay.vosburgh@canonical.com>)
        id 1h2MW0-0007DK-H0; Fri, 08 Mar 2019 20:54:48 +0000
Received: by famine.localdomain (Postfix, from userid 1000)
        id 7F7AD60868; Fri,  8 Mar 2019 12:54:46 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id 7769E9F839;
        Fri,  8 Mar 2019 12:54:46 -0800 (PST)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     Bo YU <tsu.yubo@gmail.com>
cc:     vfalico@gmail.com, andy@greyhouse.net, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuzibode@126.com
Subject: Re: [PATCH 1/2] net: bonding: fix restricted __be16 degrades to integer
In-reply-to: <2a069375f8393bf05a44669e00281714063a8530.1552023000.git.tsu.yubo@gmail.com>
References: <cover.1552023000.git.tsu.yubo@gmail.com> <2a069375f8393bf05a44669e00281714063a8530.1552023000.git.tsu.yubo@gmail.com>
Comments: In-reply-to Bo YU <tsu.yubo@gmail.com>
   message dated "Fri, 08 Mar 2019 00:33:50 -0500."
X-Mailer: MH-E 8.6+git; nmh 1.6; GNU Emacs 27.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24215.1552078486.1@famine>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 08 Mar 2019 12:54:46 -0800
Message-ID: <24216.1552078486@famine>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bo YU <tsu.yubo@gmail.com> wrote:

>There are some warning when:
>
>sudo make C=1 CF=-D__CHECK_ENDIAN__ drivers/net/bonding/
>
>drivers/net/bonding/bond_main.c:2385:26: warning: restricted __be16 degrades to integer
>drivers/net/bonding/bond_main.c:2391:20: warning: restricted __be16 degrades to integer
>...
>drivers/net/bonding/bond_main.c:3241:60: warning: restricted __be16 degrades to integer
>drivers/net/bonding/bond_main.c:3241:60: warning: restricted __be16 degrades to integer
>
>So fix it.
>
>Signed-off-by: Bo YU <tsu.yubo@gmail.com>
>---
> drivers/net/bonding/bond_main.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>index b59708c35faf..135fec28daa9 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -2382,13 +2382,13 @@ static void bond_arp_send(struct net_device *slave_dev, int arp_op,
> 		return;
> 	}
> 
>-	if (!tags || tags->vlan_proto == VLAN_N_VID)
>+	if (!tags || be16_to_cpu(tags->vlan_proto) == VLAN_N_VID)
> 		goto xmit;
> 
> 	tags++;
> 
> 	/* Go through all the tags backwards and add them to the packet */
>-	while (tags->vlan_proto != VLAN_N_VID) {
>+	while (be16_to_cpu(tags->vlan_proto) != VLAN_N_VID) {

	I believe both of the above are incorrect, as vlan_proto is set
explicitly to VLAN_N_VID (in host byte order) by bond_verify_device_path
as a sentinel value.  Byte swapping the tags->vlan_proto value would
cause the test or loop to miss the sentinel.


> 		if (!tags->vlan_id) {
> 			tags++;
> 			continue;
>@@ -3238,7 +3238,7 @@ static inline u32 bond_eth_hash(struct sk_buff *skb)
> 
> 	ep = skb_header_pointer(skb, 0, sizeof(hdr_tmp), &hdr_tmp);
> 	if (ep)
>-		return ep->h_dest[5] ^ ep->h_source[5] ^ ep->h_proto;
>+		return ep->h_dest[5] ^ ep->h_source[5] ^ be16_to_cpu(ep->h_proto);

	This is probably harmless, other than adding work to the
transmit path.

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com
