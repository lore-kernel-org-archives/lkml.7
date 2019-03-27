Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC11C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 07:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D5420811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 07:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GdErZuqB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c49YYWBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbfC0Hui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 03:50:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49546 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfC0Huh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 03:50:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F3E7560A43; Wed, 27 Mar 2019 07:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553673037;
        bh=ge94f7hU7A6Jb94FgQsv6Db3d8w3n2ygB3+38mZRfME=;
        h=From:To:Cc:Subject:Date:From;
        b=GdErZuqBkjsoqD7PMrtYyhRZ4yyvomMhMORcAXNVqHK+8z5a8xjQyVMNPyWtTD46i
         LigmFiWN5skA3e8EsSUevK5VtErysxGUleGW8rw1daZUcniwvSLxg2ZmVd7kFsKKPe
         bBQy0hngW5c/eiWuzhnIrP5DSuE5ytv2+o2Lc/os=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D856560ACE;
        Wed, 27 Mar 2019 07:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553673036;
        bh=ge94f7hU7A6Jb94FgQsv6Db3d8w3n2ygB3+38mZRfME=;
        h=From:To:Cc:Subject:Date:From;
        b=c49YYWBAcqAjVWGUvCSMKlcZDTMxqjscVDMNokyULeVubV+3bU2psYjq2hfXskbeU
         ym3mqpj49aGedF70VFrdj/WfTNvPX26UDx2aBwnkCXyb/E/+NcFK0sk4mjILGSO38f
         SkH9RbSeFxXROXZvViaKhemee+UXvDwC9efrpe8A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D856560ACE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     keescook@chromium.org, jannh@google.com,
        linux-kernel@vger.kernel.org, jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH] Yama: mark function as static
Date:   Wed, 27 Mar 2019 13:20:18 +0530
Message-Id: <1553673018-19234-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse complains yama_task_prctl can be static. Fix it by making
it static.

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
 security/yama/yama_lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 57cc607..9c5a15b 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -222,7 +222,7 @@ void yama_task_free(struct task_struct *task)
  * Return 0 on success, -ve on error.  -ENOSYS is returned when Yama
  * does not handle the given option.
  */
-int yama_task_prctl(int option, unsigned long arg2, unsigned long arg3,
+static int yama_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			   unsigned long arg4, unsigned long arg5)
 {
 	int rc = -ENOSYS;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

