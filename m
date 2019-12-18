Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A396C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7690824676
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfLRUkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:40:47 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45230 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfLRUkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:40:17 -0500
Received: by mail-qt1-f195.google.com with SMTP id l12so3014414qtq.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:40:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BBJpO1RZK85vWbcm3gmGrgqk1MkuQnaI7ZsKD3UbeWo=;
        b=dAJmn/lGO/UzcLWq/kqEf1HSbXTXvMXXMFQ6eJyFZsO7SI0SwqAsEb04RFoz93WYrt
         blTwb9/MdcwzqovY13XBS16R5aPDBJ57+AkAMoFSeyX9oEoigk9RzbI1kgQHSsyGuYks
         4v5Wb02VdtvgUWkguxtNmKVP85tjK3Q3DT4IL4YZSDQlmELxIYmJDJqAb4+BGa1RGhLr
         owbtfe1LUARBWhjaHTzpwaQQcTDvKIJ5/JWi9c3T9jDM/44hP/mFdd8vRLm4kLDFPCeN
         dQO3zO0qswLd7Hmg9Vg2UQ4x5f5izPIyAWBKsTHrquPnNbIRIflKdL+pQFTjEQWmPfSB
         wAvQ==
X-Gm-Message-State: APjAAAXFgMIar2RBCsT3iC4MxLGVjdi0Tq3SApSQJJfKPXtIAw+DwZJh
        umIDnAele6sKiFA2hpDDN9Y=
X-Google-Smtp-Source: APXvYqzxeD/0xF3An257KeKUIVVu6HXJE/niDfhgOkUXzJ+vzjDUKawQcLH4+Dm38zoRaRPFR12CvA==
X-Received: by 2002:ac8:1087:: with SMTP id a7mr4005633qtj.274.1576701616677;
        Wed, 18 Dec 2019 12:40:16 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t7sm993347qkm.136.2019.12.18.12.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:40:16 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 16/24] arch/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 15:39:54 -0500
Message-Id: <20191218204002.30512-17-nivedita@alum.mit.edu>
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
 arch/parisc/kernel/setup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/parisc/kernel/setup.c b/arch/parisc/kernel/setup.c
index 53a21ce927de..e320bae501d3 100644
--- a/arch/parisc/kernel/setup.c
+++ b/arch/parisc/kernel/setup.c
@@ -151,10 +151,6 @@ void __init setup_arch(char **cmdline_p)
 	dma_ops_init();
 #endif
 
-#if defined(CONFIG_VT) && defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;	/* we use do_take_over_console() later ! */
-#endif
-
 	clear_sched_clock_stable();
 }
 
-- 
2.24.1

