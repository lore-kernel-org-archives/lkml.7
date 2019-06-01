Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40003C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 18:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C03427799
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 18:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jE1Z79hW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfFASo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 14:44:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44011 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfFASoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 14:44:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id c6so8175453pfa.10
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 11:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L8o6xZnk+AA5G0Hb3ZR7vX/fohNyZ7Mc6P+BC4SlPNc=;
        b=jE1Z79hWunaHZ2AgkwpNryasxyA4uD0dNZ9h0JjmGklSaARKgABs6rq8GYZlEm0tZn
         Bd3YzSoe+T9YW98kuyGrgLvusdzCNGgVu9gbcgQmbdPhQdDNqMmf+9oQrdUThp2jaNey
         0rJd0qQO7zPPqTXI6fCSm2k7d8myDekPJShPqnntdyvA1Zr5o0lskQgpJwUlzL9R2Fcx
         zEO+JkKFSoxwjyDCrzG1mBJosaI4zo1L6TKhBVXWx7IuqAKivx9TLUdqS9KHyG0IPsE4
         tsJYGclN+aFe1Y/gxg4NuHYKvpsnIxbsd5XShYQE3Ba/bJjPkliRMIhBRmcnZwG6PPDg
         WCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L8o6xZnk+AA5G0Hb3ZR7vX/fohNyZ7Mc6P+BC4SlPNc=;
        b=OjJQth6fuwTrq+zAyqroAF/GudxDoIgWFP5vrZKlH4mpG1k3sSoG9PAW+7Tiv3aLt3
         XtgcqbIBmbwYf7Gl1p2I1ZCQMewhti5MXxCoMVZsKh7BjAV6NgwaQYPCSShBrkmUM0wH
         zdsKLjdnSGOZKWRkGnyzl1dJ876kqZyO7lVMK8t1D79fn048jOIdxm/UYgjvzupYQ3RK
         r999yIeFVSJo7tm53NcGC0y1FuFq6RjpzCaPvH9LkccqDKVanfXX9GafZzeCqThjqI7o
         iokZcF8qV1PUM7SQwSEl2Np+JhhrmGDc9gDwlzjGtCqVC/GtKxt1dJ8fK/2xwhfyci7p
         oXIw==
X-Gm-Message-State: APjAAAXlntvzoTAfX5jjymEjIJGHHWxUbUHGButGsGPy0v8O/YJFREVX
        qM8yTZ1cUIIPG88LUUOeTKf6YrMi
X-Google-Smtp-Source: APXvYqzB9foPKgg4VEAKGLiJCJBJHzbQPPr0DnlubXv6Odl44h1yEZu0dPhylGUmXcxU1iF29R067w==
X-Received: by 2002:a17:90a:1aa8:: with SMTP id p37mr18355687pjp.17.1559414664028;
        Sat, 01 Jun 2019 11:44:24 -0700 (PDT)
Received: from localhost.localdomain ([117.192.16.207])
        by smtp.googlemail.com with ESMTPSA id w187sm13287950pfw.20.2019.06.01.11.44.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jun 2019 11:44:23 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, linux.dkm@gmail.com,
        himadri18.07@gmail.com, straube.linux@gmail.com
Subject: [PATCH 8/8] staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
Date:   Sun,  2 Jun 2019 00:13:42 +0530
Message-Id: <ad9dad01b15d233cbded3f0693c3c33e21f8d286.1559412149.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559412149.git.linux.dkm@gmail.com>
References: <cover.1559412149.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes CamelCase blnEnableRxFF0Filter by renaming it
to bln_enable_rx_ff0_filter in drv_types.h and related files rtl871x_cmd.c
xmit_linux.c

It was reported by checkpatch.pl

Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h   | 2 +-
 drivers/staging/rtl8712/rtl871x_cmd.c | 2 +-
 drivers/staging/rtl8712/xmit_linux.c  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index ddab6514a549..33caa9477f9f 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -164,7 +164,7 @@ struct _adapter {
 	struct iw_statistics iwstats;
 	int pid; /*process id from UI*/
 	struct work_struct wk_filter_rx_ff0;
-	u8 blnEnableRxFF0Filter;
+	u8 bln_enable_rx_ff0_filter;
 	spinlock_t lockRxFF0Filter;
 	const struct firmware *fw;
 	struct usb_interface *pusb_intf;
diff --git a/drivers/staging/rtl8712/rtl871x_cmd.c b/drivers/staging/rtl8712/rtl871x_cmd.c
index 05a78ac24987..873232d0be9f 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.c
+++ b/drivers/staging/rtl8712/rtl871x_cmd.c
@@ -238,7 +238,7 @@ u8 r8712_sitesurvey_cmd(struct _adapter *padapter,
 	mod_timer(&pmlmepriv->scan_to_timer,
 		  jiffies + msecs_to_jiffies(SCANNING_TIMEOUT));
 	padapter->ledpriv.LedControlHandler(padapter, LED_CTL_SITE_SURVEY);
-	padapter->blnEnableRxFF0Filter = 0;
+	padapter->bln_enable_rx_ff0_filter = 0;
 	return _SUCCESS;
 }
 
diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
index e65a51c7f372..241c0c91122b 100644
--- a/drivers/staging/rtl8712/xmit_linux.c
+++ b/drivers/staging/rtl8712/xmit_linux.c
@@ -103,11 +103,11 @@ void r8712_SetFilter(struct work_struct *work)
 	r8712_write8(padapter, 0x117, newvalue);
 
 	spin_lock_irqsave(&padapter->lockRxFF0Filter, irqL);
-	padapter->blnEnableRxFF0Filter = 1;
+	padapter->bln_enable_rx_ff0_filter = 1;
 	spin_unlock_irqrestore(&padapter->lockRxFF0Filter, irqL);
 	do {
 		msleep(100);
-	} while (padapter->blnEnableRxFF0Filter == 1);
+	} while (padapter->bln_enable_rx_ff0_filter == 1);
 	r8712_write8(padapter, 0x117, oldvalue);
 }
 
-- 
2.19.1

