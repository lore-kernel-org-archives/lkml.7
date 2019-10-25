Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A43CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E77F21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F5JEpHMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406986AbfJYHdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 03:33:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41078 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406004AbfJYHdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:33:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id p4so1069788wrm.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 00:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VxRxdqK8wDgtRtqhN/4fmGim8qsHy1Sh2vs1pQm0S1s=;
        b=F5JEpHMej8YX8/tXiqp25sBGpi1nHuIwrK/ACEWIlTPQozJML/KptQdG5HGN4mB0mN
         Dmj9dtiWrZYX+yR4JK3i5Lrw7hKeW+ZMJhTepWlCKmhVeVGbDNAPXVaKRs49ut5Lchs0
         pGD2ZDoyvmprP9o6AMdzq9FkIlo5jzFVLmfO6O0XiN/zFuzIo43Ms3rH2k8+GWNv37wk
         Aq9mXXxRAIzdsuXmoGscnLJrlSDOetxBr+G4c3kWFlddhFxWqp7ShmIBashpCE7vlqNI
         JqRXHfCVpcFEjLwlJbT8XxvWOLUMeeWwrzIKjnAHNEPWE1XG74iy+9G1Ok8qTXMOQYad
         KaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VxRxdqK8wDgtRtqhN/4fmGim8qsHy1Sh2vs1pQm0S1s=;
        b=nTPou0FZsW6b4fvv3+hy7F+or4kb3r+Hu0kovOFrZjibQARzMN58V+ZKTg+1AIhT4M
         97QGK5fI5OPr8CVGueYLByPv2JcIKS80IcozOAWRE7UfQIU/rzsCqrdAqbSqndWpLAkO
         EBbb2uXTC2xuKp+JGGniZkkiQK65kpsb0KRtzAJ9lvIwCqP8glRQ2b8/RSHdLvUGpnUw
         enjeVErcrTAP8Abc5bjKZfv7EOW9Ok5Irsg1bIzgWydNTS8izDhb+VZd6ouAYbx/G7SP
         19xGVo493Te0VlV5vzQiEGxmDTN6i9XqCayPg/eU5CiDny03ZKqdCltKeBxgfZ4YShL5
         CcEA==
X-Gm-Message-State: APjAAAXmuV9mz3z27uoYpJ11TCth5GxWv7+Q+ICq1+oh6I2XbL5Qxf5O
        kL4rZxzmP0yfAqLIh+ofeGeHsg==
X-Google-Smtp-Source: APXvYqwDI5MATscItj7Zxy/MypGFHIa/wSL6G9jo3i0hphS69xVNL/iB2urgVUDMDDWBUq8S5GQmGQ==
X-Received: by 2002:a05:6000:118f:: with SMTP id g15mr1440429wrx.242.1571988827402;
        Fri, 25 Oct 2019 00:33:47 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id a11sm1586602wmh.40.2019.10.25.00.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 00:33:46 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v4 4/5] kdb: Improve handling of characters from different input sources
Date:   Fri, 25 Oct 2019 08:33:27 +0100
Message-Id: <20191025073328.643-5-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025073328.643-1-daniel.thompson@linaro.org>
References: <20191025073328.643-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if an escape timer is interrupted by a character from a
different input source then the new character is discarded and the
function returns '\e' (which will be discarded by the level above).
It is hard to see why this would ever be the desired behaviour.
Fix this to return the new character rather than the '\e'.

This is a bigger refactor than might be expected because the new
character needs to go through escape sequence detection.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 kernel/debug/kdb/kdb_io.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 9b6933d585b5..f794c0ca4557 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -127,10 +127,10 @@ char kdb_getchar(void)
 {
 #define ESCAPE_UDELAY 1000
 #define ESCAPE_DELAY (2*1000000/ESCAPE_UDELAY) /* 2 seconds worth of udelays */
-	char escape_data[5];	/* longest vt100 escape sequence is 4 bytes */
-	char *ped = escape_data;
+	char buf[4];	/* longest vt100 escape sequence is 4 bytes */
+	char *pbuf = buf;
 	int escape_delay = 0;
-	get_char_func *f, *f_escape = NULL;
+	get_char_func *f, *f_prev = NULL;
 	int key;
 
 	for (f = &kdb_poll_funcs[0]; ; ++f) {
@@ -150,26 +150,26 @@ char kdb_getchar(void)
 			continue;
 		}
 
-		if (escape_delay == 0 && key == '\e') {
+		/*
+		 * When the first character is received (or we get a change
+		 * input source) we set ourselves up to handle an escape
+		 * sequences (just in case).
+		 */
+		if (f_prev != f) {
+			f_prev = f;
+			pbuf = buf;
 			escape_delay = ESCAPE_DELAY;
-			ped = escape_data;
-			f_escape = f;
-		}
-		if (escape_delay) {
-			if (f_escape != f)
-				return '\e';
-
-			*ped++ = key;
-			key = kdb_handle_escape(escape_data, ped - escape_data);
-			if (key < 0)
-				return '\e';
-			if (key == 0)
-				continue;
 		}
 
-		break;	/* A key to process */
+		*pbuf++ = key;
+		key = kdb_handle_escape(buf, pbuf - buf);
+		if (key < 0) /* no escape sequence; return first character */
+			return buf[0];
+		if (key > 0)
+			return key;
 	}
-	return key;
+
+	unreachable();
 }
 
 /*
-- 
2.21.0

