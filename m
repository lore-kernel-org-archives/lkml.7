Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E161C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561D320857
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="fyrEzQkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbfB1VdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:33:08 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33351 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbfB1VdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 16:33:07 -0500
Received: by mail-qt1-f195.google.com with SMTP id z39so25422768qtz.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 13:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/YFSZEQBtvm4n82alTgh4ZzKfgPX0vedws+p+M35/eI=;
        b=fyrEzQkItdJX7Lx5hSrtBrkKBQsChx1cGU5hFVpAXEbxwXCsopvVOajlM9yoorK2gc
         VlaFJwIAGr/idXJimA6z2btYNn/ie9YgxoQAlAR+nMTu4e8XbiCtnhOEkD0BgejPvQUZ
         NsLvd0UcW/yKlVBGfd0KOkJkv2dNfK6kGPssXhWQ2KGQnw3btLuTHQ2tXO1TaOc6C9tS
         twgk/a7keGg/dBmWAuBxYrvKZqWuK6ZNeYpiIu7ZilddaCPVd5sDCupBwweKu0GGqXzt
         1lUkHMjZc7deeEdHnlIKYhP/hxi+MLNh33ZTC2jRAyjzu8L77ruj0kfc9Rkul+9br5C7
         nq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/YFSZEQBtvm4n82alTgh4ZzKfgPX0vedws+p+M35/eI=;
        b=Fyhm+J6Dcnn6x04GROnhDvQVzh74cx4e2ktRqL+089pe/1fywCyCINIe+nTxPwj3Zn
         DGqk7af/S2czmg5YAxmXcymWY1SKTxB+lINYo1PXPsFZAYFWoUTjEsl/sE1HS6aDok7j
         Lp7W/fciinpdPtU3qlSb2HrvX6FYR1e7ODn1iT26p/nn1b87pT6XDJVNfWL6TFlOqBpR
         oW4PsqEDyJSOxGWB/UUjjePmmEWGFwRE812m/O8gpqh27HmmKx4vZgJxL8qel0B+gfeK
         Cs6XlgE28ZGj+Y947vXURYEGgsSGZZqan7KvWtMEuUlxDVUp0NQlcITPd+oOCHfmcZvh
         Wx/A==
X-Gm-Message-State: APjAAAWGsj/vsueYD6kcGugQKvGbRzre9Sc6aqWkOT54wMxlUf/xaCMs
        ttcVR8M82iLI2mqK9emxjVoZOg==
X-Google-Smtp-Source: APXvYqx2h+ZugTct+xP6vANWAu6GJz4ASMjRLRuTLWo0Uq9SgGF7otOo1uiZdWjIsayAcQIv6haruw==
X-Received: by 2002:aed:35c6:: with SMTP id d6mr1280868qte.320.1551389586642;
        Thu, 28 Feb 2019 13:33:06 -0800 (PST)
Received: from ovpn-120-151.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s76sm7218481qki.42.2019.02.28.13.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 13:33:06 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org
Cc:     aryabinin@virtuozzo.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] x86/mm: fix "prev_pud" set but not used
Date:   Thu, 28 Feb 2019 16:32:46 -0500
Message-Id: <20190228213246.87915-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 04b67022fb6d ("x86/mm/dump_pagetables: Speed up page tables
dump for CONFIG_KASAN=y") removed pud_already_checked() but left a
unused variable.

arch/x86/mm/dump_pagetables.c: In function 'walk_pud_level':
arch/x86/mm/dump_pagetables.c:447:9: warning: variable 'prev_pud' set
but not used [-Wunused-but-set-variable]
  pud_t *prev_pud = NULL;
         ^~~~~~~~

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/mm/dump_pagetables.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index e3cdc85ce5b6..ee8f8ab46941 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -444,7 +444,6 @@ static void walk_pud_level(struct seq_file *m, struct pg_state *st, p4d_t addr,
 	int i;
 	pud_t *start, *pud_start;
 	pgprotval_t prot, eff;
-	pud_t *prev_pud = NULL;
 
 	pud_start = start = (pud_t *)p4d_page_vaddr(addr);
 
@@ -462,7 +461,6 @@ static void walk_pud_level(struct seq_file *m, struct pg_state *st, p4d_t addr,
 		} else
 			note_page(m, st, __pgprot(0), 0, 3);
 
-		prev_pud = start;
 		start++;
 	}
 }
-- 
2.17.2 (Apple Git-113)

