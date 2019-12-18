Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FCEC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817ED21D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfLRVqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:46:01 -0500
Received: from mail-qv1-f43.google.com ([209.85.219.43]:34191 "EHLO
        mail-qv1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfLRVpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:45:22 -0500
Received: by mail-qv1-f43.google.com with SMTP id o18so1389728qvf.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:45:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BBJpO1RZK85vWbcm3gmGrgqk1MkuQnaI7ZsKD3UbeWo=;
        b=Ng0ctIVtnMLD16nIkYcuCVn5TPm+BF6iNXe9vJ+WnS7K7C5S2Y0CFGq3LJLOL8zqDE
         5YjRW5hQuNSw7N9ePlV+numcuZy4gw8GbSp+FVXAZOgoTK2cgJh0FqY7axVRMtK1VJ5a
         LIYwQRDMIHM6sFa4c29zL86cXEGteA6xXM/SdDHA1LCgckW2/K/fDhNcvwvyp0zlSvmW
         whiDF49uKqRB9wbnzGb7/hrbGeIZCUM1xlFeRypqo5LaqqMTPZPGO0f5cpnS1mHi+C5+
         +X54k8LOt1CP3NU/cVbsY06jNZCK9sWrSx9Gp/BBsE7GElxJHWA4j/P7KYPrPdM3U7nS
         IUWA==
X-Gm-Message-State: APjAAAWn7z+IDQRfHjhBDp38QBWfaJ6RhZX07PXhPCEDO5EolDMlaB8o
        QIAcVMGqWGn9QhwtnWar9Co=
X-Google-Smtp-Source: APXvYqyT8OKG3noaSV17+OLHneMTgubv+iShHAQCNqYNXm+ePHHFGN4gd8Ad6rCNxEMGDw+t2d6FxQ==
X-Received: by 2002:a05:6214:1874:: with SMTP id eh20mr4656361qvb.122.1576705521054;
        Wed, 18 Dec 2019 13:45:21 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u4sm1059851qkh.59.2019.12.18.13.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:45:20 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/24] arch/parisc/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 16:44:58 -0500
Message-Id: <20191218214506.49252-17-nivedita@alum.mit.edu>
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

