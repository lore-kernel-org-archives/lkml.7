Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2E5C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95BC227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfLRVqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:46:16 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43229 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfLRVpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:45:15 -0500
Received: by mail-qt1-f195.google.com with SMTP id d18so515959qtj.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:45:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/ruuOHK8troRwOu7XsfiPt3gKMUOl0EWbM1B7FCdGE=;
        b=hIqAY9Fd5f0paVd+lvv4CIR7uvp2Ua/lrOJqSKWNUVtqpz2PdCcyQQfaPbX6/Nepxx
         ziyL7BKiNAerVBuV/W3B7Boz3Yto3ZqM/YAqSi0h77njGDArWRiyRBVZjVwPuIL/bQQe
         U+hsAMTHPqE92udi/QpP4LMSmoGMr9GgCCedBfybaBRDAmWuC6wOdZG1jo82DKwWosz4
         ZTdeEyOYnH8tReX1bLr+6KAyh3fYKFW8U2yvkfZwx0S8NJ1QrZIho+U/1dfoHa+gTLxN
         XbU9jBBAL4IOh5k4UIQh5SHOvqEmOeL29DOSmx/teFgmy2sXNixRPH/b1vLjpGBwHKQY
         hOeQ==
X-Gm-Message-State: APjAAAUX6FS2LzIrgtLLy9OI3ddH4QG8Jt+cpgWgIXXSddC2BazdVOb1
        B7a23jN7Kr811kdasQL/Iy6l742g
X-Google-Smtp-Source: APXvYqyD0qwbo9gD9gRzvgNRv/FBRMFqgZTyJfExH1zrXk3o0/YZp1KEJrE4u+ip5iC7YL5JEPOLSA==
X-Received: by 2002:ac8:2af4:: with SMTP id c49mr4333435qta.367.1576705514898;
        Wed, 18 Dec 2019 13:45:14 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u4sm1059851qkh.59.2019.12.18.13.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:45:14 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/24] arch/ia64/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 16:44:51 -0500
Message-Id: <20191218214506.49252-10-nivedita@alum.mit.edu>
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
 arch/ia64/kernel/setup.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index c49fcef754de..4009383453f7 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -608,9 +608,6 @@ setup_arch (char **cmdline_p)
 
 #ifdef CONFIG_VT
 	if (!conswitchp) {
-# if defined(CONFIG_DUMMY_CONSOLE)
-		conswitchp = &dummy_con;
-# endif
 # if defined(CONFIG_VGA_CONSOLE)
 		/*
 		 * Non-legacy systems may route legacy VGA MMIO range to system
-- 
2.24.1

