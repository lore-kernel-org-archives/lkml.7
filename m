Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7BEC31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 00:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9104205ED
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 00:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gpwc7Kmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfFOAN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 20:13:56 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33390 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfFOAN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 20:13:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id c14so1641151plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 17:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cwvlGwWdtc9OXX8XIoL7MJN42O5n/gGoiY+jdBHrLFw=;
        b=Gpwc7KmxcHCFzB0+BYpmatSSOU7v5DgLYvKoU9yxyBCTKLWsdWwMsXpA6CU3aVAWHw
         MRrC6OGFnMvCKMt6MQUZbNfHtkJcMU6u6sKDLukckpBrxszIabf1oquOxs0OFgI3vshv
         sA0gFSN3s8/p8C48Xww5LOD0CiIhFalex48kE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cwvlGwWdtc9OXX8XIoL7MJN42O5n/gGoiY+jdBHrLFw=;
        b=TEwa0wHdRC7xTbycqBQgFWJGxA0Iar5uyo53S+jyuZ2lQZtrz6gCrH/CAKhkxPU/MM
         kUifmiCFsk1ARtVSWdQrWwoNUMQZhNYxtKQs2aj4rX7/8KtunRV70M2Lo7SXiPdUq0bJ
         Dwt77fN9/mnTMhtp98kn3DkpiNJiG+Wr6srSiQ67zImFCL1Vbb5c8xIb2ukw6TFLx2ML
         f5q0+yUWvGpmbc2kLV/KS9Wo8h3mIM/pxSabCUeQW5NKmzoob4Ds0t8Ujb5Cp6cuC7Zj
         aXXpuubaQi7JTo7OH3Nt2954owZPpIPYhW9wUJ/ezoRq3lM0h3LMTqPdV9NuhkoUx7ST
         3AkA==
X-Gm-Message-State: APjAAAXhuIwkCxHXiMc6O1YBWon8Uv2v/plSgr4NUVUK8RCFOxTRvTtv
        XXeaoBTjAUXvw5wtiKTQTo1big==
X-Google-Smtp-Source: APXvYqxV+BuIRTB3LlhOar7SSqrT2kHlsPqCi2rxz45Qk1yjRW+89Ar2AxHb7NqgqTTokTpNzCgspA==
X-Received: by 2002:a17:902:2aab:: with SMTP id j40mr54366678plb.76.1560557635362;
        Fri, 14 Jun 2019 17:13:55 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id n2sm3708253pgp.27.2019.06.14.17.13.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 17:13:54 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ganapathi Bhat <gbhat@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 5.2 1/2] mwifiex: Don't abort on small, spec-compliant vendor IEs
Date:   Fri, 14 Jun 2019 17:13:20 -0700
Message-Id: <20190615001321.241808-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per the 802.11 specification, vendor IEs are (at minimum) only required
to contain an OUI. A type field is also included in ieee80211.h (struct
ieee80211_vendor_ie) but doesn't appear in the specification. The
remaining fields (subtype, version) are a convention used in WMM
headers.

Thus, we should not reject vendor-specific IEs that have only the
minimum length (3 bytes) -- we should skip over them (since we only want
to match longer IEs, that match either WMM or WPA formats). We can
reject elements that don't have the minimum-required 3 byte OUI.

While we're at it, move the non-standard subtype and version fields into
the WMM structs, to avoid this confusion in the future about generic
"vendor header" attributes.

