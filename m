Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FC8C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6F52084D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="B5Dv63RR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfK1O70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:59:26 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33974 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfK1O5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:57:42 -0500
Received: by mail-lf1-f67.google.com with SMTP id l18so2229752lfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qF5A7O/IvrSbLrPy3H+9dqWM8UA+mIW6ZOrUrJXGJ2Q=;
        b=B5Dv63RR/4pl4ZTNUITqsFRQQZ5TAI+PA/AhP8AenPQ4xG7rpFpGcDBxA0xbml85u5
         oiAdj7WL2T+g4bt3ulClOJHjd19qEsp17OzR97zqwpMNOOndADtLGUvta4gcSO+d5iga
         juT6tqHk6l4CJNz6EPeJxH8b9Gv9Dl9QSZehg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qF5A7O/IvrSbLrPy3H+9dqWM8UA+mIW6ZOrUrJXGJ2Q=;
        b=K4vJXv5xouIloI8mHd/FU1zMYyMaeidhrtlcNaRLMRP493B205eW8P1DBWs8qadBNu
         3npiyEDEmLtMwL7dZoEWRm4HExemsx1xj5atLEk8zEj8L0TWQpNcGHJca+prH+kDWSn3
         l8kcJENXLPiftxq3m5rBYD5jo5jm6tovqdsediV+fIVNCqXfRFYBWpafr9GZQIGKGeAG
         ktpCld0VwXjVL/H0FkWfsSmcgKWYiGmxTPXJGyY7ug2HSzc0GA6CF208e9dhBnKCVvcm
         KEfI9PK9gGuJenO64wIAZGUSTi4DA84Crjl6jYSgX8tCIvxttenDBr1ctEzfYvjo88By
         H6nQ==
X-Gm-Message-State: APjAAAWipWKxyQox+qXTHCR4YLO7uZGWXvBQQwJxEBUeuVBbqne7pL7T
        5US4pPMvhM/3akMOe3AGGlH0ng==
X-Google-Smtp-Source: APXvYqwJE77ccwhGv7KUUNqfmf/Szn+K7DK68gwlig7WSVAkchsABzo/HLFah4BDnOh9yuV4ngQ3xw==
X-Received: by 2002:ac2:42c2:: with SMTP id n2mr4840125lfl.152.1574953060221;
        Thu, 28 Nov 2019 06:57:40 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:39 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 27/49] soc/fsl/qe/qe.h: update include path for cpm.h
Date:   Thu, 28 Nov 2019 15:55:32 +0100
Message-Id: <20191128145554.1297-28-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm/cpm.h under arch/powerpc is now just a wrapper for including
soc/fsl/cpm.h. In order to make the qe.h header usable on other
architectures, use the latter path directly.

Reviewed-by: Timur Tabi <timur@kernel.org>
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

