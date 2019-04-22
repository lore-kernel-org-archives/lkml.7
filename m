Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F072C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C30520685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEKE3Y92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfDVJ6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 05:58:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40609 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfDVJ6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 05:58:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so15219423wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 02:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tviv7RGIMBydUIGCciSqYt8ueHHe0A7HGQbdW9M9Q4A=;
        b=AEKE3Y92WtBlbyGmIAI6wIbGwW1c33foVrzdZ8x25yJFdiHnlMF6djZIH0deAKeLye
         0czruqfCqV64dkzuBWybzfOkVLh4TkyyPQxovNRhIAYw8sLnTxTgN0hI/km6zGcjK+B8
         QTFa5b+WdNCHLRdy0BBWtIeRXQP07hfjud7toAuLRnveiPSe+VLsy21//+Y35WicefBD
         FLLqyDwZUelXMLvvmjWcGpUDEYCnqpc6lKUqZ+aELRof9MqEs3rSjqV7aMM+dtZhcJxN
         3/DG5ZhX+0hzETwrRsoqnbl2bORNPxRBJqPBZUU3xCed/f8qnRvhXZfqkpIwr3ajQAXq
         vEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tviv7RGIMBydUIGCciSqYt8ueHHe0A7HGQbdW9M9Q4A=;
        b=f17VNvZkueyJWl3HpXOFK62ZLFY8/5bb54HAULdeqmMXxyvCUi1gi9xDqq1+hMJMZ9
         9Uh19F1uU/A8prhrKAiOfyvc8DG4sZabYOs3m38SbO6hKOuGwVNCcbCPTlEXY8jgF4hg
         TSvlgFvOY0S1Dz0lXwgVjeMaWBrXuJSbL2l+z2bMM+iAoFgSvMs7DnomHpeuZC7jYq9O
         CfxGWVWxCm9mpz+YrILz7EYXmCeWUtGCI8GNEEqx8lAuG6uWP+fkde/phiNpi2tXw2s4
         Ktc0XUDZMCJSfgyqoKIs2P1ATwIuDy3JPLfsAdaWTlMKclQuv0kgRb2+zBx61BZFnwdn
         fK6g==
X-Gm-Message-State: APjAAAUi7E8bFp31UpH/uLLTbPDtKbXgDjLpyArx/pa+0+icK4daQEKZ
        R5G/Vg65tC68JRhcIULFWxE=
X-Google-Smtp-Source: APXvYqzVsjg208/ITsrvCC0T4L1NXg74KwyguYRx3NPxcodsMsff8MnUOL+J22vfncG6zNFzxMbFFA==
X-Received: by 2002:a5d:52c6:: with SMTP id r6mr13085753wrv.131.1555927117331;
        Mon, 22 Apr 2019 02:58:37 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb88.dynamic.kabel-deutschland.de. [95.90.187.136])
        by smtp.gmail.com with ESMTPSA id i17sm12923181wrs.44.2019.04.22.02.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 02:58:36 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/4] staging: rtl8188eu: remove unnecessary parentheses
Date:   Mon, 22 Apr 2019 11:58:26 +0200
Message-Id: <20190422095826.3119-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190422095826.3119-1-straube.linux@gmail.com>
References: <20190422095826.3119-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses to improve readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c  | 6 +++---
 drivers/staging/rtl8188eu/core/rtw_cmd.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index 9588ba2a16e4..51a5b71f8c25 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -1174,15 +1174,15 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 	}
 
 	wps_ielen = (uint)pwps_ie_src[1];/* to get ie data len */
-	if ((wps_offset + wps_ielen + 2 + remainder_ielen) <= MAX_IE_SZ) {
+	if (wps_offset + wps_ielen + 2 + remainder_ielen <= MAX_IE_SZ) {
 		memcpy(pwps_ie, pwps_ie_src, wps_ielen + 2);
-		pwps_ie += (wps_ielen + 2);
+		pwps_ie += wps_ielen + 2;
 
 		if (pbackup_remainder_ie)
 			memcpy(pwps_ie, pbackup_remainder_ie, remainder_ielen);
 
 		/* update ie_length */
-		pnetwork->ie_length = wps_offset + (wps_ielen + 2) + remainder_ielen;
+		pnetwork->ie_length = wps_offset + wps_ielen + 2 + remainder_ielen;
 	}
 
 	kfree(pbackup_remainder_ie);
diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c b/drivers/staging/rtl8188eu/core/rtw_cmd.c
index 61da56a3bbc4..a24b40761af2 100644
--- a/drivers/staging/rtl8188eu/core/rtw_cmd.c
+++ b/drivers/staging/rtl8188eu/core/rtw_cmd.c
@@ -405,7 +405,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 
 	psecuritypriv->authenticator_ie[0] = (unsigned char)psecnetwork->ie_length;
 
-	if ((psecnetwork->ie_length - 12) < 255)
+	if (psecnetwork->ie_length - 12 < 255)
 		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->ies[12], psecnetwork->ie_length - 12);
 	else
 		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->ies[12], 255);
-- 
2.21.0

