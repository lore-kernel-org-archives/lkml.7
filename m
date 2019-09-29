Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815EFC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 13:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C222082F
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 13:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569765503;
	bh=PkXjBr9+cpxtf25fZEakENcrT1468XWH7Wv7LDd+vmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zOUDz8KZJWhOakvczFdqij5ULOBhQcWg8RrqlU9jAYNsRkFueTt7TU4x+shoosDXP
	 76s5ZVZBzP5YcmLw6Xuzp37yyOss5bFJ2BPRVwC02cKj3K6TXtfcmGAwWhobHAo3Qb
	 +V/YeMMXTPdKZ6rm67HREu6r8JD07S0nrW2cu1kM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbfI2N6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 09:58:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729461AbfI2N6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 09:58:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5034721906;
        Sun, 29 Sep 2019 13:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569765499;
        bh=PkXjBr9+cpxtf25fZEakENcrT1468XWH7Wv7LDd+vmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o/TkdMdPh/4AEZ6Cn4LcnitXFrzE1l5v4MI4cxEb4Xv4mBPCc7zCIrTUgxn8DSwi8
         jgscfck3j1W9BaBVEHbt/XBxcytwh8+bupwujaHFRQLNv5w7j/1uCvChtDthyg2M0O
         a7z3IBYNjWite13hSUDiipx77ms9OGWOcIbqvS6c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 4.19 22/63] iwlwifi: mvm: send BCAST management frames to the right station
Date:   Sun, 29 Sep 2019 15:53:55 +0200
Message-Id: <20190929135036.583424206@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929135031.382429403@linuxfoundation.org>
References: <20190929135031.382429403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

commit 65c3b582ecab7a403efdf08babbf87fdbe27369c upstream.

Probe responses were sent to the multicast station while
they should be routed to the broadcast station.
This has no negative effect since the frame was still
routed to the right queue, but it looked very fishy
to send a frame to a (queue, station) tuple where
'queue' is not mapped to 'station'.

Fixes: 7c305de2b954 ("iwlwifi: mvm: Direct multicast frames to the correct station")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -671,7 +671,7 @@ int iwl_mvm_tx_skb_non_sta(struct iwl_mv
 		if (info.control.vif->type == NL80211_IFTYPE_P2P_DEVICE ||
 		    info.control.vif->type == NL80211_IFTYPE_AP ||
 		    info.control.vif->type == NL80211_IFTYPE_ADHOC) {
-			if (info.control.vif->type == NL80211_IFTYPE_P2P_DEVICE)
+			if (!ieee80211_is_data(hdr->frame_control))
 				sta_id = mvmvif->bcast_sta.sta_id;
 			else
 				sta_id = mvmvif->mcast_sta.sta_id;


