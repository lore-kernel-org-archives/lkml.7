Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C582CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAEA62064B
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvCathnn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405129AbfJRKTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 06:19:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35911 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387890AbfJRKTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 06:19:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id w18so5072388wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 03:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fnATaW9ephvwvPIyDu9BKf/c05TQ0wSwN/dIqZgvugk=;
        b=LvCathnnZqgDCLo1l3AW4XbNKY2KSY04m6yhoRjC5AmKX5HWfnD/vppmA2kwp8XxgP
         5+1xYROysX0afo8bdEPzxPmIQ3ZwxJYRFLWMsxcApdmMbJ1pKJy9hy05a2Dxxf/LTZY7
         QzPvLXQVHsYsGZtd5hA9dQKrGqw7BY4cxkFf9JqMc6ULVUF/ZWOHSICP3LCrDqWwfkaS
         7zKRHa69Qn9hpQ87SNVP9peJdRBJhaYRTNd+RbOKcVZt4eOW02yg214Z2N6ZB8W+YHOK
         jihUPvamEx4I11Io1flJFanKe6JJywvkdhvUV7ddDJWKEj4toZdSJiOCvUB0DXqTtojM
         UwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fnATaW9ephvwvPIyDu9BKf/c05TQ0wSwN/dIqZgvugk=;
        b=T7U/TsU4Jr8w0onDGrjG2FJ0nWJ6krSXHsiklsKi7AkWtvCJSivizHWrEjqQv3Miqn
         Tobf5cDyUqxwjRs7gDuIm3mBQg78VI0g5saidjKIYt/jVMezxix+9T82HbuBnzmK1bDM
         phNxSWlPKt0t0S7eR12tq3rCzE3MnnXMaEGwdfmSYUtDrVVsZM0jTQIh79IyJtKUIUjQ
         aesUsKMtVSYEOn+Sr+BYZ4Va3Mlj9l8ADv8gFZ9OPd6SLstufdZdBeeZaL9VLZgMKMxi
         zWnPGpM49XaE8dF9h+3yA9hbjT0MJDS8oGoiZucjI7i+dIHFwrU0E9+pkvaU5QtQYa+v
         Uutw==
X-Gm-Message-State: APjAAAW+BTbVIA8HkT1toht+ng3MqELXGDD3LjxjofkgK4/Fiz/j4FWA
        xMNz1ANT8xmwmsY/d0Ufrnb/Vofl
X-Google-Smtp-Source: APXvYqywHV94RcJEq0nHkmWdndohv2Iz2ONUjsUdcV0JFte3xCtqDbRfCgZC+JVDIvXFXmDAMm9hFg==
X-Received: by 2002:a05:6000:92:: with SMTP id m18mr3902567wrx.105.1571393950050;
        Fri, 18 Oct 2019 03:19:10 -0700 (PDT)
Received: from debian.office.codethink.co.uk. ([78.40.148.180])
        by smtp.gmail.com with ESMTPSA id d78sm4675028wmd.47.2019.10.18.03.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 03:19:09 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] staging: rtl8723bs: reduce stack usage of cfg80211_rtw_scan
Date:   Fri, 18 Oct 2019 11:18:54 +0100
Message-Id: <20191018101854.31876-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The build of xtensa allmodconfig gives warning of:
In function 'cfg80211_rtw_scan':
warning: the frame size of 1040 bytes is larger than 1024 bytes

Allocate memory for ssid dynamically to reduce the stack usage, as an
added benifit we can remove the memset by using kzalloc while allocating
memory.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 8555f52ceb7c..59ea4fce9a08 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1512,7 +1512,7 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	int i;
 	u8 _status = false;
 	int ret = 0;
-	struct ndis_802_11_ssid ssid[RTW_SSID_SCAN_AMOUNT];
+	struct ndis_802_11_ssid *ssid = NULL;
 	struct rtw_ieee80211_channel ch[RTW_CHANNEL_SCAN_AMOUNT];
 	u8 survey_times =3;
 	u8 survey_times_for_one_ch =6;
@@ -1603,7 +1603,13 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 		goto check_need_indicate_scan_done;
 	}
 
-	memset(ssid, 0, sizeof(struct ndis_802_11_ssid)*RTW_SSID_SCAN_AMOUNT);
+	ssid = kzalloc(RTW_SSID_SCAN_AMOUNT * sizeof(struct ndis_802_11_ssid),
+		       GFP_KERNEL);
+	if (!ssid) {
+		ret = -ENOMEM;
+		goto check_need_indicate_scan_done;
+	}
+
 	/* parsing request ssids, n_ssids */
 	for (i = 0; i < request->n_ssids && i < RTW_SSID_SCAN_AMOUNT; i++) {
 		#ifdef DEBUG_CFG80211
@@ -1647,6 +1653,7 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	}
 
 check_need_indicate_scan_done:
+	kfree(ssid);
 	if (need_indicate_scan_done)
 	{
 		rtw_cfg80211_surveydone_event_callback(padapter);
-- 
2.11.0

