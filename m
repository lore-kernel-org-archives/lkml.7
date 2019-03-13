Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EBFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A529020657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505191;
	bh=u5N/AphbN1ctVchI8+bwMFpLRHYOEJegpcLWELqPvok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a9Ufm8MwmLtmZ6GEduUu4oe8LeJ+w6yGuCuEtFjs/Tp+tPbkzHzcN7uY/l/7K9R4I
	 e0ZM1h0UrB9EoH4mRF0LD3ha21nriZpYNfCqFDWnW+Bsy4ayqLzWZ3CXUmq64bI5S8
	 plInCYfe2mGZBxzZ2wyQ/ckI3pBM9MYKGBVihcuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbfCMT0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:26:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728320AbfCMTOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:14:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB1592183F;
        Wed, 13 Mar 2019 19:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504493;
        bh=u5N/AphbN1ctVchI8+bwMFpLRHYOEJegpcLWELqPvok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wC4pgA0z/Fnewc1zo+karmDI430s/CFQQe2/UotZuTlWDYXBvWuGX64Is6s90BVXj
         6ktZuMAD5nt1ZtDeBD45U/+gVXoRHJ4OpyB8zyy28CVFAPty4CmNwxhEco2si3uzaz
         K5CV9T2tAG+V1ZKxMxFR6nNlri2YqZD59NQxJbXM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 44/48] bnxt_en: Fix typo in firmware message timeout logic.
Date:   Wed, 13 Mar 2019 15:12:46 -0400
Message-Id: <20190313191250.158955-44-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191250.158955-1-sashal@kernel.org>
References: <20190313191250.158955-1-sashal@kernel.org>
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
index 1fdaf86bbe8f..63b97289f4fe 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3542,7 +3542,7 @@ static int bnxt_hwrm_do_send_msg(struct bnxt *bp, void *msg, u32 msg_len,
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

