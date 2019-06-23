Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01785C48BE8
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 18:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D261120840
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 18:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMjq9R2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfFWSAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 14:00:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40215 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfFWSAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 14:00:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so11405902wre.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 11:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XwY7oF1s2rpAVXJCsz1ECdo2yKOBz2vGMZwE6GybNDE=;
        b=gMjq9R2MKHHjqs9OKYS0aCOUV2sFpbrVHbG6pbzBSiKU8V67PGWeXT+ZlQui40ad7G
         XN2U/tRPSQL99FaRbzn7v5nuOHgZTiMo2i0dMh1yMXNlXtNTezlwsE3TLESbm4Og2yOc
         5LA4Qvfve8ePOBiDAB4vYchm2DuMaQCbLWjabU//ZMrhJaejGMC+BW1elZPSqU14w4oR
         r4cVajtTSR325If+3rHI6joP4u8Cs7wVnHeN277pp+ltMnWTiYaOXNQlDU/DuZWh6b4e
         BPMcqYLQb2JhJ4y+Wr5rokm5QaC2Fi1DsB65tsjGcfPCTGqBBH7udxSc6QlkoUuTIjyi
         zsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XwY7oF1s2rpAVXJCsz1ECdo2yKOBz2vGMZwE6GybNDE=;
        b=XiljCoUvQ80/0UeVOB/KrMM3DRS4MEi+Yfe4oVazdUQyzHC9wqMqGt8E88PHB3mUyO
         k+4BfckEpWhQuDG4Sq8KVDg/Rj/QAtTUvG/M69NgUmpeBnIP9mB5sWEAj9/bhiR7nJ5r
         iyAX2L35mbVmZkEhnTgU6n58kztukm7KqCGO5zkSQQPDcG8/sfLKTrK4qWSG7cd592jT
         p+9yk2t9OtlL9WYhajuF/kWu8APw5hRe1aJZ2xf29Os9BZC6LlBNvolOprn4QrGa2gu9
         gwSKN1Bey6Spmqk41uTpNOfJhxNKp3pyvfNNY09freDqSeOF624JTkbWWGiYz8LAOrqX
         Sb3w==
X-Gm-Message-State: APjAAAX5KqRkUkjZP3qAYdeyxjFlwuJVOkk+lj6OBCJaisqSnmiFksGz
        P5lFCjXf9/NrMAnowzaiHdw=
X-Google-Smtp-Source: APXvYqyhkzHacP8GvpB/UGe5BNJEowImB7WDuz4lkYbuNelTfLNQjMn1fK2AVjTQd3sNLbii4U1Tww==
X-Received: by 2002:a5d:5303:: with SMTP id e3mr14568750wrv.239.1561312816800;
        Sun, 23 Jun 2019 11:00:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id c4sm8216742wrt.86.2019.06.23.11.00.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 23 Jun 2019 11:00:16 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: rtl8188eu: remove unused function get_bsstype()
Date:   Sun, 23 Jun 2019 19:59:56 +0200
Message-Id: <20190623175957.16763-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function get_bsstype() is not used in the driver code, so remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c   | 10 ----------
 drivers/staging/rtl8188eu/include/rtw_mlme_ext.h |  1 -
 2 files changed, 11 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index d1e99885c8f5..159c46b096cb 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -346,16 +346,6 @@ void set_channel_bwmode(struct adapter *padapter, unsigned char channel, unsigne
 	SetBWMode(padapter, bwmode, channel_offset);
 }
 
-int get_bsstype(unsigned short capability)
-{
-	if (capability & BIT(0))
-		return WIFI_FW_AP_STATE;
-	else if (capability & BIT(1))
-		return WIFI_FW_ADHOC_STATE;
-	else
-		return 0;
-}
-
 u16 get_beacon_interval(struct wlan_bssid_ex *bss)
 {
 	__le16 val;
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
index 1fb2349bd0a0..fa14b6fedf08 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
@@ -485,7 +485,6 @@ void flush_all_cam_entry(struct adapter *padapter);
 void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 		    struct adapter *adapter, bool update_ie);
 
-int get_bsstype(unsigned short capability);
 u16 get_beacon_interval(struct wlan_bssid_ex *bss);
 
 int is_client_associated_to_ap(struct adapter *padapter);
-- 
2.22.0

