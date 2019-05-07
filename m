Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECDBC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71103205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9xny6Jg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfEGQ7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 12:59:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45572 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbfEGQ7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:59:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so8945820pfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HpUfowzPkPP+EimE58t16S3r0XExpxfBQEdnNQKh3Bc=;
        b=g9xny6JgesQKFtGTi5kEK7/Ikcq8NsKELmngrvHowFn6ojZtnzg4X+UR9s9XHsOLMK
         atxUuP/jBO/XQjlM7YFRyNAGG/kHQaIs20geCqyOQm31bLMI0iu881uzXAL5fKgtw9rk
         3rrZtE2h8ztC+6lUMMaT4V3RS/P6d9ItRnxVAi8//paxzCDECnQ1ZiZjhtn0NM/9+4Cn
         WQjWg6SfxsX2gqxeYz8u4h2YXhCVX4/wEk3g9yO2h/jvCUQDyIFKl9CP0O6JrhwzFMHP
         8ZrIEQ1DZnzNVLUaglA2DyxvaYR4khxGLgEumI2+2DCx+CV6hcM5H+xewdX6v8gdk4Ue
         O7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HpUfowzPkPP+EimE58t16S3r0XExpxfBQEdnNQKh3Bc=;
        b=HwYMzjCfKjPC1rKsJVrHakM6rQa+C48d9rKDrh2RdIzz5+DF0OrSRgIdBbgq49BbSr
         7memHf5AEBA4RlVyK4Xsp9mp7fHV4ekgXlb3ZeqUASX+FNridcR49bmPl0yGkaDUtJbq
         rsx1vGvpuO5F1wawhUiGXBNcjA3YSbxIhxSQsylIndemJ1LGFIdXRmFtvdiptFhExFar
         bp3NXcJJG7XHUsMn+J3BoXXiHb0cZfFShfN7siOs3Ws4uYnGWkq2lKTdhLYHUolyqT2X
         4Vrk94wXupygNA6pcrK1dySbuAje7YYe3SkceaI6igVb8pf3nMgke8jJDi5C2izCJEbX
         dz2Q==
X-Gm-Message-State: APjAAAVTssDnqEcjshGZNm7mO78Bzws8nQgIR33K9vAUPRK+PVLnkgJw
        l6Dc+UyQiBS9P1N2tjnhOEQ=
X-Google-Smtp-Source: APXvYqyuqnN4Vgezd5EXk0WeM5ZmcTumZxABQ40n/nV8S+B8o9TKIPvDyqx6/SaAXGHOoeGiSmm4dw==
X-Received: by 2002:a63:3190:: with SMTP id x138mr28837539pgx.402.1557248345314;
        Tue, 07 May 2019 09:59:05 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:1b24:991b:df50:ea3f])
        by smtp.gmail.com with ESMTPSA id r12sm18140093pfn.144.2019.05.07.09.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 May 2019 09:59:04 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH v2 5/7] nvme: add facility to check log page attributes
Date:   Wed,  8 May 2019 01:58:32 +0900
Message-Id: <1557248314-4238-6-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This provides a facility to check whether the controller supports the
telemetry log pages and log page offset field for the Get Log Page
command.

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v2
- New patch in this version.

 drivers/nvme/host/core.c | 1 +
 drivers/nvme/host/nvme.h | 1 +
 include/linux/nvme.h     | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6265d92..42f09d6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2580,6 +2580,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	} else
 		ctrl->shutdown_timeout = shutdown_timeout;
 
+	ctrl->lpa = id->lpa;
 	ctrl->npss = id->npss;
 	ctrl->apsta = id->apsta;
 	prev_apst_enabled = ctrl->apst_enabled;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 527d645..8711c71 100644
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
index 5217fe4..c1c4ca5 100644
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
-- 
2.7.4

