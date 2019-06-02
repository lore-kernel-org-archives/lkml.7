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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1216DC282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 10:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9884278CC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 10:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrMXlQ1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfFBK05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 06:26:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38668 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfFBK0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 06:26:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id v11so6562127pgl.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 03:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cKIUH11KwFXPaOzB3T3N/IBDlwu+dDeLYBil+yyqzok=;
        b=HrMXlQ1NrvU892a9LzgJVM7BpBWOdVTOMYFftY5ZhRPdcw7MJCipMmfppFvi8z3/ML
         CsrHymj35R/vJrvE+RdKURqtBE+2YYFcqiQqMdz2fwWVlY5tGRkR59eh7Ihlk/NCaf/t
         YcSEgQr1c2+f+Hpjp2vSpbDKMQw2xXinago994U43nrFFffONcCeG093CEEzQUo4BHyu
         nwqCzXEIjIHrq1lzripcrBUvvUi3Uw/dpROaGIrTE9HHk8MOFrBN00at7906q9nW+2iw
         ZIBeF3nfusGc3sKPb9+GCBJ6WCFMHeupWiqqXzXpXyKYTCi56yVnIiU2dhN2Qt6WRIG9
         A0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cKIUH11KwFXPaOzB3T3N/IBDlwu+dDeLYBil+yyqzok=;
        b=MYcskQ1r6iBCrYJvVvdrF8bO5AbAJN0GmzK7iCzlKlzQ984FuNXi2koBXyYDqc8aUM
         lkp82xxkA7lnQ21NOUQlpM8k0NCsNlJc2ZwhgxzXxbTzb/kx2GrSY6mwhmMU5IEm0Rm7
         vHTtONtU9pE3iGbHSdr15++Mdz0vaNouxmJzvy7/a/nDS9kxwROuZdVMmLALIhxdCzls
         n6Jpa38qI9C+EMsvYi91Qguyj+byqQxtblVRO25FGProtxCmUJuzf1xUDAok6Xv5aRUk
         0E/KiCMI1OVvelWzjtGexV1R9+fmYM0nymRk5o7G8cAwmoiQ+pWgFhb97FRFCwP7Qer8
         9CnQ==
X-Gm-Message-State: APjAAAXxBqX6Dxin8R66FXvOGpPcXAgJYVNKoumSTWDOtvRCBkegpWae
        WYb0NMewSuL/JVFPHoXkuJVdgm9f
X-Google-Smtp-Source: APXvYqzlyzLWQfeASAiWeK/a21bsbMcts5CVEapPYHUG3UG19rJXa11dEbDMdnRaNIhCMKU1MA1rUA==
X-Received: by 2002:a62:2c17:: with SMTP id s23mr23363953pfs.51.1559471214024;
        Sun, 02 Jun 2019 03:26:54 -0700 (PDT)
Received: from localhost.localdomain ([117.192.23.157])
        by smtp.googlemail.com with ESMTPSA id j13sm12221099pfh.13.2019.06.02.03.26.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 03:26:53 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, joe@perches.com, wlanfae@realtek.com,
        Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux.dkm@gmail.com, himadri18.07@gmail.com,
        straube.linux@gmail.com
Subject: [PATCH v2 8/9] staging: rtl8712: fixed enable_rx_ff0_filter as bool and CamelCase
Date:   Sun,  2 Jun 2019 15:55:37 +0530
Message-Id: <7b32a7cf85ef0c3f6d2ba82480a1f8d0ad651779.1559470738.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559470737.git.linux.dkm@gmail.com>
References: <cover.1559470737.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes CamelCase blnEnableRxFF0Filter by renaming it
to enable_rx_ff0_filter in drv_types.h and related files rtl871x_cmd.c
xmit_linux.c
It was reported by checkpatch.pl

This fix also makes enable_rx_ff0_filter a bool and uses true false than
previously used u8 as suggested by joe@perches.com

Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h   | 2 +-
 drivers/staging/rtl8712/rtl871x_cmd.c | 2 +-
 drivers/staging/rtl8712/xmit_linux.c  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index ddab6514a549..e3e2b32e964e 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -164,7 +164,7 @@ struct _adapter {
 	struct iw_statistics iwstats;
 	int pid; /*process id from UI*/
 	struct work_struct wk_filter_rx_ff0;
-	u8 blnEnableRxFF0Filter;
+	bool enable_rx_ff0_filter;
 	spinlock_t lockRxFF0Filter;
 	const struct firmware *fw;
 	struct usb_interface *pusb_intf;
diff --git a/drivers/staging/rtl8712/rtl871x_cmd.c b/drivers/staging/rtl8712/rtl871x_cmd.c
index 05a78ac24987..6a8d58d97873 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.c
+++ b/drivers/staging/rtl8712/rtl871x_cmd.c
@@ -238,7 +238,7 @@ u8 r8712_sitesurvey_cmd(struct _adapter *padapter,
 	mod_timer(&pmlmepriv->scan_to_timer,
 		  jiffies + msecs_to_jiffies(SCANNING_TIMEOUT));
 	padapter->ledpriv.LedControlHandler(padapter, LED_CTL_SITE_SURVEY);
-	padapter->blnEnableRxFF0Filter = 0;
+	padapter->enable_rx_ff0_filter = false;
 	return _SUCCESS;
 }
 
diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
index e65a51c7f372..9fa1abcf5e50 100644
--- a/drivers/staging/rtl8712/xmit_linux.c
+++ b/drivers/staging/rtl8712/xmit_linux.c
@@ -103,11 +103,11 @@ void r8712_SetFilter(struct work_struct *work)
 	r8712_write8(padapter, 0x117, newvalue);
 
 	spin_lock_irqsave(&padapter->lockRxFF0Filter, irqL);
-	padapter->blnEnableRxFF0Filter = 1;
+	padapter->enable_rx_ff0_filter = true;
 	spin_unlock_irqrestore(&padapter->lockRxFF0Filter, irqL);
 	do {
 		msleep(100);
-	} while (padapter->blnEnableRxFF0Filter == 1);
+	} while (padapter->enable_rx_ff0_filter == true);
 	r8712_write8(padapter, 0x117, oldvalue);
 }
 
-- 
2.19.1

