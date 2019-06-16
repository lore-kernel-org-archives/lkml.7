Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E351BC31E54
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 16:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5782063F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 16:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PG/InyAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfFPQUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 12:20:32 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34877 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfFPQUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 12:20:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id p1so3070428plo.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 09:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Au6/WyDNACQkvCtxbinZw6P6/1CJJirTWVuy4x6hlXM=;
        b=PG/InyAlymO5kMZLxjuKB2Evn/4/c57Jkw6JwTBkacRYyQihPP2fDhrPxBvznIu7lh
         RhRgAJrQzxcSLtu74AHxweDgNR6Wvxxb8j2Rlxp44+bHPHqkcQ/Xzrr1rDIdZtJv3D2q
         pNQrb4xhVhze2LhAyYtUZ4pbNjYLj7iVuWHVt3OHEgWLQvUntgcvS0Ug9SdeHHZlhR53
         W0325oRl+TdB9OnsmcnyapSzsLwVphDtydXNvwgzm0jNgod9EwbXyd6ZICXL2DqxSze9
         3MQxPOFTah0erY64gnznveq/L8rYJHIJrM8nw/Zes0QkZ5Uyaaju+IDFaX9i/1RsfGvU
         KflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Au6/WyDNACQkvCtxbinZw6P6/1CJJirTWVuy4x6hlXM=;
        b=L4Icn5OMjacFrnj7dArd5LUENpC7qqRSXdPvdYAHyE29pvIYqXPI/vVti+hg/q5yiX
         KlVBzRp8RxNO1HVrzCj2VEhBx6p7Pzp8gotuPWEjeDDnXt+ntXf9GSdoibQNVI2oHUbr
         zHNqjPrPdeClzntEOhwlRPvA37RCUWeubyr6U80p8K5XUvhcM6bHU0dVlg2M4TavkzDc
         jhLrruyYVyF7xBmxkUkhWG89g1cifBwoH4XFCn+TtpWiOCXpEEHoRkKbI8rx6ihoBfqs
         2KkBDK5n7YAk5CjemltOnb6VYh7zpU5HlBpQl+aiNg6PDYQ2mr+5gi4ZnIMyA058hiNl
         11Ow==
X-Gm-Message-State: APjAAAU8BO6458578ON6M+owsJ4S3vO+xHzwDcNvweTRwd8y4CH6QneB
        u4hdSt+jZ3lquZ7eJRUjGk4=
X-Google-Smtp-Source: APXvYqzYoz33MPMA3GnzvCwSZ6ixIJmW31EWi1E0OZogVdT6unKCNeC/Q9hUcXP8GcV7WkGWOgqWXQ==
X-Received: by 2002:a17:902:ba82:: with SMTP id k2mr96966428pls.323.1560702030707;
        Sun, 16 Jun 2019 09:20:30 -0700 (PDT)
Received: from localhost.localdomain (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id 8sm1687908pgc.13.2019.06.16.09.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Jun 2019 09:20:30 -0700 (PDT)
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Shobhit Kukreti <shobhitkukreti@gmail.com>
Subject: [PATCH v3 3/3] staging: rtl8723bs: Fix Indentation Error: code indent should use tabs where possible
Date:   Sun, 16 Jun 2019 09:19:51 -0700
Message-Id: <e362a922ef94022563ec3821a45c95d20d1c0b10.1560701271.git.shobhitkukreti@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560701271.git.shobhitkukreti@gmail.com>
References: <20190616131145.GA30779@t-1000>
 <cover.1560701271.git.shobhitkukreti@gmail.com>
In-Reply-To: <cover.1560701271.git.shobhitkukreti@gmail.com>
References: <cover.1560701271.git.shobhitkukreti@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolve indentation errors which were caused by a mix of space and tabs
for indentation. Previous patch to fix if-else brace styles revealed
the indentation error

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/recv_linux.c |  6 ++---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c  | 36 +++++++++++++--------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index aab0195..8695127 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -203,9 +203,9 @@ void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup)
 
 	memset(&ev, 0x00, sizeof(ev));
 	if (bgroup) {
-	    ev.flags |= IW_MICFAILURE_GROUP;
+		ev.flags |= IW_MICFAILURE_GROUP;
 	} else {
-	    ev.flags |= IW_MICFAILURE_PAIRWISE;
+		ev.flags |= IW_MICFAILURE_PAIRWISE;
 	}
 
 	ev.src_addr.sa_family = ARPHRD_ETHER;
@@ -298,7 +298,7 @@ int rtw_recv_indicatepkt(struct adapter *padapter, union recv_frame *precv_frame
 
 	RT_TRACE(_module_recv_osdep_c_, _drv_info_, ("\n rtw_recv_indicatepkt :after rtw_os_recv_indicate_pkt!!!!\n"));
 
-        return _SUCCESS;
+	return _SUCCESS;
 
 _recv_indicatepkt_drop:
 
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 9c408d9..540a7ee 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -100,26 +100,26 @@ static int sdio_alloc_irq(struct dvobj_priv *dvobj)
 
 static void sdio_free_irq(struct dvobj_priv *dvobj)
 {
-    struct sdio_data *psdio_data;
-    struct sdio_func *func;
-    int err;
-
-    if (dvobj->irq_alloc) {
-        psdio_data = &dvobj->intf_data;
-        func = psdio_data->func;
-
-        if (func) {
-            sdio_claim_host(func);
-            err = sdio_release_irq(func);
-            if (err) {
+	struct sdio_data *psdio_data;
+	struct sdio_func *func;
+	int err;
+
+	if (dvobj->irq_alloc) {
+		psdio_data = &dvobj->intf_data;
+		func = psdio_data->func;
+
+		if (func) {
+			sdio_claim_host(func);
+			err = sdio_release_irq(func);
+			if (err) {
 				dvobj->drv_dbg.dbg_sdio_free_irq_error_cnt++;
 				DBG_871X_LEVEL(_drv_err_,"%s: sdio_release_irq FAIL(%d)!\n", __func__, err);
-            } else
-		dvobj->drv_dbg.dbg_sdio_free_irq_cnt++;
-            sdio_release_host(func);
-        }
-        dvobj->irq_alloc = 0;
-    }
+			} else
+				dvobj->drv_dbg.dbg_sdio_free_irq_cnt++;
+			sdio_release_host(func);
+		}
+		dvobj->irq_alloc = 0;
+	}
 }
 
 #ifdef CONFIG_GPIO_WAKEUP
-- 
2.7.4

