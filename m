Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F14DCA9EC1
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032F221835
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTKQ5eL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbfJ2Bno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 21:43:44 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32932 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbfJ2Bnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 21:43:40 -0400
Received: by mail-qt1-f194.google.com with SMTP id y39so12421296qty.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 18:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lAvEaeqENeVb/DhAt46H1R5niz9Z9sNvfAe5diIhyRY=;
        b=YTKQ5eL3jNc2ylypKneapURZFnFOC7if9/ntbG+5qwp8Rc8G83PNiMQjG2qeGkKWIE
         WROILV8irXpeXLAzcVzVegChTLAxwfB0Rh0WWVjW2SPrq1fZ4vrNWRzt2zL0NgN8mvpp
         FUFTBShNt+Z3UmEWhl/WVLJOBlNNV07Vv4vESyc5K0g25MA6fRQ41jPPI8H3L8Qx6Hve
         CLkYAe+439/eKzHHDIDz1Yu7MPb3DgANyvJrpd+83ud+MPjNTP2ZRiCP1f8elguyxtTV
         /vmO2RTy01PqhsbmG4mb5XHGS950hQIEBNWf2x7CKhvDhnFwzZclfIu3hgehAG/o6nx1
         pEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lAvEaeqENeVb/DhAt46H1R5niz9Z9sNvfAe5diIhyRY=;
        b=AymRn4BjPZkG0i5JNRXJxiuZzqZafA/HXPMPKWxRgLWGuuN1pLIRWiwFchjkjCFLXO
         k/Pnz0iUaESCzLXRj29hPyf0Gf5bq9RbcCH5e84RF4J8uO7EoAOGrvwAwhfqt3KbSvF1
         4KixrUeRzlbj6C5ffeD/yRx3gfDF3kg2TFWy4vI+li/xXwPd8QfTZkZoDZB/szHCTxpq
         2JSqAnVj4NHpJ3A+Jb+EOweRcezgI5sJYm9Lo6GPTBpkidz1CLmXlOKev8NjoulXGURh
         eWhZPDfewZAmifa1sIDPFxgRA6+8e0VfpxapabKsZHJ7iu+NR2T2tz252aMwG2HCF+La
         zbOg==
X-Gm-Message-State: APjAAAWJhpAwdOo4k+Zbp9Vk4pb2qFuTHuKXXq+dYlkfY7OTvIpoKUny
        6S+iRB4LTe50QcKTGoO8WLDGIYXkv7Q3GA==
X-Google-Smtp-Source: APXvYqzZzThiov5OFoGD+8O8B/45mrFpAsO02vijv25JLzLZ5cAJ9CHt0/q3V7pq3tkhuxB7MupspQ==
X-Received: by 2002:a0c:94d7:: with SMTP id k23mr19000528qvk.200.1572313419369;
        Mon, 28 Oct 2019 18:43:39 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:483:ade:87ad:69fb:5b32:cf88])
        by smtp.gmail.com with ESMTPSA id 197sm6698394qkh.80.2019.10.28.18.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 18:43:38 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        kim.jamie.bradley@gmail.com, nishkadg.linux@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH 5/5] staging: rts5208: Eliminate the use of Camel Case in file sd.h
Date:   Mon, 28 Oct 2019 22:43:16 -0300
Message-Id: <20191029014316.6452-6-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191029014316.6452-1-gabrielabittencourt00@gmail.com>
References: <20191029014316.6452-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up checks of "Avoid CamelCase" in file sd.h

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/rts5208/sd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/sd.h b/drivers/staging/rts5208/sd.h
index dc9e8cad7a74..f4ff62653b56 100644
--- a/drivers/staging/rts5208/sd.h
+++ b/drivers/staging/rts5208/sd.h
@@ -232,7 +232,7 @@
 #define DCM_LOW_FREQUENCY_MODE   0x01
 
 #define DCM_HIGH_FREQUENCY_MODE_SET  0x0C
-#define DCM_Low_FREQUENCY_MODE_SET   0x00
+#define DCM_LOW_FREQUENCY_MODE_SET   0x00
 
 #define MULTIPLY_BY_1    0x00
 #define MULTIPLY_BY_2    0x01
-- 
2.20.1

