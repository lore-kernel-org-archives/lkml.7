Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEEEC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3549E21D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLRVpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:45:24 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:35803 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfLRVpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:45:21 -0500
Received: by mail-qv1-f67.google.com with SMTP id u10so1308129qvi.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:45:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dfoBv1/fajBVFYCXkRzHX94CB9r4wEDcgyCOURmAgAg=;
        b=emliEjp3SzuS1NR8F6BvurcWoQLy3T6gYl/N/iTGeTjJWc8c06kAD4TBVINjLyJiAm
         2PKKyNsO4PZInhUdB8TNX0gAt3tNHQmRIoElDJ0TrQ945i4ZmYk6tBeNa9EGGEXBcrSk
         R6okU2qB4R0fdyXTk7aVEeDt/vUfKxJtNEB/+AzFhgcb0OQMrYiCMM+ghPfEgx9Hx0aL
         rYcHYEb6G805MY8L5bkS6/H67n2d5C77B4wnYEI8CncGkh8wQF+wNHhDB0FaizHRPSXb
         bfGEtnvSw39l6B+oBIVmES68oheEebTeCmimXXCqIKzwKkRma4vFJZS6NE+D1NvtpXEs
         uPlQ==
X-Gm-Message-State: APjAAAU7+eORJ4Yf/s6iKntagpP4WWKY54UrLp81u0WcawrAj2D1gDfh
        25hWyc1aNUzu2liyEQPJKiE=
X-Google-Smtp-Source: APXvYqyJcgV0YzfwIJWEoPzEWKHM/Q8SNW5jLeaK/pkZxk08wlg0hw8p4nfU1ul4ALKejsYqz8VKSA==
X-Received: by 2002:a05:6214:7cc:: with SMTP id bb12mr4424854qvb.207.1576705519918;
        Wed, 18 Dec 2019 13:45:19 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u4sm1059851qkh.59.2019.12.18.13.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:45:19 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/24] arch/openrisc/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 16:44:57 -0500
Message-Id: <20191218214506.49252-16-nivedita@alum.mit.edu>
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
 arch/openrisc/kernel/setup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index d668f5be3a99..c0a774b51e45 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -308,11 +308,6 @@ void __init setup_arch(char **cmdline_p)
 	/* paging_init() sets up the MMU and marks all pages as reserved */
 	paging_init();
 
-#if defined(CONFIG_VT) && defined(CONFIG_DUMMY_CONSOLE)
-	if (!conswitchp)
-		conswitchp = &dummy_con;
-#endif
-
 	*cmdline_p = boot_command_line;
 
 	printk(KERN_INFO "OpenRISC Linux -- http://openrisc.io\n");
-- 
2.24.1

