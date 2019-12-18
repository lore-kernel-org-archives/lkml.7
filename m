Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB9DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBAC218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfLRUlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:41:19 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38905 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfLRUkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:40:09 -0500
Received: by mail-qk1-f196.google.com with SMTP id k6so2748814qki.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:40:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0dV63FGKurbHicTv4fkFntFqg9okeIkli05F9bbXIFo=;
        b=OD0mfmCaPhJ4axlJWdJw8CeDOW94keoMS3GuwKrFq5Cut78IGYHby94yYaqiNFt1lr
         dxZ7t6elsuHi6dDSPP1yATW8767hQfCMpafGxxwfxCHgpnxp9vdXHzNwaAaXrfT8Qwl8
         lkAZlhJhKbHAeDcpAqshLyuVOAJtmqpcz8oSvko59zMu6GTsNqtTjjcE826Xq/4m4NW6
         pf+QUoImMmzFjLxx+Ktj6Z1cAtM4ckL4JIuBDzwBp+WPHuc2TzKwT9MjM4DwS1g5YEe1
         ss1qfe+D0+RQ/pc4RdYiWvIvNILlP4+d23QR51p2OHvC5606tIArYmcPFvVLmj1Ux7as
         jHGA==
X-Gm-Message-State: APjAAAVDkPqFC9lBJ5DNF1HEBRTra0Lji2LPwAtaPu6+puKfnvmpbvqJ
        XkMlJyeHq2dhSgmXVuZ8878=
X-Google-Smtp-Source: APXvYqy7g8VA/vyCZyiAr1MTJflsjvhd5lg+Noe7FGR8uvVYdF+iyTISxzdq8dk3Ql8VrWm362jvIw==
X-Received: by 2002:a37:9f94:: with SMTP id i142mr4760899qke.244.1576701608892;
        Wed, 18 Dec 2019 12:40:08 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t7sm993347qkm.136.2019.12.18.12.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:40:08 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 06/24] arch/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 15:39:44 -0500
Message-Id: <20191218204002.30512-7-nivedita@alum.mit.edu>
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
 arch/arm64/kernel/setup.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 56f664561754..2a86676b693a 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -353,9 +353,6 @@ void __init setup_arch(char **cmdline_p)
 	init_task.thread_info.ttbr0 = __pa_symbol(empty_zero_page);
 #endif
 
-#ifdef CONFIG_VT
-	conswitchp = &dummy_con;
-#endif
 	if (boot_args[1] || boot_args[2] || boot_args[3]) {
 		pr_err("WARNING: x1-x3 nonzero in violation of boot protocol:\n"
 			"\tx1: %016llx\n\tx2: %016llx\n\tx3: %016llx\n"
-- 
2.24.1

