Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98718C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B58B206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KN0HQPBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfLPKfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:35:47 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45310 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfLPKfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:35:46 -0500
Received: by mail-ed1-f67.google.com with SMTP id v28so4532958edw.12;
        Mon, 16 Dec 2019 02:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hfv/K9kTRS6rEzUbcO1jHjSU+LAu5sBSnOlDV1lj9AI=;
        b=KN0HQPBKU35Gl/sMkWpCqppgDVtbdOJFBOYHOiSeSnQhziNiGJ6pV1dKS1Y75e7T2K
         zhffMcuwkGoL0KUvIqqJitFFnWaneA2MGnmXB0a7m5Mf3yIlZuIh8MtMCTxe4zZbyY6I
         4htAoJcz06r7//KM77uPL+OQrakX4Qz1cYH7faSoGbYSHX6M+y1zJFz1xpiklMlcC3gH
         omTeUL7vqVQ8Oj/+W1rNeLa4Aj8iGWwVH2TrgDFDMNIBOJvDmsNJ+Ny3lAWtpWFGTtHB
         6fqxtoiRQ8FTceYwE25kKCZbPlUUl8cdEwUkB8eHUW7YKNeUB7e4GLJ++LWQux87MSpv
         /gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hfv/K9kTRS6rEzUbcO1jHjSU+LAu5sBSnOlDV1lj9AI=;
        b=S6twI5/99/3KQWg2Lqh/leexU8DuXHphizX39PPOTpkgzqpP+7f1kGrtH6ptUPBBSP
         i5m6eu63A9e6Vg4B+2+kz2QzbMefypCOiqoYv+ljVpPJ1DlZ3fXLlFqEEZbep5Bg2Wkv
         w5OUT8tEwsBOfFEKQ211GT/DKWZtqHWtZIkBpuLB/sS+v8LLt4hZlGoioG7H9pGpvXNP
         LuehELOppiUKrS63rt+yawEt1jcicnmkv51aHVJN5Ca0mtCIIXHZqJu9Z5eX9k/c9FPB
         SICv2/dPpNylbRlZEJdAbNLRQkho1p7fWz4jpa3GZIvwppU4LQ2AlqR0wQam4/ityCF2
         8YjA==
X-Gm-Message-State: APjAAAXpKKgeZLfLgBQn9X4w3x5t2D6Z9XW3PQd7ua+i31wVyDWPlTz5
        wCx4WfxRtXEwzg/cIqbT51Q=
X-Google-Smtp-Source: APXvYqyDdkahsZ0FslcdDaLhatxbEYuSdhIZCdwDxLTLEP21m9mX05JIV5djukc1O4EjdINpoQ8dMg==
X-Received: by 2002:a17:906:1f12:: with SMTP id w18mr32202730ejj.63.1576492544719;
        Mon, 16 Dec 2019 02:35:44 -0800 (PST)
Received: from localhost.localdomain ([46.114.39.109])
        by smtp.googlemail.com with ESMTPSA id n24sm504191edr.30.2019.12.16.02.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 02:35:44 -0800 (PST)
From:   Gon Solo <gonsolo@gmail.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Gon Solo <gonsolo@gmail.com>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Fix undefined reference to 'node_reclaim_distance'.
Date:   Mon, 16 Dec 2019 11:35:22 +0100
Message-Id: <20191216103522.32215-2-gonsolo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216103522.32215-1-gonsolo@gmail.com>
References: <20191216103522.32215-1-gonsolo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to https://lkml.org/lkml/2019/12/16/101 and
http://kisskb.ellerman.id.au/kisskb/buildresult/14067948/ building on
sh4 is broken due to a

page_alloc.c:(.text+0x3148): undefined reference to `node_reclaim_distance'.

This only happens with CONFIG_NUMA=y (variable used with #ifdef
CONFIG_NUMA at mm/page_alloc.c:3529) and CONFIG_SMP=n (variable defined at
kernel/sched/topology.c:2291 but the whole file to be built depends on
CONFIG_SMP in kernel/sched/Makefile:23.

Follow the lead of arch/x86/Kconfig:1547 and depend on SMP.

This assumes that there are no NUMA systems without SMP which is
reasonable I guess.

Signed-off-by: Gon Solo <gonsolo@gmail.com>
---
 arch/sh/mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index 5c8a2ebfc720..cf655d8e8758 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -108,7 +108,7 @@ config VSYSCALL
 
 config NUMA
 	bool "Non Uniform Memory Access (NUMA) Support"
-	depends on MMU && SYS_SUPPORTS_NUMA
+	depends on MMU && SMP && SYS_SUPPORTS_NUMA
 	select ARCH_WANT_NUMA_VARIABLE_LOCALITY
 	default n
 	help
-- 
2.20.1

