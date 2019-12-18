Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B52C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D0A227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfLRUkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:40:42 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33190 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbfLRUkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:40:18 -0500
Received: by mail-qt1-f195.google.com with SMTP id d5so3076606qto.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:40:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=smdZf1o+sX783B1zfvINLQ+T4hhryNo5pnaWNDicN+w=;
        b=XWHHbQgwSygE6skDVcv62whYSz58lR2xU2WrrENuBKGMATEy/14GweSx5o5Fp1wr7i
         mB2ZC2+5XwB3bOP9UyjamBb8UA5dt1gmSMdyL1E6QMKzYv8WO1j/RZXJSDVSCFQFy5wN
         L1aqDOmyJVWw390ul/f4R6JdJVF4AI57GhqF9sZJnhXsre0QzVh4w9dBNH44+qAlMOrK
         A6MPOICQ2zjr4vUaU9X86VjgdeIIm+1BgxJSG15NwX2M/Al96Wdf1aJcvrDj8nqKNQtL
         DgdpgVGZ6fzmZi/PTSTyhjVYs6qa0orSJOzILmZshfye60JdskLYqMrFDvOjHcJGFFfN
         eYdw==
X-Gm-Message-State: APjAAAXIw8dtmlzSwspZfudaVN5YwJ8FDn6nh+89lfC1y0ITQHUGWQqc
        FkRlZYTbjdLKfQQ0LCtFSDfiFpsd
X-Google-Smtp-Source: APXvYqzx4WWeuyTeoHAbNek0l732CPs4tyBlBL8PsYo1PxVe5YW0O4gQoZGleWxY6q/1lkjce0XkZw==
X-Received: by 2002:ac8:6697:: with SMTP id d23mr4119072qtp.350.1576701618253;
        Wed, 18 Dec 2019 12:40:18 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t7sm993347qkm.136.2019.12.18.12.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:40:17 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 18/24] arch/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 15:39:56 -0500
Message-Id: <20191218204002.30512-19-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218204002.30512-1-nivedita@alum.mit.edu>
References: <20191218204002.30512-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

con_init in tty/vt.c will now set conswitchp to dummy_con if it's unset.
Drop it from arch setup code.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/riscv/kernel/setup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 365ff8420bfe..9babfcf3bb70 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -78,9 +78,5 @@ void __init setup_arch(char **cmdline_p)
 	setup_smp();
 #endif
 
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
-
 	riscv_fill_hwcap();
 }
-- 
2.24.1

