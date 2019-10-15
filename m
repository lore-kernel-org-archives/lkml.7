Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43B5C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF1F21835
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1Xy0PgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfJOL0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 07:26:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40649 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfJOL0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:26:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so12284352pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 04:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P78Ogbx/JUEYn/bIu/iC6vnYMekh5viyN9GtdfVO390=;
        b=g1Xy0PgWMT0Wi5ZbRL9lcQNlTD1b9pM7Napp6DJ5oapxFeZr/4gbjJCfWG6U1iMYds
         kEUWZkyiqoQUQRNL5MZtmplu7HQGaIDudCFUxOc3/uC7xxBKmtvupqjm9gMtQwRGnlB5
         tWkLitMdEWshU0ms96HXAPYAPwGoSeTpkm6oKG/XzWtdq23BLuPDjNLRVg0xt1uIzFTW
         YNspxlU1tJdkY0l3W6UzCh4x/JS1uFK/XMQ5EVo31PkSIri19xSP+LAki18uMpy6NPch
         cxiQo8CnUaz37vy5qRC2VWUz4c3duMxUMnzno4EPId5f1DKqI+KrwGy4lPbRgPlaicb8
         F5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P78Ogbx/JUEYn/bIu/iC6vnYMekh5viyN9GtdfVO390=;
        b=ZM7VNu3/Kmcqw2l3sze2hi2Fa+3XLkb6VBIBRD3Ut+bKlwHM37gObgW29IPQE8oktF
         HD9AY6Qb8c0IXqGsg5H6CS42NBhioC08C0i3wSUlM00HnEz0srBw/oweiU8At5fRZ6qw
         NHY/5eg1i1BkeFS2w3tvAjW3+Ww67Lv9AbD5C/NxY4NKogh9q2tcTfP9UhbJ2+IQu7XC
         cKJWwFne+vwXjPh13dvx6WeBC18aq++ELZIxEASLowlVcQf+wcfL6IMrqEkPOAtUPTW9
         bIgaPxyhdHul7JazAcnaVJfrJnzFR++qQ/1qoeDcby97otkVFB8+nD1jT34wZedxyYOT
         z++g==
X-Gm-Message-State: APjAAAW5kRsJUuECuVxq5ga4Ok4pblgmLyKLB1kGamWtZwAIIp84yK1v
        MY0N0KVjmtfcqauKj0+0GKI=
X-Google-Smtp-Source: APXvYqxVLK4cdlaaXsSaRoY9F8T3ZEuahptUYY9sDukuxATKWJIOx3icdsmU/GDvo7lg5q4Lduu45w==
X-Received: by 2002:a17:90a:8990:: with SMTP id v16mr42084195pjn.119.1571138810266;
        Tue, 15 Oct 2019 04:26:50 -0700 (PDT)
Received: from wambui.brck.local ([197.254.95.158])
        by smtp.googlemail.com with ESMTPSA id y2sm23864541pfe.126.2019.10.15.04.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 04:26:49 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: remove casts to pointers in kfree
Date:   Tue, 15 Oct 2019 14:26:37 +0300
Message-Id: <20191015112637.20824-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary casts in pointer types passed to kfree.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 3030ae5b6b6d..71fcb466019a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2155,7 +2155,7 @@ sint rtw_set_auth(struct adapter *adapter, struct security_priv *psecuritypriv)
 
 	psetauthparm = rtw_zmalloc(sizeof(struct setauth_parm));
 	if (!psetauthparm) {
-		kfree((unsigned char *)pcmd);
+		kfree(pcmd);
 		res = _FAIL;
 		goto exit;
 	}
@@ -2238,7 +2238,7 @@ sint rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, s
 	if (enqueue) {
 		pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
 		if (!pcmd) {
-			kfree((unsigned char *)psetkeyparm);
+			kfree(psetkeyparm);
 			res = _FAIL;  /* try again */
 			goto exit;
 		}
-- 
2.23.0

