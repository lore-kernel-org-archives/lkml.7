Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A92CC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E85821835
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=phytec.de header.i=@phytec.de header.b="aSfRXbx1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfLPRVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:21:39 -0500
Received: from mickerik.phytec.de ([195.145.39.210]:60736 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfLPRVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1576515982; x=1579107982;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wgGOn0shs177g7kPo1CpR8L7E8Z8ys8t8NgHwI7xOoY=;
        b=aSfRXbx1NPySNFC/FR5FWMfvZCTigdICW6KeihmRyA+EptIj3cDcX2YXmf4DPGm1
        TsXu2hqU1Xku2uUx3BJctjd8I8qo+ftw8MH6K1zLQ3weeU7Bq/2kHl1GD7EHWHLr
        B91J9SdJFlx2mFLAIhzJmKKzq28LA2iHTDjl/K4kpI4=;
X-AuditID: c39127d2-df9ff7000000408f-0c-5df7b98d928d
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 9E.1C.16527.D89B7FD5; Mon, 16 Dec 2019 18:06:21 +0100 (CET)
Received: from augenblix2.phytec.de ([172.16.0.56])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2019121618062158-25361 ;
          Mon, 16 Dec 2019 18:06:21 +0100 
From:   Robert Karszniewicz <r.karszniewicz@phytec.de>
To:     linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/1] regulator: of: Hide wrong warning regarding suspend state configuration
Date:   Mon, 16 Dec 2019 18:06:21 +0100
Message-Id: <1576515981-77867-2-git-send-email-r.karszniewicz@phytec.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576515981-77867-1-git-send-email-r.karszniewicz@phytec.de>
References: <1576515981-77867-1-git-send-email-r.karszniewicz@phytec.de>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 16.12.2019 18:06:21,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 16.12.2019 18:06:21,
        Serialize complete at 16.12.2019 18:06:21
X-TNEFEvaluated: 1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAJMWRmVeSWpSXmKPExsWyRoCBS7d35/dYg1mPbSymPnzCZvHtSgeT
        xeVdc9gcmD12zrrL7rFpVSebx+dNcgHMUVw2Kak5mWWpRfp2CVwZPdfXMxa85KhoXcbWwLiZ
        vYuRk0NCwETi8/YvQDYXh5DAVkaJy9euMUM45xglOrs3soBUsQFV7W6+xQxiiwgoSGzufcYK
        YjMLeEh0POkDs4UFYiSat/4Bs1kEVCU2fHvKBGLzAtVcfXkIapucxM1znWBzOAU8Jd5uXAA2
        Xwiopvn+RyaImkYmicaZEhC2kMTpxWeZJzDyLWBkWMUolJuZnJ1alJmtV5BRWZKarJeSuokR
        GCqHJ6pf2sHYN8fjECMTB+MhRgkOZiUR3h0K32OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ827g
        LQkTEkhPLEnNTk0tSC2CyTJxcEo1MO6b0sTZfnwW00+fA58C0uVnV+nVSIZM4ax39vjT0+fs
        f3ud2WzxNln5OM6Db+7YW++U7lQVS/u57uTmiB2f5/j4LInXeZdxOHR+nPrC+CMhB05Ny/c+
        rcSxU23JaeXey/LT733fflD8Y4V4iqr+1N5169KUZncd+JH+5OrE1fHFz5+WWD45s1WJpTgj
        0VCLuag4EQBYzJDOAwIAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A "No configuration" warning is falsely emitted in the case when the
of-property regulator-always-on is set but regulator-(on|off)-in-suspend
isn't set.
This patch fixes the warning by explicitly setting always-on regulator's
states to ENABLE_IN_SUSPEND.

Signed-off-by: Robert Karszniewicz <r.karszniewicz@phytec.de>
---
Tested on v4.19.67, applies cleanly on v5.5-rc2.

 drivers/regulator/of_regulator.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 210fc20..3acb1571 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -188,8 +188,14 @@ static void of_get_regulation_constraints(struct device_node *np,
 			continue;
 		}
 
+		if (!suspend_state)
+			continue;
+
+		if (constraints->always_on)
+			suspend_state->enabled = ENABLE_IN_SUSPEND;
+
 		suspend_np = of_get_child_by_name(np, regulator_states[i]);
-		if (!suspend_np || !suspend_state)
+		if (!suspend_np)
 			continue;
 
 		if (!of_property_read_u32(suspend_np, "regulator-mode",
-- 
2.7.4

