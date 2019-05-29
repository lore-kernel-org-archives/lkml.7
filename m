Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6777BC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2717F208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fF8OWavK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfE2NUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:20:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44360 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfE2NUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:20:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id n2so1355634pgp.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 06:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MnsmjGULYbyE0ak6jRzzu9lNKNNX7Vv2vqMfhHQMf7g=;
        b=fF8OWavKnY8mawPFHREaawr8yDeOuu2jsuoUvXQAbTbB2ZI5fqlKMlGGB6PMpkx0BV
         mCIEllMv3ip5gQTVm5u4+agvoC7NrGXm+GecCTjYa1xrflD+E7Yqg7HgKbzRbT9aTFUP
         7JzfJZtd2Z68FKXAMuPnXRkK2L6iunF4LzRSxiMrWWkXQ1XLdlrxSFS6dbc4NB89Xgje
         M7O7nSy9LLNyMZNtYCZUxFv60J2pCv+7Zpo3YDzsrtV8hR23x8gJuZIOnylGDWgdMXuS
         XY7F3G2gqjK5XFb9YorFbX3wTeR1Sa7X02PGiXTJzmPHmzr/F+AV2GOo6oNH94zMzAmq
         LOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MnsmjGULYbyE0ak6jRzzu9lNKNNX7Vv2vqMfhHQMf7g=;
        b=TcBOVSS9i8ry1kBH2Ij1SPiPkACeDSQJVEvMXmVXo9kI89/zcqOHVSicRCs98aCXhZ
         QYNvSqJy1hrS3j8euZRN0YTwi6ciHpCQe4QUqfxf4kgX+6TLSD6III5y7fS50TwKNSz3
         BUHlEPPwxQfw7i3xJGmb6oYG8fENC0sI79C8dwQJN7/+yAQGVnL9q4Fr55JBFuRh6h7s
         6n1gg5t3YbAg7x7Z+VhJON/h4Ezfl1ZimtQme+7YaRqJdJaDJDOlbKpZmrd643H+cMAN
         gnin4k4cQ6B2Izu+mz0AUkYSjnigb7cVW+OgW+Q6uKS+5ke7XZFf1kQwsOcgOgCA0pmF
         SGIA==
X-Gm-Message-State: APjAAAWvWEke2khlEdPNWxC3sn4bp5+7bCHZQCeh6MZVj6cvZWTdZtSH
        UUYJOmjaqDuDcdv5+3IHzBw=
X-Google-Smtp-Source: APXvYqwrIpIcdADUaHyqqcKbgm99ep3yRJ0nrQO/vlRmcdUx3v4Ql4Qq1Svd9NESOvFINo3fGCD8uA==
X-Received: by 2002:a17:90a:33c5:: with SMTP id n63mr12445270pjb.16.1559136046086;
        Wed, 29 May 2019 06:20:46 -0700 (PDT)
Received: from localhost.localdomain ([122.163.67.155])
        by smtp.gmail.com with ESMTPSA id l3sm28812133pgl.3.2019.05.29.06.20.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 06:20:45 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     larry.finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, himadri18.07@gmail.com,
        daniela.mormocea@gmail.com, straube.linux@gmail.com,
        vatsalanarang@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: rtl8712: Remove unnecessary variable in rtl8712_recv.c
Date:   Wed, 29 May 2019 18:50:31 +0530
Message-Id: <20190529132031.6493-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary variable last_evm in rtl8712_recv.c and use its value
directly.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_recv.c | 5 ++---
 drivers/staging/rtl8712/rtl871x_cmd.c  | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
index 82ddc0c3ecd4..f6f7cd5fd0f2 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -885,7 +885,7 @@ static void query_rx_phy_status(struct _adapter *padapter,
 static void process_link_qual(struct _adapter *padapter,
 			      union recv_frame *prframe)
 {
-	u32	last_evm = 0, tmpVal;
+	u32	tmpVal;
 	struct rx_pkt_attrib *pattrib;
 	struct smooth_rssi_data *sqd = &padapter->recvpriv.signal_qual_data;
 
@@ -898,8 +898,7 @@ static void process_link_qual(struct _adapter *padapter,
 		 */
 		if (sqd->total_num++ >= PHY_LINKQUALITY_SLID_WIN_MAX) {
 			sqd->total_num = PHY_LINKQUALITY_SLID_WIN_MAX;
-			last_evm = sqd->elements[sqd->index];
-			sqd->total_val -= last_evm;
+			sqd->total_val -= sqd->elements[sqd->index];
 		}
 		sqd->total_val += pattrib->signal_qual;
 		sqd->elements[sqd->index++] = pattrib->signal_qual;
diff --git a/drivers/staging/rtl8712/rtl871x_cmd.c b/drivers/staging/rtl8712/rtl871x_cmd.c
index 05a78ac24987..7c437ee9e022 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.c
+++ b/drivers/staging/rtl8712/rtl871x_cmd.c
@@ -880,7 +880,7 @@ void r8712_createbss_cmd_callback(struct _adapter *padapter,
 		}
 		r8712_indicate_connect(padapter);
 	} else {
-		pwlan = _r8712_alloc_network(pmlmepriv);
+		pwlan = r8712_alloc_network(pmlmepriv);
 		if (!pwlan) {
 			pwlan = r8712_get_oldest_wlan_network(
 				&pmlmepriv->scanned_queue);
-- 
2.19.1

