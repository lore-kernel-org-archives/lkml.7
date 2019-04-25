Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F369DC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F78E206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dj22L9PA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbfDYTwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:52:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33032 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfDYTwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:52:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id k19so379353pgh.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1aMJ19YFecOaxMFya4ZH3n4hLdnfFu1RgIII04nJVJI=;
        b=Dj22L9PAiazQqbwdgRTYTFdWPbwAtZTxhikXKkiaOg+pa1ZrbNcbAqBcKlpMbIRvRc
         v7qyn+MLyotx3UVKTc2Zg9SW931tEt+vwB/lPn8kT/zsXtl2aVEvQFU3lvDIJ/97MDdC
         BCY340QlcFH9XFInHeb644fFYH2YG/59zLviK6Go40vzCwByRgZwqer4jq8TZsPcCQS5
         ijk7nEgNeHVRvIdhBz7ucNrV5qtPfbqJY7ZnFf9GUJVPZ0zCBcyzm00jkoU/Zv89nFxw
         Z7P3j9CexD73eKvnTq/r7S0XNRWgq2etbu2kt1XHL7ZRYgYpXx6FDjuyEI1Zhcb7iBDg
         dkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1aMJ19YFecOaxMFya4ZH3n4hLdnfFu1RgIII04nJVJI=;
        b=eLz4MEvbuMNXnuGSlzmR36Ld65P5uTIkwVSauHOwY0gvIbGed1kiZPuwjaiVeNvUna
         ooVxaKXKaSqRgaqTpqQVLdJVllEIFad6mjKMuQsLZj4GG1og5+do4ymR77I0OIhdVm1u
         BtHfoz7M9u7As5ulvV5R8LQeOHqExNJkfcR/a0AMGxJWxGQzOM/ZOZYu7BifBRbmLRTs
         AFsEnCANsRs5yipbSKD81QWjm4bJbP6JXtnwd7e/pPmpCltz4hvyGiBDWBLpM9OQ5ond
         RZKbap/4DMw88yqJlKp4f925jXCof+b26ndhnPUmKeSdQvSQOW6xEtbNiobTgXPIJqfO
         RklA==
X-Gm-Message-State: APjAAAW/9U0RKZr4u3+esJfEhwpFV2kb2dp2kVBROwVk9FbtFasa+//Z
        wGvmGuW3+FFOqDad8czOWJw=
X-Google-Smtp-Source: APXvYqwMTvJx0Le8xgE4jcKYKlpwY1R3kISXtLtW3n6s1D+3LNZDykr0IQm9IPcnaC4aamBKvqvRQg==
X-Received: by 2002:a63:6888:: with SMTP id d130mr39193416pgc.451.1556221923378;
        Thu, 25 Apr 2019 12:52:03 -0700 (PDT)
Received: from localhost.localdomain ([103.87.57.142])
        by smtp.gmail.com with ESMTPSA id m11sm48649579pgd.12.2019.04.25.12.52.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:52:02 -0700 (PDT)
From:   Vatsala Narang <vatsalanarang@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Julia.Lawall@lip6.fr, straube.linux@gmail.com,
        Vatsala Narang <vatsalanarang@gmail.com>
Subject: [PATCH] staging: rtl8723bs: core: Remove return in void function
Date:   Fri, 26 Apr 2019 01:21:45 +0530
Message-Id: <20190425195145.25326-1-vatsalanarang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove return in void function to get rid of checkpatch warning.

Signed-off-by: Vatsala Narang <vatsalanarang@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 094d61bcb469..67b9aeda7f3a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -2861,8 +2861,6 @@ void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *pst
 
 	/* spin_unlock_bh(&psta->sleep_q.lock); */
 	spin_unlock_bh(&pxmitpriv->lock);
-
-	return;
 }
 
 void enqueue_pending_xmitbuf(
-- 
2.17.1

