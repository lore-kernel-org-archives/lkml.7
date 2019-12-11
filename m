Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C611CC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4732467A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576078244;
	bh=YvNrqfFXbfMVo4oZYLuelAF7JrGjGJutSAP9bzSC4Wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k/2eLopF0ukjb0AouRa2PJci74UejDFbj49a+0UgRGyU2Mm58E5uM+iDpCVKJ43aN
	 FbW1SLN1D0DE4CPCg3v7VTYG5Vpt2HSGcE37rV7yrNPS2hiHrYD72faV9Fn0sqHxdA
	 XyMrzTpW3EfPMJuHeCT6JVNa0q4aHhSrbp2S/JZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387874AbfLKP3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:29:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:35942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387555AbfLKP3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:29:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E2EA2465B;
        Wed, 11 Dec 2019 15:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576078155;
        bh=YvNrqfFXbfMVo4oZYLuelAF7JrGjGJutSAP9bzSC4Wg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=osYIw5PZwtHkMSC1nRHYe7ua5FC5i9xGj8SJgze71S97IZONcW+zNlerlD1Q5ZBe2
         PSXelih2FIyE0LJNSIEWPPtbzuf6YYtmFVOH5VihfWi7EhdIRbUbox8dAAKwfVFgfh
         phPmfzZafhuyV2qFNBxqYGrQLJrkIRS98RuvQNcA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Maurizio Lombardi <mlombard@redhat.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 41/58] scsi: scsi_debug: num_tgts must be >= 0
Date:   Wed, 11 Dec 2019 10:28:14 -0500
Message-Id: <20191211152831.23507-41-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211152831.23507-1-sashal@kernel.org>
References: <20191211152831.23507-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit aa5334c4f3014940f11bf876e919c956abef4089 ]

Passing the parameter "num_tgts=-1" will start an infinite loop that
exhausts the system memory

Link: https://lore.kernel.org/r/20191115163727.24626-1-mlombard@redhat.com
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Acked-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_debug.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 92bc5b2d24ae9..ac936b5ca74e5 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -4960,6 +4960,11 @@ static int __init scsi_debug_init(void)
 		return -EINVAL;
 	}
 
+	if (sdebug_num_tgts < 0) {
+		pr_err("num_tgts must be >= 0\n");
+		return -EINVAL;
+	}
+
 	if (sdebug_guard > 1) {
 		pr_err("guard must be 0 or 1\n");
 		return -EINVAL;
-- 
2.20.1

