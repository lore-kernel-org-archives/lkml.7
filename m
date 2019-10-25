Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3B3CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8701720867
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KZPcyclU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394324AbfJYHdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 03:33:47 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:55687 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394292AbfJYHdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:33:45 -0400
Received: by mail-wm1-f48.google.com with SMTP id g24so910905wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 00:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K2G9g70k35Ma4xF7YfZ9Z31DwyEbpBEhJM1jJfvb0Ls=;
        b=KZPcyclUjyY3yLuxdwofig+TMKb8hwaV/GkEcAnwSOzk46h9+ITKqyXeyxWpnIrWuX
         nDy7RdqY/pj3FifZQks815NKfP+KPn5CGujJofWfn2eHvm//5FawiG/ZIE0WF4Q6ZMjf
         sdgk8LCX96ssM3eihwYzq8pPN44a05KlVGxI2CSWb1d1qxakYWfvCZNsKuzYn4EVhTsQ
         mNisCKFMW1Nnn9Gw2WZpqru3/5txrIpYVrSwBF09yuJmL6nTE8ixDpPz7n2xANdjYbny
         0ZRIWRinykxgRdKuuceIFRIngP4GJhTxKaVt0AU2PoIu1kKP16DK/0x/qNIJJiAooKh7
         u/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K2G9g70k35Ma4xF7YfZ9Z31DwyEbpBEhJM1jJfvb0Ls=;
        b=E+K2G32bj5BHR+yovrdkx93XDZvLYwKKYetPS2LooMLvs8hcg2CnSs1HegypNTCqIM
         +gqqXqer51hIagOo/jFKvDTllNSorhxPB0MIMS9aoQOgg5cxUoB9P6ya+xdqOzWyWhCv
         nHolzgvwcoD5buIcxxplwh6GDXsrlZPQDKVJiGpNAgOk3RHK7vZ8TscdOFNtU6WbOKVS
         GXKhdutLI8LoyTW3AtSiXWzJKBRQQHjFAaiC4Yc2+6RiIY2/qvPmQZjcHK1s9coGbMO9
         VNZdcOVmIX2lp5jGT/PfO7atJeFwHYZE165wzmsJjS0uJDAeWl9N2ayWGiqNs019Rtwm
         Orqw==
X-Gm-Message-State: APjAAAUPy5fzrN67YCP34x5GGt0c8rPZOiDuB0kTVaVNTw0pdyEVhrFO
        M8njzXZ1cOF0kuu7oUC1ykZRzw==
X-Google-Smtp-Source: APXvYqyz5HgKF726DT+MGAt4cBrrtuTFCrfsKRMpI2Z6psLGtRU1rTjmt7F4Zu6P/chlp+WcoOAfaw==
X-Received: by 2002:a1c:1d53:: with SMTP id d80mr1047271wmd.88.1571988823439;
        Fri, 25 Oct 2019 00:33:43 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id a11sm1586602wmh.40.2019.10.25.00.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 00:33:42 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v4 1/5] kdb: Tidy up code to handle escape sequences
Date:   Fri, 25 Oct 2019 08:33:24 +0100
Message-Id: <20191025073328.643-2-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025073328.643-1-daniel.thompson@linaro.org>
References: <20191025073328.643-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kdb_read_get_key() has extremely complex break/continue control flow
managed by state variables and is very hard to review or modify. In
particular the way the escape sequence handling interacts with the
general control flow is hard to follow. Separate out the escape key
handling, without changing the control flow. This makes the main body of
the code easier to review.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 kernel/debug/kdb/kdb_io.c | 128 ++++++++++++++++++++------------------
 1 file changed, 67 insertions(+), 61 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 3a5184eb6977..cfc054fd8097 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -49,6 +49,65 @@ static int kgdb_transition_check(char *buffer)
 	return 0;
 }
 
