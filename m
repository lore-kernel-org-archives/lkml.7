Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0CDC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1C220835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yR1nmvMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfCGKN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:13:28 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40201 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfCGKNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:13:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id g20so8559628wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 02:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Niv4ry4Ht+sxGjnCxKmfDqaEVLiah3CqjMUhN/hOXN4=;
        b=yR1nmvMf1fCdlxvgSENtriX3WgsjDI+IPDnnJk7JFdhE8JCSWg4NTREZytgNAcvFaT
         IK3l2fRCkQPyDD2Hz4Zsu8j3+ygSljewQzP484SfLz5HPxag9gg3Mre8FwziCHLOE1oJ
         78e3K+2UUjYbQVJUl4AUywyzL2uMNP/KLtrELjQBW6vlZMGng2n0gcH/0vwzIVQ2SDZr
         0gMdF2+58yoSIefo7o/kJ0VU7Kqcqb5alBDB14uZC4LF797rUozoJpyrf79WA1CDuglq
         xhXuOwNC7LfiOlsQsw4sIjbib50TmtBenyT70Fr2TDHLqEQE+TCF0E1VC2TJK2joaBvi
         EZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Niv4ry4Ht+sxGjnCxKmfDqaEVLiah3CqjMUhN/hOXN4=;
        b=JsvYRQXJczjwPXKoUufCGRikbsKNrRwalncgj0Vl9eCZ4A16nH9pF3gep7KWNXzrqO
         7S0tUyz+3Q5ea5CVhN0FanQmqPorjhEU83nznowC/YuYFIRmQhLEYoWPQlAlN2yG0kvF
         ZQ3JCxlzXfhHOj0zCfgHMywJe4wzqSzLf/Bf0GwwJZmX8AZtRlvXbGY5H1i8qsUb+oS2
         YtpMmXJuEvWZishT23QUnuEwKR1JaV3Mz6lDO4RAfboUCHjrTVDir3lN9lKsOoygvjdv
         e5BbbQo44noPnOCc385PZKjJUPtJAeVJrBw+JkIlYizEmHFYmqZZ5cJsTvlVzW49kYKC
         EIkg==
X-Gm-Message-State: APjAAAXcSpCb08szAQOXIttxYBmVOStF6FaOeQ6gqKlz6cBqwSHwp741
        pqwOJAuTte31WHDl1+U7OCLBQBQo7+0=
X-Google-Smtp-Source: APXvYqzQSQOhGP7mcMiQ7DvKUQT18m0jQ3nojdHhccG8hfEjkidGlZYv0Bcw8BWJit6QxZ1o//yPww==
X-Received: by 2002:a1c:2dd1:: with SMTP id t200mr5046697wmt.148.1551953603357;
        Thu, 07 Mar 2019 02:13:23 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id n9sm3529767wmi.33.2019.03.07.02.13.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 02:13:22 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        ktadakam@qti.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 8/8] misc: fastrpc: increase max init file size to 64 MB
Date:   Thu,  7 Mar 2019 10:12:29 +0000
Message-Id: <20190307101229.7856-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190307101229.7856-1-srinivas.kandagatla@linaro.org>
References: <20190307101229.7856-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases where Neural Processing is required the size of init process
exceeds default size of 2MB, increase this size to 64MB which is required
for QCS404 CDSP Neural Processing.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index d0e2e2620087..7e0d4528f3b9 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -32,7 +32,7 @@
 #define FASTRPC_CTX_MAX (256)
 #define FASTRPC_INIT_HANDLE	1
 #define FASTRPC_CTXID_MASK (0xFF0)
-#define INIT_FILELEN_MAX (2 * 1024 * 1024)
+#define INIT_FILELEN_MAX (64 * 1024 * 1024)
 #define INIT_MEMLEN_MAX  (8 * 1024 * 1024)
 #define FASTRPC_DEVICE_NAME	"fastrpc"
 
-- 
2.21.0

