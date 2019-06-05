Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D530C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149182070B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="KhvFchy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfFEUST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:18:19 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44891 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfFEUST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:18:19 -0400
Received: by mail-qt1-f195.google.com with SMTP id x47so7379qtk.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 13:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=eep8Xi7UqaO2aP4V8ZuSDtp+KDuR2Kw3YoepF8M+Ejo=;
        b=KhvFchy6WV2EGfCS0aKB8oaKfyjgeRmeyn5nergkSRaRclnHRr0EFgeHPHkV3yyjO4
         MTPwrCIXy50L0s7MQp+ilwKKfvjwr/zNgTQvTMn1Rb2rHDdUUeBz/07gqhGk9HGhynZ1
         s/faqm6zGOU1WwUU0J55rjchdzu2qMhuRNVVG3yVcOZj01qjQE+GXvnQFbPXgAg0v+LW
         c4bZMzOr3OMmCgbQPNKmZzGSs9lNqK20G76vSNLgUhzSMIfPEx/7IYxkjm1pSgHqg8nd
         H4/6yUbrfvKZn9lA8l0YybNIqV108wW+TRieMvtg3wXE9x/jIkVyGy3mlb41Z6Gaggi/
         QV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eep8Xi7UqaO2aP4V8ZuSDtp+KDuR2Kw3YoepF8M+Ejo=;
        b=gMrVhEw4TfiCGqcBY+ljm6i9FKxuJTqbQ9Q43pKoD41YQVv3ZU+xBQARu2nGuImROd
         y2mCOoejWK3/VXNMYPtlLwAUNOAkyc/8U7NArB5zdx7EEafLcxPzkISThOD4amHy+Tq7
         eyyhqhaaAayIBAeHxcKuX98LGBIYLmfxrt4zrzqfHNOFNXtqcMmzzbTfNVZ1l8DdSxzh
         hguQQVnakw4Axv4TOugg3Rx1g1G4l0nvwRfSlHkr2dlvneezTMqsLdrBEMDil9Citnuc
         nwZvwpx77t8w1kghOcjZ2daXMrlCmcIqOVExUObdhpTCPcM2taz4J/509DC3nWkWSJ/C
         j+3Q==
X-Gm-Message-State: APjAAAWsUAtRgvqc6uEkhJUbIoDLiKJanbo8a56zyClJ25U1VqWe3QyR
        gktrY996KagZpy3p43Vk6W9K7g==
X-Google-Smtp-Source: APXvYqylnnxGRmwwDNBSxxHTCizpj0mUP+4/+2jTc7tjkZ0Todi8uSs1a4jq1v8xplv2rH3dQb9LMA==
X-Received: by 2002:ac8:1796:: with SMTP id o22mr34231264qtj.98.1559765898586;
        Wed, 05 Jun 2019 13:18:18 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d7sm7840507qth.44.2019.06.05.13.18.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 13:18:17 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mpe@ellerman.id.au
Cc:     paulus@samba.org, benh@kernel.crashing.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] powerpc/setup_64: fix -Wempty-body warnings
Date:   Wed,  5 Jun 2019 16:17:55 -0400
Message-Id: <1559765875-6328-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the beginning of setup_64.c, it has,

  #ifdef DEBUG
  #define DBG(fmt...) udbg_printf(fmt)
  #else
  #define DBG(fmt...)
  #endif

where DBG() could be compiled away, and generate warnings,

arch/powerpc/kernel/setup_64.c: In function 'initialize_cache_info':
arch/powerpc/kernel/setup_64.c:579:49: warning: suggest braces around
empty body in an 'if' statement [-Wempty-body]
    DBG("Argh, can't find dcache properties !\n");
                                                 ^
arch/powerpc/kernel/setup_64.c:582:49: warning: suggest braces around
empty body in an 'if' statement [-Wempty-body]
    DBG("Argh, can't find icache properties !\n");

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/powerpc/kernel/setup_64.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 44b4c432a273..23758834324f 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -575,12 +575,13 @@ void __init initialize_cache_info(void)
 	 * d-cache and i-cache sizes... -Peter
 	 */
 	if (cpu) {
-		if (!parse_cache_info(cpu, false, &ppc64_caches.l1d))
+		/* Add an extra brace to silence -Wempty-body warnings. */
+		if (!parse_cache_info(cpu, false, &ppc64_caches.l1d)) {
 			DBG("Argh, can't find dcache properties !\n");
-
-		if (!parse_cache_info(cpu, true, &ppc64_caches.l1i))
+		}
+		if (!parse_cache_info(cpu, true, &ppc64_caches.l1i)) {
 			DBG("Argh, can't find icache properties !\n");
-
+		}
 		/*
 		 * Try to find the L2 and L3 if any. Assume they are
 		 * unified and use the D-side properties.
-- 
1.8.3.1

