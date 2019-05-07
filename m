Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA1CC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE11920989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557207193;
	bh=ReXJ0NNW2i0g/7KpHfVhmvHLLii7VyQOjxovKlHUoO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i/Sv1pSkWAUDndq7Mxm2lLrXABxl5G/ZmayyzHmT4h0oNwYlU/ahfhX27x3CzrKB5
	 FgMlTNOj2fPIgUD9bT1FxNbH8OE66FKN7QSpfyZtlAKHOjGOhT3USRbkqip6uvDZcE
	 Kh16x6GLiE443/jpN+s/ZkFwOTcI4MiBH0FPlpeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfEGFdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:33:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbfEGFdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:33:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30A4620C01;
        Tue,  7 May 2019 05:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207183;
        bh=ReXJ0NNW2i0g/7KpHfVhmvHLLii7VyQOjxovKlHUoO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DU127+6EB9SESNtcSOwdMJmA286FFgAiUTOQvGdzoFZLYe36+nmWuLbvglNVJaNDF
         7ZTi2f/4L3IDlBw0LHH52sRH8iOr8FGmJnTO+v4M10p4RUah1Nd8ogTopY9N+/3Krg
         Z2J/Lk5/FcnJCuqlIZnGtaMIYRA/WUZvRka7OIeE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 19/99] tools/testing/nvdimm: Retain security state after overwrite
Date:   Tue,  7 May 2019 01:31:13 -0400
Message-Id: <20190507053235.29900-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053235.29900-1-sashal@kernel.org>
References: <20190507053235.29900-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

[ Upstream commit 2170a0d53bee1a6c1a4ebd042f99d85aafc6c0ea ]

Overwrite retains the security state after completion of operation.  Fix
nfit_test to reflect this so that the kernel can test the behavior it is
more likely to see in practice.

Fixes: 926f74802cb1 ("tools/testing/nvdimm: Add overwrite support for nfit_test")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/nvdimm/test/nfit.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index cad719876ef4..85ffdcfa596b 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -146,6 +146,7 @@ static int dimm_fail_cmd_code[ARRAY_SIZE(handle)];
 struct nfit_test_sec {
 	u8 state;
 	u8 ext_state;
+	u8 old_state;
 	u8 passphrase[32];
 	u8 master_passphrase[32];
 	u64 overwrite_end_time;
@@ -1100,7 +1101,7 @@ static int nd_intel_test_cmd_overwrite(struct nfit_test *t,
 		return 0;
 	}
 
-	memset(sec->passphrase, 0, ND_INTEL_PASSPHRASE_SIZE);
+	sec->old_state = sec->state;
 	sec->state = ND_INTEL_SEC_STATE_OVERWRITE;
 	dev_dbg(dev, "overwrite progressing.\n");
 	sec->overwrite_end_time = get_jiffies_64() + 5 * HZ;
@@ -1122,7 +1123,8 @@ static int nd_intel_test_cmd_query_overwrite(struct nfit_test *t,
 
 	if (time_is_before_jiffies64(sec->overwrite_end_time)) {
 		sec->overwrite_end_time = 0;
-		sec->state = 0;
+		sec->state = sec->old_state;
+		sec->old_state = 0;
 		sec->ext_state = ND_INTEL_SEC_ESTATE_ENABLED;
 		dev_dbg(dev, "overwrite is complete\n");
 	} else
-- 
2.20.1

