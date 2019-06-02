Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F14C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 10:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EAE278C2
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 10:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGIO0EXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfFBK0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 06:26:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43933 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfFBK0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 06:26:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so6557557pgv.10
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 03:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yCdVRr7mANjXJtV9EmJLK/WkxyR5NULqnVw4jsKhao0=;
        b=PGIO0EXhWZd1UjXvZCIpiTwP4KBvOSMrUlJKigyNfhe7rysKtiLYvxhAGRwbB/I5L9
         Tg5p1+WNX8Y/eW2Mg4PRBLnsYFgNNblZ0cwWA5JDbwlhgFSaUgmZnSCrQxr4RmnQLNJr
         RzxdLwrK9aCv9mhlIwfCr0jdIxA8kjAT+wczOB6/85EnRWZKIh5rJ76nJmmLFLxOlK8H
         dnSkukov4Y8DfAYOMW7iDzFj95Igs/H3HW3Fu87Tehl9JZY/PFrvpI+ldEJVB8WMF+35
         8uH3XA1HChfBAUn23qrD1lgvdIzGUL/RIkX9VikWURTo1VmDFkSCqHxdFagzAbBAOwPJ
         fGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yCdVRr7mANjXJtV9EmJLK/WkxyR5NULqnVw4jsKhao0=;
        b=WMwaGDkPycJ0q6Q1hxadpsI70nWiqLrbg+hbCvmZYc8ClGiPXKYmZlPyOZiwGtamJv
         45IRkmckQXzCbbX7RHENxWUsNmP4GVOj06BRGxa4mYb6jAciIowlLasoTwuZG3mfy8Gb
         47pgPpVimul+7qgnMylVhoESKnWk+mr3d1Oj3/FwZiyu1rTSzNEtqelcjDu7rMZVT7FB
         vYPrnJwFaBWgHIHPeQ1y0eYwvpxppan/6Y3amLJHhnYmiWygJqRXmJZ/mI6jvIXWtmBs
         2Ho8K8RGjGSlRIobzUnwoMwxFkSVkDzToKP9OjXUI4hh/jc7xbI3SicSCPzFyrRQM/4O
         Pf/w==
X-Gm-Message-State: APjAAAVSqRhKG9GRPXnOMw+bBw5IJbVuoQnVSfk2lF/UYU6oSX0Wl/Ls
        47eqUWnPv7rYz7fdfF7CNHTAA6h7
X-Google-Smtp-Source: APXvYqwU7tg1Z0/3+ZLgMXbawhku5u7AAnCga6NojHxfPMtRVvQLXxcAch3PonpL6UhvqWJ5cG8isw==
X-Received: by 2002:a62:b50c:: with SMTP id y12mr17406452pfe.171.1559471191878;
        Sun, 02 Jun 2019 03:26:31 -0700 (PDT)
Received: from localhost.localdomain ([117.192.23.157])
        by smtp.googlemail.com with ESMTPSA id j13sm12221099pfh.13.2019.06.02.03.26.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 03:26:31 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, joe@perches.com, wlanfae@realtek.com,
        Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux.dkm@gmail.com, himadri18.07@gmail.com,
        straube.linux@gmail.com
Subject: [PATCH v2 1/9] staging: rtl8712: Fixed CamelCase rename ImrContent to imr_content
Date:   Sun,  2 Jun 2019 15:55:30 +0530
Message-Id: <b23b7ef3b339923fee07045b6cc053a05bd9b717.1559470738.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559470737.git.linux.dkm@gmail.com>
References: <cover.1559470737.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames CamelCase ImrContent to imr_content in struct _adapter and related
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

