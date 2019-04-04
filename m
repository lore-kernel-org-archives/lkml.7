Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C65BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73E520693
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369628;
	bh=ZD04GrMzLOgxk0HcJpAxOYyJpmUul8jemHmmJrAb8hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o9dLEFEJwbCDPsEENPzeLzzIiDCNAPm+kSzLZ2ye5N53lXe6rE1a1mLHZw09Iv5Lv
	 wmB0eWmz8C3AF8gvnM5oIl5crFtfpAO6oo+D53uz3eR7omNVV/V0QJ7dTZB+7Cy3+w
	 pov0h+2gDLzi+4dZxSSLkOSZT4v1BiPtm2kRq1NA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388209AbfDDJU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:20:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388239AbfDDJRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:17:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D94D2075E;
        Thu,  4 Apr 2019 09:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369454;
        bh=ZD04GrMzLOgxk0HcJpAxOYyJpmUul8jemHmmJrAb8hw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CHUh+a7c0qvLck6dkAoet3/kopMeJ+tEetHs03THjJTX5fs+HMeGuL3WHBqgg4jgh
         yUT7v7Agx+J+PU13NdDhyR6gOqxXAgTSluHxJXYEEQKiixHzgkc8E9av7XylK2/xmd
         pGnrEduC7ScWFCgYznDGQYuXRZpPRDpS63x/OJpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zumeng Chen <zumeng.chen@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 230/246] wlcore: Fix memory leak in case wl12xx_fetch_firmware failure
Date:   Thu,  4 Apr 2019 10:48:50 +0200
Message-Id: <20190404084627.309909066@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ba2ffc96321c8433606ceeb85c9e722b8113e5a7 ]

Release fw_status, raw_fw_status, and tx_res_if when wl12xx_fetch_firmware
failed instead of meaningless goto out to avoid the following memory leak
reports(Only the last one listed):

unreferenced object 0xc28a9a00 (size 512):
  comm "kworker/0:4", pid 31298, jiffies 2783204 (age 203.290s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
  backtrace:
    [<6624adab>] kmemleak_alloc+0x40/0x74
    [<500ddb31>] kmem_cache_alloc_trace+0x1ac/0x270
    [<db4d731d>] wl12xx_chip_wakeup+0xc4/0x1fc [wlcore]
    [<76c5db53>] wl1271_op_add_interface+0x4a4/0x8f4 [wlcore]
    [<cbf30777>] drv_add_interface+0xa4/0x1a0 [mac80211]
    [<65bac325>] ieee80211_reconfig+0x9c0/0x1644 [mac80211]
    [<2817c80e>] ieee80211_restart_work+0x90/0xc8 [mac80211]
    [<7e1d425a>] process_one_work+0x284/0x42c
    [<55f9432e>] worker_thread+0x2fc/0x48c
    [<abb582c6>] kthread+0x148/0x160
    [<63144b13>] ret_from_fork+0x14/0x2c
    [< (null)>] (null)
    [<1f6e7715>] 0xffffffff

Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ti/wlcore/main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 26b187336875..2e12de813a5b 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -1085,8 +1085,11 @@ static int wl12xx_chip_wakeup(struct wl1271 *wl, bool plt)
 		goto out;
 
 	ret = wl12xx_fetch_firmware(wl, plt);
-	if (ret < 0)
-		goto out;
+	if (ret < 0) {
+		kfree(wl->fw_status);
+		kfree(wl->raw_fw_status);
+		kfree(wl->tx_res_if);
+	}
 
 out:
 	return ret;
-- 
2.19.1



