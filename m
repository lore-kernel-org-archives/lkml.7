Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AF6C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D1B22CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567612940;
	bh=+vy2sI6ZQKEC8eJl5BuN7/MMzh/3CK0DPMhT/+F2YH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pZ/0laeIu82EzGKhdRIr3kWP+xHWhboGzfeZCAwXnCfVC2bIUQC3NYg/vkWPOAK1O
	 D62xx6P0w4WTx/jcLl6KvHudExt2P59yg9QeZHu3hpY6WefIyjB8Crf1v0FND98FkG
	 lhm7V4yVoXny1MxwBMLHLS2Xlv8qjjtu+7Tyo1Fk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733227AbfIDQCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:02:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733213AbfIDQCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:02:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 755C42339D;
        Wed,  4 Sep 2019 16:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612936;
        bh=+vy2sI6ZQKEC8eJl5BuN7/MMzh/3CK0DPMhT/+F2YH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jOLKW/gH/V26mSbhZAW+Bxvh3w5A8wTqxmG96bC0cgVFlO4Gy3lmq7QOPmTW1nBx7
         KujujJb/BQHkPPMDEPVFSF/tnR8e2YjPZERLmD26Xa4Pmn5bLZvc4yRzqlCykn+pLP
         HGD72PT55nRtmgqDxSkXShzcYHUJxwSbog0qsQG4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Zephaniah E. Loss-Cutler-Hull" <zephaniah@gmail.com>,
        Len Brown <len.brown@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 34/36] tools/power x86_energy_perf_policy: Fix argument parsing
Date:   Wed,  4 Sep 2019 12:01:20 -0400
Message-Id: <20190904160122.4179-34-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904160122.4179-1-sashal@kernel.org>
References: <20190904160122.4179-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Zephaniah E. Loss-Cutler-Hull" <zephaniah@gmail.com>

[ Upstream commit 03531482402a2bc4ab93cf6dde46833775e035e9 ]

The -w argument in x86_energy_perf_policy currently triggers an
unconditional segfault.

This is because the argument string reads: "+a:c:dD:E:e:f:m:M:rt:u:vw" and
yet the argument handler expects an argument.

When parse_optarg_string is called with a null argument, we then proceed to
crash in strncmp, not horribly friendly.

The man page describes -w as taking an argument, the long form
(--hwp-window) is correctly marked as taking a required argument, and the
code expects it.

As such, this patch simply marks the short form (-w) as requiring an
argument.

Signed-off-by: Zephaniah E. Loss-Cutler-Hull <zephaniah@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index bbef8bcf44d6d..2aba622d1c5aa 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -546,7 +546,7 @@ void cmdline(int argc, char **argv)
 
 	progname = argv[0];
 
-	while ((opt = getopt_long_only(argc, argv, "+a:c:dD:E:e:f:m:M:rt:u:vw",
+	while ((opt = getopt_long_only(argc, argv, "+a:c:dD:E:e:f:m:M:rt:u:vw:",
 				long_options, &option_index)) != -1) {
 		switch (opt) {
 		case 'a':
-- 
2.20.1

