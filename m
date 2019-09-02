Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BB4C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 19:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52CB23697
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 19:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="GDm1X0Hz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfIBTwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 15:52:19 -0400
Received: from mx4.ucr.edu ([138.23.248.66]:38453 "EHLO mx4.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbfIBTwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 15:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1567453938; x=1598989938;
  h=from:to:cc:subject:date:message-id;
  bh=9YFH2+4SF5lZUXY1DJWRSn3RrCp+ubm6h31IWEhi4Fw=;
  b=GDm1X0Hz9dBiN9dP8CNAev+6zAJUC2EK1R9uAOf62x4PiEKjffXKZKPu
   1TTrOrfShW1rC5kO/gDD7IzC6Vv9XKaUvPsFWn3R0Ggi1HsIeRWwioem+
   2+om8yjtCJVTLzaYh2VRItJyCb4XmkgXE4jZ45/MF2nkTma+xnAtddt0l
   7g/gkRfWVXaKkr7/wXnxbpJPwjkiLmlKtBv4Dj1J+RJKC4WyCvjUvpRZL
   CSuED0aChFux1q7UYn1B9vvOpXDUUlPM0S93HjKVBoYZApOK6FfjWLyad
   6XDQEelIdm/dQcN03bE/q51I3ETmhXgLBEFS14bl9ndkMbWOtxC8CJZef
   Q==;
IronPort-SDR: /nDbqhA4WW2WzE0+3w07ivtbqB3PvllXb7LHYoiMr8PTomElc5L8ds84yIvrTaIAI24hcY1cXX
 hvA7+irmHxBKtA2XGOKXE5VfTrtGARsR+uHU8aqlryi6OVcILvsg6Ge5SnN+1e+gc24fJLmt8I
 dsExy30641tCTjUgh9ZMpb6WGwx3w3ACoQjjbwDLFdGmqyD9EV+295Y6ftA7j/EH0K7aSP+UON
 Uy4zOZXf3yxKZxaSoWlUr8Marnd2ws8pouyBHprRyd6DWanXyL9aIwGWYy3Uu0imIESg1VPgsg
 JgM=
IronPort-PHdr: =?us-ascii?q?9a23=3AodkhchTLxqJ7VkfHk9OOgWzQYtpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa69bRON2/xhgRfzUJnB7Loc0qyK6vqmADNYqs/d6TgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrswndrNQajIl+Jqo+1x?=
 =?us-ascii?q?fErWZEcPlKyG11Il6egwzy7dqq8p559CRQtfMh98peXqj/Yq81U79WAik4Pm?=
 =?us-ascii?q?4s/MHkugXNQgWJ5nsHT2UZiQFIDBTf7BH7RZj+rC33vfdg1SaAPM32Sbc0WS?=
 =?us-ascii?q?m+76puVRTlhjsLOyI//WrKkcF7kr5Vrwy9qBx+247UYZ+aNPxifqPGYNgWQX?=
 =?us-ascii?q?NNUttNWyBdB4+xaY4PD+saPeZDron9oVQOpgagCwe1GejvxD5IiWHy3aInzu?=
 =?us-ascii?q?8tFQ/L0BAlE98IrX/arsj6NL0KXO610qfG0DvNYfBR1zrm9ITEbgosre2WUL?=
 =?us-ascii?q?5sbcbcz1QkGQPfjlWXrIzoJzGa1uUMsmib8upgUv+khmknqgBwojig3MYshp?=
 =?us-ascii?q?XVio8b0V3E6Dl2wJwvKdKmVUF7fMepHZ1NvC+ZL4t7Wt0uT31stSogybALuY?=
 =?us-ascii?q?S3cDYXxJkn3RLTdviKfoyQ7h7+VeucJS10iGxrdb+/nRq+70mtxvf+W8S71l?=
 =?us-ascii?q?tBszBLncPWtn8X0hze8s2HSvxg8Ui/wTuPzAXT6v1cIUAziKrbN4Ytwr4umZ?=
 =?us-ascii?q?oXtkTOBir2l1/3jK+Sb0kk4ueo5/n+brXou5ORM4t5hhvxMqQpncy/DuA4PR?=
 =?us-ascii?q?YUU2eH/uS80aXv/Uz/QLpUkv07irfVvIzeKMgBpaO0AxVZ3pg+5xu/FTuqzd?=
 =?us-ascii?q?AVkH0fIFJAYh2HjozpO1/UIPD/CPeym1StkTZrx//cP73tHonBI3bYnbf8Yb?=
 =?us-ascii?q?l98VRQxxQuwtBC/55UEK0OIOrvWk/ts9zVFhs5Mw2yw+b6B9Rxz4AeVnyVAq?=
 =?us-ascii?q?+fLqzStUSF5vwgI+aSfo8ZojX9JOY/5/7ok3A5nUURfa6z3ZsYOziWBPNjdn?=
 =?us-ascii?q?SYc3rxhZ9VAHUKtwtmFLfClVaYFzNfeiDhDOoH+jgnBdf+Xs/4TYe3jenEg3?=
 =?us-ascii?q?+2?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2G8AQDOcW1dgMfXVdFlHQEBBQEHBQG?=
 =?us-ascii?q?BVgUBCwGDV0wQjR2GXwEBAQaLOHGFeoooAQgBAQEMAQEtAgEBhD+CbyM3Bg4?=
 =?us-ascii?q?CAwgBAQUBAQEBAQYEAQECEAEBCQ0JCCeFQ4I6KYJgCxZngRUBBQE1IjmCRwG?=
 =?us-ascii?q?BdhQFnSyBAzyMVohvAQgMgUkJAQiBIgGHHoRZgRCBB4RhhA2DVoJEBIEuAQE?=
 =?us-ascii?q?BlFqWDQEGAoINFIFzklwnhDKJG4sYAS2mEgIKBwYPIYFFgXtNJYFsCoFEgnq?=
 =?us-ascii?q?OLSAzgQiMKoJUAQ?=
X-IPAS-Result: =?us-ascii?q?A2G8AQDOcW1dgMfXVdFlHQEBBQEHBQGBVgUBCwGDV0wQj?=
 =?us-ascii?q?R2GXwEBAQaLOHGFeoooAQgBAQEMAQEtAgEBhD+CbyM3Bg4CAwgBAQUBAQEBA?=
 =?us-ascii?q?QYEAQECEAEBCQ0JCCeFQ4I6KYJgCxZngRUBBQE1IjmCRwGBdhQFnSyBAzyMV?=
 =?us-ascii?q?ohvAQgMgUkJAQiBIgGHHoRZgRCBB4RhhA2DVoJEBIEuAQEBlFqWDQEGAoINF?=
 =?us-ascii?q?IFzklwnhDKJG4sYAS2mEgIKBwYPIYFFgXtNJYFsCoFEgnqOLSAzgQiMKoJUA?=
 =?us-ascii?q?Q?=
X-IronPort-AV: E=Sophos;i="5.64,460,1559545200"; 
   d="scan'208";a="74305840"
Received: from mail-pg1-f199.google.com ([209.85.215.199])
  by smtpmx4.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 12:52:17 -0700
Received: by mail-pg1-f199.google.com with SMTP id l12so9446590pgt.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 12:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=imcM1xVZHBkiHfxi87jX+roFThFEftffl3PXiRWCv+8=;
        b=rAmVfyZa6XskFCoWEiYm5yl7j0BuVq9s0XUaUmLnnfor5bgOsVtRx+bSv5qwmByVaO
         MA3sK4fkdwnlWGLMgswVVyGf2ocvvyBBJ0vTxnZSURD804w/e26U5Y/WaHb9HiSvD03V
         coCnnmNzn3YJIyxhZgJBpkimTHAgkDzYqt7ZiLmOUw1wl8qBmNxPNDU1ihBZAZ41XmNT
         vQqD0MSYIGrX63U50T8pw+/gdkSsbj+qUb9uIk/7GnF6+5t8tK92FmOsBi9tjdRsSqEX
         pXmYzaca3KZGbP/9LqQsXCXqKahYr3IdjZ+4Cxp7H5Y8ol45zE8eYf/YslynnPUmEZOv
         rT6g==
X-Gm-Message-State: APjAAAUBW480IUl4vPToDQHnMtxP5Wv7snTtSnrCXEuE+vUO1U7RAPeS
        rJ8DxUP+QnVOw6wJ3gg/pq8/MYDx5bq/D/yeGRkscbUGhYNkYJLRf+dtyCaOdo+r0EbaZD866wm
        AOnRZ+Gceklkb/de6c4NM1M0fDg==
X-Received: by 2002:a62:1ad3:: with SMTP id a202mr4537049pfa.75.1567453936365;
        Mon, 02 Sep 2019 12:52:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyPBYltAxKyIZu4dx1GwCHmzv2ova/fEu/SPfzXd989va7lJQiG441O5i7EwTD95j5m7ldSNg==
X-Received: by 2002:a62:1ad3:: with SMTP id a202mr4537028pfa.75.1567453936124;
        Mon, 02 Sep 2019 12:52:16 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id s76sm13420529pgc.92.2019.09.02.12.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 12:52:15 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Cezary Jackiewicz <cezary.jackiewicz@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] compal-laptop: Variable "value" in function ec_read_u8() could be uninitialized
Date:   Mon,  2 Sep 2019 12:52:49 -0700
Message-Id: <20190902195249.18221-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function ec_read_u8(), variable "value" could be uninitialized
if ec_read() fails. However, "value" is returned directly and used
in its callers. This is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/platform/x86/compal-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/compal-laptop.c b/drivers/platform/x86/compal-laptop.c
index 09dfa6f48a1a..ab610376fdad 100644
--- a/drivers/platform/x86/compal-laptop.c
+++ b/drivers/platform/x86/compal-laptop.c
@@ -226,7 +226,7 @@ static const unsigned char pwm_lookup_table[256] = {
 /* General access */
 static u8 ec_read_u8(u8 addr)
 {
-	u8 value;
+	u8 value = 0;
 	ec_read(addr, &value);
 	return value;
 }
-- 
2.17.1

