Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2769FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69A9218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="M6+qONH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbfC3AJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:09:27 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35987 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730391AbfC3AJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:09:11 -0400
Received: by mail-qt1-f196.google.com with SMTP id s15so4694169qtn.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 17:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gFPF0xdLu5V+0kEHHrdxm8rWiz86XO06lZiBRioAcRI=;
        b=M6+qONH+QmteVwe5RMrKW8JP1cwszZ9jGlNEPDwUU74o9h9+G9R7P7fYlR1aZ3Ni78
         xR58IiBkgPlV4+xX8RpfX/E8jB/z6bcNB6FPylKn+vrliUpbNCKMCfbP7iHPfCnsI6uP
         tzxOCfibwE6yQrW/FxGCPGhOxscjdi/pFI6w5hFX+XlBE71NzAW5UvCG5krNonY0uk8k
         3mI2dvd+zt5R2u/Uru0lh7yyS/9ckd7ojW4NvkA7Zze5g3LmVNUCVwj77Q6pMUNOND+n
         HodpADLdydgdszggckNXsViG/zTC9fSobw6WTSCCeNFMw4cWa12x9jor34keTIm5tJol
         Ja5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gFPF0xdLu5V+0kEHHrdxm8rWiz86XO06lZiBRioAcRI=;
        b=AhBJdzmJ2++nCCSeFf+I+mlJ/yq5oADNFprkDTmfggu6ADKLAeMR51zUjdtIiTMlZF
         VmsHqWsMZK2pyCZrPpPmWjksUyctdkx1IQO26VUi7UuckYyNv//ifjnqqJLG9E2H04v6
         FemDf7ydV0S/c3xU8JDGmTgXYHF3m/GvOlrNt6a0K8SkjipcUZStgui9WDENeVagaVRt
         d08iXzuC199tgTW4Z4/JvRbl+GU73jRVaky+zs/bVYkcGuV9SLQ53l4v/ivRLul7MC5m
         iL3bWd0wbCK18qHL8szX3JLC12orP9Z4hSoLGmztXfoKKnLlySK1/cxjkEpqShomQOfa
         Cfyg==
X-Gm-Message-State: APjAAAVWWAkuCUnFz1r1U7fEKIKGzI+SFdL/4XC+QEGM4zjWhLj+Gnqp
        xuePfcJOYh92Lzq9ykpKnnkzsw==
X-Google-Smtp-Source: APXvYqzpWDD87vmRg/8e2IVWUpzQq6thDRGnAS7KZ8batFaNr7MVg9E8b5r0FA2M+43KSjiQv42iuQ==
X-Received: by 2002:ac8:30a1:: with SMTP id v30mr42338564qta.176.1553904550069;
        Fri, 29 Mar 2019 17:09:10 -0700 (PDT)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id i63sm1996757qkd.82.2019.03.29.17.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 17:09:09 -0700 (PDT)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     peterz@infradead.org, tglx@linutronix.de
Cc:     ard.biesheuvel@linaro.org, yamada.masahiro@socionext.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com,
        alexei.starovoitov@gmail.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Simon Horman <simon.horman@netronome.com>
Subject: [PATCH 2/3] locking/static_key: factor out the fast path of static_key_slow_dec()
Date:   Fri, 29 Mar 2019 17:08:53 -0700
Message-Id: <20190330000854.30142-3-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190330000854.30142-1-jakub.kicinski@netronome.com>
References: <20190330000854.30142-1-jakub.kicinski@netronome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

static_key_slow_dec() checks if the atomic enable count is larger
than 1, and if so there decrements it before taking the jump_label_lock.
Move this logic into a helper for reuse in rate limitted keys.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
---
 kernel/jump_label.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 73bbbaddbd9c..02c3d11264dd 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -202,13 +202,13 @@ void static_key_disable(struct static_key *key)
 }
 EXPORT_SYMBOL_GPL(static_key_disable);
 
-static void __static_key_slow_dec_cpuslocked(struct static_key *key,
-					   unsigned long rate_limit,
-					   struct delayed_work *work)
+static bool static_key_slow_try_dec(struct static_key *key)
 {
 	int val;
 
-	lockdep_assert_cpus_held();
+	val = atomic_fetch_add_unless(&key->enabled, -1, 1);
+	if (val == 1)
+		return false;
 
 	/*
 	 * The negative count check is valid even when a negative
@@ -217,11 +217,18 @@ static void __static_key_slow_dec_cpuslocked(struct static_key *key,
 	 * returns is unbalanced, because all other static_key_slow_inc()
 	 * instances block while the update is in progress.
 	 */
-	val = atomic_fetch_add_unless(&key->enabled, -1, 1);
-	if (val != 1) {
-		WARN(val < 0, "jump label: negative count!\n");
+	WARN(val < 0, "jump label: negative count!\n");
+	return true;
+}
+
+static void __static_key_slow_dec_cpuslocked(struct static_key *key,
+					   unsigned long rate_limit,
+					   struct delayed_work *work)
+{
+	lockdep_assert_cpus_held();
+
+	if (static_key_slow_try_dec(key))
 		return;
-	}
 
 	jump_label_lock();
 	if (atomic_dec_and_test(&key->enabled)) {
-- 
2.21.0

