Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ED8C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8CC206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tZfC1OM8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbfJHNVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:21:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39844 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730332AbfJHNVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:21:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so19417063wrj.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 06:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zRFXe3/XZQCUi1W0+GR//OOmf/+747T61SkEsMl88/k=;
        b=tZfC1OM8yntNwmeY8DAkjskgZ4slX04meu2wTKakCs13kvAbXSBqEwTrQ9aC2yuPML
         OHcDHrf/kxg7FZQc/bw5zY+4gw2NEUUh+Kan7Efd79O7lwR4tYdG5Ez1HZlIt6tnd5g6
         RQnyvNGFQZCIWBeImePzvn0xNbkGynWCXxsrKdMTufPSnkx0Nw6NgQD/t19klEMPlGia
         +hbI4WRCv7GGXO50twrjV6esz8V7EnR3akgbWjXhCwYSEvIvCzJ1AxoPB2Mg/6V1KdUE
         19it6wJ7xMQ7755HDqWvENvwa/+R+1Kxtl2IQxVfBH7Tp1Eb6cujDx22F/QNnXvrxBnd
         zaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zRFXe3/XZQCUi1W0+GR//OOmf/+747T61SkEsMl88/k=;
        b=iQ5RPcojrZZuoBYuxqZUCSSya3YRisBa/lJVY3bD8F957bc8rZKqKMGf+cEhqtAvGH
         iwiODhgTeM4qPAkbv2UPok4WJwXZvnsTz+gqJDYiP/xJs98LzR2nJxlQGxuxstu4rWdS
         uzlvN3Pcv01UAnC6+pw6x1ZEs3/zqczGkR3/3AQWfUSIjqsnLw32p+LHDpCDJqf9j2s6
         3kApJJEMZd0NJqtxrRmyKzRviTmq3O0kHM9xIkO/8ooCn8x3mV6epAdJ8XuJwqiqeKkR
         N82/eB8vTmOIe1JQidT9IyNhsjgggs6bZj+NwiwsBSO5j1Vyr8jA5kGrxRv9bipbY5jQ
         Uk+Q==
X-Gm-Message-State: APjAAAW6nEutZxX/zkb7vlT8T3vxtmNLJIHclyNmReVgFtGfSdK4qlAO
        2q/AUt6nSUmkq7r/R8YrqX8Hfw==
X-Google-Smtp-Source: APXvYqwgrNAtVXxMcAt3CGH50mxfEVwuB6vCmi+Ycmt+f/kJStXemqbH+BSDPfEc5kcFu46toPhOYw==
X-Received: by 2002:adf:9d87:: with SMTP id p7mr25812577wre.245.1570540863921;
        Tue, 08 Oct 2019 06:21:03 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id t8sm18237214wrx.76.2019.10.08.06.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 06:21:03 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v2 4/5] kdb: Improve handling of characters from different input sources
Date:   Tue,  8 Oct 2019 14:20:42 +0100
Message-Id: <20191008132043.7966-5-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191008132043.7966-1-daniel.thompson@linaro.org>
References: <20191008132043.7966-1-daniel.thompson@linaro.org>
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
Fix this to return the new character rather then the '\e'.

This is a bigger refactor that might be expected because the new
character needs to go through escape sequence detection.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index a9e73bc9d1c3..288dd1babf90 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -122,8 +122,8 @@ static int kdb_getchar(void)
 {
 #define ESCAPE_UDELAY 1000
 #define ESCAPE_DELAY (2*1000000/ESCAPE_UDELAY) /* 2 seconds worth of udelays */
-	char escape_data[5];	/* longest vt100 escape sequence is 4 bytes */
-	char *ped = escape_data;
+	char buf[4];	/* longest vt100 escape sequence is 4 bytes */
+	char *pbuf = buf;
 	int escape_delay = 0;
 	get_char_func *f, *f_escape = NULL;
 	int key;
@@ -145,27 +145,26 @@ static int kdb_getchar(void)
 			continue;
 		}
 
-		if (escape_delay == 0 && key == '\e') {
-			escape_delay = ESCAPE_DELAY;
-			ped = escape_data;
+		/*
+		 * When the first character is received (or we get a change
+		 * input source) we set ourselves up to handle an escape
+		 * sequences (just in case).
+		 */
+		if (f_escape != f) {
 			f_escape = f;
-		}
-		if (escape_delay) {
-			if (f_escape != f)
-				return '\e';
-
-			*ped++ = key;
-			key = kdb_read_handle_escape(escape_data,
-						     ped - escape_data);
-			if (key < 0)
-				return '\e';
-			if (key == 0)
-				continue;
+			pbuf = buf;
+			escape_delay = ESCAPE_DELAY;
 		}
 
-		break;	/* A key to process */
+		*pbuf++ = key;
+		key = kdb_read_handle_escape(buf, pbuf - buf);
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

