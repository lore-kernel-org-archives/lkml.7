Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8934FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADB42087F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDYBEhFP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfCQPUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 11:20:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34903 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfCQPUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 11:20:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id j5so9554393pfa.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 08:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dtmSQh7h+9HPMP+3kzZx9bwucSwcJmnOugm5SRWUFcc=;
        b=FDYBEhFP54+q9EAPjC6wPgcgmvqC+KQCBtaqA+GG8UpHq4BA6MqxSN/seTU4cH88TK
         EGu0PvFp6S0ROmxxcEsFG9Qb2SQKo24+/WfueMa/onARt1oQRLll/DKE1I3ZuvnIXgR5
         Lv4EJrESMsd1i4RjLMDNpS/DS7r5iLUMyLjoL6sQIPW0JSxP8+sR0BYp1t/IPtCtjwwE
         A7xPM5tyPWLJI4qjSHlxcEwCdq0L9Q9enJVC/1VsKhlIj2ZvDCTQ91UomuwA7oYnGK7e
         dCG7renW3OkHnMQIYijt57jRotruLTIPMYWtvcXBX2bpWByhi8IGnQNnxAiyU8o3mb9/
         J3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dtmSQh7h+9HPMP+3kzZx9bwucSwcJmnOugm5SRWUFcc=;
        b=NljtH3vvG6camYwVoOdV80g5SjUwjzPa+airViapv+UxG8AOqfsWOPrLh6n2NC5q/R
         MKfUv7ExYP9b8YnqSgKUPtxW1t/EmNrkZNPR2qGJMiKMIHeglVcSa18UG7BTGZ578x0R
         E29RkiP5MmclzY4mDPfe/DUrD2FmIuOd9M/8VH0lhmM5xe4iI7fvoueUIXBxYBj/zTbA
         jj62MsAZWP9k86ijupqFPqiFEXGfaCTm+uE/gxjZdGigJsyRoUfxY1Wy5UOmW/tOVmEb
         XBF71XhibmeRaxy7ijboDMuBfbraqEoU6OeTIqRHYp5Ij9+mND8msjvuCV1tla1a6oGr
         oehQ==
X-Gm-Message-State: APjAAAUZaMZQZ6ui4VYm9D8V1gNJNTCmSSenva7y8iVx5pRSIoVae85L
        lUkaeCwVDlmM2XI2ne19Eck=
X-Google-Smtp-Source: APXvYqxBr7c0Fy4IhmOr1W9EbscEkMrvDianY83Xoni8NPUY6uNbfuh6Zhk7eEm6C0fFRIKT4pXjoA==
X-Received: by 2002:a17:902:e60e:: with SMTP id cm14mr15028437plb.192.1552836023549;
        Sun, 17 Mar 2019 08:20:23 -0700 (PDT)
Received: from localhost.localdomain ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id d9sm9383902pgq.6.2019.03.17.08.20.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 08:20:22 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATHv3] staging: rtl8723bs: do not use __constant_cpu_to_le16
Date:   Mon, 18 Mar 2019 00:20:14 +0900
Message-Id: <20190317152014.28694-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_to_le16() is capable enough to detect __builtin_constant_p()
and to use an appropriate compile time ___constant_swahbXX()
function.

So we can use cpu_to_le16() instead of __constant_cpu_to_le16().

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 drivers/staging/rtl8723bs/include/wifi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index 559bf2606fb7..1e79e6f0c206 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -266,8 +266,8 @@ enum WIFI_REG_DOMAIN {
 
 #define SetFrameType(pbuf, type)	\
 	do {	\
-		*(unsigned short *)(pbuf) &= __constant_cpu_to_le16(~(BIT(3) | BIT(2))); \
-		*(unsigned short *)(pbuf) |= __constant_cpu_to_le16(type); \
+		*(unsigned short *)(pbuf) &= cpu_to_le16(~(BIT(3) | BIT(2))); \
+		*(unsigned short *)(pbuf) |= cpu_to_le16(type); \
 	} while (0)
 
 #define GetFrameSubType(pbuf)	(le16_to_cpu(*(__le16 *)(pbuf)) & (BIT(7) |\
-- 
2.21.0

