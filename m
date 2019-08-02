Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F1DC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B392183F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752262;
	bh=rG3Nzm6yFSgJkHxwMDookGrvn/vJSL34l5WKDDTQqrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=joHTsNp0uZrIqCdI58SOeWAiSeyHIKTrDJsUpd0aCOVfI6ogpjfN5aVyqnOUShAya
	 tJWHyYcqDLQIomwD7SNNBm2eenPr+awFuGmMiLDoT1zWy0J3t9BXYcfw5DTZDlbYP+
	 zP3InhUXViiXmsNzyFFv86HWnTydA06my4VPn5Xg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394145AbfHBNYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:24:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394092AbfHBNYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:24:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ECDE21851;
        Fri,  2 Aug 2019 13:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752243;
        bh=rG3Nzm6yFSgJkHxwMDookGrvn/vJSL34l5WKDDTQqrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X5tg4JoRrsX3La4Qaq+yyD7uTyueRGXJ/ifA/DNymSNcp2OTo6U9HAjRTZiF4NziY
         2/l8EUey1uVuUwjfbZdrkJkwXIEA+sITihCfNBGwHtl/lioygHGmyCcadBfBdrIJ+R
         BnVQ968ecU/oTZLlEe44Z80VZIlBGVw6OpBhpnwg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Junxiao Bi <junxiao.bi@oracle.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 34/42] scsi: megaraid_sas: fix panic on loading firmware crashdump
Date:   Fri,  2 Aug 2019 09:22:54 -0400
Message-Id: <20190802132302.13537-34-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802132302.13537-1-sashal@kernel.org>
References: <20190802132302.13537-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junxiao Bi <junxiao.bi@oracle.com>

[ Upstream commit 3b5f307ef3cb5022bfe3c8ca5b8f2114d5bf6c29 ]

While loading fw crashdump in function fw_crash_buffer_show(), left bytes
in one dma chunk was not checked, if copying size over it, overflow access
will cause kernel panic.

Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index e0c87228438d3..806ceabcabc3f 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3025,6 +3025,7 @@ megasas_fw_crash_buffer_show(struct device *cdev,
 	u32 size;
 	unsigned long buff_addr;
 	unsigned long dmachunk = CRASH_DMA_BUF_SIZE;
+	unsigned long chunk_left_bytes;
 	unsigned long src_addr;
 	unsigned long flags;
 	u32 buff_offset;
@@ -3050,6 +3051,8 @@ megasas_fw_crash_buffer_show(struct device *cdev,
 	}
 
 	size = (instance->fw_crash_buffer_size * dmachunk) - buff_offset;
+	chunk_left_bytes = dmachunk - (buff_offset % dmachunk);
+	size = (size > chunk_left_bytes) ? chunk_left_bytes : size;
 	size = (size >= PAGE_SIZE) ? (PAGE_SIZE - 1) : size;
 
 	src_addr = (unsigned long)instance->crash_buf[buff_offset / dmachunk] +
-- 
2.20.1

