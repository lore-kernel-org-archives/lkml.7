Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B56C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4757C20679
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3naw4cy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbfFTOLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:11:00 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43179 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732001AbfFTOK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:10:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id 16so2822923ljv.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 07:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NpAs0Rq9F1GVcM1iEuyCuwPux0eS1gd8j8020bDIIDc=;
        b=r3naw4cyU8IXOhRYIgs5R6ygDdL3aodR/NDpWNiIV44JFXKfkU9jRWGIeAMDqsuTOF
         rpGmzoVqni5QeJX4J3Ucp/gN6m6T2+WLJexVut0siw8oZkAGzUyYgL8V93IkT1Imyu9N
         ETfbMAYhtA1Lu+LJYuEKkUG7VDia/1m3OPwqygbnr7jJh9ckdHjct9lyrJybU3oGdRMn
         LgYkgvhAH33N70AlwpmpUIrxbdOXuGe3qpSAbD3ckaOBRVAuBMEOo0dKZOsQCnt712JR
         5zeHdwugaVyHKGPHyMADuXL9N7s8JEExzgOqr7WBunrFD24DIgeJedZ0636aELY/wx6H
         0twg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NpAs0Rq9F1GVcM1iEuyCuwPux0eS1gd8j8020bDIIDc=;
        b=bb28Wk2QaisIZZ81n4UJRVTeiHcDJBrJuNfkAMkXPd4I3QC6Nfc0L+0aEaLoden0Zh
         wln6uUDNWC+rI979WrT2c1GsxnrU11LMwXBr0969cZzqHf8eXo2BTmTcxD4mTVqUFJ09
         7Qe48oe34+Ibg9jCghYGlBAhFng5elLPKFPlm8uuX766h7Twh0llNxL5UUUBK36+0SKj
         zcXw0NqJwA6ea73AsTosE7kN/9af0ASlBiWjKSznLNt5FdAWnjgMAI/JWxb+zD/SWPqg
         gfQbULtZ67gwK3GeGwbgcrRGNYP4IUlsJTtH4bpnFXNXAodYcz6l+Bb0TkZZUz0adzrT
         qtFQ==
X-Gm-Message-State: APjAAAUHGDaGc9bRynC3ExpDe8qq/zbsULSa78zE+PghIrm0LTbCUvxH
        mzoicWaGTChSQ5bQgeEDdy8a2w8v
X-Google-Smtp-Source: APXvYqx6Oo2GrKNt06xbiW8rRXheyi2pucpdXR9QjkQ+gkGbV/j3AaJAYgp2j+Yb8bvej2dMcoAE0w==
X-Received: by 2002:a2e:8696:: with SMTP id l22mr10871282lji.201.1561039853627;
        Thu, 20 Jun 2019 07:10:53 -0700 (PDT)
Received: from localhost.localdomain (v902-804.aalto.fi. [130.233.11.55])
        by smtp.gmail.com with ESMTPSA id 27sm3524684ljw.97.2019.06.20.07.10.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 07:10:53 -0700 (PDT)
From:   Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 4/7] rslib: decode_rs: code cleanup
Date:   Thu, 20 Jun 2019 17:10:36 +0300
Message-Id: <20190620141039.9874-5-ferdinand.blomqvist@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190620141039.9874-1-ferdinand.blomqvist@gmail.com>
References: <20190620141039.9874-1-ferdinand.blomqvist@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing useful was done after the finish label when count is negative so
return directly instead of jumping to finish.

Signed-off-by: Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
---
 lib/reed_solomon/decode_rs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
index 22006eaa41e6..78629bbe6590 100644
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -88,8 +88,7 @@
 		/* if syndrome is zero, data[] is a codeword and there are no
 		 * errors to correct. So return data[] unmodified
 		 */
-		count = 0;
-		goto finish;
+		return 0;
 	}
 
  decode:
@@ -202,8 +201,7 @@
 		 * deg(lambda) unequal to number of roots => uncorrectable
 		 * error detected
 		 */
-		count = -EBADMSG;
-		goto finish;
+		return -EBADMSG;
 	}
 	/*
 	 * Compute err+eras evaluator poly omega(x) = s(x)*lambda(x) (modulo
@@ -261,7 +259,6 @@
 		}
 	}
 
-finish:
 	if (eras_pos != NULL) {
 		for (i = 0; i < count; i++)
 			eras_pos[i] = loc[i] - pad;
-- 
2.17.2

