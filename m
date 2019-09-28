Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D26DC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 00:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7BC207E0
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 00:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbVLvO5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfI1AnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 20:43:03 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38144 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfI1AnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 20:43:02 -0400
Received: by mail-lj1-f196.google.com with SMTP id b20so4139451ljj.5;
        Fri, 27 Sep 2019 17:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=drAdC+jh//y0Il1JQmnrfyXmS5xiniQET11ZhYLtsNQ=;
        b=EbVLvO5c9u1cmYy67A/CSPoAFV6W3bSxrWka08Ocvh9SykBFtA2cXbMXu6CuippO4y
         +ZN1Qx/akAZbA6wtiiqaq/gcYBt4MG8IuA2SMIs2hLViIn/79mV3aroqezSM4scl02/b
         SMOKRZ2vJZk2bs15X4JiM+JID29mWHDD4TwwjckBcrWUOSwkyD4VfnZ/GtS9NCRsfJCJ
         lzqtZZpBDn/9Lh0Eq5z0+Ls1K6kEio8vzxbG2upFXpxAmW9N3sHfbJVenr7gBHW6LW+x
         oN1FDOlYCGIQus8RtMrKN0POLJkI/8VY9hlySue49q7QAPvVx7I9WgzBI+TNnQGOeMLI
         3wrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=drAdC+jh//y0Il1JQmnrfyXmS5xiniQET11ZhYLtsNQ=;
        b=nyBF/1r3V2nFfCd6gM1xqxTkzGeBJ5NC2NBCM5PG+VTdgRdpWSjBKjX6T6ikMD2jPr
         DleSVfXPJeL0YWxKGMbkX00SfPVx8uZxZpxa9XXiFvfFYRlOz+EKQM8eL0WcW3/rxwY8
         o1FT7sqJ7DJnR026zu5LC8GisvFMQNZb1fU5PTHLtaZNx81DNt16X14hWEqxIaUuuptj
         B/Pf8COyUtPsZbqmm8p4QHa8VWjxQCdnycDE6ZJxWJb9udinXfOTmwK+DOhAY37rnt5p
         0iytJ2F9sJ5g9AyemoQuTQcdaEYwj1L1d6Tzmq/vihtj1CWM/V/K4gG0k2dY758zpdvU
         4maQ==
X-Gm-Message-State: APjAAAXniMwsesZEvjZDfRm4mTNzye12NTiWjVXIadcgeXOGNpdU3ovk
        i+ILf/4Cg/ZRa57db0n6F5g=
X-Google-Smtp-Source: APXvYqy7t+MaiMhmrU03sqIManQL59XjP5tmRCzlTRYlrMH2XuCkNNM47MNDx2trNS8z8SRAkQnGzA==
X-Received: by 2002:a2e:7f07:: with SMTP id a7mr4791334ljd.173.1569631380551;
        Fri, 27 Sep 2019 17:43:00 -0700 (PDT)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id f22sm842744lfk.56.2019.09.27.17.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 17:42:59 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: update arch features
Date:   Fri, 27 Sep 2019 17:42:44 -0700
Message-Id: <20190928004244.22199-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xtensa now supports tracehook, queued spinlocks and rwlocks. Update
corresponding Documentation/features entries.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 Documentation/features/core/tracehook/arch-support.txt           | 2 +-
 Documentation/features/locking/queued-rwlocks/arch-support.txt   | 2 +-
 Documentation/features/locking/queued-spinlocks/arch-support.txt | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/features/core/tracehook/arch-support.txt b/Documentation/features/core/tracehook/arch-support.txt
index d344b99aae1e..964667052eda 100644
--- a/Documentation/features/core/tracehook/arch-support.txt
+++ b/Documentation/features/core/tracehook/arch-support.txt
@@ -30,5 +30,5 @@
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
-    |      xtensa: | TODO |
+    |      xtensa: |  ok  |
     -----------------------
diff --git a/Documentation/features/locking/queued-rwlocks/arch-support.txt b/Documentation/features/locking/queued-rwlocks/arch-support.txt
index c683da198f31..ee922746a64c 100644
--- a/Documentation/features/locking/queued-rwlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-rwlocks/arch-support.txt
@@ -30,5 +30,5 @@
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
-    |      xtensa: | TODO |
+    |      xtensa: |  ok  |
     -----------------------
diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
index e3080b82aefd..eb0e6047a2ce 100644
--- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
@@ -30,5 +30,5 @@
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
-    |      xtensa: | TODO |
+    |      xtensa: |  ok  |
     -----------------------
-- 
2.11.0

