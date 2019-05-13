Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6F1C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4EA20989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5KZjiBz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbfEMJOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:14:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36665 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfEMJOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:14:01 -0400
Received: by mail-pl1-f196.google.com with SMTP id d21so6178361plr.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 02:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MeeCp+np+yt0c0eaVBCua0qAl6unHqmhh7kigQ2zt3U=;
        b=H5KZjiBzWWweTTl1VyQugGvr/qV8mmdv1snwyJw79E4rHSwhAUObcVgIcDsC+6Fu+4
         oIM1gnFEuHgXyr1Za7E5JZdCR39tOfmsbJhtrWfw3S+HUhLeeOjF4+xROrmswOKxDvje
         rBs7hg0Z+PTdSUryb8QOZuBqe4k1URpCGx8L7ImSGINdYS894kI5+fCXZyx54S6EiFPx
         H56GbpCqu3M4SPVS2iznb50JoJtePMMs57VnhAuK2h0tYn0TNMp6d/oAsN0plmMWBWoI
         CTRb8Y+5Azuc0A1Du5wSanZxUhycZn5WjL/fGD/gPLtjgkq8kyvtyPwmrSg3cKv4XzBE
         n6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MeeCp+np+yt0c0eaVBCua0qAl6unHqmhh7kigQ2zt3U=;
        b=I2WKcJudHsiNlkcHOENaIgm6TG5+24ivS5N7G4Wiytgnjf+QfTiR/ehLF9TsBES2Tl
         tnptsjp32PjWbYySt0F/ftpK4cACrq6N3Nwtxvzhm1XUNxW0xci2ZW5qROei3rBu5QL8
         /zPldzCeBV3lZqaIClvoxXBqBv9q1VGo098DtQlKTdT17K6gWaq29eJAVuAxLn1hYtML
         9AoDZoA7lpNnTDQ5/PJBiBxV3tLH6ol8hl88+fE9gjzqoKHmnA9PBo2qjivKtlJX+4kG
         FmJzxMCFsAOrFiJxCKhDEwBgj96UnvzuAImghwwDScstFTFWDLE22xkJUyQrALcD7Ha+
         hVdg==
X-Gm-Message-State: APjAAAUgRb3axuwHrxQ0CfuQAJ/ev3ZepCpCo8v179vXqYrLFgnh78rm
        IEPNQCCXmwNd+WNH1EKskZ0=
X-Google-Smtp-Source: APXvYqy0FNeyMZegEeaf+rSJSjnvrQPpzgIBVEdrTD0pg/pPvFC/Rh7WOkf7TTeeEdmUrwb8898iYA==
X-Received: by 2002:a17:902:8305:: with SMTP id bd5mr5211060plb.339.1557738840605;
        Mon, 13 May 2019 02:14:00 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id n18sm35500837pfi.48.2019.05.13.02.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 02:14:00 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 13/17] locking/lockdep: Add nest lock type
Date:   Mon, 13 May 2019 17:11:59 +0800
Message-Id: <20190513091203.7299-14-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190513091203.7299-1-duyuyang@gmail.com>
References: <20190513091203.7299-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a macro LOCK_TYPE_NEST for nest lock type and mark the nested lock in
check_deadlock_current(). Unlike the other LOCK_TYPE_* enums, this lock type
is used only in lockdep.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c           | 7 +++++--
 kernel/locking/lockdep_internals.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c94c105..417b23d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2523,6 +2523,7 @@ static inline void inc_chains(void)
  *  0: on deadlock detected;
  *  1: on OK;
  *  2: LOCK_TYPE_RECURSIVE on recursive read
+ *  3: LOCK_TYPE_NEST on nest lock
  */
 static int
 check_deadlock_current(struct task_struct *curr, struct held_lock *next)
@@ -2552,7 +2553,7 @@ static inline void inc_chains(void)
 		 * nesting behaviour.
 		 */
 		if (nest)
-			return LOCK_TYPE_RECURSIVE;
+			return LOCK_TYPE_NEST;
 
 		print_deadlock_bug(curr, prev, next);
 		return 0;
@@ -3127,11 +3128,13 @@ static int validate_chain(struct task_struct *curr,
 
 		if (!ret)
 			return 0;
+
 		/*
 		 * Add dependency only if this lock is not the head
 		 * of the chain, and if it's not a secondary read-lock:
 		 */
-		if (!chain_head && ret != LOCK_TYPE_RECURSIVE) {
+		if (!chain_head && ret != LOCK_TYPE_RECURSIVE &&
+		    ret != LOCK_TYPE_NEST) {
 			if (!check_prevs_add(curr, hlock))
 				return 0;
 		}
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index c287bcb..b06c405 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -28,6 +28,7 @@ enum lock_usage_bit {
 
 #define LOCK_TYPE_BITS	16
 #define LOCK_TYPE_MASK	0xFFFF
+#define LOCK_TYPE_NEST	3
 
 /*
  * Usage-state bitmasks:
-- 
1.8.3.1