+/**
+ * kdb_handle_escape() - validity check on an accumulated escape sequence.
+ * @buf:	Accumulated escape characters to be examined. Note that buf
+ *		is not a string, it is an array of characters and need not be
+ *		nil terminated.
+ * @sz:		Number of accumulated escape characters.
+ *
+ * Return: -1 if the escape sequence is unwanted, 0 if it is incomplete,
+ * otherwise it returns a mapped key value to pass to the upper layers.
+ */
+static int kdb_handle_escape(char *buf, size_t sz)
+{
+	char *lastkey = buf + sz - 1;
+
+	switch (sz) {
+	case 1:
+		if (*lastkey == '\e')
+			return 0;
+		break;
+
+	case 2: /* \e<something> */
+		if (*lastkey == '[')
+			return 0;
+		break;
+
+	case 3:
+		switch (*lastkey) {
+		case 'A': /* \e[A, up arrow */
+			return 16;
+		case 'B': /* \e[B, down arrow */
+			return 14;
+		case 'C': /* \e[C, right arrow */
+			return 6;
+		case 'D': /* \e[D, left arrow */
+			return 2;
+		case '1': /* \e[<1,3,4>], may be home, del, end */
+		case '3':
+		case '4':
+			return 0;
+		}
+		break;
+
+	case 4:
+		if (*lastkey == '~') {
+			switch (buf[2]) {
+			case '1': /* \e[1~, home */
+				return 1;
+			case '3': /* \e[3~, del */
+				return 4;
+			case '4': /* \e[4~, end */
+				return 5;
+			}
+		}
+		break;
+	}
+
+	return -1;
+}
+
 static int kdb_read_get_key(char *buffer, size_t bufsize)
 {
 #define ESCAPE_UDELAY 1000
@@ -102,68 +161,15 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
 				escape_delay = 2;
 				continue;
 			}
-			if (ped - escape_data == 1) {
-				/* \e */
-				continue;
-			} else if (ped - escape_data == 2) {
-				/* \e<something> */
-				if (key != '[')
-					escape_delay = 2;
-				continue;
-			} else if (ped - escape_data == 3) {
-				/* \e[<something> */
-				int mapkey = 0;
-				switch (key) {
-				case 'A': /* \e[A, up arrow */
-					mapkey = 16;
-					break;
-				case 'B': /* \e[B, down arrow */
-					mapkey = 14;
-					break;
-				case 'C': /* \e[C, right arrow */
-					mapkey = 6;
-					break;
-				case 'D': /* \e[D, left arrow */
-					mapkey = 2;
-					break;
-				case '1': /* dropthrough */
-				case '3': /* dropthrough */
-				/* \e[<1,3,4>], may be home, del, end */
-				case '4':
-					mapkey = -1;
-					break;
-				}
-				if (mapkey != -1) {
-					if (mapkey > 0) {
-						escape_data[0] = mapkey;
-						escape_data[1] = '\0';
-					}
-					escape_delay = 2;
-				}
-				continue;
-			} else if (ped - escape_data == 4) {
-				/* \e[<1,3,4><something> */
-				int mapkey = 0;
-				if (key == '~') {
-					switch (escape_data[2]) {
-					case '1': /* \e[1~, home */
-						mapkey = 1;
-						break;
-					case '3': /* \e[3~, del */
-						mapkey = 4;
-						break;
-					case '4': /* \e[4~, end */
-						mapkey = 5;
-						break;
-					}
-				}
-				if (mapkey > 0) {
-					escape_data[0] = mapkey;
-					escape_data[1] = '\0';
-				}
-				escape_delay = 2;
-				continue;
+
+			key = kdb_handle_escape(escape_data, ped - escape_data);
+			if (key > 0) {
+				escape_data[0] = key;
+				escape_data[1] = '\0';
 			}
+			if (key)
+				escape_delay = 2;
+			continue;
 		}
 		break;	/* A key to process */
 	}
-- 
2.21.0

