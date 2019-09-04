Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613EBC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286B52087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567621036;
	bh=RO75rEGuI0EXfpa+RFUYzyyXCpPFC+MVgXKPVup4TEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CJfDInwbdqGBqm1f0eOAsodgQP7XH/oFAcTF2L1TFu3xNU0I2SqiQdfgrgs8EuC22
	 TyYPaOH85/SJhk+T0OItAOoy4b6ZOiow1a++4437KsCm6AdITRDVOuYXSruJSvqGhj
	 8JfUOKglVpJK7qCPBuLWJOSWdsf+TRBWPorZ9DWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390840AbfIDSOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390828AbfIDSOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:14:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 882402087E;
        Wed,  4 Sep 2019 18:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620875;
        bh=RO75rEGuI0EXfpa+RFUYzyyXCpPFC+MVgXKPVup4TEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eAMZbza8MG1zMVLOrbG6W9XTqFJLzo9EspgLPHr2yQFWDO+NxCK9R9An4PWT6JGEC
         yiToUBmsDcmT8KnSGQxA0fU6Rzsph4D/SNDZ6ilbFAs6P++Xgq9oV9auOATDSiBg4b
         LGMfV8t912aBrK47ykpeX7hpBRqByJ10HoIy0Sw4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Kenzior <denkenz@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.2 128/143] mac80211: Correctly set noencrypt for PAE frames
Date:   Wed,  4 Sep 2019 19:54:31 +0200
Message-Id: <20190904175319.414317377@linuxfoundation.org>
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

commit f8b43c5cf4b62a19f2210a0f5367b84e1eff1ab9 upstream.

The noencrypt flag was intended to be set if the "frame was received
unencrypted" according to include/uapi/linux/nl80211.h.  However, the
current behavior is opposite of this.

Cc: stable@vger.kernel.org
Fixes: 018f6fbf540d ("mac80211: Send control port frames over nl80211")
Signed-off-by: Denis Kenzior <denkenz@gmail.com>
Link: https://lore.kernel.org/r/20190827224120.14545-3-denkenz@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/rx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2447,7 +2447,7 @@ static void ieee80211_deliver_skb_to_loc
 		      skb->protocol == cpu_to_be16(ETH_P_PREAUTH)) &&
 		     sdata->control_port_over_nl80211)) {
 		struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
-		bool noencrypt = status->flag & RX_FLAG_DECRYPTED;
+		bool noencrypt = !(status->flag & RX_FLAG_DECRYPTED);
 
 		cfg80211_rx_control_port(dev, skb, noencrypt);
 		dev_kfree_skb(skb);


