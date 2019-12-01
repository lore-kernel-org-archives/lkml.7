Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02DBC432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 18:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5A920716
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 18:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKkA0pkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfLASfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 13:35:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34623 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfLASfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 13:35:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id n13so17342434pff.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2019 10:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z3TzwSYn5g3MrmieUv6eN394fAt/3mpfuC3Uls+rr6g=;
        b=mKkA0pkGmxqIHJ+qCSrIllvlqSR4felhHMYUGM4ymrdXNEDhgAyVWK1U+EGU3Ck+ZC
         tctswF4V8L51AnZxXFHjaxhCCSJz7IuTZrnoIAxH/ZLRSxvm6qa+vvp2aQ9nyBs4qYmF
         T5QGEPaa9Cas4JUaJyL97bHVD9azTp14OdwikDC6Bq6hszF/OJGu4XaAlQbQoJp6EZPB
         P2XUFBtZU8Pkxr8T8KL8pfxl8pOre3rab0QHDFOUVn/HjvV5P1FHHylG7KtH0hVbyEXx
         p/TqnOs4xAOqhK+w0563YzN2fn57DxZB3oM50RvZd96z09P3cDgjgRn/tftf+zr5w10o
         g1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z3TzwSYn5g3MrmieUv6eN394fAt/3mpfuC3Uls+rr6g=;
        b=PJpPeTA/POrZVArVhMXo5oOEDmd+zuPQw4yU63UbmINgLgXKl6qkcTFplEUUP1I41l
         VAYDqVTikovwc8yMggznYVLbCxkUCHjiyNw8OF8wNJDUwRpc3N5oNXPQrM+oadGIs6eO
         bHDgX43ODdAOSdnYu0qDTSAXy+CupRfgG5BWyL6ZFLaGSpBeIqbBalfVHoOTbfiJ2aVZ
         kAihTsHrjni2wD1Aaxo8NCFQdIaQVDddwpRBxWOUC/G1myovSCIRuE4NtjTRBua7+P8A
         c5OqNHBe9y/uRbVJkVFsBP5fA0q95C7sOg4meDm1Y+3fjg6+xgdWEEg4EzI7ip3QTVKC
         CdsA==
X-Gm-Message-State: APjAAAUUaBEII1WQ1JtFoA8aJXlNelqdyHcn1erYhrOMpR/bdSjX2D15
        pWjLyIJYRaV6LT1mzVAfPd0=
X-Google-Smtp-Source: APXvYqxg/NKmExH60ea61UZusx0DpypzbkLGYSHNbTZo/5IvSi29I/71C0L9mCytHATmuEAjrSguQw==
X-Received: by 2002:a63:e647:: with SMTP id p7mr28156201pgj.47.1575225344893;
        Sun, 01 Dec 2019 10:35:44 -0800 (PST)
Received: from localhost.localdomain ([139.5.253.99])
        by smtp.googlemail.com with ESMTPSA id y128sm5432492pfg.17.2019.12.01.10.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2019 10:35:44 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH v3] kernel: audit.c: Add __rcu annotation to RCU pointer
Date:   Mon,  2 Dec 2019 00:03:48 +0530
Message-Id: <20191201183347.18122-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __rcu annotation to RCU-protected global pointer auditd_conn.

auditd_conn is an RCU-protected global pointer,i.e., accessed
via RCU methods rcu_dereference() and rcu_assign_pointer(),
hence it must be annotated with __rcu for sparse to report
warnings/errors correctly.

Fix multiple instances of the sparse error:
error: incompatible types in comparison expression
(different address spaces)

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Amol Grover <frextrite@gmail.com>
---
v3:
- update changelog to be more descriptive

v2:
- fix erroneous RCU pointer initialization
 
 kernel/audit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index da8dc0db5bd3..ff7cfc61f53d 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -102,12 +102,13 @@ struct audit_net {
  * This struct is RCU protected; you must either hold the RCU lock for reading
  * or the associated spinlock for writing.
  */
-static struct auditd_connection {
+struct auditd_connection {
 	struct pid *pid;
 	u32 portid;
 	struct net *net;
 	struct rcu_head rcu;
-} *auditd_conn = NULL;
+};
+static struct auditd_connection __rcu *auditd_conn;
 static DEFINE_SPINLOCK(auditd_conn_lock);
 
 /* If audit_rate_limit is non-zero, limit the rate of sending audit records
-- 
2.24.0

