Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A629CC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C34F20679
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564738855;
	bh=PNDWx3XNzQ1K62lbT5otTzo/qHp1YKmQ0pKCdaSERUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qTaFtyRz5UwyHe2dX8dnVvyKFpUKf75OPgAEkkh7yIfChP2KoUnK9GiE88Ncl6/Z9
	 R+VbRPFCqx1+D2ojYTGLgAdAyYw5GDEELnahE7TaGjba3wFvLGtA+UXDQJIAO2lMq9
	 kAF/qdJ8vWnlmczopuET9s63fHyVSCCdqW1LUBps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404439AbfHBJkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404417AbfHBJkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:40:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49A9E20679;
        Fri,  2 Aug 2019 09:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564738848;
        bh=PNDWx3XNzQ1K62lbT5otTzo/qHp1YKmQ0pKCdaSERUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nPtOQgh8xk9xE3Aup8uYCsc2ja1gxo2lWOu0ev1XplVroqHiMSWnrhl3l79ZfSM7D
         gidWCau4SWS19Srq7kNDGUOX7BNO9yxpM89wBZPCtAQW8H7E65gEcwqPLwO2gPhGtH
         VCMW3zi3CC5m2m914PRGYGiFkKAN9GYm4LToFuNw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+d454a826e670502484b8@syzkaller.appspotmail.com,
        Jeremy Sowden <jeremy@azazel.net>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 009/223] batman-adv: fix for leaked TVLV handler.
Date:   Fri,  2 Aug 2019 11:33:54 +0200
Message-Id: <20190802092239.449388086@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092238.692035242@linuxfoundation.org>
References: <20190802092238.692035242@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 17f78dd1bd624a4dd78ed5db3284a63ee807fcc3 ]

A handler for BATADV_TVLV_ROAM was being registered when the
translation-table was initialized, but not unregistered when the
translation-table was freed.  Unregister it.

Fixes: 122edaa05940 ("batman-adv: tvlv - convert roaming adv packet to use tvlv unicast packets")
Reported-by: syzbot+d454a826e670502484b8@syzkaller.appspotmail.com
Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/translation-table.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index af4a02ad8503..1fab9bcf535d 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3700,6 +3700,8 @@ static void batadv_tt_purge(struct work_struct *work)
 
 void batadv_tt_free(struct batadv_priv *bat_priv)
 {
+	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_ROAM, 1);
+
 	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_TT, 1);
 	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_TT, 1);
 
-- 
2.20.1



