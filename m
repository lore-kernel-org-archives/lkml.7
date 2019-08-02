Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB8DC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 01:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD99206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 01:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1rGG0ML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388765AbfHBBrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 21:47:05 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34446 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731827AbfHBBrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 21:47:01 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so33001008plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 18:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Etlez9dE8UqhxirD/p7zPZHxWg6Y+RwIC2UF77KrqUA=;
        b=B1rGG0ML+eK+vBHhcOqPhE5B34pRycIFx00bLE5KeXaxeF9lF8YuTlmWhgW24FIdFc
         n4TqXM5Ere56agornnPWPTsRt/ACLoPUPUxII17zu6XAp8bNGjbiDrLYmWuGpMQnpotE
         5+hyaQq8EEVBRzNPxn7m7LCGovcJhImFtWnJJQJKgLCpvz+25kUv1M8tNZuGmmHDPHC/
         by84rsu7WfVJ8waU0c5IDm2TlsbwxjT9l/kRiwDVOcsx5zqN21wzzMu9PDNeJlb1vEsS
         qIMqfhw2dhKF+6ZSMoaBrbUG6Mm3xDTj3+3aDJNpMf67urZF5tpzzIoMAu6aR+h5Errm
         5yCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Etlez9dE8UqhxirD/p7zPZHxWg6Y+RwIC2UF77KrqUA=;
        b=k9ntnMR4GAuOsWihgTOnZ4AWUaPU+8TX+D4Ba17pR6IJmTJk6zEPTMz5Z5W7dfoVdd
         bhmelnwbFlm71mcsLElUliLeZZrpSEy6YgDS3NX2AjmELLEb33n259bHTkcrX7/RRqAD
         F8bbwilHZkQVvTJBzo7lb9kQNwreJ8hK8khVB3x2G+isRx3iQDT+dwEm4yLNEpNWpIL6
         PXTS9SYMh8AmnyBlPYUIDOYv6ZIxkwskN9VltXkE0rxid49EnhwArijGsdKD51P2Bkru
         0YXu10sXAp+Zw3ZIM2VfA6UeA4OanoHY9wahXNwsLO/6W7PwDZzZ6QfOGQ99dKrFJ7fa
         TmJQ==
X-Gm-Message-State: APjAAAWpJG6fnP+0MlZn+NQdQbz6WDe/BYva3weaR9117xQ6seydllpL
        Ia/irfu7uQB+w1OMllrz9f0=
X-Google-Smtp-Source: APXvYqy76PmU9A7LNRI2MgRUeuk9FheJDuDs3czzGQMpYLy9afNhfBVIrTA18yvjt3ViiFTbhGUvEA==
X-Received: by 2002:a17:902:1e6:: with SMTP id b93mr127464652plb.295.1564710421338;
        Thu, 01 Aug 2019 18:47:01 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id z63sm46537520pfb.98.2019.08.01.18.46.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 18:47:00 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2 03/10] locking/locktorture: Replace strncmp with str_has_prefix
Date:   Fri,  2 Aug 2019 09:46:56 +0800
Message-Id: <20190802014656.8789-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncmp(str, const, len) is error-prone because len
is easy to have typo.
The example is the hard-coded len has counting error
or sizeof(const) forgets - 1.
So we prefer using newly introduced str_has_prefix
to substitute such strncmp.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Newly detected in upstream.

 kernel/locking/locktorture.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index c513031cd7e3..8dd900247205 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -889,16 +889,16 @@ static int __init lock_torture_init(void)
 		cxt.nrealwriters_stress = 2 * num_online_cpus();
 
 #ifdef CONFIG_DEBUG_MUTEXES
-	if (strncmp(torture_type, "mutex", 5) == 0)
+	if (str_has_prefix(torture_type, "mutex"))
 		cxt.debug_lock = true;
 #endif
 #ifdef CONFIG_DEBUG_RT_MUTEXES
-	if (strncmp(torture_type, "rtmutex", 7) == 0)
+	if (str_has_prefix(torture_type, "rtmutex"))
 		cxt.debug_lock = true;
 #endif
 #ifdef CONFIG_DEBUG_SPINLOCK
-	if ((strncmp(torture_type, "spin", 4) == 0) ||
-	    (strncmp(torture_type, "rw_lock", 7) == 0))
+	if ((str_has_prefix(torture_type, "spin")) ||
+	    (str_has_prefix(torture_type, "rw_lock")))
 		cxt.debug_lock = true;
 #endif
 
-- 
2.20.1

