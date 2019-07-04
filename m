Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48C9C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B846821873
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eng.ucsd.edu header.i=@eng.ucsd.edu header.b="KZG459qz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfGDU6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 16:58:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:47039 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfGDU6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 16:58:19 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so7213076ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 13:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eng.ucsd.edu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=kaWcOT8T+KSXDRlP7d1Sy+89HMvlHdNWlBmmeaX1Ra8=;
        b=KZG459qzCfFpjjcyPjltODY9KHxY7Ksf3ptXJGrrwixRi+P2LVc37qpMlLZWYYpAyl
         HdVyPmC4A/wFQlJSm3pIFCKwL2Ey2C4sgyVR5llRL35ZyWXhY2SE60INjRNsd3lZ5utm
         sW7palrxgQB+BbEsFzHlr/Rj0hWd4+xYFWkj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kaWcOT8T+KSXDRlP7d1Sy+89HMvlHdNWlBmmeaX1Ra8=;
        b=DHAYyrX4sYXNsF2nJ5IKQ/T9iVUrxJX6OLVR69y7HuFLJKDHhtX8wJsV689ephDWHL
         Ramongy8U5qHifXENBcjRTtMNySdk0IE7G4QZHlfS3eNQlATKk1UTWi7I/PTRvM5jzv5
         80iXc1jp7hY2KhevBG+K5RUmQdHRaUw19FEW5mshnUAZyvH6wrcKx4vzhUHsIXO5UUOl
         7hPRSOkQzWYaVwhagx3JQKGWxt59L8A7Ws9jPocFduTkxY8U+8BbEfmsFCv3Uy90Uo4L
         M5wDVqKGM6cgNGEzU9rWIifTyxy0+a3cfGsH+dZpYwaPlcMy48ui54XZa/E+uFzxwmUn
         cH4Q==
X-Gm-Message-State: APjAAAUOUVHnASffGNHDr1ftgSQ0Er069SgFxVNN+a+jJgasnz/MQvrQ
        KUcJk152H6mWhP2NR1lLz+5UqA==
X-Google-Smtp-Source: APXvYqy6DxlR3BJsDf8tnWYMrAZCxUjn4r75QRNoiRjv9Z5MS0qFRQfisfAGuXuHEknEFwt+vsLyZg==
X-Received: by 2002:a2e:b0f0:: with SMTP id h16mr78772ljl.21.1562273897101;
        Thu, 04 Jul 2019 13:58:17 -0700 (PDT)
Received: from luke-XPS-13 (77-255-206-190.adsl.inetia.pl. [77.255.206.190])
        by smtp.gmail.com with ESMTPSA id f10sm1044907lfh.82.2019.07.04.13.58.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 13:58:16 -0700 (PDT)
Date:   Thu, 4 Jul 2019 13:58:12 -0700
From:   Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] media: dvb_frontend.h: Fix shifting signed 32-bit value
 problem
Message-ID: <20190704205812.GA28496@luke-XPS-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
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

