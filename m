Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B64C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34712087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620877;
	bh=rhf55IcYROlziFP28mrnnFn92oSViVrUFf7Fzn0oJRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zKwrwLJuDkwtRfESV8xi4EpW2FKAh9wz+OdcCLuBdmRUv/eddAZeaseVS8xjNbrVT
	 2W42ETXz6/JLsQDF8K1Z9mwS3lTMgkAjbt+czLxIsbfg1Dzcrr5y+d45naTwwWFxrw
	 +UQ5rliIG8H1ynXPvysqGPujYxtlDwiSrOzs43yI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389911AbfIDSOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:14:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390826AbfIDSOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:14:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4E4B2087E;
        Wed,  4 Sep 2019 18:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620873;
        bh=rhf55IcYROlziFP28mrnnFn92oSViVrUFf7Fzn0oJRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1VPKZE9EfZGyrvsxopcyv7BS438fD3+/alA0w2oy/g9eaClAqM37AewSuTlm08/ns
         v75Tku2bnpiHmwSEvIhYTAq+x7WaUywjGYnaKurEVFtbIYqCxNaWfK3U+ufrhXPiV8
         0RuCIwE5qRkES2zuhTR26pgV9rp/KVZCwtoIHwN4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Kenzior <denkenz@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.2 127/143] mac80211: Dont memset RXCB prior to PAE intercept
Date:   Wed,  4 Sep 2019 19:54:30 +0200
Message-Id: <20190904175319.374648675@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175314.206239922@linuxfoundation.org>
References: <20190904175314.206239922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Kenzior <denkenz@gmail.com>

commit c8a41c6afa27b8c3f61622dfd882b912da9d6721 upstream.

In ieee80211_deliver_skb_to_local_stack intercepts EAPoL frames if
mac80211 is configured to do so and forwards the contents over nl80211.
During this process some additional data is also forwarded, including
whether the frame was received encrypted or not.  Unfortunately just
prior to the call to ieee80211_deliver_skb_to_local_stack, skb->cb is
cleared, resulting in incorrect data being exposed over nl80211.

Fixes: 018f6fbf540d ("mac80211: Send control port frames over nl80211")
Cc: stable@vger.kernel.org
Signed-off-by: Denis Kenzior <denkenz@gmail.com>
Link: https://lore.kernel.org/r/20190827224120.14545-2-denkenz@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/rx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2452,6 +2452,8 @@ static void ieee80211_deliver_skb_to_loc
 		cfg80211_rx_control_port(dev, skb, noencrypt);
 		dev_kfree_skb(skb);
 	} else {
+		memset(skb->cb, 0, sizeof(skb->cb));
+
 		/* deliver to local stack */
 		if (rx->napi)
 			napi_gro_receive(rx->napi, skb);
@@ -2546,8 +2548,6 @@ ieee80211_deliver_skb(struct ieee80211_r
 
 	if (skb) {
 		skb->protocol = eth_type_trans(skb, dev);
-		memset(skb->cb, 0, sizeof(skb->cb));
-
 		ieee80211_deliver_skb_to_local_stack(skb, rx);
 	}
 


