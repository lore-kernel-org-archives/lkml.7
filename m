Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E978DC28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 18:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C573427791
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 18:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rR8LhYT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfFASoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 14:44:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33244 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfFASoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 14:44:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id x10so3067079pfi.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 11:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yc+ew6mEhC1K44V9Kaq8PMD2XpGRYZvToFDeIsNedGk=;
        b=rR8LhYT3DpvWcqY8wPeCw54F1wWu0JBcXYZ6CT8bOuoQJNi6ioatr5b+Rb5Rs7+Vdc
         hZkcnQ1hxmOziliNsH2wvmCaRas4FG9RjretA29WsnccEv1aJi8vwEOW+ZYIpPJsNY+q
         TjVkyKFihA424QCuZV5Vlp5AL81bwr1cRPwSDEcASjE8+5byigiMoL32SDdlZQix37vZ
         gwal3EJ2Ay4QbIY59N6qMxrIvdJNusMtbp77ScKaekqOzkzGn3z/QNrMTtZWsdKdLWnU
         IlsRacU5MzG6P+gJWC+QO0F2ufUxU1Jbgsz0aDZ21FK64GrPO5h7a2NXAso1SlQAhL0F
         PP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yc+ew6mEhC1K44V9Kaq8PMD2XpGRYZvToFDeIsNedGk=;
        b=ibpdeJPLzXgIUMAHKSg83REr2MrVdu58eLFVzTUy1eoB0/Hz7m2pfJDW3WCNV4mR7R
         kifIBNgCKfCU2z+07c6iqwyChY6h/XvLYPv8GMU8eXxSv2G8mhUkQAfZpvGk3m0hK2pL
         7L8q3IqcgMHfwY7yec5r+bE4iOQdJkq8ktxNu2s2/Q61r73umPEO/0PgJCmMK7XoQoGT
         iOcY7ykYGnHpi4YZAChIATwnav9EN/CFry2mYyO7k+uJM5iYIHlRWdQa6Fc6CbR5oXD6
         0zVaX6s79ZmBW47nPCmSchgPUvLZcxLX3F4KcVUSmBgf58Zn7IxslaWRhLAhC0GgYqd5
         HRBg==
X-Gm-Message-State: APjAAAXER063Xt+zW/gNJk3p6K+verMU0xm1CYkdjL+kjWm2A9dpK75X
        Jycz7QzR0fYEszZEK5Z8tpNawAUK
X-Google-Smtp-Source: APXvYqwfOocYJqrzLu39BMTUvUR9v4h0OhOCaViWg/ThtzzVofru3cfQ/YgTECIHJlsG7C8nKMInLQ==
X-Received: by 2002:a17:90a:2562:: with SMTP id j89mr3779918pje.123.1559414644684;
        Sat, 01 Jun 2019 11:44:04 -0700 (PDT)
Received: from localhost.localdomain ([117.192.16.207])
        by smtp.googlemail.com with ESMTPSA id w187sm13287950pfw.20.2019.06.01.11.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jun 2019 11:44:04 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, linux.dkm@gmail.com,
        himadri18.07@gmail.com, straube.linux@gmail.com
Subject: [PATCH 1/8] staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
Date:   Sun,  2 Jun 2019 00:13:35 +0530
Message-Id: <f0a4ae0b484feb85bfccd50dd5c2fd94f1ccc4af.1559412149.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559412149.git.linux.dkm@gmail.com>
References: <cover.1559412149.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes CamelCase ImrContent from struct _adapter and in related
files drv_types.h, rtl871x_mp_ioctl.c, rtl871x_pwrctrl.h

CHECK: Avoid CamelCase: <ImrContent>

Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h        | 2 +-
 drivers/staging/rtl8712/rtl871x_mp_ioctl.c | 2 +-
 drivers/staging/rtl8712/rtl871x_pwrctrl.h  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index 9ae86631fa8b..89ebb5a49d25 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -149,7 +149,7 @@ struct _adapter {
 	bool	surprise_removed;
 	bool	suspended;
 	u32	IsrContent;
-	u32	ImrContent;
+	u32	imr_content;
 	u8	EepromAddressSize;
 	u8	hw_init_completed;
 	struct task_struct *cmdThread;
diff --git a/drivers/staging/rtl8712/rtl871x_mp_ioctl.c b/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
index 588346da1412..4cf9d3afd2c5 100644
--- a/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
+++ b/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
@@ -665,7 +665,7 @@ uint oid_rt_pro_write_register_hdl(struct oid_par_priv *poid_par_priv)
 		if ((status == RNDIS_STATUS_SUCCESS) &&
 		    (RegRWStruct->offset == HIMR) &&
 		    (RegRWStruct->width == 4))
-			Adapter->ImrContent = RegRWStruct->value;
+			Adapter->imr_content = RegRWStruct->value;
 	}
 	return status;
 }
diff --git a/drivers/staging/rtl8712/rtl871x_pwrctrl.h b/drivers/staging/rtl8712/rtl871x_pwrctrl.h
index 11b5034f203d..cca81a3f4031 100644
--- a/drivers/staging/rtl8712/rtl871x_pwrctrl.h
+++ b/drivers/staging/rtl8712/rtl871x_pwrctrl.h
@@ -88,7 +88,7 @@ struct	pwrctrl_priv {
 	uint pwr_mode;
 	uint smart_ps;
 	uint alives;
-	uint ImrContent;	/* used to store original imr. */
+	uint imr_content;	/* used to store original imr. */
 	uint bSleep; /* sleep -> active is different from active -> sleep. */
 
 	struct work_struct SetPSModeWorkItem;
-- 
2.19.1

