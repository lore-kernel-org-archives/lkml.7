Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21B0C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5C3216E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600795;
	bh=bPbReT1Q2wWR3wdpKMn+8Jo3hIt0ICft7mkQIAevbeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=foAX9V1v5hR16ARloHuWUyaJ81vBDRugP8eDrtBlXRzYwZO/trGscr5u+gD7WVEY2
	 GW6bjE+geREpHlZXwmQH9n/MHpmIgbjzTHd3hb9LCpC1rNei2JdITrc/BYp8NCu6jA
	 4zQfvXKdPGnmPxDa0GNO1rIlL9URJofLA2mWOQUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387674AbfGHPU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:20:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387421AbfGHPTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:19:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E836E21707;
        Mon,  8 Jul 2019 15:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599189;
        bh=bPbReT1Q2wWR3wdpKMn+8Jo3hIt0ICft7mkQIAevbeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mCCE4keTrNyRCJU5OSjh8YR3lj7KtJQLm0H4N/8VXtvAQ6trCwa/TyebCixobXa57
         C9sRTBEjZX4Ph0CEjeck/TSx5PqehMR0YXlP/Hndtlii2asSnIuVwrl7Q3NZwfxRMc
         Pa6vX51GFtc/ESGQ72V+HFT+v8iRK/nQ9F0wJoLM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.9 034/102] mac80211: drop robust management frames from unknown TA
Date:   Mon,  8 Jul 2019 17:12:27 +0200
Message-Id: <20190708150528.144266776@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150525.973820964@linuxfoundation.org>
References: <20190708150525.973820964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

commit 588f7d39b3592a36fb7702ae3b8bdd9be4621e2f upstream.

When receiving a robust management frame, drop it if we don't have
rx->sta since then we don't have a security association and thus
couldn't possibly validate the frame.

Cc: stable@vger.kernel.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/rx.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3568,6 +3568,8 @@ static bool ieee80211_accept_frame(struc
 	case NL80211_IFTYPE_STATION:
 		if (!bssid && !sdata->u.mgd.use_4addr)
 			return false;
+		if (ieee80211_is_robust_mgmt_frame(skb) && !rx->sta)
+			return false;
 		if (multicast)
 			return true;
 		return ether_addr_equal(sdata->vif.addr, hdr->addr1);


