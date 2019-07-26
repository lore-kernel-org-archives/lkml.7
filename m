Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382D5C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05607208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="IE0RZWx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387459AbfGZO0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:26:00 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37134 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbfGZO0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:26:00 -0400
Received: by mail-qt1-f196.google.com with SMTP id y26so52754685qto.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 07:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WTNB9/sSUp3RvghC3N7AVUzrEDJYp8g0FPiSPT+2XmY=;
        b=IE0RZWx//RRo+SUPna44fGwa3H83J/6k6ORc+Rz2IlkOveVpNT1DGd4MnPYXZ+04AV
         9XQxJEG26nX0gY91WPbL6hMCTPqAfleSp43IEFQhaJ54PMVaProxdSjOFyWv5n4JdvDn
         o5R3X0qyI6AyUarBkYZVyT7V6WwJZypymVQskeQlX1uSoPnJD3ru+AQq3CvOJFFIJpuE
         JtVzLWHBhyqcT4pSq2h0Tbv5n7nw/Kp9NGb8fBMnUKSceZrVeNu9YCe2bLVa3zuGIoMW
         ab4MfMKbtuXDez7tfWTxgQ77j3aYEkeD+4efnKuyjhaIHHimKHhL1vvvi9uH/AASXbA8
         Wc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WTNB9/sSUp3RvghC3N7AVUzrEDJYp8g0FPiSPT+2XmY=;
        b=tANeRDBMGkSa7pY5mhmDF4uE/5nszR3S7hJfxSHM3Z4J/4SqbtVrSRIzSts1X5twUq
         50QQwcPlI5rjVoR+HTwOyYp+XD/TPhYTRQJX8FEjQH256QdWABZHGK6wZXQ/cLLFfQVm
         RSSGs9fERlWo0zklHZID8kOMPm/zSgRWzgLwAtIOaGjOjsAWq7DeqOTMzHNPMjtuTZ+Q
         vvnDrBIqGlp2zrFPjpzV3sAHdRzpiFpNDPDJreDYBGG4Mty+yNYHFXLxPHMUc3A/Avnw
         VL5NuV+zCXJ81qEhXaxRPf/mK5KqThJmq3wvlnerugMhHsX6tGF0/enPknw3E/2OaBDk
         twRQ==
X-Gm-Message-State: APjAAAXrO5947/TEcQP+eo8dHEpdQryvNkFhWyFXmEZs3RNrDWa7/Ssa
        8DVZDCBvuAGNtNR4O7pjy8Pat97PrAw05Q==
X-Google-Smtp-Source: APXvYqw7RxbbTRB1wYmPz1aZ7z6CkuQJpFWipr6DnxLizs1HK6WYvq1PfoOxTVIsTZP+MX2WlhfIww==
X-Received: by 2002:a0c:d066:: with SMTP id d35mr66686999qvh.221.1564151159483;
        Fri, 26 Jul 2019 07:25:59 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l19sm30771521qtb.6.2019.07.26.07.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 07:25:58 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     martin.petersen@oracle.com
Cc:     jejb@linux.ibm.com, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] scsi/megaraid_sas: fix a compilation warning
Date:   Fri, 26 Jul 2019 10:25:43 -0400
Message-Id: <1564151143-22889-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit de516379e85f ("scsi: megaraid_sas: changes to function
prototypes") introduced a comilation warning due to it changed the
function prototype of read_fw_status_reg() to take an instance pointer
instead, but forgot to remove an unused variable.

drivers/scsi/megaraid/megaraid_sas_fusion.c: In function
'megasas_fusion_update_can_queue':
drivers/scsi/megaraid/megaraid_sas_fusion.c:326:39: warning: variable
'reg_set' set but not used [-Wunused-but-set-variable]
  struct megasas_register_set __iomem *reg_set;
                                       ^~~~~~~
Fixes: de516379e85f ("scsi: megaraid_sas: changes to function prototypes")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index a32b3f0fcd15..e8092d59d575 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -323,9 +323,6 @@ inline void megasas_return_cmd_fusion(struct megasas_instance *instance,
 {
 	u16 cur_max_fw_cmds = 0;
 	u16 ldio_threshold = 0;
-	struct megasas_register_set __iomem *reg_set;
-
-	reg_set = instance->reg_set;
 
 	/* ventura FW does not fill outbound_scratch_pad_2 with queue depth */
 	if (instance->adapter_type < VENTURA_SERIES)
-- 
1.8.3.1

