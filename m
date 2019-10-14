Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86CAECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B147F2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wDcXON+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbfJNPqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:46:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38739 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387729AbfJNPqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:46:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id y18so10856906wrn.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 08:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7kINXNWWBt4SCXZfRMWNijcHokD4yWzFteamr/of+Do=;
        b=wDcXON+1m4xAvti7aNKoc4cwF+oGVBwBFrv+CuaZGoSXIxoadjTCogRb+8Gi3on6Ph
         X63WBulioLHClOM0wy48u5QXBnY3CrsffaJ2GHcPloBlVAj++z0zpW/CDqgyaHy5fWTP
         Pwpdx1VDGTtMbhaW1dOfkNWCcevpdo4dOOOzoIHkYWHV1zahTUyITHbfcmukOpiGFMlO
         IFRLoBaAzPD07oiavJbvoyFk5kL4bPekWz+AATsk+e/gpmdjWIk/IV5vEINYtMuCVGhC
         NnEdyHXGWrKNpAucuRa884MReYJfDNCM0GK1o+cHtotwrwIeG9gwhmmf3adlrbyyvx0n
         4Sxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7kINXNWWBt4SCXZfRMWNijcHokD4yWzFteamr/of+Do=;
        b=GKViPMBuktqCdiGtx26XrFeOXGTxwpTLcAoCiFy5/EcSS39Qfwcf0JnK7OnSMZGoP9
         JTJ/WpzDe148hJYij+6xlvh33VKlGKAffcYFQruvvje6+1Qyml60bjBs6UfYKoZwUdRE
         ozUqJP1P55D4LMcz2t1YKi6R4pk5vC6kDItO22+2/fi/YmoWZEldcnINuvAzTDG9blga
         oR7VYRJtReFO3FMV74XvCo7kKnUrkomWLb876YUZfG22jQYjo1rSnAvn8ALMtNaGzMeq
         aaB6K/QwB7SnCvQbKFd1bTHglacWuhZ4cOL4uWFuBkjypUMIOuKzPtAkqQgmaEH7dMAq
         q4XA==
X-Gm-Message-State: APjAAAWrGt4F7ZLwpo4jcuCpXElXLOmduylgd23/GYIFRxVdRgIEWUi9
        wPdOfcjCnVC8vb8tHO1wMpC9kQ==
X-Google-Smtp-Source: APXvYqy0ovnoys29DS6SHPRM492SOwp8R433s33wX1W4a85GrfH/w2L+Td6L/d9LtZee3kn3EjlN3w==
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr10159794wru.25.1571067992613;
        Mon, 14 Oct 2019 08:46:32 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id q22sm16539738wmj.5.2019.10.14.08.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 08:46:31 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v3 2/5] kdb: Simplify code to fetch characters from console
Date:   Mon, 14 Oct 2019 16:46:23 +0100
Message-Id: <20191014154626.351-3-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191014154626.351-1-daniel.thompson@linaro.org>
References: <20191014154626.351-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kdb_read_get_key() contains complex control flow that, on
close inspection, turns out to be unnecessary. In particular:

1. It is impossible to enter the branch conditioned on (escape_delay == 1)
   except when the loop enters with (escape_delay == 2) allowing us to
   combine the branches.

2. Most of the code conditioned on (escape_delay == 2) simply modifies
   local data and then breaks out of the loop causing the function to
   return escape_data[0].

3. Based on #2 there is not actually any need to ever explicitly set
   escape_delay to 2 because we it is much simpler to directly return
   escape_data[0] instead.

4. escape_data[0] is, for all but one exit path, known to be '\e'.

Simplify the code based on these observations.

There is a subtle (and harmless) change of behaviour resulting from this
simplification: instead of letting the escape timeout after ~1998
milliseconds we now timeout after ~2000 milliseconds

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 kernel/debug/kdb/kdb_io.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 68e2c29f14f5..78cb6e339408 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -122,25 +122,18 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
 			touch_nmi_watchdog();
 			f = &kdb_poll_funcs[0];
 		}
-		if (escape_delay == 2) {
-			*ped = '\0';
-			ped = escape_data;
-			--escape_delay;
-		}
-		if (escape_delay == 1) {
-			key = *ped++;
-			if (!*ped)
-				--escape_delay;
-			break;
-		}
+
 		key = (*f)();
+
 		if (key == -1) {
 			if (escape_delay) {
 				udelay(ESCAPE_UDELAY);
-				--escape_delay;
+				if (--escape_delay == 0)
+					return '\e';
 			}
 			continue;
 		}
+
 		if (bufsize <= 2) {
 			if (key == '\r')
 				key = '\n';
@@ -148,28 +141,25 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
 			*buffer = '\0';
 			return -1;
 		}
+
 		if (escape_delay == 0 && key == '\e') {
 			escape_delay = ESCAPE_DELAY;
 			ped = escape_data;
 			f_escape = f;
 		}
 		if (escape_delay) {
-			*ped++ = key;
-			if (f_escape != f) {
-				escape_delay = 2;
-				continue;
-			}
+			if (f_escape != f)
+				return '\e';
 
+			*ped++ = key;
 			key = kdb_read_handle_escape(escape_data,
 						     ped - escape_data);
-			if (key > 0) {
-				escape_data[0] = key;
-				escape_data[1] = '\0';
-			}
-			if (key)
-				escape_delay = 2;
-			continue;
+			if (key < 0)
+				return '\e';
+			if (key == 0)
+				continue;
 		}
+
 		break;	/* A key to process */
 	}
 	return key;
-- 
2.21.0

