Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D35C46470
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CEC2173E
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTyF8V1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfELPyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 11:54:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33070 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfELPyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 11:54:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id h17so5458574pgv.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 08:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d2wWJz4YMrtwlEJecuuUCAduDMfeNvXVgccKamh1L2Q=;
        b=HTyF8V1iLjPVxWHbZrbWrT5ZaAU4mLUUHpZIcejE7e9hY0xzp+108g1aABAR2PpEDY
         8uWGlXfcIjem/w4djblB78fN/3fnWfukobhZ9J8uuYyhMwEuyDm+PP1c+VfkG4mJNgw1
         f2bR7qdWIgGUQbyYzd120QyA4Is98EqOVYY3Q54LyOzkZRe+Mnu4BwYCjwJoOt05/Q55
         7uDUOpg6E3LZNgsQONUlaiV1XwFPvFd29eGU2fXe4qHtkCZyuU7YYBUEl8Xr5Ga9GKKJ
         jsxv/C8j05CN9Oq3RiF2lUuUWvrvMiTSMWJntkP6+S+pr0OYdWRitmmeeQuZhYY1C18v
         qU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d2wWJz4YMrtwlEJecuuUCAduDMfeNvXVgccKamh1L2Q=;
        b=sMUw6aE05IchlMdF6cKBZj6bOC1P4bdemMHIKHJquScINCl14H/O3fKUFVMEu1laA3
         UrEoGIYkjKMLmH0US0tNKlEIJbMpqaaciJbujKnSaes2bvMKoMWBBv4zv03WMk30Il4x
         vNKItTTARIlNjqLr7oYpmyLTweYRvcCbbBCo8M0aTW5O0LvJGhuAIaqJIhgRTii2lQ4/
         NoSFP7PQUb5o1JkNdduTiYFfrdkgBwHOWVe1MezXTJXE3dGpOI2ZwqP/Vy+Me4yqtafr
         VEiITA5pDoy2THkCeGGQ8xhZnzH/BIoEcpi1EK6indaAAGJt5LoC8k8k0oerRk/COoHd
         FT8g==
X-Gm-Message-State: APjAAAVZ1ohHXQZTUXO6GkvGJwBdUtqRg+p1MDkvu75LtCvYYrm2jOGL
        FduKK4o3cSBBeOqufN0Zsqc=
X-Google-Smtp-Source: APXvYqzBUPLt00KkhehGsTxNtdxkDAU5B9QsWEqMfdCFnVl++gjx41xIRjsfCsqqGnGEyfkPFHcNZg==
X-Received: by 2002:a63:1a03:: with SMTP id a3mr26445478pga.412.1557676490807;
        Sun, 12 May 2019 08:54:50 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:918e:f7e4:1728:3f45])
        by smtp.gmail.com with ESMTPSA id v2sm4470058pgr.2.2019.05.12.08.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 May 2019 08:54:50 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>
Subject: [PATCH v3 4/7] nvme: add basic facility to get telemetry log page
Date:   Mon, 13 May 2019 00:54:14 +0900
Message-Id: <1557676457-4195-5-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
References: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the required definisions to get telemetry log page.
The telemetry log page structure and identifier are copied from nvme-cli.

We also need a facility to check log page attributes in order to know
the controller supports the telemetry log pages and log page offset field
for the Get Log Page command.  The telemetry data area could be larger
than maximum data transfer size, so we may need to split into multiple
transfers with incremental page offset.

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Kenneth Heitke <kenneth.heitke@intel.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v3
- Merge 'add telemetry log page definisions' patch and 'add facility to
  check log page attributes' patch
- Copy struct nvme_telemetry_log_page_hdr from the latest nvme-cli
- Add BUILD_BUG_ON for the size of struct nvme_telemetry_log_page_hdr

 drivers/nvme/host/core.c |  2 ++
 drivers/nvme/host/nvme.h |  1 +
 include/linux/nvme.h     | 17 +++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a6644a2..0cea2a8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2585,6 +2585,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	} else
 		ctrl->shutdown_timeout = shutdown_timeout;
 
+	ctrl->lpa = id->lpa;
 	ctrl->npss = id->npss;
 	ctrl->apsta = id->apsta;
 	prev_apst_enabled = ctrl->apst_enabled;
@@ -3898,6 +3899,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl) != NVME_IDENTIFY_DATA_SIZE);
 	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != NVME_IDENTIFY_DATA_SIZE);
 	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_telemetry_log_page_hdr) != 512);
 	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
 	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_directive_cmd) != 64);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5ee75b5..7f6f1fc 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -195,6 +195,7 @@ struct nvme_ctrl {
 	u32 vs;
 	u32 sgls;
 	u16 kas;
+	u8 lpa;
 	u8 npss;
 	u8 apsta;
 	u32 oaes;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c40720c..8c0b29d 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -294,6 +294,8 @@ enum {
 	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
 	NVME_CTRL_OACS_DBBUF_SUPP		= 1 << 8,
 	NVME_CTRL_LPA_CMD_EFFECTS_LOG		= 1 << 1,
+	NVME_CTRL_LPA_EXTENDED_DATA		= 1 << 2,
+	NVME_CTRL_LPA_TELEMETRY_LOG		= 1 << 3,
 };
 
 struct nvme_lbaf {
@@ -396,6 +398,20 @@ enum {
 	NVME_NIDT_UUID		= 0x03,
 };
 
+struct nvme_telemetry_log_page_hdr {
+	__u8    lpi; /* Log page identifier */
+	__u8    rsvd[4];
+	__u8    iee_oui[3];
+	__le16  dalb1; /* Data area 1 last block */
+	__le16  dalb2; /* Data area 2 last block */
+	__le16  dalb3; /* Data area 3 last block */
+	__u8    rsvd1[368];
+	__u8    ctrlavail; /* Controller initiated data avail?*/
+	__u8    ctrldgn; /* Controller initiated telemetry Data Gen # */
+	__u8    rsnident[128];
+	__u8    telemetry_dataarea[0];
+};
+
 struct nvme_smart_log {
 	__u8			critical_warning;
 	__u8			temperature[2];
@@ -832,6 +848,7 @@ enum {
 	NVME_LOG_FW_SLOT	= 0x03,
 	NVME_LOG_CHANGED_NS	= 0x04,
 	NVME_LOG_CMD_EFFECTS	= 0x05,
+	NVME_LOG_TELEMETRY_CTRL	= 0x08,
 	NVME_LOG_ANA		= 0x0c,
 	NVME_LOG_DISC		= 0x70,
 	NVME_LOG_RESERVATION	= 0x80,
-- 
2.7.4

