Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7E2C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 00:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91ECE21479
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 00:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MworLe62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfFSAiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 20:38:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38955 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfFSAiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 20:38:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id 196so8600459pgc.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 17:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Bl4ZB5AKo3Ojo0KbLAkYeawsDDC/1j35REkKvkzHQM0=;
        b=MworLe621CZHwckohZ2C4nmq/YIMa1LI0E8FN1pI8fMmJvLNo2DEEveri1heBM/hJD
         1K4CKSNqVayTjkso6YQDeD1CoHCb1XzRVnDnSGnd5Dd8sWiuNyzVoFJ3qX4L1QVVZqG1
         kWDD5BhDR3uD/zaa2hOgqsSodTpCy8rEYwq+t6XqfHYtIfZAK5huEGB2xXYHQtTvf62A
         E9sbtnjpUwh6L7xQ/vMWeWlhvevL/NYGQZG9di0qdtGPk5ZU9GUnhD+kUCjut+knshN9
         fw243ECi61MReDKY83ml3sDWoU9d7KafH5MxYrsHPjXHusm2ogVg90ddhWyezegqm2p0
         aoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Bl4ZB5AKo3Ojo0KbLAkYeawsDDC/1j35REkKvkzHQM0=;
        b=sURbd6jK5eMT2Zl2ZtTnm3Yu611hwrygr1KgGyBcToKeB+1KNS96Uyy52P+0KOktwQ
         lkaRrbMR9mJRX6XK9PdCViJ1jT9RF1r6DWoMHm6hy99iKtKxhn/tuwVUK5o3lnSNb/CR
         y5mAw+DRQqS2tc/Z8U9XNp/sKqce63geBw+u5327cWyz9Yr8EkVhf0JEG88Yc/hPEPoU
         CuD6wEQLfca6f6/5BYdw0FNGMsayPtRfUcMLG8Z/TYVtOlTCu4E9zcUrb7SV0ua/ZpJo
         f7YKYNhTM7NBhiRm8bMqvzd1unvVQpQAsstEZtTxHjbvzVadlLmZwSC/6b9eTlpxEP7+
         7yTw==
X-Gm-Message-State: APjAAAX8D/Fr2p9VwU8IDke4NKVJ/Ukb5kJ8/0Qm7KWIKJY+CrFCUHZZ
        abH2JWC2CjOwFFQ87BhRotY=
X-Google-Smtp-Source: APXvYqxdQXfcEw5nDEvmxOBSuO3mvsAjfKKWbCMNtwtt2e0y4vACYU+tMrqg8cgMJN4pLqXNzSZcfQ==
X-Received: by 2002:a63:1658:: with SMTP id 24mr4422453pgw.167.1560904696454;
        Tue, 18 Jun 2019 17:38:16 -0700 (PDT)
Received: from localhost.localdomain (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id x26sm14217860pfq.69.2019.06.18.17.38.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Jun 2019 17:38:16 -0700 (PDT)
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Joe Perches <joe@perches.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Shobhit Kukreti <shobhitkukreti@gmail.com>
Subject: [PATCH v4 3/3] staging: rtl8723bs: Fix Indentation Error: code indent should use tabs where possible
Date:   Tue, 18 Jun 2019 17:37:34 -0700
Message-Id: <e111358b9aca77380a9d93f11e971079600869a3.1560903975.git.shobhitkukreti@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560903975.git.shobhitkukreti@gmail.com>
References: <20190618070019.GA20601@kroah.com>
 <cover.1560903975.git.shobhitkukreti@gmail.com>
In-Reply-To: <cover.1560903975.git.shobhitkukreti@gmail.com>
References: <cover.1560903975.git.shobhitkukreti@gmail.com>
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
index 746f074..643cacc 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -202,9 +202,9 @@ void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup)
 
 	memset(&ev, 0x00, sizeof(ev));
 	if (bgroup) {
-	    ev.flags |= IW_MICFAILURE_GROUP;
+		ev.flags |= IW_MICFAILURE_GROUP;
 	} else {
-	    ev.flags |= IW_MICFAILURE_PAIRWISE;
+		ev.flags |= IW_MICFAILURE_PAIRWISE;
 	}
 
 	ev.src_addr.sa_family = ARPHRD_ETHER;
@@ -297,7 +297,7 @@ int rtw_recv_indicatepkt(struct adapter *padapter, union recv_frame *precv_frame
 
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

