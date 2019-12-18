Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA02C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFBF227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfLRUkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:40:11 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41485 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbfLRUkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:40:08 -0500
Received: by mail-qk1-f196.google.com with SMTP id x129so2724631qke.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:40:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UeBf/VpWa9gYAtz/T4azpaJTgSpTj/SRdru/GVfph8M=;
        b=ffmDaB1WxFDQhrD9RgrJ5SGEdFstWHbOgkzqT/9QlDEa8T8IIxXHqU6EMN9jLjHAkQ
         wzQJzD8ou5NpRGr4AxD/XtA4RH70Jj7Sd86XttxSWYFn7WE5UeOzeZcNfKb5hBFF8sxj
         GUOp7ePs6+7+QUzcbl3rX/SiEpakuRAk0TCds8b5denfNGDWMr065rHRxM/xavJjgZtW
         /cQitAbZHKUeqUsL13+2gSyzSZYGu5qKDybYs6rH537yiCVjV4MkyPrjOZdDK++R866o
         SIzQx0OIRjytJneFmCtMgAvpOr7BHCu6vCmehSRoVQlXUmhKqbAJE8tN6/bkOrem7K5a
         iAgw==
X-Gm-Message-State: APjAAAVFLTMXPVK9cfjMkYDwa8jB4AfV9eCDTFsKRSpdhmkl0fnbynMh
        KnwkOgkhEcuL0R2LJuoZclc=
X-Google-Smtp-Source: APXvYqxlRhAJeqNvOCKU2HnhknDW5KZ+4QH3x4voIdCcxpJODUuH1cH/Ekj4aSD6a0136mN71xdtJg==
X-Received: by 2002:a05:620a:955:: with SMTP id w21mr4676476qkw.122.1576701607100;
        Wed, 18 Dec 2019 12:40:07 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t7sm993347qkm.136.2019.12.18.12.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:40:06 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 04/24] arch/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 15:39:42 -0500
Message-Id: <20191218204002.30512-5-nivedita@alum.mit.edu>
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
 arch/arc/kernel/setup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index 7ee89dc61f6e..e1c647490f00 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -572,10 +572,6 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	root_mountflags &= ~MS_RDONLY;
 
-#if defined(CONFIG_VT) && defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
-#endif
-
 	arc_unwind_init();
 }
 
-- 
2.24.1

