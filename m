Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596FEC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 19:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3127C2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 19:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="MGH5mdQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfFETlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 15:41:11 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34921 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFETlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 15:41:11 -0400
Received: by mail-qt1-f196.google.com with SMTP id d23so19453320qto.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 12:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KIj/CoUDc48PNaB+kzyB9ex343ExxV3vBCdcElq4Uow=;
        b=MGH5mdQm9xUfkFdxoNyIb94Yhmw78TprqBWKyhsEQo2yYyyDa2lNQQx2da7TA6Lcuu
         C4FfNDC1aNHvaL9RAXB27MqIuxGyCyH2zFM26XyexO+WeAApzjws2WsaylkE+yvZ1ulM
         ebZLuL3BF/kXnUZv/muP43AVsfIHHFgLP5sxVnJm+/hOIk1PinaRZ4mlPO3X8D5gAXSe
         vzWRI3ujSnckUC291z/ihMbiG97r4eO0cMT/3RG6PupXMT/a15HRF1TSt3EzZaSrwETR
         sLtMuh0kPGnUK1GI3IxaPciELsF7aEOC4+cwv7dr0atM2z4xkMwGVnebapetMcYEU6WM
         y9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KIj/CoUDc48PNaB+kzyB9ex343ExxV3vBCdcElq4Uow=;
        b=GX1X2b0nOhcGqJm5iF+AAoLH56xJwW/4lGov5cb2zoEFDaua0qsBxFJfK4tBTyJRbt
         uTVnUIYnNfoZ1FZeRHl7WFyPNrPdDjEjNOTO6RblZoldqNXFLe/gEAPVl3GxqwXjpwNX
         OZWqj6ejnICzYMPUXvrSZX/TBWMpBjCWNWsuojgdOiide/CU795mREaKQA3Jlpho4Fr4
         kQPukHLQtjUw4n4WM3c7FM+Xu0yQVqzPvNslr9DFGhRym/QO7OQbxO2cvHbXagFrXiQB
         4vye9AF9hMkuSQUehKKsA1FA1pXp9JAsPLzlyFDDvKh1BUoG63gxQZerf6aTwCxf2dLN
         XrTg==
X-Gm-Message-State: APjAAAUcFSFWhtweJfvL1FFpe3RT9KaK6q6396PhTg72KpbXynrZtbmO
        YOX5cDs1MZjCdwm7q5cuipNLEA==
X-Google-Smtp-Source: APXvYqxpv6VrdKJWfT/6aczVhiQUrH60uScF9E33+q5Og/km0gdK2Bb/a6KWJWJSlDk3afdsUwUAxA==
X-Received: by 2002:a0c:add1:: with SMTP id x17mr4349349qvc.81.1559763670372;
        Wed, 05 Jun 2019 12:41:10 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l40sm6407933qtc.51.2019.06.05.12.41.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 12:41:09 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] x86/cacheinfo: fix a -Wtype-limits warning
Date:   Wed,  5 Jun 2019 15:40:54 -0400
Message-Id: <1559763654-5155-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpuinfo_x86.x86_model is an unsigned type, so compares it against zero
will generate a compilation warning,

arch/x86/kernel/cpu/cacheinfo.c: In function
'cacheinfo_amd_init_llc_id':
arch/x86/kernel/cpu/cacheinfo.c:662:19: warning: comparison is always
true due to limited range of data type [-Wtype-limits]

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/kernel/cpu/cacheinfo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 395d46f78582..c7503be92f35 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -658,8 +658,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
 	if (c->x86 < 0x17) {
 		/* LLC is at the node level. */
 		per_cpu(cpu_llc_id, cpu) = node_id;
-	} else if (c->x86 == 0x17 &&
-		   c->x86_model >= 0 && c->x86_model <= 0x1F) {
+	} else if (c->x86 == 0x17 && c->x86_model <= 0x1F) {
 		/*
 		 * LLC is at the core complex level.
 		 * Core complex ID is ApicId[3] for these processors.
-- 
1.8.3.1

