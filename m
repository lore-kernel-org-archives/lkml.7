Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAC1C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 18:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B6D627791
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 18:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMEXYnWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfFASoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 14:44:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42509 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbfFASoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 14:44:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id go2so5321063plb.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 11:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jy5f39JtoflmsGwijkPz6ujk/wlkmv8ts/C2dFv0hM8=;
        b=SMEXYnWBrGvRRxI8vI3wtGEtbCfacwdTp0wnY7tuMsvIFvsXKh0UcnNxfweZsQUGXb
         oOJbNWXLZs8Tc2M/5oWBGsBcGZ/V6usf9HNpK2usPt/wZyDMww2g8YolyqRiV0AxDyzb
         oUhZk6a4MY/OO2QW5MGHZA0LzDs0DgnbnoDruITIqdR8T0YMadzuSvPNrY+RrYtaaOXy
         a6n3Z1ZLryT1udkgU7qlRbyk4v+7KEy0i/+PRkp2xWx7WdJHIzjkaZI7Ywdkc/zeDzze
         YPevpOdGftF6jzkLSXpXyjFWx0a+dy9muf+Jd2d+OHUOcSrnzU53fQVD852KIrE7AsgB
         TBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jy5f39JtoflmsGwijkPz6ujk/wlkmv8ts/C2dFv0hM8=;
        b=hWcIVJtpq2nuiIafSEuA3MZ/KyEOldYhjZmr04WH1Sv1nF2L+9e5xIPogbB8m8PY2f
         trojxNM3+Rn26bxV12gmR2QVp+gLHHexxcD1h62Pe40LRPh1NYfYdnTLRdXkJ3vcSiUx
         4PYj7m1YL9jESDQIZkYkzai243g2jvmaCIgQaWLlCwWR/5V3mNaRiS7G4j5wW23Pd0f3
         +ofaXqd79Dvbtu+hM0PCtTF9qNgRJh6qp4trxIaHB61OaauESxHZVbjX4Yr9+P/VLPBW
         HtCxXk2n5HlIomZpBvLjiT8Z70y9KS9WTR2Pkjs+BKHCUL3zAAV5hAqc0lcm9xfWasc3
         1z7A==
X-Gm-Message-State: APjAAAWLwhT7huz0UkYJJ6nLx2/UJOQB4etBPbM5bPy0CYaQM2CChy51
        6ZTyPSDPt6nFTcByxGrL6CtaPZFw
X-Google-Smtp-Source: APXvYqwPXmXV5gbzkCjHvzXjyi4j5Nt9O9zQfVHzPiRwMWNHm1jHzULe7gfn9plaaFyXKpVWB5z6Gw==
X-Received: by 2002:a17:902:9b81:: with SMTP id y1mr8911422plp.195.1559414655904;
        Sat, 01 Jun 2019 11:44:15 -0700 (PDT)
Received: from localhost.localdomain ([117.192.16.207])
        by smtp.googlemail.com with ESMTPSA id w187sm13287950pfw.20.2019.06.01.11.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jun 2019 11:44:15 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, linux.dkm@gmail.com,
        himadri18.07@gmail.com, straube.linux@gmail.com
Subject: [PATCH 5/8] staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
Date:   Sun,  2 Jun 2019 00:13:39 +0530
Message-Id: <dbb23bc21fcd7cfbad485ceefc15d97a38566dd0.1559412149.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559412149.git.linux.dkm@gmail.com>
References: <cover.1559412149.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes CamelCase IsrContent to isr_content as suggested by
checkpatch.pl

Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index 5360f049088a..a5060a020b2b 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -148,7 +148,7 @@ struct _adapter {
 	bool	driver_stopped;
 	bool	surprise_removed;
 	bool	suspended;
-	u32	IsrContent;
+	u32	isr_content;
 	u32	imr_content;
 	u8	eeprom_address_size;
 	u8	hw_init_completed;
-- 
2.19.1

