Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81A8C3276F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE6B21D7D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="PZzR+KJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgACDTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 22:19:41 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:15604 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726136AbgACDTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 22:19:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578021581; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=vjy5dIMVDT1Phjpq4ZShDs2av01qUSIKCZ/bB67Qb0g=; b=PZzR+KJA96+j6bo6JCh0tEsnrRXTWW74OPjowsqr034sj2Sbe4AnL7VonKH7Pf58bsjq+LkW
 4Ja4/u57TrWG6aqI+uYILB15Gs1MgJSeJX5Y/pMQ7YWuCbm2dsLAYHTCkHQrncQ7OclbFiZS
 6BoOrQbFQvR9j08Wa1E6M6DnCEM=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e0eb2cb.7fd22c807d18-smtp-out-n03;
 Fri, 03 Jan 2020 03:19:39 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 685DFC4479D; Fri,  3 Jan 2020 03:19:39 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1050AC433CB;
        Fri,  3 Jan 2020 03:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1050AC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: show the CP_PAUSE reason in checkpoint traces
Date:   Fri,  3 Jan 2020 08:49:28 +0530
Message-Id: <1578021568-21552-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the duplicate CP_UMOUNT enum and add the new CP_PAUSE
enum to show the checkpoint reason in the trace prints.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 include/trace/events/f2fs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 1796ff9..3a17252 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -49,6 +49,7 @@
 TRACE_DEFINE_ENUM(CP_RECOVERY);
 TRACE_DEFINE_ENUM(CP_DISCARD);
 TRACE_DEFINE_ENUM(CP_TRIMMED);
+TRACE_DEFINE_ENUM(CP_PAUSE);
 
 #define show_block_type(type)						\
 	__print_symbolic(type,						\
@@ -124,7 +125,7 @@
 		{ CP_SYNC,	"Sync" },				\
 		{ CP_RECOVERY,	"Recovery" },				\
 		{ CP_DISCARD,	"Discard" },				\
-		{ CP_UMOUNT,	"Umount" },				\
+		{ CP_PAUSE,	"Pause" },				\
 		{ CP_TRIMMED,	"Trimmed" })
 
 #define show_fsync_cpreason(type)					\
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
