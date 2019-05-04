Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D90C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 18:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84126206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 18:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvcaKBHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfEDSnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 14:43:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45263 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfEDSnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 14:43:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id i21so4346641pgi.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 11:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5+ufxo2LIp2vNFzc2baEGBYQFRJKvB7gapWAnt4yEUs=;
        b=dvcaKBHrQ3baDGhFiAKQWee8ptrNFC05hUNOL3mySUG8NlzmAhPKxA4vJaDLozoJ0e
         HENw9bOj7YufZZz2pYGCEyMt5PccKxqpfo1ksEhZyMkDdRhVvir84mS7MWP7t2x+SJqn
         VzP1yAfR2Fr00sYCcQJj/HkQPHQt0EcjO9z0a44hW44JpCcOyjM3q4BVzG0RHyxs/8nH
         B5/+/X/o97tUv6T95Zln8UNGpCMGajquRGDCMCK6xX5sdX4Ofv8hiwGoEKRI2WZ7UdUj
         2MLrmzcsUDVd86DQs0WjCIDf+gXKLwJC1+exImqnMWmP0RuzYYoaw2IAPT3X/HbwAX20
         ex+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5+ufxo2LIp2vNFzc2baEGBYQFRJKvB7gapWAnt4yEUs=;
        b=K0iXkvuMwjIb/EFnpn7Rws6ts68ENbEO+yKP+rKaBZ4mwoK+IPXA3OZ3wi2g8xcXCk
         zZ4tqXZ+dekjjl7MbJ7+XAHjjYEq/05QA5740Nymc38rHVer53LVtmyh5M73Le1RMIKX
         LG92GQrfjgEqYFJjkVb6TdrCkp8mlWA9ym8LZUnWT28CekH5RSBQQ8rZ/b6jsRAZCwoT
         benietgA135uOEejerB53y1GnbNBk3LBu5LYiYw+z+xon2F1Kf7iQS38LwA4nqc+QG3j
         aekskKMVbbF4Uwf6U9GjN8vxIJRjxz5qGD1sqOTpcDJ5B8S5iyJhSsGcn5WijJAif7Uo
         udQg==
X-Gm-Message-State: APjAAAWg1JypYWY6z67lGWM1F0f7jVpTN1ifH+56ETD7LyY8JGJ93F6J
        1gA5ZOQ8h9XneL9iw1TjaCc=
X-Google-Smtp-Source: APXvYqzLPEODIHlYX/QGbD7lWtt+ej4jwkGSd62GaI1unQOuW9EitC8oJ+0IvZj0rV31PsA4uGWbmQ==
X-Received: by 2002:a63:4a5a:: with SMTP id j26mr19654306pgl.361.1556995411400;
        Sat, 04 May 2019 11:43:31 -0700 (PDT)
Received: from localhost.localdomain ([103.87.57.241])
        by smtp.gmail.com with ESMTPSA id p67sm10593167pfi.123.2019.05.04.11.43.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:43:30 -0700 (PDT)
From:   Vatsala Narang <vatsalanarang@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hadess@hadess.net, hdegoede@redhat.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
        Vatsala Narang <vatsalanarang@gmail.com>
Subject: [PATCH 1/7] staging: rtl8723bs: core: Remove blank line.
Date:   Sun,  5 May 2019 00:13:12 +0530
Message-Id: <20190504184312.25567-1-vatsalanarang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid style issues, remove multiple blank lines.

Signed-off-by: Vatsala Narang <vatsalanarang@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index d110d4514771..00d84d34da97 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -11,7 +11,6 @@
 #include <rtw_wifi_regd.h>
 #include <linux/kernel.h>
 
-
 static struct mlme_handler mlme_sta_tbl[] = {
 	{WIFI_ASSOCREQ,		"OnAssocReq",	&OnAssocReq},
 	{WIFI_ASSOCRSP,		"OnAssocRsp",	&OnAssocRsp},
@@ -51,7 +50,6 @@ static struct action_handler OnAction_tbl[] = {
 	{RTW_WLAN_CATEGORY_P2P, "ACTION_P2P", &DoReserved},
 };
 
-
 static u8 null_addr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
 
 /**************************************************
@@ -1261,7 +1259,6 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 		goto OnAssocReqFail;
 	}
 
-
 	/*  now we should check all the fields... */
 	/*  checking SSID */
 	p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, _SSID_IE_, &ie_len,
@@ -3219,7 +3216,6 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 
 	}
 
-
 	if (pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_REALTEK) {
 		pframe = rtw_set_ie(pframe, _VENDOR_SPECIFIC_IE_, 6, REALTEK_96B_IE, &(pattrib->pktlen));
 	}
@@ -3264,7 +3260,6 @@ void issue_assocreq(struct adapter *padapter)
 	pattrib = &pmgntframe->attrib;
 	update_mgntframe_attrib(padapter, pattrib);
 
-
 	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
 
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
-- 
2.17.1

