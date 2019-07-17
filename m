Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FD2C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 14:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA2E20818
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 14:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eng.ucsd.edu header.i=@eng.ucsd.edu header.b="dL4SEpTG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfGQOJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 10:09:38 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46297 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfGQOJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 10:09:37 -0400
Received: by mail-lf1-f67.google.com with SMTP id z15so12303976lfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 07:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eng.ucsd.edu; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=kaWcOT8T+KSXDRlP7d1Sy+89HMvlHdNWlBmmeaX1Ra8=;
        b=dL4SEpTGX/ngKWygtGkODclXiRzKgEWqnKQck8BeSRpLX8Fn6KUIfOiVffCGxmmswf
         Uxr1m/YoRjp+Xr1MOUM6Z2opsKK89UPwN+QgIOH3BgI/ZLYT2HZleUtgQtE33kmej2jh
         pAueIU+HMvy5AoCSMpL2koGDMdLXV1fLIuccM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=kaWcOT8T+KSXDRlP7d1Sy+89HMvlHdNWlBmmeaX1Ra8=;
        b=o6sLEWy5OzEbGHssuNByaT9brq5ratKygZ8f/Rz+VKblGtMCXBmvC5dqnhmfZuk6Ev
         k3GgczwV7VaPSK1mctyfaUuBeMQdtpI2MeoJ/LvAPAMYs1SVil2S/KrDI8gJa5q96Rhs
         9+KJid6jPhcnVHm4izXnhpjoOXKVZhL2qek9jh2ERu+Pc2860oll0GpQNUHAvLL2bnei
         Jv3Mg3MkrOVQgh9PzDvYN9uvD+iLOujuGKJzIGciYoSGD2A0iHQMNxkhW9TqpTUqXB1u
         kDgUUZBlznlbQHGWsLjb0LbF35GGdaoqu4e82zS8hfOlqtaie23798uBAoa7sChSoOlH
         IFvA==
X-Gm-Message-State: APjAAAUblaGUbB6oDY2dr1PA9jQn5qCxu/u/PQ+a0ZQBC2wxkDAcJ7BH
        Nr1FPyYVN49OYYNGSfKwF+TVGg==
X-Google-Smtp-Source: APXvYqwF3WgPkqs+Px5oxYI48v57W4Ei3OacwDVIw5KkyeL7BsYvE07r7h/sq13Zn4lsZDq404fLvg==
X-Received: by 2002:ac2:5bc7:: with SMTP id u7mr18342073lfn.167.1563372575327;
        Wed, 17 Jul 2019 07:09:35 -0700 (PDT)
Received: from [192.168.1.2] (178-37-168-43.adsl.inetia.pl. [178.37.168.43])
        by smtp.gmail.com with ESMTPSA id j3sm3485074lfp.34.2019.07.17.07.09.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 07:09:34 -0700 (PDT)
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
From:   Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
Subject: [PATCH v2 RESEND] media: dvb_frontend.h: Fix shifting signed 32-bit
 value problem
Message-ID: <0d5dae7b-e6e5-27ea-ba6d-59065f0c6edf@eng.ucsd.edu>
Date:   Wed, 17 Jul 2019 07:09:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix DVBFE_ALGO_RECOVERY and DVBFE_ALGO_SEARCH_ERROR use BIT macro which
fixes undefined behavior error by certain compilers. 

Also changed all other bit shifted definitions to use macro for better
readability. 

Signed-off-by: Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
---
 Changes in V2:
 + Added BIT macro to all bit shifted definitions
 - Removed U cast on 31 bit shifted definition
 Changes in V1:
 + Added U cast to shifting 31 bits

 include/media/dvb_frontend.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/media/dvb_frontend.h b/include/media/dvb_frontend.h
index f05cd7b94a2c..0d76fa4551b3 100644
--- a/include/media/dvb_frontend.h
+++ b/include/media/dvb_frontend.h
@@ -41,6 +41,7 @@
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/bitops.h>
 
 #include <linux/dvb/frontend.h>
 
@@ -141,10 +142,10 @@ struct analog_parameters {
  *	These devices have AUTO recovery capabilities from LOCK failure
  */
 enum dvbfe_algo {
-	DVBFE_ALGO_HW			= (1 <<  0),
-	DVBFE_ALGO_SW			= (1 <<  1),
-	DVBFE_ALGO_CUSTOM		= (1 <<  2),
-	DVBFE_ALGO_RECOVERY		= (1 << 31)
+	DVBFE_ALGO_HW			= BIT(0),
+	DVBFE_ALGO_SW			= BIT(1),
+	DVBFE_ALGO_CUSTOM		= BIT(2),
+	DVBFE_ALGO_RECOVERY		= BIT(31),
 };
 
 /**
@@ -170,12 +171,12 @@ enum dvbfe_algo {
  *	The frontend search algorithm was requested to search again
  */
 enum dvbfe_search {
-	DVBFE_ALGO_SEARCH_SUCCESS	= (1 <<  0),
-	DVBFE_ALGO_SEARCH_ASLEEP	= (1 <<  1),
-	DVBFE_ALGO_SEARCH_FAILED	= (1 <<  2),
-	DVBFE_ALGO_SEARCH_INVALID	= (1 <<  3),
-	DVBFE_ALGO_SEARCH_AGAIN		= (1 <<  4),
-	DVBFE_ALGO_SEARCH_ERROR		= (1 << 31),
+	DVBFE_ALGO_SEARCH_SUCCESS	= BIT(0),
+	DVBFE_ALGO_SEARCH_ASLEEP	= BIT(1),
+	DVBFE_ALGO_SEARCH_FAILED	= BIT(2),
+	DVBFE_ALGO_SEARCH_INVALID	= BIT(3),
+	DVBFE_ALGO_SEARCH_AGAIN		= BIT(4),
+	DVBFE_ALGO_SEARCH_ERROR		= BIT(31),
 };
 
 /**
-- 
2.20.1
