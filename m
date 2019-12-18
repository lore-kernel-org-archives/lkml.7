Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC96DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79E221D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfLRVpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:45:22 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:44665 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfLRVpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:45:17 -0500
Received: by mail-qv1-f65.google.com with SMTP id n8so1367102qvg.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:45:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L92CVkon/nLqJ4vOLY/kKoM5pQOZuk1/nWVb5NREnUs=;
        b=kltBtbdSfqeijclfaTwr3QdHuoWupsK2xe78zhqH4CgXIanOnhjSHy3tlpdXmiLyZI
         +RHYlyOCP1GtSweraOuDC0VET9+a5pkQBAH9nhBJjA2T83Qh4FTerrXJY9Mnh6j07TYw
         wRtp0qHJ5Xiqcgdg4lMhhc279a1OD7XFvlG0puy3BTifhfCg53CtGgM66QqUa1SNN+/s
         779rB92jzqam6neW0ITl56Gv4ybRhXwsIotBBKWBa7xz0M8me+7E4ccA/rsaFuWh9+3I
         Cz/UFEIW5V9cGdH8/Ht5pS1759x+9SWWR/6vulicg0Se79ivNpD9kSXTzkDsWNeqrhLy
         0zFw==
X-Gm-Message-State: APjAAAWcTNiiPlb7VIKdx5OvyilBSu/sbvItJ1eRefoGx0xIT+6L69kH
        9dpj3TOykvALxTMmdyFUFfw=
X-Google-Smtp-Source: APXvYqyB3uBmWp77+UDehW72H0UvPNTduU8HNAMk9eZuy2/lo3hnoKpqLP/mXFhUv+e6bepQe8+hSg==
X-Received: by 2002:ad4:46c3:: with SMTP id g3mr4396115qvw.60.1576705516595;
        Wed, 18 Dec 2019 13:45:16 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u4sm1059851qkh.59.2019.12.18.13.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:45:15 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/24] arch/microblaze/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 16:44:53 -0500
Message-Id: <20191218214506.49252-12-nivedita@alum.mit.edu>
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
 arch/microblaze/kernel/setup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setup.c
index 522a0c5d9c59..511c1ab7f57f 100644
--- a/arch/microblaze/kernel/setup.c
+++ b/arch/microblaze/kernel/setup.c
@@ -65,10 +65,6 @@ void __init setup_arch(char **cmdline_p)
 	microblaze_cache_init();
 
 	xilinx_pci_init();
-
-#if defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
-#endif
 }
 
 #ifdef CONFIG_MTD_UCLINUX
-- 
2.24.1

