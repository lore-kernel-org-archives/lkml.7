Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F4CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD1920657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505390;
	bh=sTTE+BVeq+nnyGrb3DQa9hLV8gpn8zpZLTTA4f9U0Lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oeo9icUEof+UMu+DJKy0mp+tBFXsOHni9BpRzB1T/1p0X+yqUyh88IqIQQb4Yh8AO
	 bMx39HSS1FZs+LkRA5yY4SEGRXjCAuXvPiUIzHvHg3c7VmPsnuiFXXwijcwsPfzJEr
	 tjmPw59ig7scajm+3nT27Rfbtq1zK7mxpWGuruws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfCMT3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:29:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727249AbfCMTMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:12:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EF522075C;
        Wed, 13 Mar 2019 19:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504359;
        bh=sTTE+BVeq+nnyGrb3DQa9hLV8gpn8zpZLTTA4f9U0Lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WJRAjFsc7q7MSR44r8KWDJlQ2HrJZsp8WaXw7Hv9kZnF7+es7Y+8+9IexHciI9f6w
         p8aEIlv4A6KgTK7BuAF18ct+FO3bl1veiH0YjPETOk24RGcIjDQD/t/UuuYpoW5u9P
         kksg88Lz56ZkhgVHfVGBf9tHSRZuJ6ZAozu38tB0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 56/60] bnxt_en: Fix typo in firmware message timeout logic.
Date:   Wed, 13 Mar 2019 15:10:17 -0400
Message-Id: <20190313191021.158171-56-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 67681d02aaa1db9044a16df4ca9c77cde1221a3e ]

The logic that polls for the firmware message response uses a shorter
sleep interval for the first few passes.  But there was a typo so it
was using the wrong counter (larger counter) for these short sleep
passes.  The result is a slightly shorter timeout period for these
firmware messages than intended.  Fix it by using the proper counter.

Fixes: 9751e8e71487 ("bnxt_en: reduce timeout on initial HWRM calls")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 29b068b81e2a..938ea8ada0da 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3844,7 +3844,7 @@ static int bnxt_hwrm_do_send_msg(struct bnxt *bp, void *msg, u32 msg_len,
 			if (len)
 				break;
 			/* on first few passes, just barely sleep */
-			if (i < DFLT_HWRM_CMD_TIMEOUT)
+			if (i < HWRM_SHORT_TIMEOUT_COUNTER)
 				usleep_range(HWRM_SHORT_MIN_TIMEOUT,
 					     HWRM_SHORT_MAX_TIMEOUT);
 			else
-- 
2.19.1

