Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03156CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69B62166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdgmUpti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392637AbfJXP7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:59:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46637 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389313AbfJXP7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:59:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id n15so15905741wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 08:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qS1KbH+p9OlpOqB7da3kENa3GN4JhCMKjz4FoW9W5QY=;
        b=FdgmUptiBhTgkUvBTVUjRqWgTHhl29rHtBcRHxIYViGaNOkDFZQ4Nhi5xQeU676eC4
         ga8uwv++NtNpAV7hKRtxkvWMF7hLvVLaMRAmgB4AWksXfvzOV1qqzD+hu60JckVBJSv1
         RATMY92a4CDAua1oA19A74kL6QJ94uyQNtBCQc4Gzah5z3i0kWXStXHZCzay/8+f88Fo
         EZ0iukrfOFwNDBi8QZh8ApwWjEvlALUr0lSNdjovFtexa2DCrybOWi7rj+IfO141CvQX
         7zbNZrzSUlkoMaPJqqVkPop7NAxPGFjnqfW3qKVRD+n32Z1i5HrD1fJDhaijhaVa3mco
         GnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qS1KbH+p9OlpOqB7da3kENa3GN4JhCMKjz4FoW9W5QY=;
        b=bt982N4lIWRl3G1MeR7FFzxL+MBkmvJbQ9f5B7IJrqQ2dDimKUEp8MseX7aIQ32vGb
         zQkN75cKZIrRpS04kr1cc8nvzD2MSru78OMQFfIGataAw12o631WEwEWudhUFCGOEwG7
         K8rMxeqWykkYf+FJM2VgBgcpXo5r1b/pv/HFZIcBXZ8aGuuf+1VVYGcxRUwWEhdyAc1/
         ek2Don16NhjuWY39YYBy+VsQDjvqpW5YWD6fvaufFwmt0rkT91JyuxaMtjHpexoE3T17
         LAyPw+RTaSoxZmGu7hvLbmkEBmhKjkqMQuO1WjFYfCSBhbLNPcmD1st8Uvq9cVtIEje+
         qXdw==
X-Gm-Message-State: APjAAAU6FmAEnSpvDyDvj5jEb7sQHndPj+zYrbYjqgV1hgqYHcfnDrpp
        Cj9nnUr+XdVVbuPrIqI2EpY=
X-Google-Smtp-Source: APXvYqwY4EDnyuX7k0+Hh8zPrdqNYeCWjoTg6QLnKs7oBpy71VyRLqwEN+ZHrWAxNArgPvmhGCTaFQ==
X-Received: by 2002:a5d:640e:: with SMTP id z14mr4451615wru.311.1571932771504;
        Thu, 24 Oct 2019 08:59:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id g5sm3472142wmg.12.2019.10.24.08.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:59:30 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove code valid only for 5 GHz
Date:   Thu, 24 Oct 2019 17:59:18 +0200
Message-Id: <20191024155918.13399-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove code valid only for 5 GHz, according to the TODO.

- find and remove remaining code valid only for 5 GHz. Most of the obvious
  ones have been removed, but things like channel > 14 still exist.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c       | 12 ++------
 .../staging/rtl8188eu/os_dep/ioctl_linux.c    | 30 +++++--------------
 2 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index 9aa44c921aca..88e42cc1d837 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -440,15 +440,9 @@ static void update_bmc_sta(struct adapter *padapter)
 				tx_ra_bitmap |= rtw_get_bit_value_from_ieee_value(psta->bssrateset[i] & 0x7f);
 		}
 
-		if (pcur_network->Configuration.DSConfig > 14) {
-			/* force to A mode. 5G doesn't support CCK rates */
-			network_type = WIRELESS_11A;
-			tx_ra_bitmap = 0x150; /*  6, 12, 24 Mbps */
-		} else {
-			/* force to b mode */
-			network_type = WIRELESS_11B;
-			tx_ra_bitmap = 0xf;
-		}
+		/* force to b mode */
+		network_type = WIRELESS_11B;
+		tx_ra_bitmap = 0xf;
 
 		raid = networktype_to_raid(network_type);
 		init_rate = get_highest_rate_idx(tx_ra_bitmap & 0x0fffffff) & 0x3f;
diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index ec5835d1aa8c..710c33fd4965 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -148,17 +148,10 @@ static char *translate_scan(struct adapter *padapter,
 		else
 			snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11bg");
 	} else {
-		if (pnetwork->network.Configuration.DSConfig > 14) {
-			if (ht_cap)
-				snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11an");
-			else
-				snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11a");
-		} else {
-			if (ht_cap)
-				snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11gn");
-			else
-				snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11g");
-		}
+		if (ht_cap)
+			snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11gn");
+		else
+			snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11g");
 	}
 
 	start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_CHAR_LEN);
@@ -650,17 +643,10 @@ static int rtw_wx_get_name(struct net_device *dev,
 			else
 				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11bg");
 		} else {
-			if (pcur_bss->Configuration.DSConfig > 14) {
-				if (ht_cap)
-					snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11an");
-				else
-					snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11a");
-			} else {
-				if (ht_cap)
-					snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11gn");
-				else
-					snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11g");
-			}
+			if (ht_cap)
+				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11gn");
+			else
+				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11g");
 		}
 	} else {
 		snprintf(wrqu->name, IFNAMSIZ, "unassociated");
-- 
2.23.0

