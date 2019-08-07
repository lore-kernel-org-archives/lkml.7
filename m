Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C912AC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 05:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F2F21E6C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 05:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cIXhIats"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfHGFj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 01:39:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43393 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbfHGFjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 01:39:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so31939846pld.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 22:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hV2OpNDlf9B8X2Y4BzyxalclcI5O3SjBzPMCmfPooZQ=;
        b=cIXhIatsOcPuqn1+MgSm/QQB00cmGPVG8EbiRAPHUblko3fhn/9Pkpx/65QgW82eNH
         M0NEPAUTZxkplleu9px9+XRjuwTitLxz1ocIySnkyfqIvPgUWfLOZP4JvFXaeDAGHuZf
         gfb+cgF+zUNZJoCL70yvlLUa1ZzUuJXe6Wkujgon5BgiOZruSI4mqq+7l2Az18BLZMJa
         hIgU/T237Nrn1TzV5hATl8jhLt3m7srfJmdcAEm+yU+ToxZ8gJi1xu1FnqOX2Dhnktp+
         6+Crb6NnrQKI5jNDt6RGfuKMOiXcj/jhR316UzF1+SlE5hhasDGbjw0nzwq6pkPCkU0g
         oWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hV2OpNDlf9B8X2Y4BzyxalclcI5O3SjBzPMCmfPooZQ=;
        b=eBbkhKjtLuN+tUZdIbsZlKp5THVMvPX18efdTMSeGA9jh2RqjD7AR7q1nmQb4X5TIV
         dGQMLer0mva0bePmOrmtuw5hW90yvzUJDtmYr3uNHsmRMtJuSR/5pdRJx4HY+6Gt0iJJ
         EHzRst4bhMx/iC5Vv0q6sr94RiJbrtNBYwysPb5o2b/BPeEk/I34WirHKcRq8+p+jp3R
         NL5+zKAlnmmSPqQUT/ap8QcLUdXqTsbw/fQvNeq+VXGptCVH+nO99iSp9Xg9AgRJBceM
         g86n6vLZMDcB1LUvn7veHOaRQX0uuQavt8dWzbAB1qbb1YQmXmWmMEQAbvSQAofiqD1F
         IpJw==
X-Gm-Message-State: APjAAAXAlSSjKfn3taHgjkyhxSBQASnVbHs1NwZkswDJcamKYHngYJ5N
        jH3Yb2dGsrxpDvruXacd2jVlGhKi5IA=
X-Google-Smtp-Source: APXvYqxVdFtsesLs97Pm6ige+MLx7B4T80576E9cEvBvip+y9DeCaBSXv/ssBsoin6c7szx10I2wuQ==
X-Received: by 2002:a62:2ccc:: with SMTP id s195mr7503689pfs.256.1565156394058;
        Tue, 06 Aug 2019 22:39:54 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u7sm86070777pfm.96.2019.08.06.22.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 22:39:53 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH 7/9] remoteproc: Introduce "panic" callback in ops
Date:   Tue,  6 Aug 2019 22:39:40 -0700
Message-Id: <20190807053942.9836-8-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190807053942.9836-1-bjorn.andersson@linaro.org>
References: <20190807053942.9836-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a "panic" function in the remoteproc ops table, to allow
remoteproc instances to perform operations needed in order to aid in
post mortem system debugging, such as flushing caches etc, when the
kernel panics.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 16 ++++++++++++++++
 include/linux/remoteproc.h           |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 3c5fbbbfb0f1..cc47797c6496 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1833,6 +1833,16 @@ void rproc_shutdown(struct rproc *rproc)
 }
 EXPORT_SYMBOL(rproc_shutdown);
 
+static int rproc_panic_handler(struct notifier_block *nb, unsigned long event,
+			       void *ptr)
+{
+	struct rproc *rproc = container_of(nb, struct rproc, panic_nb);
+
+	rproc->ops->panic(rproc);
+
+	return NOTIFY_DONE;
+}
+
 /**
  * rproc_get_by_phandle() - find a remote processor by phandle
  * @phandle: phandle to the rproc
@@ -2058,6 +2068,12 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 		rproc->ops->get_boot_addr = rproc_elf_get_boot_addr;
 	}
 
+	/* Register panic notifier for remoteprocs with "panic" callback */
+	if (rproc->ops->panic) {
+		rproc->panic_nb.notifier_call = rproc_panic_handler;
+		atomic_notifier_chain_register(&panic_notifier_list, &rproc->panic_nb);
+	}
+
 	mutex_init(&rproc->lock);
 
 	idr_init(&rproc->notifyids);
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 16ad66683ad0..33553f6d8ff0 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -383,6 +383,7 @@ struct rproc_ops {
 	int (*load)(struct rproc *rproc, const struct firmware *fw);
 	int (*sanity_check)(struct rproc *rproc, const struct firmware *fw);
 	u32 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
+	void (*panic)(struct rproc *rproc);
 };
 
 /**
@@ -481,6 +482,7 @@ struct rproc_dump_segment {
  * @auto_boot: flag to indicate if remote processor should be auto-started
  * @dump_segments: list of segments in the firmware
  * @nb_vdev: number of vdev currently handled by rproc
+ * @panic_nb: notifier_block for remoteproc's panic handler
  */
 struct rproc {
 	struct list_head node;
@@ -514,6 +516,7 @@ struct rproc {
 	bool auto_boot;
 	struct list_head dump_segments;
 	int nb_vdev;
+	struct notifier_block panic_nb;
 };
 
 /**
-- 
2.18.0

