Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78253C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509AE2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfLRVpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:45:42 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39102 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfLRVp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:45:26 -0500
Received: by mail-qt1-f194.google.com with SMTP id e5so3211852qtm.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:45:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wa3xpCF0PYCQcq/3TSDnS3wckgcLrmnEjegMcusCHSQ=;
        b=EzM9wJ7R0zwNX8nIITGtLv79LbnIWvc6xvkiQbs+BzI7i8vDppKDWr3DqFDEUUq8QZ
         tSnGx3jAWbbwBucaUxzz5bRL83P1qtP/kflXTWquJX1YQJqnQ/d68uYN0en7jpGNwTWs
         3TjL3hwPlMZpelZ6hodeQAmPC198JoEwyHouqtoneRQ+DhXy1SuN/lhaiwGFvk01TMk1
         v5zNV+LxBDSp2QDORxnNQWnzd45myA1iPr1cYsBHEAgL2QYPurHLwudLaKzXm15Wo3xR
         t5WgX5ubDjBnUoQSaklT0pWAVbejw8JzgFwU+Dbml5f86VWG08w++OIZPtzf50yZAvSb
         R4uw==
X-Gm-Message-State: APjAAAVKpm9koHqGPPUn3fgwbtYoXXKLqyHgmUU1TEhx91/vVX5trn5d
        9FNugB8B7oHRjsqZNfTAb14=
X-Google-Smtp-Source: APXvYqwGC6PAom5Lk7cDDqObrmFqwyJpT7fLrUEZMi1K3sNAFoDZdYDgc8eHg+ivWcDwqHLpBq9hoA==
X-Received: by 2002:ac8:145:: with SMTP id f5mr4178624qtg.194.1576705525744;
        Wed, 18 Dec 2019 13:45:25 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u4sm1059851qkh.59.2019.12.18.13.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:45:25 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/24] arch/unicore32/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 16:45:04 -0500
Message-Id: <20191218214506.49252-23-nivedita@alum.mit.edu>
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
 arch/unicore32/kernel/setup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/unicore32/kernel/setup.c b/arch/unicore32/kernel/setup.c
index 95ae3b54df68..0c4242a5ee1d 100644
--- a/arch/unicore32/kernel/setup.c
+++ b/arch/unicore32/kernel/setup.c
@@ -270,8 +270,6 @@ void __init setup_arch(char **cmdline_p)
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
 	conswitchp = &vga_con;
-#elif defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
 #endif
 #endif
 	early_trap_init();
-- 
2.24.1

