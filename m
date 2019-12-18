Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1871C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE95121D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfLRVpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:45:21 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46387 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfLRVpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:45:14 -0500
Received: by mail-qt1-f196.google.com with SMTP id 38so3174446qtb.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:45:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RI4FfjUerUGerBdwMNUghyq+e/9oztb7saspiR/63kY=;
        b=eiKRCutoSD5Tprl/TLnv8LCtLbgsdOZPIQ4Yl9/GpGaDHyr2QV3VhF8sGkZ17zpnme
         1R/oGtLu9PGLO8C+Wejf/FPB1wAMJ9D9rD8wXeLNXFyXGir4njmTY4Kr3/T0tfS3reHo
         MBm/8BwGYPvD9sVt/hySW47zIiPtn78QOzF2Vohgh/JEgheDblK2XELQuqt27+Ka1TXu
         xY+oS4Sret6Bca0kDT6lHje3EaL6WUrhdbhbX/ZoT1goazO2J5lt+g0onz0StQWs5c5l
         UB8c6nHzrWCMeJc7kDYzqe1XI+/U7VWgMRUxtI/TvZIVTDWlrVETZRnAXttT1EdY5nFy
         r6Ww==
X-Gm-Message-State: APjAAAWuqKGZ+GW9AbSGWF3ASfNNb3HmTiaz50O4IC19uyc1Uaw9+WTj
        vG8gPHf/eO1NpP2Wve1CVDg=
X-Google-Smtp-Source: APXvYqwBsnfsyDJZDYonnkltL2s9i+dm+AGwzuNYc0xVBNBLoEGa5eCnc+UEmij40q5F+4047BAM4g==
X-Received: by 2002:ac8:3fb6:: with SMTP id d51mr4312793qtk.288.1576705513210;
        Wed, 18 Dec 2019 13:45:13 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u4sm1059851qkh.59.2019.12.18.13.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:45:12 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/24] arch/c6x/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 16:44:49 -0500
Message-Id: <20191218214506.49252-8-nivedita@alum.mit.edu>
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
 arch/c6x/kernel/setup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/c6x/kernel/setup.c b/arch/c6x/kernel/setup.c
index 8ef35131f999..48c709644e29 100644
--- a/arch/c6x/kernel/setup.c
+++ b/arch/c6x/kernel/setup.c
@@ -397,10 +397,6 @@ void __init setup_arch(char **cmdline_p)
 
 	/* Get CPU info */
 	get_cpuinfo();
-
-#if defined(CONFIG_VT) && defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
-#endif
 }
 
 #define cpu_to_ptr(n) ((void *)((long)(n)+1))
-- 
2.24.1

