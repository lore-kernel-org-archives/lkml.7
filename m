Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C17BC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461972465E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfLRVqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:46:23 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:35929 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfLRVpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:45:15 -0500
Received: by mail-qv1-f67.google.com with SMTP id m14so1386053qvl.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:45:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XK7YmmLGQlfcgUyNbnddM2ijtu/hYGP9ckYtCpSRDMs=;
        b=ACJj18ZMPlQTWXq5YxXux/EX4kXRLsQkNDqcbSackzWst67YKOa9C2fh67nJxqtawE
         z35cgFu8+m4+uY2Q6JvmFUb4j2NlivyK6/1u6A9x37Lnpl6TCX7PuUeVhTpIDaNVt2Yz
         tQCQjr3v3yor3HDkMjH9tex/podu/mkzBS3dKdyMYC+8cdSbke7t7z1maabx6oK53Noo
         KTNqY8EBuWAp6BrkksVBz1/89CFjR4hBHUJGAYgV6B29QsS+eNIzxLF8ED8IfueDprSi
         /6DjrSIjREV2vlVrAcdpaOSjWImIjR/6M15nKYrUUIuAMht+Whan+3k+7kGTun4GFZIi
         Yxog==
X-Gm-Message-State: APjAAAUQNRHLC8q3ZX8cmkKLURNP6o+MQ9iFIqMwYAsMbZItHuMia85d
        lqBCDu0miOE/Gh+K6Y8Rc1E=
X-Google-Smtp-Source: APXvYqwFOrvOpY6WvnUs3EjM9EVwSNnTvnRX4Ew1pmDNBkT07/iqyKc686Npqqth1o0/V4JqRC9QHw==
X-Received: by 2002:a05:6214:118d:: with SMTP id t13mr4427675qvv.5.1576705514036;
        Wed, 18 Dec 2019 13:45:14 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u4sm1059851qkh.59.2019.12.18.13.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:45:13 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/24] arch/csky/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 16:44:50 -0500
Message-Id: <20191218214506.49252-9-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218214506.49252-1-nivedita@alum.mit.edu>
References: <20191218211231.GA918900@kroah.com>
 <20191218214506.49252-1-nivedita@alum.mit.edu>
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
 arch/csky/kernel/setup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
index 23ee604aafdb..52eaf31ba27f 100644
--- a/arch/csky/kernel/setup.c
+++ b/arch/csky/kernel/setup.c
@@ -136,10 +136,6 @@ void __init setup_arch(char **cmdline_p)
 #ifdef CONFIG_HIGHMEM
 	kmap_init();
 #endif
-
-#if defined(CONFIG_VT) && defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
-#endif
 }
 
 unsigned long va_pa_offset;
-- 
2.24.1

