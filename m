Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC38FC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A727C20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEahU486"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfCFPcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:32:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34059 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfCFPci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:32:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id u9so8891777pfn.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 07:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cWIpiV/9pFypL53JQAd++mm0OmXzeO77NSzV4QARuJI=;
        b=mEahU486ZGPKLUKdMxv51J73eKrQepRbYHGyfoNb7rOp+XytSSTp6SXAEbwOak2wWl
         GnczzmN/hqbWwrbN7WnhXL/tDuc3CEofGgtQkpHm8uCKdv6AHq/odp0qNklWPrfsU9Qp
         8Qvu/WuM0QL6kPRxvO1u0JxbX+BDzcOrVmBK2AFVguvOGRrpxlMo4WxZYA7xs7aYLqVz
         ZurgI8++lf+LxGuk2aV955OR0UdnbEMx1tY3x/dve34lFGtDtBy5J4LNt0c4/7gEhn6u
         LWye2wZ7JtTGI0HJRM8ZwTao5x/kBfTIcBYeHRp9v1Pg9ZHwKmqVvbYUz5sOr/YFoPBE
         zh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cWIpiV/9pFypL53JQAd++mm0OmXzeO77NSzV4QARuJI=;
        b=pTe/wjKOFEWOKEpWQXEFRZzu5EC5pGCH2dJ1bWxjRAD3IM7NsyB53AaEG2pjWcHyJn
         p9CJr4nuihaFdwOFDyKBvfo7srU/5QMW6ykvXu60e1EErtJ83IgzYYf0TENVJUfZMPBc
         1mUjk7OpvoZjPdNQXDbsqeDGwQIk2J7n7FE5sJ4nPwAFqXMwevVTbEb7Fk67NzpOfaOa
         7UDdd3yvxAMbUpIn66BxsG+rZk8uYE2V4E2G4Qnbz6qj6692iotrhgJPoG4w9qVpKWqA
         y4YTCk5UHB88SYZu19o74XLABKFVUcrw9H8oXbSNQnkDxOjODt3NLyYEVVOh8nD0jQwH
         x5zg==
X-Gm-Message-State: APjAAAUTMfbaiITNERvtSVfMfzOmPF8SbVMFYVFy796dcGO9Mei3iG5P
        vrmmHy7Tt1ec1iUTdwxzdVblROhNMPo=
X-Google-Smtp-Source: APXvYqwbIqIPAYIr64Ok/nU0k66MC90SGPK/12RUSfzRWuBezOK2xY/7H6aFXmu4mDORyDl6rL9HpA==
X-Received: by 2002:a17:902:2f:: with SMTP id 44mr2346773pla.139.1551886357271;
        Wed, 06 Mar 2019 07:32:37 -0800 (PST)
Received: from emca-Inspiron-3558 ([2601:1c0:4202:56f0:4905:9244:a0db:5d2c])
        by smtp.gmail.com with ESMTPSA id g3sm3232492pfo.125.2019.03.06.07.32.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Mar 2019 07:32:36 -0800 (PST)
From:   Robert Eshleman <bobbyeshleman@gmail.com>
To:     bobbyeshleman@gmail.com
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        =?UTF-8?q?Robert=20W=C4=99c=C5=82awski?= <r.weclawski@gmail.com>,
        Bhaskar Singh <bhaskar.kernel@gmail.com>,
        =?UTF-8?q?Kacper=20Ko=C5=82odziej?= <kacper@kolodziej.it>,
        Janani Sankara Babu <jananis37@gmail.com>,
        =?UTF-8?q?Florian=20B=C3=BCstgens?= <flbue@gmx.de>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: cleanup spacing style
Date:   Wed,  6 Mar 2019 07:31:41 -0800
Message-Id: <1551886313-26435-1-git-send-email-bobbyeshleman@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a few spacing warnings from checkpatch.pl,
as well as an incorrect spacing between a function type and
the function name.

Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index 94c9d9f..fc500da 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -68,7 +68,7 @@ static void update_BCNTIM(struct adapter *padapter)
 
 	/* update TIM IE */
 	p = rtw_get_ie(pie + _FIXED_IE_LENGTH_, _TIM_IE_, &tim_ielen,
-			pnetwork_mlmeext->ie_length - _FIXED_IE_LENGTH_);
+		       pnetwork_mlmeext->ie_length - _FIXED_IE_LENGTH_);
 	if (p && tim_ielen > 0) {
 		tim_ielen += 2;
 		premainder_ie = p + tim_ielen;
@@ -89,7 +89,7 @@ static void update_BCNTIM(struct adapter *padapter)
 			       &tmp_len, (pnetwork_mlmeext->ie_length -
 					  _BEACON_IE_OFFSET_));
 		if (p)
-			offset += tmp_len+2;
+			offset += tmp_len + 2;
 
 		/* DS Parameter Set IE, len = 3 */
 		offset += 3;
@@ -162,7 +162,7 @@ static u8 chk_sta_is_alive(struct sta_info *psta)
 	return ret;
 }
 
-void	expire_timeout_chk(struct adapter *padapter)
+void expire_timeout_chk(struct adapter *padapter)
 {
 	struct list_head *phead, *plist;
 	u8 updated = 0;
-- 
2.7.4

