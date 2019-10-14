Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E39C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF532133F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tI5ziScF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387744AbfJNPqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:46:35 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:33703 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbfJNPqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:46:34 -0400
Received: by mail-wr1-f44.google.com with SMTP id b9so20341745wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 08:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jevXkkwcX0tlcqUocBLqbbviGRXh0qF+AVQ/mfDGUjk=;
        b=tI5ziScFn2BLsrXBgfvUTIl08iV6sOgpXr5k+1Pj1kKR3aqoRMExitDKDlLxjX2GXl
         G59aID6ez6Ymar1kpnivugXNbl5TecFb49b3Ktws91ZWOqgcmaJNJRwT8ouoxOtqjpb4
         C+kfoMT7NwZ1NtmjvsF/3fk70DsbnkwPM5OLjjh41VCuOc80tl3zbxCpNDgKBZ5SRUFc
         wHgqig4h0/LXG/rprIZbvk/Bddsn5CabXMytCxzESJD9PW9sqHjy4BJSTHqTTMA7mFUn
         pizDZ2FrKM2MSTvISU1Fnq6vbuRj2WcbRrb+TBhldU8aWxhS1vw/piJ7dLP6RDicl3OS
         hzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jevXkkwcX0tlcqUocBLqbbviGRXh0qF+AVQ/mfDGUjk=;
        b=bdWF8L8n+n6ZAStqqyvX5xLAnjm4qosktknpCP7IwWP6I7YI4NebqaggYbn5flHfDT
         Uj9ouijv0gWFYy2O/KNnc46yAoAAGlI5qOcRuKbjHhMOl2JYOX5ONkxw4kRj0oQ5Qc+w
         Lh95Ng8q4mHnz1jwM1YjCKrd5ZBSTRQGqO/6c6iRXav3eX8nNFH8WSZxGSyxxmVy3hAf
         rMKSvtdClY6COufccJxWSz19hlCu8euW7ynUoPEgpupDz70kw6D0hLmIOfByPFszGqoO
         ogjdiDmC0y3NGatHoelPvgqHrs29/gcWyqGnwnzD9VRoFCcWR/v76hakWslzLnEyfiiH
         obwQ==
X-Gm-Message-State: APjAAAW2jP5G9ZxhrjyduNTqGbmXyAbLUdUHsdp43vW4HIMhi/tJ++fB
        MRknG2j/WbmvOW17f+hpkHfEMA==
X-Google-Smtp-Source: APXvYqwrhpQluePggjAgvaGAIAcAXqpG1HIcFcJRG+3p3ceuWTCqXStrR4+HdCNFx4yifdG69aY9Wg==
X-Received: by 2002:adf:ed88:: with SMTP id c8mr7828592wro.214.1571067991501;
        Mon, 14 Oct 2019 08:46:31 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id q22sm16539738wmj.5.2019.10.14.08.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 08:46:30 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v3 1/5] kdb: Tidy up code to handle escape sequences
Date:   Mon, 14 Oct 2019 16:46:22 +0100
Message-Id: <20191014154626.351-2-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191014154626.351-1-daniel.thompson@linaro.org>
References: <20191014154626.351-1-daniel.thompson@linaro.org>
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
 kernel/debug/kdb/kdb_io.c | 127 ++++++++++++++++++++------------------
 1 file changed, 66 insertions(+), 61 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 3a5184eb6977..68e2c29f14f5 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -49,6 +49,63 @@ static int kgdb_transition_check(char *buffer)
 	return 0;
 }
 
+/*
+ * kdb_read_handle_escape
+ *
+ * Run a validity check on an accumulated escape sequence.
+ *
+ * Returns -1 if the escape sequence is unwanted, 0 if it is incomplete,
+ * otherwise it returns a mapped key value to pass to the upper layers.
+ */
+static int kdb_read_handle_escape(char *buf, size_t sz)
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
@@ -102,68 +159,16 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
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
+			key = kdb_read_handle_escape(escape_data,
+						     ped - escape_data);
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