Fixes: 685c9b7750bf ("mwifiex: Abort at too short BSS descriptor element")
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
It appears that commit 685c9b7750bf is on its way to 5.2, so I labeled
this bugfix for 5.2 as well.

 drivers/net/wireless/marvell/mwifiex/fw.h      | 12 +++++++++---
 drivers/net/wireless/marvell/mwifiex/scan.c    | 18 +++++++++++-------
 .../net/wireless/marvell/mwifiex/sta_ioctl.c   |  4 ++--
 drivers/net/wireless/marvell/mwifiex/wmm.c     |  2 +-
 4 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index b73f99dc5a72..1fb76d2f5d3f 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -1759,9 +1759,10 @@ struct mwifiex_ie_types_wmm_queue_status {
 struct ieee_types_vendor_header {
 	u8 element_id;
 	u8 len;
-	u8 oui[4];	/* 0~2: oui, 3: oui_type */
-	u8 oui_subtype;
-	u8 version;
+	struct {
+		u8 oui[3];
+		u8 oui_type;
+	} __packed oui;
 } __packed;
 
 struct ieee_types_wmm_parameter {
@@ -1775,6 +1776,9 @@ struct ieee_types_wmm_parameter {
 	 *   Version     [1]
 	 */
 	struct ieee_types_vendor_header vend_hdr;
+	u8 oui_subtype;
+	u8 version;
+
 	u8 qos_info_bitmap;
 	u8 reserved;
 	struct ieee_types_wmm_ac_parameters ac_params[IEEE80211_NUM_ACS];
@@ -1792,6 +1796,8 @@ struct ieee_types_wmm_info {
 	 *   Version     [1]
 	 */
 	struct ieee_types_vendor_header vend_hdr;
+	u8 oui_subtype;
+	u8 version;
 
 	u8 qos_info_bitmap;
 } __packed;
diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index c269a0de9413..e2786ab612ca 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -1361,21 +1361,25 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 			break;
 
 		case WLAN_EID_VENDOR_SPECIFIC:
-			if (element_len + 2 < sizeof(vendor_ie->vend_hdr))
-				return -EINVAL;
-
 			vendor_ie = (struct ieee_types_vendor_specific *)
 					current_ptr;
 
-			if (!memcmp
-			    (vendor_ie->vend_hdr.oui, wpa_oui,
-			     sizeof(wpa_oui))) {
+			/* 802.11 requires at least 3-byte OUI. */
+			if (element_len < sizeof(vendor_ie->vend_hdr.oui.oui))
+				return -EINVAL;
+
+			/* Not long enough for a match? Skip it. */
+			if (element_len < sizeof(wpa_oui))
+				break;
+
+			if (!memcmp(&vendor_ie->vend_hdr.oui, wpa_oui,
+				    sizeof(wpa_oui))) {
 				bss_entry->bcn_wpa_ie =
 					(struct ieee_types_vendor_specific *)
 					current_ptr;
 				bss_entry->wpa_offset = (u16)
 					(current_ptr - bss_entry->beacon_buf);
-			} else if (!memcmp(vendor_ie->vend_hdr.oui, wmm_oui,
+			} else if (!memcmp(&vendor_ie->vend_hdr.oui, wmm_oui,
 				    sizeof(wmm_oui))) {
 				if (total_ie_len ==
 				    sizeof(struct ieee_types_wmm_parameter) ||
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
index ebc0e41e5d3b..74e50566db1f 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -1351,7 +1351,7 @@ mwifiex_set_gen_ie_helper(struct mwifiex_private *priv, u8 *ie_data_ptr,
 			/* Test to see if it is a WPA IE, if not, then
 			 * it is a gen IE
 			 */
-			if (!memcmp(pvendor_ie->oui, wpa_oui,
+			if (!memcmp(&pvendor_ie->oui, wpa_oui,
 				    sizeof(wpa_oui))) {
 				/* IE is a WPA/WPA2 IE so call set_wpa function
 				 */
@@ -1361,7 +1361,7 @@ mwifiex_set_gen_ie_helper(struct mwifiex_private *priv, u8 *ie_data_ptr,
 				goto next_ie;
 			}
 
-			if (!memcmp(pvendor_ie->oui, wps_oui,
+			if (!memcmp(&pvendor_ie->oui, wps_oui,
 				    sizeof(wps_oui))) {
 				/* Test to see if it is a WPS IE,
 				 * if so, enable wps session flag
diff --git a/drivers/net/wireless/marvell/mwifiex/wmm.c b/drivers/net/wireless/marvell/mwifiex/wmm.c
index 407b9932ca4d..64916ba15df5 100644
--- a/drivers/net/wireless/marvell/mwifiex/wmm.c
+++ b/drivers/net/wireless/marvell/mwifiex/wmm.c
@@ -240,7 +240,7 @@ mwifiex_wmm_setup_queue_priorities(struct mwifiex_private *priv,
 	mwifiex_dbg(priv->adapter, INFO,
 		    "info: WMM Parameter IE: version=%d,\t"
 		    "qos_info Parameter Set Count=%d, Reserved=%#x\n",
-		    wmm_ie->vend_hdr.version, wmm_ie->qos_info_bitmap &
+		    wmm_ie->version, wmm_ie->qos_info_bitmap &
 		    IEEE80211_WMM_IE_AP_QOSINFO_PARAM_SET_CNT_MASK,
 		    wmm_ie->reserved);
 
-- 
2.22.0.410.gd8fdbe21b5-goog

