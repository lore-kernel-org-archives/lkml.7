Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE5AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F4017206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wwNfzBdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbfJHNVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:21:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41324 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730332AbfJHNVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:21:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id q9so19398063wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 06:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aow4Ms/uS5HYvl47E6APw8x/hPXJ5HEyt9xExUwySdY=;
        b=wwNfzBdwi+tFi4BAUOyHRxO6sorSM8lVJ0f9OAf/MSR66X2lKs83f5eUB33YApalVX
         DfbAID5zJHC+4shWyp8zC0I5X7YkdXjVNfcPkPirASMdmdzhHb88bim0n/2batTqVJRv
         kYf6f/zuRO1fawEMpXrpt5Vcy9AJeeCIMNkIN6DefjZgQuTONg9Ksi85K/qNK8d1fjOd
         5Odbk25PcC6sEH/YXIndJQ3+1wr1dhQJ1tlKpH6m9Nz4M6cfo9oAL//ZU0WNas+QuqxW
         hxPYxi4BPjP2kqJTiBFgC1KlH/wbh1kGeQ+d+qSLmHkzQLK69ZjQzM/6pWFChJh9YXzs
         a/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aow4Ms/uS5HYvl47E6APw8x/hPXJ5HEyt9xExUwySdY=;
        b=hg+AK+73VPeF8mwaSs5nXCdDaMZoYbNIpWeJJiJFcGnyN73ds+NmwG1kCfx4imMdUC
         BUJQzZtuui0k7F9yH2Wa2ikUiOpRLtlBa7F7L8Tr3EiCok27hXO9dbLI6FvE3JQkCvK8
         Fm6t+b2LctiC7xvL/BT02Xwf+P2xqaBw5ciHFqbtUzhYEBS8O0vvKm7FdrKMngy0l5ya
         u0u4bRcwZcUGulkUJbKowe1QiBJ5OzCZh7y7wRBbPvhnvvD6UKMAhWCAi4joVq3757Vn
         pxY7+KVuM/mXPudpil+epBS5gq3RObIH4CaqG6qfcEgejRFO8WVBKeOeSP6rMaGOZ+N8
         HSJw==
X-Gm-Message-State: APjAAAX1ywjokVqu0usiuJ6ng01ZCEE8lHL58LnLrkYS5xMamXmLcU/W
        0fraTOXiBv9pWob974uk9FT3Nw==
X-Google-Smtp-Source: APXvYqyS4GHDWXh8kUnxEPgegNjfoS/nOujwEIaubur1wcA3ko8QUV+4bqOePx6mf8a6cIqbdxBmVQ==
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr28870355wrt.100.1570540861496;
        Tue, 08 Oct 2019 06:21:01 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id t8sm18237214wrx.76.2019.10.08.06.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 06:21:00 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v2 2/5] kdb: Simplify code to fetch characters from console
Date:   Tue,  8 Oct 2019 14:20:40 +0100
Message-Id: <20191008132043.7966-3-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191008132043.7966-1-daniel.thompson@linaro.org>
References: <20191008132043.7966-1-daniel.thompson@linaro.org>
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

