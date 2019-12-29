Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF95C2D0DA
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484B8206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642615;
	bh=nSXKaU5SQpSfrM9QlvZlXIaLKQ6xDYxaul8vUU6sXKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=08E0m2Ubk28JbbKD39T+DJLY9qqGFbdFd88KdkGGzf+pMN7nMmXy612V6YCsSexyp
	 m6bNgv8TKp1+XOp7L0pt/w3j+ksU+1BEgRQfUb/JBx8QlTqcu3KaltkiMfVln72oEt
	 EbZHmLIqrKgny0SeLAjhzJHLxOYz2Rx57DI2ifjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfL2Rx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:53:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:40328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732082AbfL2RxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:53:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E492206A4;
        Sun, 29 Dec 2019 17:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642002;
        bh=nSXKaU5SQpSfrM9QlvZlXIaLKQ6xDYxaul8vUU6sXKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z5rd0wAL4ORUTrew6qlzrVkIzf+t69Rx8GE7PV5a68rDz8fPuEjIaxRGC/tDgblEw
         2PIhcew3UJeLceqEpPFTHJcE5YeUYvZapaLSgXC0heb/WST97vBEgW2uZ/sVaekJOA
         imSFTTsMPtqKbCo5NWtpMD82tQbMElGO+TPoqXHE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 301/434] qtnfmac: fix invalid channel information output
Date:   Sun, 29 Dec 2019 18:25:54 +0100
Message-Id: <20191229172721.946537402@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>

[ Upstream commit 24227a9e956a7c9913a7e6e7199a9ae3f540fe88 ]

Do not attempt to print frequency for an invalid channel
provided by firmware. That channel may simply not exist.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/quantenna/qtnfmac/event.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/event.c b/drivers/net/wireless/quantenna/qtnfmac/event.c
index b57c8c18a8d0..7846383c8828 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/event.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/event.c
@@ -171,8 +171,9 @@ qtnf_event_handle_bss_join(struct qtnf_vif *vif,
 		return -EPROTO;
 	}
 
-	pr_debug("VIF%u.%u: BSSID:%pM status:%u\n",
-		 vif->mac->macid, vif->vifid, join_info->bssid, status);
+	pr_debug("VIF%u.%u: BSSID:%pM chan:%u status:%u\n",
+		 vif->mac->macid, vif->vifid, join_info->bssid,
+		 le16_to_cpu(join_info->chan.chan.center_freq), status);
 
 	if (status != WLAN_STATUS_SUCCESS)
 		goto done;
@@ -181,7 +182,7 @@ qtnf_event_handle_bss_join(struct qtnf_vif *vif,
 	if (!cfg80211_chandef_valid(&chandef)) {
 		pr_warn("MAC%u.%u: bad channel freq=%u cf1=%u cf2=%u bw=%u\n",
 			vif->mac->macid, vif->vifid,
-			chandef.chan->center_freq,
+			chandef.chan ? chandef.chan->center_freq : 0,
 			chandef.center_freq1,
 			chandef.center_freq2,
 			chandef.width);
-- 
2.20.1



