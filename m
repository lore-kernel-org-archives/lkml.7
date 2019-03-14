Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD56C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E452184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWF5OdpE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfCNIcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 04:32:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46368 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfCNIcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 04:32:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id a22so3461290pgg.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 01:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dKVQjBxld+72OlQDAygD0glhI7e/1AVVJqYfT4sOJr8=;
        b=NWF5OdpE75NuH2tFxjAYEfoohEfaIXhBUm3dENxavR0s24EbLUXbVjed+EWL6l9y84
         gtbEX/j/7TGXnLBXJa5JEw1OjYbGDTW1D5Kbum7xAuzSs8JyW9Wg6wS7i7wUrG2yQIaC
         XQ5GuXdgqZWy3cxkK5ovibVzDSF+ol3zZ3scbkIm9yBCcSKIVP5R5HCyzcGf5IWOz2T3
         rMvwWuH1J700O13L+ZNfP4ZcomN6lHhXM53SXm/cHV5NT4jDQzX6fqVuh638/oJ/cgze
         bzba+Wszzh11MjdUZq1LIhoqDgu0W1Ab8BwK+CaGGslAK32sjIKRdXXAmzomYjLrQFr2
         PLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dKVQjBxld+72OlQDAygD0glhI7e/1AVVJqYfT4sOJr8=;
        b=Q+YptBXCdM2k5qFJz6iUCRRTPf6PgsegnaEpv+NKNty7f1w/8erVUEtv5reNNzWqyM
         OFHoFXS+IzO157AtDUAf3s3A/PqbQvhmmAFuEeVcvez/aazrmEmb2hqnXXR43z+0CuiU
         9pYun5olDrjdYckTO2/hweKKOxk+rkdfRuv4aVHTkfwLuIXTQaJiXbaVA9BPj1NKaFRO
         nwlnOYxggFreEG6ozYHvbOhnZ4o5DcNf5GUdOpK0nlzJvbRAt09+yCk2Xfx23OOK6ZIu
         DLOQkGGOK7ePPgiBHKbAyvjVceuRaDtmEEQ2PwFx00c1WJBM0R9KG6gGQk19Xjqg8jQk
         hLvQ==
X-Gm-Message-State: APjAAAVQ3WSlVoeKiDfYqGhu/gM2JL71pU4WN4eZep+0b8Xuxs/Dj9zk
        3UDstKRyjMi/zXx9WAO6lIc=
X-Google-Smtp-Source: APXvYqy8KMqzyJvwTS4D38Tx5N1WcbcW3G63igJB7BipwS5TeRhUR+ANj0hvDOAInnJLtPhAQp/Tpw==
X-Received: by 2002:a65:49c4:: with SMTP id t4mr44644287pgs.421.1552552322539;
        Thu, 14 Mar 2019 01:32:02 -0700 (PDT)
Received: from localhost.localdomain ([175.223.23.218])
        by smtp.gmail.com with ESMTPSA id s6sm17884288pfm.94.2019.03.14.01.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 01:32:01 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] staging: rtl8723bs: do not use __constant_cpu_to_le16
Date:   Thu, 14 Mar 2019 17:31:55 +0900
Message-Id: <20190314083155.23164-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A trivial patch.

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

