Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47549C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F3F21927
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z0fLFZdi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387790AbfJNPqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:46:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39318 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbfJNPqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:46:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so20322770wrj.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 08:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NXVuAHcqUdvW3hoXUr87/ZG8r6N5TpAF9zjL4wdSLjs=;
        b=z0fLFZdiPdt8jFM79h6y29ec5MdAp59EkR64ijJkc1qehMaqn2x6FJkeo/NnmuHEHk
         j0o5v8iPg0+KK7JLooF72uFuacfEAcb5FywnYGz7gOgd/bdQjzM6xIdbn517084et/Xp
         Bq9Xot8YchrJLHTDzrMGZvXI0Q7d5flJhYIIQifqmAN2SKlNNbYDtyYTLoM83wZjUy9M
         HMEivEnl+VO0Sw0i7PmvinffXtQ6t0u+p+lPg5N9W6YSlxKWX/msc+74g9VSRDOp6Jra
         Ei0/RMsmyksc/XTq8VdmV1LYgxKtE8T6SUbWEuQ1FrPqweF1N6srFJdGMEz+FfxIRraP
         31PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NXVuAHcqUdvW3hoXUr87/ZG8r6N5TpAF9zjL4wdSLjs=;
        b=aqK2RBMrVFZw7hMkn2QdTGrf/849sbeogpTjkiKd8mlhoFCWOSJZDEkdMDyxR4fGEO
         PmrAaJ2TTXAhKmpCozfrl+AwRnzu725TNPaqN1ew3FQhGsKD4r0d8DwpgkS6M5bW83Tf
         W6dqqEEDx3nCGN85wOTZLeamBFibuOUH8RVV4G35o2pbiqN9q5dOzkba3uEwcpPBDeck
         6pcJrEwmbMrSwZiM7pc7qLmyZ5otUuQGuaROVqGrtacbvIvjmr6z65GWhl1F1W7QsLxm
         2D6Ci2b+tKCEfhddMTG7qjQFjrpsfPyYrBGcCS+b7B5cTXIsEtUltCokzVGrxatwxu6u
         2UdA==
X-Gm-Message-State: APjAAAXg0xKbV1uLfPQV5fSyo3MCzHw48vbXwcCeRi0XxQ85DlsvKL6N
        VOT3P0KmgE40YkW98BhM0gAiBg==
X-Google-Smtp-Source: APXvYqx5FADHfzYt8ud++1U/l8HJVf0n/fufR09PMBReCszMIQDI28Ic5gABp6oUYxd229QF8PVDnQ==
X-Received: by 2002:adf:fa12:: with SMTP id m18mr26744805wrr.248.1571067995742;
        Mon, 14 Oct 2019 08:46:35 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id q22sm16539738wmj.5.2019.10.14.08.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 08:46:34 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v3 4/5] kdb: Improve handling of characters from different input sources
Date:   Mon, 14 Oct 2019 16:46:25 +0100
Message-Id: <20191014154626.351-5-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191014154626.351-1-daniel.thompson@linaro.org>
References: <20191014154626.351-1-daniel.thompson@linaro.org>
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
---
 kernel/debug/kdb/kdb_io.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 39476616295e..f9839566c7d6 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -125,10 +125,10 @@ char kdb_getchar(void)
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
@@ -148,27 +148,26 @@ char kdb_getchar(void)
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
-			key = kdb_handle_escape(escape_data,
-						     ped - escape_data);
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

