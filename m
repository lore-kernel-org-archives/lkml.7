Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55258CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7D621D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cvs9FoyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394314AbfJYHdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 03:33:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56095 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfJYHdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:33:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id g24so910960wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 00:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N2ThTAgeoHW31mlsGh12ha2Pd6KE6BHGLEXeQ2AbFfI=;
        b=Cvs9FoyYv3MIFrp8WsjkZyLWI7/e8F24s3eJ99R0F1t4im2+jVXGtFQuSpT7wg3scc
         wsdBc7PXrlNxj22obCjBZy14slZaCxrfheFn1+wmC8Xy1rZaOWc1eQ60VjEYGPp6b/xo
         iIkWjEJYecuOfoEUGTAsoCrjvgxigmHbtwl2qh4UB2czJI2aNxSxmZ+EedpO2rYEueBe
         mZWcnRQGeptOqWd2+S6GA59sILp53CTh9fm3jOrMTtjcObFTulfmEGsOM9IQDxcAoRzl
         j7AIrrWMZL7YrxHf+6bFe9NhFOXQ1RWVWS58lPGPx5ABi9/7dLBYS8ib4dqZ2AQvMOmR
         d80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N2ThTAgeoHW31mlsGh12ha2Pd6KE6BHGLEXeQ2AbFfI=;
        b=Fo7Nlbsf/phcBxHMoq1V1zHZDVBFK0aVdRMvm6BKMmtw9tEHwRnvRj1iILlONKqLRr
         AVe1iq7u3Gxz4dx1y1xmYGlb15Kxq1CAjU0Ip7HCcs3324pCsLc3LxdTNYyjMPQxWXBe
         G88LdBs1gLjr/kYXF69hhpSel7XR6OAYFh1JSNn2FN61IP1WP7OtNZCb3ZvrmTryBduh
         Q1kXqTEH4dJ9uxyR1gy2VdyKdk0wZ1XbbfpjgvE6+zNGdKUfXv0Cn5mEjjW+KaAES5Hs
         KhXh+cV9UD3+qzL7vZG2BnUIreIf+sKgFTkm4P6seNc/g0dUO5mZOprWl02PJA7xcN4v
         8goA==
X-Gm-Message-State: APjAAAWGUqjAh05Ge/qoXp2PEWhd8crCHGPy9ErIIY3tuIChQQUJOpmP
        V1H6zagqhBX7xzJ5h5lxlyiOo0x6+KHPFQ==
X-Google-Smtp-Source: APXvYqwyGKGRjS9F8gjBeH9bcpVse8C1AwyaGfdsUQNKHh5P4Ahfrc9NpXUS5b2AvwtLf8hZ5yKnQw==
X-Received: by 2002:a7b:cd89:: with SMTP id y9mr2191028wmj.51.1571988824531;
        Fri, 25 Oct 2019 00:33:44 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id a11sm1586602wmh.40.2019.10.25.00.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 00:33:43 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v4 2/5] kdb: Simplify code to fetch characters from console
Date:   Fri, 25 Oct 2019 08:33:25 +0100
Message-Id: <20191025073328.643-3-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025073328.643-1-daniel.thompson@linaro.org>
References: <20191025073328.643-1-daniel.thompson@linaro.org>
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
index cfc054fd8097..a92ceca29637 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -124,25 +124,18 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
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
@@ -150,27 +143,24 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
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
 			key = kdb_handle_escape(escape_data, ped - escape_data);
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

