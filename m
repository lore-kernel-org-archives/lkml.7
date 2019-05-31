Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143F9C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 17:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AEA26D35
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 17:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+haEbGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfEaRcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 13:32:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33765 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfEaRcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 13:32:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id g21so4293347plq.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 10:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GubS+arfOZNAUjicwzdrEl/ueLaaOn8vkPvMNsjgz6Y=;
        b=W+haEbGknQ/drf9bb0vWglr3IUlfC8m4m004aUwefq1NU03QWNzAWYYN7Ma+aAfhYF
         ZBzRYK7QtUL/olblfxqBidTiln2jezhXCx+eJ9w5V5fENE4zTinzlaoEBticN8aLSeWS
         4/5IbpsqkF+mshEbWRELH3+rMG3GlF267Bwg8f1NkKkORLlsDA5L+SLhHfaiO4xqTDjz
         2EgIJobgYi2H6eT1BaxMd+RjpQgKj35gLu22fo1HbFOPJzeN3aYqWASMzlfzisThffm3
         6Iy6SRqTwqNjk2P5ZXaRuFrYuhHuA/E/6m3v9eTLjHbqDJxR+I+w6MbWvDJ6PN17ZgM5
         CXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GubS+arfOZNAUjicwzdrEl/ueLaaOn8vkPvMNsjgz6Y=;
        b=X0H0OqdGj8D66wQKFYnLNeWkjSkfM56Nm4vmjR90UnF6gM9MA6qDDonwogP805fG8l
         0kk/8R/YlyFeAgU1u37iy3DzHv+2E9TCGN6pmoIEF9dPxAHTo2LViuAEQ9YJOVu0HG2q
         5Ma5src09MWBL0woa7yWy9fOzOOm8HO1NNrTwJ4enOX7dfvBXTvz4O1y9uUC7rokJBpZ
         ShByFE8Ob5We8Yj7Eq8gmX0TkQgU9lZKp0Rm5YJXN1iSDfbD/LLk5Mq5ikUXO4fCBTVn
         KECj/PCIcK5co88x7HWnhCyZtn5iwEr8UOvdwtIlWsT+zl/w1xUx1XPSl+AN09OTi3tT
         p+DQ==
X-Gm-Message-State: APjAAAU2KXL+nVzspsjlcnm+zLf4E2EG52gfqgK5fEKYe5iHNUuI7j9H
        5jxtqlssM17FFcKltb/CBW0=
X-Google-Smtp-Source: APXvYqz9x5GBZktyYUKj15ZWH+z13Jr1JKwzJ3DHOPsiUCAl2Bm8zAy/O3Hd7HG48J+dJKBBmyAPCA==
X-Received: by 2002:a17:902:e40f:: with SMTP id ci15mr11169483plb.280.1559323970122;
        Fri, 31 May 2019 10:32:50 -0700 (PDT)
Received: from localhost.localdomain ([157.40.16.227])
        by smtp.gmail.com with ESMTPSA id d13sm11340180pfh.113.2019.05.31.10.32.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 10:32:46 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH v2] staging: vt6655: Change return type of function and remove variable
Date:   Fri, 31 May 2019 23:02:26 +0530
Message-Id: <20190531173226.15236-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190530211513.GA25966@kroah.com>
References: <20190530211513.GA25966@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove return variable bResult from function CARDbRadioPowerOff and
change the return type of the function to void as it always returns true
and the return value is never stored nor checked when called.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/vt6655/card.c | 8 ++------
 drivers/staging/vt6655/card.h | 2 +-
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 6ecbe925026d..eba4ee0750dc 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -409,14 +409,11 @@ bool CARDbSetBeaconPeriod(struct vnt_private *priv,
  *  Out:
  *      none
  *
- * Return Value: true if success; otherwise false
  */
-bool CARDbRadioPowerOff(struct vnt_private *priv)
+void CARDbRadioPowerOff(struct vnt_private *priv)
 {
-	bool bResult = true;
-
 	if (priv->bRadioOff)
-		return true;
+		return;
 
 	switch (priv->byRFType) {
 	case RF_RFMD2959:
@@ -444,7 +441,6 @@ bool CARDbRadioPowerOff(struct vnt_private *priv)
 	pr_debug("chester power off\n");
 	MACvRegBitsOn(priv->PortOffset, MAC_REG_GPIOCTL0,
 		      LED_ACTSET);  /* LED issue */
-	return bResult;
 }
 
 /*
diff --git a/drivers/staging/vt6655/card.h b/drivers/staging/vt6655/card.h
index f422fb3c78bd..887c1692e05b 100644
--- a/drivers/staging/vt6655/card.h
+++ b/drivers/staging/vt6655/card.h
@@ -57,7 +57,7 @@ u64 CARDqGetTSFOffset(unsigned char byRxRate, u64 qwTSF1, u64 qwTSF2);
 unsigned char CARDbyGetPktType(struct vnt_private *priv);
 void CARDvSafeResetTx(struct vnt_private *priv);
 void CARDvSafeResetRx(struct vnt_private *priv);
-bool CARDbRadioPowerOff(struct vnt_private *priv);
+void CARDbRadioPowerOff(struct vnt_private *priv);
 bool CARDbRadioPowerOn(struct vnt_private *priv);
 bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type);
 bool CARDbUpdateTSF(struct vnt_private *priv, unsigned char byRxRate,
-- 
2.19.1

