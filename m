Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D06FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0E62085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="fwPnjhH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbfKHNCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:02:09 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41252 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729737AbfKHNCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:02:05 -0500
Received: by mail-lj1-f193.google.com with SMTP id m9so6113919ljh.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N4h2w9DiO+4P3jPc0w1TT3xARdv8ATB93lgz8xw4vxA=;
        b=fwPnjhH+AaqAmrnzgfvsU+L9+8OhXmN2600F8bPtwqsqH8u1+zeWZvMRZT2S5CtXhN
         bzKLLdixWy9kgQjYP/uOsAIZp0u1Ssmgt4tcoj8VPgGjQ22Hm/uXXQlOmed8oj0PSuLt
         ZGmRW8UaAsucAjYrV7oJhG1YpGes9Og+Zn4Uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4h2w9DiO+4P3jPc0w1TT3xARdv8ATB93lgz8xw4vxA=;
        b=twaR9SIgxqiTDZ7U5agMd5D3jT5F9cxZ9Sny1MyV9l4SXkdcB7i/P7ZTdM15lTflsQ
         trEXW6f+UMFVrnk0zAdMS9QBF1FyptKs7wNxlK2qus/H66Tj9S3AwKH61q0pwSJXkgPo
         luoJCEdGtoLKmoLHqO49iM4Y5gWTEw7/LN30K7OBlLjTijEUcMRLDOpA8KwIDObhG/R4
         3Gei6nR6k7ju0nm1R44oVwBhJ17ST4B2wbNCKvySWd/Qgc8b0xjBrtgfS+thzNp48NRp
         6t7uNEtv8QfC6m4ikxo8hLa7wpqeRWRm05NEWIL3hUDT2nOhmF700hUF2O3/isz60CUa
         oc8A==
X-Gm-Message-State: APjAAAUwh9TfFlJL/BMJGekaHJYrIFcjgWnGLbeyKHAR8Bf6vPRmyXmu
        2RDddOEvfj7t9x01j1N0HJlpxQ==
X-Google-Smtp-Source: APXvYqyCwmZwJn72ggRacXvlR0yu2D6d+8LbbMJit9Xetek1SpNBQJ7uRnYgqyaDOgv8d24FMyh9nQ==
X-Received: by 2002:a2e:89c2:: with SMTP id c2mr6731748ljk.161.1573218122321;
        Fri, 08 Nov 2019 05:02:02 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:02:01 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 27/47] soc/fsl/qe/qe.h: update include path for cpm.h
Date:   Fri,  8 Nov 2019 14:01:03 +0100
Message-Id: <20191108130123.6839-28-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm/cpm.h under arch/powerpc is now just a wrapper for including
soc/fsl/cpm.h. In order to make the qe.h header usable on other
architectures, use the latter path directly.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/soc/fsl/qe/qe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
index 9cac04c692fd..521fa3a177e0 100644
--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -17,7 +17,7 @@
 #include <linux/spinlock.h>
 #include <linux/errno.h>
 #include <linux/err.h>
-#include <asm/cpm.h>
+#include <soc/fsl/cpm.h>
 #include <soc/fsl/qe/immap_qe.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-- 
2.23.0

