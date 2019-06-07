Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F17C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322BC208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2pqzYFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbfFGRm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 13:42:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39674 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfFGRm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:42:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id g9so1091376plm.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 10:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ra2PqqpFCqMevcx+C2yV53QDcU7nf5/ZME/R+Tm3leo=;
        b=j2pqzYFOCdTeRA/t8xjy+tyKotSKnXIKql+kSpgXTxOZlD0r9BgZoqftvAMhCLHRM8
         djAKaKETMy3ode+bZnlfwX6BZ8LatGH2tLBdSUkwJZzc8DIvPKAe4BKHFkzzJycNpX24
         diNMaVNP14rHDRK6p7Pest4IZH91wR+LwO1F5h1vVZYPCkPDMx5/HSKxPC7Gcp01VHPW
         LDNGB5Wpw9+KEfj+jkNb2NscqUBmvnOWBRCSPQ9b1LbOFMhfABOvKNFx2Ta/09kDwrSF
         ECQ/oX4LfGu0Ainnu8Y6vz/A86ve071CObzxtqEdnOVOPApU272hguz1goEtg9TqI7OC
         t4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ra2PqqpFCqMevcx+C2yV53QDcU7nf5/ZME/R+Tm3leo=;
        b=bufKN1eKs1w66ZZ7hxdyxuDr9vfehV5kZfNRNspopTTu2aTiavE2BI/4wS13USX+bb
         aLUbR5wTwbuw3Kkkd+TBeM+vs+NUALrk+6hN6zqchLHQWZ7mVwT289nm2rl1gATiQQbc
         NFZlpzwwySUloZuAft4mlPHucetHqaKP1YdetE2aLTOxfSejgwuLvjbmOu9ZTBSdSzES
         brx6G0AI6cuipEdLTdBH/L/k9ZHWrAZO+uvk8s+8x0HY5/W3e+89drcfYEwuLVSMU1M0
         D4RGbP71Me0CBIUp6iBeX1yWDA7C6rJDyeSTdHl02T/Qc1xMjJJuCzTo1KtBvMHKxAlc
         T8fg==
X-Gm-Message-State: APjAAAW8nRVuei4/khxeo16LDijNSZ/4A4nXpQkmrW9lUbg8oLqtARBA
        VEGalLhFupbXdFS65hbvf44=
X-Google-Smtp-Source: APXvYqzuL0i55MZmmFYI9By5jCEPCrkwD9J9ent/IbDee/Ac5JTYdjPdgvtbmGncwbyL/UI8mf1Xtw==
X-Received: by 2002:a17:902:bc47:: with SMTP id t7mr44768830plz.336.1559929377294;
        Fri, 07 Jun 2019 10:42:57 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id u20sm524540pgm.56.2019.06.07.10.42.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 10:42:56 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] hrtimer: remove unused header files
Date:   Fri,  7 Jun 2019 13:42:53 -0400
Message-Id: <20190607174253.27403-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

seq_file.h does not need to be included, so remove it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 kernel/time/hrtimer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 41dfff23c1f9..edb230aba3d1 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -30,7 +30,6 @@
 #include <linux/syscalls.h>
 #include <linux/interrupt.h>
 #include <linux/tick.h>
-#include <linux/seq_file.h>
 #include <linux/err.h>
 #include <linux/debugobjects.h>
 #include <linux/sched/signal.h>
-- 
2.17.0

