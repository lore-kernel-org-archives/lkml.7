Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18546C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E24222CC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfoxsbTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfIZSAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 14:00:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39306 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfIZSAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 14:00:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id v17so3522914wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 11:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yt1IsVUKjYQaKm/AvxEUk4/OIGKh6xPQUX0IWIVIWz4=;
        b=MfoxsbTOd7CE7lu/tBKmqAxmmPLffab11eVdUuD21vTZLiwGkFoZJVPvU5/SXB9D0w
         o+zEzQLqEHOXW4XmzDuAhdH0zRo/w3D5238gENnU8fsuSSkMZzROM/VF5V5qDdjIVUgq
         fWBsfP2YfN3Egm/Mnfnn79mWLWmqYf4TYsGfcF4Dz1hWtkNntmjB5avWTiMONI1fM/iv
         LjuxW0T2SbpHPZYgD+YQt1WtMqI8POPoEWAmahoRVx+vROUfgt5UhaxIH1TxLPc/AMdo
         pNngM+DHGIuESDAW6dBuUAIh9vb9aIOwZohQZ3FaHNLn5VuL3pElt1lwiae3QJ6AVZpf
         FF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yt1IsVUKjYQaKm/AvxEUk4/OIGKh6xPQUX0IWIVIWz4=;
        b=mhK39uxYqMiqkzBi5UIU5Oqbn3IjGUpbA8emz2W52p1ITCT+2PxG3alTMqmhTthG87
         IFRgS/XanoTg1S7YR7mqvp3hKs7pLzm+RdrvLSlbMbsTWnZxekt1C+CGdu166QDBb+UR
         nvTamIOUSruU+k0UCKXY0U4T0muN2xuTJP6PLhX/Wo3MPwYusZ4b1QpV510xPjv9mRVW
         d5+wvMg7EAVhuwnxwGzmLzomTly5l2qOV7VLSPNq3nmRoL9leZLucd4WGhG3zogqQQ9C
         nQtYm9cvDAyb1l7mIjqs4CnOk4NmKjyz1x4A4jGd5olrD+3hxeGGP5F67unipeWxsOaC
         L1TQ==
X-Gm-Message-State: APjAAAWs8e5aWzeb+wj+Jgg+yDWxg5fxA4tCXuctVd+Kh+x6H4d6qXdp
        P/np2OMJ1eTmsbHpf7cyCDkh4Okf
X-Google-Smtp-Source: APXvYqy98BN/fP0M1TwKem39Ec84DDIrutllK92T6sDfFbkX94gmpqbHy+NL9lOY4PqnHLoCLA1TKg==
X-Received: by 2002:a1c:c5c3:: with SMTP id v186mr3959754wmf.125.1569520822037;
        Thu, 26 Sep 2019 11:00:22 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id p7sm4458308wma.34.2019.09.26.11.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 11:00:21 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: remove unused function write_cam_from_cache
Date:   Thu, 26 Sep 2019 19:59:33 +0200
Message-Id: <20190926175933.44967-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function write_cam_from_cache in rtw_wlan_util.c is never used,
so remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c   | 13 -------------
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h |  1 -
 2 files changed, 14 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 5ab98f3e722e..3933e8637e57 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -606,19 +606,6 @@ inline void clear_cam_entry(struct adapter *adapter, u8 id)
 	clear_cam_cache(adapter, id);
 }
 
-inline void write_cam_from_cache(struct adapter *adapter, u8 id)
-{
-	struct dvobj_priv *dvobj = adapter_to_dvobj(adapter);
-	struct cam_ctl_t *cam_ctl = &dvobj->cam_ctl;
-	struct cam_entry_cache cache;
-
-	spin_lock_bh(&cam_ctl->lock);
-	memcpy(&cache, &dvobj->cam_cache[id], sizeof(struct cam_entry_cache));
-	spin_unlock_bh(&cam_ctl->lock);
-
-	_write_cam(adapter, id, cache.ctrl, cache.mac, cache.key);
-}
-
 void write_cam_cache(struct adapter *adapter, u8 id, u16 ctrl, u8 *mac, u8 *key)
 {
 	struct dvobj_priv *dvobj = adapter_to_dvobj(adapter);
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index fd3cf955c9f8..73e8ec09b6e1 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -576,7 +576,6 @@ void read_cam(struct adapter *padapter , u8 entry, u8 *get_key);
 /* modify HW only */
 void _write_cam(struct adapter *padapter, u8 entry, u16 ctrl, u8 *mac, u8 *key);
 void _clear_cam_entry(struct adapter *padapter, u8 entry);
-void write_cam_from_cache(struct adapter *adapter, u8 id);
 
 /* modify both HW and cache */
 void write_cam(struct adapter *padapter, u8 id, u16 ctrl, u8 *mac, u8 *key);
-- 
2.23.0

