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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B385BCA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 12:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F41520863
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 12:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkRz5TS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfJZMLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 08:11:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44246 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfJZMLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 08:11:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id z11so5140757wro.11
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 05:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wlIbY6qWygm8S+/7/rhkO5IYEXU3HNNCNBVMVh8yCIg=;
        b=QkRz5TS+iFvdmdL9sc6n1xAKsruuwESTowZ3YOng6vNzBeGUCxtdG9ZD1o/nLWBi1F
         XzwYmeAtVbEWNdP13i9fCTMDU9AmpypPofoC5yYQtleVGLYLAsNz0yzGaZE/k2cWEAHe
         VI/dxAyAfql6ZsxEHjzGSoxKusK5p+tpCkW/+pAlpnbxZnF/6GHuQvqJZEHJf2GxsfJJ
         TIvgcSaEbFixcMwQTzPrmktGoUHtBrNR26O0ezgcyLLrl9BqYB8iro1TrEVgEl1TiNRn
         AyoFDrzsJVlo9VLXTkS9gqnXYt7fqyVs0hlwuz3QoNvqnDzk9RWfOS8yVxsTis73wKdN
         Hz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wlIbY6qWygm8S+/7/rhkO5IYEXU3HNNCNBVMVh8yCIg=;
        b=f5bvXQMiAAx88UO9ho38d+MGltqJK17KRNvLlm59RShnr3KnH0+1CS7wrXFwOxeDH0
         DvmsupDexNXgHxGKF/0dCxzya3vD9k6/39LYvl9CCqmukO5JBE8WfRph/j1Xzd3pqoAF
         m1MNnV3KTMFtF6bM09R9pg+zOmPZZkVfu/F4BL6gNZPuII3DCpnXQvbSDcGK2P3zj6Ni
         KiwdGFtZiei8ETeK00wrOz1wRaNLRcNFiMKwuo7PdkeTBk9qfJloArKEZvvgEjWH3QRG
         CJWbhlw13PikjueBtOYFBWihxFTVD8mFN4C79Sr0I+oIx4HToFOGA9oACOZagyOKpowl
         2UZw==
X-Gm-Message-State: APjAAAUEeY1vekCgohQ1WAnQT6pQCSz+rlKgckxHvkRF1D7XIp7E+5CR
        VS2ZQCgYmDREWP2cGXXNb96pSf1d
X-Google-Smtp-Source: APXvYqxuZDSI7upYqoj7hx/zA0PUVltdu969pgZg2g35ChqNdRhbXhQ1UyaBC9aHvldnmchGah3vgg==
X-Received: by 2002:adf:e488:: with SMTP id i8mr7185919wrm.302.1572091911725;
        Sat, 26 Oct 2019 05:11:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id v8sm5789906wra.79.2019.10.26.05.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2019 05:11:50 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/7] staging: rtl8188eu: cleanup comments in rtw_sta_mgt.c
Date:   Sat, 26 Oct 2019 14:11:29 +0200
Message-Id: <20191026121135.181897-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup comments in rtw_sta_mgt.c to use kernel block comment style
and not exceed 80 characters line length.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
index 91a30142c567..cbe970979eb0 100644
--- a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
@@ -199,10 +199,13 @@ struct sta_info *rtw_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 		pstapriv->asoc_sta_count++;
 		spin_unlock_bh(&pstapriv->sta_hash_lock);
 
-/*  Commented by Albert 2009/08/13 */
-/*  For the SMC router, the sequence number of first packet of WPS handshake will be 0. */
-/*  In this case, this packet will be dropped by recv_decache function if we use the 0x00 as the default value for tid_rxseq variable. */
-/*  So, we initialize the tid_rxseq variable as the 0xffff. */
+		/* Commented by Albert 2009/08/13
+		 * For the SMC router, the sequence number of first packet of
+		 * WPS handshake will be 0. In this case, this packet will be
+		 * dropped by recv_decache function if we use the 0x00 as the
+		 * default value for tid_rxseq variable. So, we initialize the
+		 * tid_rxseq variable as the 0xffff.
+		 */
 
 		for (i = 0; i < 16; i++)
 			memcpy(&psta->sta_recvpriv.rxcache.tid_rxseq[i], &wRxSeqInitialValue, 2);
@@ -296,7 +299,9 @@ u32 rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 
 	del_timer_sync(&psta->addba_retry_timer);
 
-	/* for A-MPDU Rx reordering buffer control, cancel reordering_ctrl_timer */
+	/* for A-MPDU Rx reordering buffer control, cancel
+	 * reordering_ctrl_timer
+	 */
 	for (i = 0; i < 16; i++) {
 		struct list_head *phead, *plist;
 		struct recv_frame *prframe;
-- 
2.23.0

