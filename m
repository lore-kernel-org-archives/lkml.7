Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F76C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 01:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60222085A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 01:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hw+6B+Ex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfFSBOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 21:14:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39682 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfFSBOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 21:14:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id 196so8644855pgc.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 18:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Pji7lKgrO/kCVnYgvDkmXNm8qNW9reyHS5Rp4oBPXfM=;
        b=hw+6B+Exze8ZdzgLnsyml7I9sVxD8thWvlLSiyktfXW32+8AKxutW1Y2PcCVCMW9ZJ
         uv9hHZYx5wztPs27FcyWjxAIVcC3L4H4l3F1lRQQq+/WYtawCgUnvnqNr0RnqpoVBDM6
         9sJJDhNhgiaWyKHXf927VUeGACCpjNCMnPVwqSEjg8vcqxbD9xbd8GmGv4ulSN9mDxZO
         +nALWgDN9dWZytsRnGGir5AJ6YjThE1drp7BJVGFYpsERvS73hWgVhy/2RF79J5+gVIv
         CvQOJMeoWDqwrau4shH3Mv7ffbs5zJUrHFJtlQKy6KsKzjD4v3iVOapY3qLuVS346QkK
         MTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Pji7lKgrO/kCVnYgvDkmXNm8qNW9reyHS5Rp4oBPXfM=;
        b=qZf6JPpzjH72rRJRjiVo0ki31zwY5IVKxDlDPEh4sIhUiAol2icIbxjTp+PIfLzf4z
         KxVyid4KgifoEIy74vCpAjwE8t2bHEoZgEwlCqaAKby3YGIHn8ytiObu1adFDZ1N4UYU
         K8opLS8gptgIvW5Cn70wsf2A9XGIwV2lqP46Idi/kGM3SytZyrgCH6spj0hPp7LTlPBh
         nURrskQq7AUE+Z79xZuQ1sTqebelBv00NfSdSN5BGs1RFs2tkIxham0TOD9jV2snVc2c
         ukeS3HdaNxsngujcFPhXbMaNKIhSJIQZ7KrYpNO9t0CNlKRKRcPrCelvbMWADOoPDwXX
         tRsA==
X-Gm-Message-State: APjAAAUbJMyrXL1ew22CD2MovmaN+0XvkM9X7mTNyZuUHNuQHRBKZw4L
        WNG08/jJU6SidcIv/IfBbhc=
X-Google-Smtp-Source: APXvYqwZoi9mR/P+Z1XfZa+SWxO/ROXPckbCO4waB6NLC+c8mvtlOPTb03RK/0zNmTEOlLeNsxGl6A==
X-Received: by 2002:a17:90a:9f0b:: with SMTP id n11mr8046154pjp.98.1560906887809;
        Tue, 18 Jun 2019 18:14:47 -0700 (PDT)
Received: from t-1000 (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id m11sm3147174pjv.21.2019.06.18.18.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 18:14:47 -0700 (PDT)
Date:   Tue, 18 Jun 2019 18:14:44 -0700
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     shobhitkukreti@gmail.com
Subject: [PATCH] staging: rtl8723bs: hal: Remove True/False Comparisons
Message-ID: <20190619011441.GA30949@t-1000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing comparisons to True/False in if statements.

Checkpatch reported:
CHECK: Using comparison to true is error prone

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
index eb6e07e..8e4caee 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
@@ -1421,7 +1421,7 @@ static void halbtc8723b1ant_PsTdma(
 
 
 	if (bTurnOn) {
-		if (pBtLinkInfo->bSlaveRole == true)
+		if (pBtLinkInfo->bSlaveRole)
 			psTdmaByte4Val = psTdmaByte4Val | 0x1;  /* 0x778 = 0x1 at wifi slot (no blocking BT Low-Pri pkts) */
 
 
@@ -2337,9 +2337,9 @@ static void halbtc8723b1ant_ActionWifiConnected(PBTC_COEXIST pBtCoexist)
 					);
 			}
 		} else if (
-			(pCoexSta->bPanExist == false) &&
-			(pCoexSta->bA2dpExist == false) &&
-			(pCoexSta->bHidExist == false)
+			(!pCoexSta->bPanExist) &&
+			(!pCoexSta->bA2dpExist) &&
+			(!pCoexSta->bHidExist)
 		)
 			halbtc8723b1ant_PowerSaveState(pBtCoexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
 		else
-- 
2.7.4

