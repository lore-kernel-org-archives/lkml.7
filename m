Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECE7CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 12:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C4920863
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 12:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Alqdrmod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfJZML6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 08:11:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55889 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfJZML4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 08:11:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id g24so4839528wmh.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 05:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ROdiUFie8VPool1pzj4M8/NsYOT7cWJYujn+QRdPF48=;
        b=AlqdrmodfB2rBN9q1tTZv458MN/RslIaLRXFeOeGkRMKbPPh8TtPe0WKzfbkx4+iwM
         f0u6I85jzwSn9dvT5uR2vB7b2BHORpvqGVKyc9+rSjipxzxzFYHQ4zGUHDTQ6cfW5I2Z
         xfpP72Ue4kAkYBTarXmu2HAcGCx2pDOiN25WDcX+jAasFbhpqgO0A+en5B9PV/YWMPzW
         A9e2QQw4bR9T+3cKAamNJtFUKSzquHuX/gyN6sQ/rw4ZcHDzzitvF2rXYZmYMLNnvDOl
         4z841TP/fVrCLDaQ0SkaDmCl50k2V2pfzwaU4Pf7k9Z89Jxr7dTajxMOKeKvfdm5Abd0
         Z10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ROdiUFie8VPool1pzj4M8/NsYOT7cWJYujn+QRdPF48=;
        b=ZG8jgNm9a1kvnF24ClbwrutdlQ32NOKwBOQWqNyzXOtcmWa2GrGTm6gmue+gT+DDQC
         8RmxjNg309p9GP2oIIztAkPuifN5/eVr1GlEJWkIc7fKCP7YDGEnalclaIhITucGs/+f
         vg+lttor052xoQYIrI2dhfye2OgNNtDJ8YwF/D+uLMf9dqgqiyoLOv+q7SzbWlyOfvXd
         iupghZ4gzUUDE6ZmCi3V1EAdCdRGWZNBHhQ9NObgPH0FCVEhprV+o8y7Z7tuLmp2RDUg
         l74eTDMMLEWz0HmpltT8k+9lzQB+s49yiutkk+DuskxnZJdrslk02Erg1UU8GJtqyZhN
         Tycw==
X-Gm-Message-State: APjAAAUrQlUxxuWqZUTxd0Rhy5T+jciSH+u6OugtjCZQslEXLGdYU3oY
        NWfywnI0TmN9NUPvV0ycgcE=
X-Google-Smtp-Source: APXvYqxeTooQKZiEc2mBWfb+OQCbQqxGnXpC/cxWfdn7perNeBGaeYaAKOlietK+Z7Q0Lr9voDLU7Q==
X-Received: by 2002:a05:600c:2487:: with SMTP id 7mr7812955wms.164.1572091914530;
        Sat, 26 Oct 2019 05:11:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id v8sm5789906wra.79.2019.10.26.05.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2019 05:11:54 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/7] staging: rtl8188eu: convert rtw_access_ctrl to return bool
Date:   Sat, 26 Oct 2019 14:11:32 +0200
Message-Id: <20191026121135.181897-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191026121135.181897-1-straube.linux@gmail.com>
References: <20191026121135.181897-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_access_ctrl returns boolean values, so change the return
type to bool. Also convert the local variables that are used for the
return value from u8 to bool.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c | 6 +++---
 drivers/staging/rtl8188eu/include/sta_info.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
index 157ae2f355ff..282c835a635c 100644
--- a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
@@ -476,13 +476,13 @@ struct sta_info *rtw_get_bcmc_stainfo(struct adapter *padapter)
 	return rtw_get_stainfo(pstapriv, bc_addr);
 }
 
-u8 rtw_access_ctrl(struct adapter *padapter, u8 *mac_addr)
+bool rtw_access_ctrl(struct adapter *padapter, u8 *mac_addr)
 {
-	u8 res = true;
+	bool res = true;
 #ifdef CONFIG_88EU_AP_MODE
 	struct list_head *plist, *phead;
 	struct rtw_wlan_acl_node *paclnode;
-	u8 match = false;
+	bool match = false;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
 	struct __queue *pacl_node_q = &pacl_list->acl_node_q;
diff --git a/drivers/staging/rtl8188eu/include/sta_info.h b/drivers/staging/rtl8188eu/include/sta_info.h
index dc685a14aeb8..6165adafc451 100644
--- a/drivers/staging/rtl8188eu/include/sta_info.h
+++ b/drivers/staging/rtl8188eu/include/sta_info.h
@@ -354,6 +354,6 @@ void rtw_free_all_stainfo(struct adapter *adapt);
 struct sta_info *rtw_get_stainfo(struct sta_priv *stapriv, u8 *hwaddr);
 u32 rtw_init_bcmc_stainfo(struct adapter *adapt);
 struct sta_info *rtw_get_bcmc_stainfo(struct adapter *padapter);
-u8 rtw_access_ctrl(struct adapter *padapter, u8 *mac_addr);
+bool rtw_access_ctrl(struct adapter *padapter, u8 *mac_addr);
 
 #endif /* _STA_INFO_H_ */
-- 
2.23.0

