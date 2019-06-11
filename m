Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF784C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A0E21773
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENnb5DPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404861AbfFKPTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:19:43 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36364 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404842AbfFKPTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:19:42 -0400
Received: by mail-qt1-f196.google.com with SMTP id p15so7576195qtl.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 08:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xk/nUeSwmjb6lEDGBh3mV3CTpCHSAUw0VWDygG78GcY=;
        b=ENnb5DPQJReREn1b0ZGYhCbls9bU6aKjPnMMIT3IDI6TQL/5Z6ccXp8OUmJ9pntjhe
         BXopYGyAbHSZdSYdyck6ZmfLWsHijBIB8zEsuUgr7j6ZREBdo2RFm6qj1JyJt7TQQWaS
         c28gYKAPWXlG/Xh03mKf7GK7+C4oPDcFjTe+nDDgMBjbm780EQu33is/diUiQcIQ4HV9
         BKtQmpq+LjUq0P9BJKzTscvaxSgHu7psnFXFqkDIn5q0fNdGTw7DB8axTTgzkYNCfIAq
         ORZGVpvcwfIilUxX8eO6TkXJk4heEc4JV0dBZ4+w695PDlNBRe5hzWnlu1BHu+oJqNni
         PbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xk/nUeSwmjb6lEDGBh3mV3CTpCHSAUw0VWDygG78GcY=;
        b=H5EILjb9v+5DjrTlVz16B1NtubxzfkLpl+DBlRr0hRsJUgeAth4H9J48xzreqDQjHr
         9tV4Qw0v/ryPi9A48r9NZKt2Ar69y4K+JVEhcCRxVUpHZ7g63pkdp2KWkfc2qL5zquPV
         D9AEkzYbkmTYyl9Oux1yhoAz/rgKeR0yr51IKdGBhu4EYV3s08D59D/jA8NNCkcl6RbW
         dxJ/pi9vH9Ud8eRoB0ZjBa0odoJC2groSQO5ywKqpTUQdnT4eUnyf0Qj3setz7De5sJ0
         FT/8+1QkX5sZUditW0wVgMEq5EAWWUItrHXuGRqrF25LFJ5VSj9gOw/hy78KTxzbDbYi
         FkmQ==
X-Gm-Message-State: APjAAAU5cy011NvVYhGwdArma1UpkzpLr2Xd0C6zJZ9+0NxNcHecxhkK
        QnTazxRvf79EH3gUf8vGyQ==
X-Google-Smtp-Source: APXvYqw28toKoVkfyCeZHHVkhZ1hltwnLs7p4JkG/RqFIAuee62sNbitk9iGIz/UO3zf6zppFIJZ9Q==
X-Received: by 2002:ac8:2e5d:: with SMTP id s29mr56136444qta.70.1560266381319;
        Tue, 11 Jun 2019 08:19:41 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z57sm6538533qta.62.2019.06.11.08.19.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 08:19:40 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org,
        Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>
Subject: [PATCH 2/2] arm64/mm: show TAINT_CPU_OUT_OF_SPEC warning if the cache size is over the spec.
Date:   Tue, 11 Jun 2019 11:17:31 -0400
Message-Id: <20190611151731.6135-3-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190611151731.6135-1-msys.mizuma@gmail.com>
References: <20190611151731.6135-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Show the warning and taints as TAINT_CPU_OUT_OF_SPEC if the cache line
size is greater than the maximum.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Reviewed-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Tested-by: Zhang Lei <zhang.lei@jp.fujitsu.com>
---
 arch/arm64/include/asm/cache.h | 2 ++
 arch/arm64/mm/init.c           | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 926434f413fa..636e277fefc9 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -91,6 +91,8 @@ static inline u32 cache_type_cwg(void)
 
 #define __read_mostly __attribute__((__section__(".data..read_mostly")))
 
+#define ARM64_MAX_CACHE_LINE_SIZE	2048
+
 static inline int cache_line_size(void)
 {
 	u32 cwg = cache_type_cwg();
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index d2adffb81b5d..df621d90b19c 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -562,6 +562,11 @@ void __init mem_init(void)
 		 */
 		sysctl_overcommit_memory = OVERCOMMIT_ALWAYS;
 	}
+
+	WARN_TAINT(cache_line_size() > ARM64_MAX_CACHE_LINE_SIZE,
+		   TAINT_CPU_OUT_OF_SPEC,
+		   "CTR_EL0.CWG is greater than the spec (%d > %d)",
+		   cache_line_size(), ARM64_MAX_CACHE_LINE_SIZE);
 }
 
 void free_initmem(void)
-- 
2.20.1

