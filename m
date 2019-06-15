Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43DBC31E51
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 00:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C310205ED
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 00:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dsc/F7g2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfFOAOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 20:14:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46860 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfFOAN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 20:13:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id v9so2378773pgr.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 17:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z8Sr3wwef/63KELNe4jUJaKB5wCZ2YTUwefjWC3YKWA=;
        b=dsc/F7g2uIm7KIaNWINoPbXEKXEF+qrsta0rCrMTJ3HTQAlFdVy7t6i557mgCbrynO
         ufA2pqxjJyc1/F2fpZKpMkbKNlUj95WoPq95c2aPaODVcYcqEvjlT/2CMntRk6FrXUYr
         kbNBP8McMPLivkpcZdP7OZfk3Eq78x3UCzDL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z8Sr3wwef/63KELNe4jUJaKB5wCZ2YTUwefjWC3YKWA=;
        b=t9v7ZpslPuOOj9tzhDM1OEBomAzil0UQP1EQD16sFJLJJR5MnWqjucUqRtST1sFISI
         Qmq9iNb59liolEemtr46TFedTJa0PhW07TZQ8p1Yu9pGZWTCrzrGR7vldvOEsc37N7oJ
         AGU/Yh7uS/8oFNnuprxyxAcXF5akuGQ+3QNNg08EpWXnH7FzaUqkSjCDvX27CjpQ0Y3O
         cUyinqS20GwZl5RUilCjIoBPYP2HauDqHT/0KT37RQpiXVtmJrXsxOoQa/yV07mTihsl
         KE9V7pHS3TPROjFtpumffI82NAMt9+2liHGQq6bJJ2HVsa86yzKeBNlUUjML7EaTTaqe
         8Jdg==
X-Gm-Message-State: APjAAAUZX5ksuzRJoVBhP0jaQiHUqZ/4EF3U5po1aXQNp5XXKcAfKrrO
        KOdlb5enfpTD+dPNrYuC/tNtLw==
X-Google-Smtp-Source: APXvYqx99nlTn0yxCc0/LUOCwLtM405Jzo+91yDOaKTrB2/qezmNV06q9avSDDvLHEMrmliA60WlkA==
X-Received: by 2002:a17:90a:b908:: with SMTP id p8mr13640504pjr.94.1560557636959;
        Fri, 14 Jun 2019 17:13:56 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id n2sm3708253pgp.27.2019.06.14.17.13.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 17:13:56 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ganapathi Bhat <gbhat@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/2] mwifiex: use 'total_ie_len' in mwifiex_update_bss_desc_with_ie()
Date:   Fri, 14 Jun 2019 17:13:21 -0700
Message-Id: <20190615001321.241808-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190615001321.241808-1-briannorris@chromium.org>
References: <20190615001321.241808-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is clearer than copy/pasting the magic number '+ 2' around, and it
even saves the need for one existing comment.

Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/marvell/mwifiex/scan.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index e2786ab612ca..707e5159262f 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -1269,7 +1269,7 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 			break;
 
 		case WLAN_EID_FH_PARAMS:
-			if (element_len + 2 < sizeof(*fh_param_set))
+			if (total_ie_len < sizeof(*fh_param_set))
 				return -EINVAL;
 			fh_param_set =
 				(struct ieee_types_fh_param_set *) current_ptr;
@@ -1279,7 +1279,7 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 			break;
 
 		case WLAN_EID_DS_PARAMS:
-			if (element_len + 2 < sizeof(*ds_param_set))
+			if (total_ie_len < sizeof(*ds_param_set))
 				return -EINVAL;
 			ds_param_set =
 				(struct ieee_types_ds_param_set *) current_ptr;
@@ -1292,7 +1292,7 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 			break;
 
 		case WLAN_EID_CF_PARAMS:
-			if (element_len + 2 < sizeof(*cf_param_set))
+			if (total_ie_len < sizeof(*cf_param_set))
 				return -EINVAL;
 			cf_param_set =
 				(struct ieee_types_cf_param_set *) current_ptr;
@@ -1302,7 +1302,7 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 			break;
 
 		case WLAN_EID_IBSS_PARAMS:
-			if (element_len + 2 < sizeof(*ibss_param_set))
+			if (total_ie_len < sizeof(*ibss_param_set))
 				return -EINVAL;
 			ibss_param_set =
 				(struct ieee_types_ibss_param_set *)
@@ -1459,10 +1459,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 			break;
 		}
 
-		current_ptr += element_len + 2;
-
-		/* Need to account for IE ID and IE Len */
-		bytes_left -= (element_len + 2);
+		current_ptr += total_ie_len;
+		bytes_left -= total_ie_len;
 
 	}	/* while (bytes_left > 2) */
 	return ret;
-- 
2.22.0.410.gd8fdbe21b5-goog

