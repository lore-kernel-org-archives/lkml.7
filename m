Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDBDC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7E12077B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfH2Qve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:51:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37453 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfH2Qvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:51:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id d16so4551708wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 09:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SKsJY57Vd8P380yZjRTYqZ29aNOB3lqsM0XLQ0UvZ90=;
        b=dcPwbEzWsuDtrypRbAhxp57pQuc10tpytIBhz00FrsBqbK9fZHXIgTpVnVKGLNI4IC
         CtyObWAoa5XzYcTBoegEMxY8kVC67ZxJmsuhd08Y8FuqTJxvTCEhEzWJ0pZV4p1QLT4A
         8WHRPFrfbX3ne3AinoVNimqpuw3oYpF+yAtqvZRf1ITvK+BuIyost+lz3LYliBuly1sR
         bWHH/MeUL3m/84CD5JHfprVt6RYo1tBuNdqUaJuSUl5IF9xvBqI4QsPn1Ee81GdpcWiI
         BXvbY5xknp3PdOCfOgxYKrlS92wBM5HCiorWZ+WFSkuqx/9PAesBQTIl4aiW0yRXgtGf
         gtuw==
X-Gm-Message-State: APjAAAWZVH4IH1CQdf6h2z6bLMk1ixGWlVtAoFeptKPR+iPwXECBHicI
        03QxfTvcNPZ4LEprXqpiWDbSPWWRNok=
X-Google-Smtp-Source: APXvYqzXt0ZDuhoHOdja5D35iM9SDovMAdmyvo7iE8zCgrVqpSk9sdKplvVrsmD5u13Eqz0eyLlQDw==
X-Received: by 2002:a1c:be15:: with SMTP id o21mr12560738wmf.140.1567097489839;
        Thu, 29 Aug 2019 09:51:29 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id o14sm8340770wrg.64.2019.08.29.09.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 09:51:29 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-kernel@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>,
        Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wimax@intel.com
Subject: [PATCH v3 06/11] wimax/i2400m: remove unlikely() from WARN*() condition
Date:   Thu, 29 Aug 2019 19:50:20 +0300
Message-Id: <20190829165025.15750-6-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829165025.15750-1-efremov@linux.com>
References: <20190829165025.15750-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"unlikely(WARN_ON(x))" is excessive. WARN_ON() already uses unlikely()
internally.

Signed-off-by: Denis Efremov <efremov@linux.com>
Cc: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Cc: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-wimax@intel.com
---
 drivers/net/wimax/i2400m/tx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wimax/i2400m/tx.c b/drivers/net/wimax/i2400m/tx.c
index ebd64e083726..1255302e251e 100644
--- a/drivers/net/wimax/i2400m/tx.c
+++ b/drivers/net/wimax/i2400m/tx.c
@@ -654,8 +654,7 @@ void i2400m_tx_close(struct i2400m *i2400m)
 	padding = aligned_size - tx_msg_moved->size;
 	if (padding > 0) {
 		pad_buf = i2400m_tx_fifo_push(i2400m, padding, 0, 0);
-		if (unlikely(WARN_ON(pad_buf == NULL
-				     || pad_buf == TAIL_FULL))) {
+		if (WARN_ON(pad_buf == NULL || pad_buf == TAIL_FULL)) {
 			/* This should not happen -- append should verify
 			 * there is always space left at least to append
 			 * tx_block_size */
-- 
2.21.0

