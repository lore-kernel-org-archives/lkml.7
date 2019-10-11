Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118A9C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD72721D7A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNxAVXrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfJKFwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:52:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43385 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfJKFwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:52:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id i32so5122127pgl.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 22:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i1L51lOnWKHW5TJeL5qfRnIenvgB0vCtd5X2cYOSU8A=;
        b=bNxAVXrY9EW23UPXRaicX+62+nvRJdhzdaDPzBHW6vpX0KAU2wBy3YYpxoeqh1i8dE
         RM9seEvHE+LRr6/UGMxf0tZ+bnw07J52e3bXE27x2qTvztZ41P/vY9CHSA1mkPs1yURT
         ElVLEpQI0iLDsh+6FgsUFaxmR0H9n+OkkNbwBelSbuT6l44GI2pIiFSJUwytkB/jSVxm
         9vg+/VIdeQtpbZWopmEOhAfviYqAW12t7ebAVgu3AB4ukBuzgoTZvfp4rHvzFNXiuVC4
         ePSXJFNwVdB0gw8oJy93B4eb85dVgAbtsDMCJYMTXWeTLVAlBicsJbykpiLnYyP02/9L
         IEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i1L51lOnWKHW5TJeL5qfRnIenvgB0vCtd5X2cYOSU8A=;
        b=LehlEkx66xN6XOimNhwmDcg6KHcyfvBWmoJQlmDbqCEh1Pv5fIU0A05GhPlG9e3u2q
         clEAbgo6luGN00bSX6rtDb1R70z7PKump+1bR0i6d8RzoOduHxP5AkMcVrYT/ZcPGpKt
         Wi/sXSpJgHQThIF5/Y2W2omm9Pxz0Fg7cgRsfS09KD7RoblSm2nZx+/koYrKdB9ZmD37
         DxouOgPsqXnnZtHFb886ltDpO6RMjhBLalBJodSvfgq9EvMrVsVNdiWSyS9gcsVRU2VV
         vHtfoLNzTcZUL6QCHnx4C109IFLsgzR8/M+e84LfHPSDPETujVd9uH8fOkEK8dqf0PzQ
         bxuw==
X-Gm-Message-State: APjAAAXg/zLfFbqukgAWftN8DCOeMwIGeDlG0E0+OKU6Z3G4fod1B0oV
        KiIj3A1VCLcR16DVfw5Gnik=
X-Google-Smtp-Source: APXvYqwVZHzHwUMl8BA+E2Napohfu3FQGxNVsf6mi0nHXnuX8HAf8mpJAHyP1ymwqePr/diSzaRVLA==
X-Received: by 2002:a63:44f:: with SMTP id 76mr15328817pge.164.1570773135204;
        Thu, 10 Oct 2019 22:52:15 -0700 (PDT)
Received: from localhost.localdomain ([45.52.215.209])
        by smtp.gmail.com with ESMTPSA id i184sm10257782pge.5.2019.10.10.22.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 22:52:14 -0700 (PDT)
From:   Chandra Annamaneni <chandra627@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, dan.carpenter@oracle.com,
        fabian.krueger@fau.de, michael.scheiderer@fau.de,
        chandra627@gmail.com, simon@nikanor.nu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] KPC2000: kpc2000_spi.c: Fix style issues (Unnecessary parenthesis)
Date:   Thu, 10 Oct 2019 22:51:55 -0700
Message-Id: <20191011055155.4985-5-chandra627@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191011055155.4985-1-chandra627@gmail.com>
References: <20191011055155.4985-1-chandra627@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolved: CHECK: Unnecessary parentheses around table[i]

Signed-off-by: Chandra Annamaneni <chandra627@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 26e1e8466fb2..8cd6936eda17 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -478,7 +478,7 @@ kp_spi_probe(struct platform_device *pldev)
 	/* register the slave boards */
 #define NEW_SPI_DEVICE_FROM_BOARD_INFO_TABLE(table) \
 	for (i = 0 ; i < ARRAY_SIZE(table) ; i++) { \
-		spi_new_device(master, &(table[i])); \
+		spi_new_device(master, &table[i]); \
 	}
 
 	switch ((drvdata->card_id & 0xFFFF0000) >> 16) {
-- 
2.20.1

