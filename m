Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6162CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9069B222C6
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="O+2twWxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410114AbfJRMxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:53:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40562 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410083AbfJRMwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:52:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id 7so6107221ljw.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 05:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lfRyiPOJ+tpAygOEKq/virXF46WU8l1j3zrd6+53ses=;
        b=O+2twWxd5ixrCSJsM3mqFuz2a0vonUX7o4geTRlccuwfBNBIkK0S/WNPoTXAT/ExaF
         dkMsazXfL3MDmLS9//NfORvVoX4k5KWgn3R2GUa5kvsosQWeE4yx/GCfDaOYnuEKShPx
         NZ8VzHB+aadfG9OCrBQ/8mnicW9eKOfG/sQjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lfRyiPOJ+tpAygOEKq/virXF46WU8l1j3zrd6+53ses=;
        b=CM7E/Nxagm4qr1tej1xqAr8F6XX9t67pUkNrtH+XsDOV0l3+TtAtA81jFQIHUOqmhF
         nV0PWd/+A9fXqDhJ5dsG897INInZRYmqaMwpC8FsSBcf6e4xHZsS8bC8oXAJfJdgen3m
         Af2fM/M7i8EHsTy6ENGJSrU/dOx+rA+Q5N1fVZZdx1edxxRAqC70oQhmh20Ig+oBWWVe
         llcl6G+zSCK9po9kt9CWIpk0WLfsqx6ufpzcpZS4KgEN2Q7PFNHfu4TWLYIdGx8b14O/
         EoRLa6YYvouIPvzVqodKyLTpcxMoM0mGgB+q3jKztn+xsFORD9F/ojqAVYA04fXYsrHL
         +kNw==
X-Gm-Message-State: APjAAAXGBeKgVh/+XFKOW0Sv3MnROpj67NNHNI88fI7KUvCrsEZA9AcW
        1ZC2N9Ytr8gGxZdbhRw16Q/zMA==
X-Google-Smtp-Source: APXvYqxgLZsNIbhizhuYW69HOITY4WDfzxrxJeyVBTBM/JEr7MEt70x5TT22MnwDFNbFNwCyBKK2cw==
X-Received: by 2002:a2e:b00c:: with SMTP id y12mr6149308ljk.113.1571403173688;
        Fri, 18 Oct 2019 05:52:53 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m17sm7454792lje.0.2019.10.18.05.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 05:52:53 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] soc/fsl/qe/qe.h: remove include of asm/cpm.h
Date:   Fri, 18 Oct 2019 14:52:34 +0200
Message-Id: <20191018125234.21825-8-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm/cpm.h only exists on PPC, so this prevents use of this header on
other platforms. Drivers that need asm/cpm.h (and are thus inherently
PPC-specific) must include that explicitly.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/soc/fsl/qe/qe.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
index c1036d16ed03..3768c226490e 100644
--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -17,7 +17,6 @@
 #include <linux/spinlock.h>
 #include <linux/errno.h>
 #include <linux/err.h>
-#include <asm/cpm.h>
 #include <soc/fsl/qe/immap_qe.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-- 
2.20.1

