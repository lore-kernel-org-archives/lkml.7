Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3337FC433FF
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 18:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E5F20844
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 18:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOq+dD82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfHDSNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 14:13:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37971 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfHDSNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 14:13:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so38437482pfn.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 11:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FmcZ2hRM/N0fqpxXPyaJgm9RQypUKj6pFQyAEiitRbQ=;
        b=QOq+dD8238vDhFCumvsPRVNAJc/w1AyJQ/yrJFybIR9DotuEndkSxPBenU8MwE/JOL
         QJDUFUBAfuWKeU+tj4PNo47FpLroyJdURQK0hUJIetVMVo0t4Nkdd7nFyxNJtlhXzbLt
         G9kc/VzDZ20eUbrSPPrXNIvgb9sWvunDgBd4r80WIap4JOlATzOkEmCXHWrbhLkKdVHr
         M6R8auxV4rBHG0rbXq333kqNqvH6U0w2LFcjiX/YIs2i9PwiZ01zdi1kqkj9CSQWot5e
         +/KJBtjjdrSd4vkqlLLcJxBMEkVK7rGRR6wQpZoM889o3XVem6wRnRGV++gVTuPodwQF
         HC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FmcZ2hRM/N0fqpxXPyaJgm9RQypUKj6pFQyAEiitRbQ=;
        b=kTzdtTWTAr0Kcb07LOO5kwDMALJ+MbEJk+u7I9zKA3u929eRmRJnk+3TDzQfxxK55p
         4NcfDwzb3vGN54V9S0qsdvwhk5MuCHOQ9sZSGNqo3yR7e2MiBjC3u3t6iX4k5QFrzaq0
         mhXRaptLMYl+A47jsUlCc5yjRXSbxWnWRsW7s1gjAxdqS0GEwNf/mVUYhhHmcSTgMsr9
         oAjciJpGI3ICzcxGbrdzHJ6vndZLp5D58leY0Twmf6+WpHPR3WmCjCqL7fH8Qols08Ks
         NwpR2xwGTujL5eAvvhovogi0zngrSt7QIEPI6dBqsg3c0hsxW82Tgq67MKO2WgdhsnLC
         Rt2A==
X-Gm-Message-State: APjAAAUqKeeX2j5AvH5wCqD50EnkA0ODGh5oNo1t7R7rKxal70HpUEyG
        id8RFBWemkid5oulZVvJ/GQ=
X-Google-Smtp-Source: APXvYqz+l8k+a1rHIiexacBDBVj9Dzb05Jm7BxC5GzUYlYQWnvFLMNZKJ25VJep+sij+hZ3Yez+v2A==
X-Received: by 2002:a63:d84e:: with SMTP id k14mr133530694pgj.234.1564942419120;
        Sun, 04 Aug 2019 11:13:39 -0700 (PDT)
Received: from localhost.localdomain ([116.75.76.55])
        by smtp.gmail.com with ESMTPSA id f64sm85201258pfa.115.2019.08.04.11.13.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 04 Aug 2019 11:13:38 -0700 (PDT)
From:   Giridhar Prasath R <cristianoprasath@gmail.com>
Cc:     Giridhar Prasath R <cristianoprasath@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix the following checkpatch warnings:
Date:   Mon,  5 Aug 2019 05:13:19 +0530
Message-Id: <20190804234322.4410-1-cristianoprasath@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: line over 80 characters
FILE: drivers/staging/pi433/pi433_if.h

Signed-off-by: Giridhar Prasath R <cristianoprasath@gmail.com>
---
 drivers/staging/pi433/pi433_if.h | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
index 9feb95c431cb..915bd96910c6 100644
--- a/drivers/staging/pi433/pi433_if.h
+++ b/drivers/staging/pi433/pi433_if.h
@@ -117,9 +117,14 @@ struct pi433_rx_cfg {
 
 	/* packet format */
 	enum option_on_off	enable_sync;
-	enum option_on_off	enable_length_byte;	  /* should be used in combination with sync, only */
-	enum address_filtering	enable_address_filtering; /* operational with sync, only */
-	enum option_on_off	enable_crc;		  /* only operational, if sync on and fixed length or length byte is used */
+	/* should be used in combination with sync, only */
+	enum option_on_off	enable_length_byte;
+	/* operational with sync, only */
+	enum address_filtering	enable_address_filtering;
+	/* only operational,
+	 * if sync on and fixed length or length byte is used
+	 */
+	enum option_on_off	enable_crc;
 
 	__u8			sync_length;
 	__u8			fixed_message_length;
@@ -132,10 +137,14 @@ struct pi433_rx_cfg {
 
 #define PI433_IOC_MAGIC			'r'
 
-#define PI433_IOC_RD_TX_CFG	_IOR(PI433_IOC_MAGIC, PI433_TX_CFG_IOCTL_NR, char[sizeof(struct pi433_tx_cfg)])
-#define PI433_IOC_WR_TX_CFG	_IOW(PI433_IOC_MAGIC, PI433_TX_CFG_IOCTL_NR, char[sizeof(struct pi433_tx_cfg)])
+#define PI433_IOC_RD_TX_CFG	_IOR(PI433_IOC_MAGIC, PI433_TX_CFG_IOCTL_NR,\
+char[sizeof(struct pi433_tx_cfg)])
+#define PI433_IOC_WR_TX_CFG	_IOW(PI433_IOC_MAGIC, PI433_TX_CFG_IOCTL_NR,\
+char[sizeof(struct pi433_tx_cfg)])
 
-#define PI433_IOC_RD_RX_CFG	_IOR(PI433_IOC_MAGIC, PI433_RX_CFG_IOCTL_NR, char[sizeof(struct pi433_rx_cfg)])
-#define PI433_IOC_WR_RX_CFG	_IOW(PI433_IOC_MAGIC, PI433_RX_CFG_IOCTL_NR, char[sizeof(struct pi433_rx_cfg)])
+#define PI433_IOC_RD_RX_CFG	_IOR(PI433_IOC_MAGIC, PI433_RX_CFG_IOCTL_NR,\
+char[sizeof(struct pi433_rx_cfg)])
+#define PI433_IOC_WR_RX_CFG	_IOW(PI433_IOC_MAGIC, PI433_RX_CFG_IOCTL_NR,\
+char[sizeof(struct pi433_rx_cfg)])
 
 #endif /* PI433_H */
-- 
2.22.0

