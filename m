Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22826C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E628C2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZKaonyE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfCSCUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:20:48 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35260 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfCSCUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:20:44 -0400
Received: by mail-io1-f68.google.com with SMTP id x4so16343157ion.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SB3yE8I5nx2bmDKKeMxxFCegct/omwRR6io2Pjhj+Hc=;
        b=IZKaonyEyLFbGLxf2j83euGbbx8tjYnIyqnCVJD7jRsV8bCl6zq4HB8kLHHdGjnkP2
         0AVGQxeI5TyTMOD42+HrEqZGbY1MNGYMA6XXioe2+AX/yiEYwu9QxGd278nptZvwjoFo
         Q88xDgfws7JqC4T1D9+FnqlWEA3lN3Oou0w/+hUWcE7mVyxSBIFXoF8oCTi59KBzFD0C
         H3WrZmcGLwCqQWeASTmML6Klg/fR496QsR1YA/KLwdW9CrZ94sglzi36mr8UyhkWn8pd
         IMBhRAELtKBfZXh6RqqSy10GB3ap/oUQbFFO5KaYEZXjG3Rpb6Emy9E2LAUgSsrfy7H4
         aK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SB3yE8I5nx2bmDKKeMxxFCegct/omwRR6io2Pjhj+Hc=;
        b=sNYNeWVUYQl9bPQAgXffqpVqh8vQVffHpc5sOZ3BUHrHt1sp8fJ6wP1ufekqgSLKUB
         6lFXlC3KU8ZlDStxqcrHqM8CJ9ir04Bc+diVzcxTzJjGDIFAZpBnz9LFavOVx5DoYyG0
         11PHSYVjo1IDwSC1gV+wJXih248extKKnvROcXZrwCs3WuShTtSaWpxhzC8zsAQfLwi9
         ZqkdWjX5hAleQPbHnsjJOrf006vw5QfTggUDKxE6jO8v2fGykPX4q6x7i2dftwZEzvYc
         47oXjd9lHEzPqTgpxKjC8zxaDlDeRulIj+PDbu9CS2kWv4bZRDCDzFLX1BRb0IUhxyKR
         Cg0Q==
X-Gm-Message-State: APjAAAWT10yOn8Mkhb75FqOTCEite0vi+tGgL9YBgwAkuf2oxpeJ2UL3
        B1b0CoKfS4iB6EW1wFrv9zg=
X-Google-Smtp-Source: APXvYqw7b2RBiyL8ltVHdr8e/j0QTo3vV2eiIM1sXJWGyA22Yyoqc9WQXJOQLm/3yk7yr0Ou9n08ww==
X-Received: by 2002:a5e:c24b:: with SMTP id w11mr30758iop.264.1552962043680;
        Mon, 18 Mar 2019 19:20:43 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id l8sm673838itl.26.2019.03.18.19.20.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 19:20:43 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH v2 10/11] staging: mt7621-mmc: Fix BRUST -> BURST typo
Date:   Mon, 18 Mar 2019 20:20:11 -0600
Message-Id: <20190319022012.11051-11-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319022012.11051-1-thirtythreeforty@gmail.com>
References: <20190319022012.11051-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Obvious typo.  It is specified as BURST in the datasheet.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 drivers/staging/mt7621-mmc/mt6575_sd.h | 10 +++++-----
 drivers/staging/mt7621-mmc/sd.c        |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/mt6575_sd.h b/drivers/staging/mt7621-mmc/mt6575_sd.h
index 8b6cf17175cd..7ee3a9ed328a 100644
--- a/drivers/staging/mt7621-mmc/mt6575_sd.h
+++ b/drivers/staging/mt7621-mmc/mt6575_sd.h
@@ -53,10 +53,10 @@
 #define MSDC_BUS_4BITS          (1)
 #define MSDC_BUS_8BITS          (2)
 
-#define MSDC_BRUST_8B           (3)
-#define MSDC_BRUST_16B          (4)
-#define MSDC_BRUST_32B          (5)
-#define MSDC_BRUST_64B          (6)
+#define MSDC_BURST_8B           (3)
+#define MSDC_BURST_16B          (4)
+#define MSDC_BURST_32B          (5)
+#define MSDC_BURST_64B          (6)
 
 #define MSDC_PIN_PULL_NONE      (0)
 #define MSDC_PIN_PULL_DOWN      (1)
@@ -280,7 +280,7 @@ enum {
 #define MSDC_DMA_CTRL_RESUME    (0x1  << 2)     /* W */
 #define MSDC_DMA_CTRL_MODE      (0x1  << 8)     /* RW */
 #define MSDC_DMA_CTRL_LASTBUF   (0x1  << 10)    /* RW */
-#define MSDC_DMA_CTRL_BRUSTSZ   (0x7  << 12)    /* RW */
+#define MSDC_DMA_CTRL_BURSTSZ   (0x7  << 12)    /* RW */
 #define MSDC_DMA_CTRL_XFERSZ    (0xffffUL << 16)/* RW */
 
 /* MSDC_DMA_CFG mask */
diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index f64d51c8bd42..b52e0284ea8e 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -626,8 +626,8 @@ static void msdc_dma_setup(struct msdc_host *host, struct msdc_dma *dma,
 	}
 
 	sdr_set_field(host->base + MSDC_DMA_CFG, MSDC_DMA_CFG_DECSEN, 1);
-	sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_BRUSTSZ,
-		      MSDC_BRUST_64B);
+	sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_BURSTSZ,
+		      MSDC_BURST_64B);
 	sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_MODE, 1);
 
 	writel(PHYSADDR((u32)dma->gpd_addr), host->base + MSDC_DMA_SA);
-- 
2.21.0

