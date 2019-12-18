Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78925C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5307A227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfLRUks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:40:48 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34987 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfLRUkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:40:15 -0500
Received: by mail-qk1-f195.google.com with SMTP id z76so3113753qka.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:40:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EVS8C1CmVe0PF737qzOV4edJfMDPYHvKPgJECzGTAu0=;
        b=AXgVxGjrDbC/uvJsPNtBWaZCP/+M0O6txRLQD7y1Hpoz6UONib+GgZ62r9MRMrC9mP
         vjTa4tToU8rS2caYQQRIxeWKMzT5WTfwBR9bmkBq16JJZe9paA7pEr3exXiE+eZvaZm6
         dXZJp9gr/3iyex+wMVqaZTlkusPAhDTpwVNxW+xT6psJM5/KVTzIOVmjWc6M//BCDDF5
         5KDIToNo4hYeyGSGSWiBjnSdCADI3iJ2Li6WJFIjclnCwLXkJHGaSrThoMmKTgqzLrm1
         zTBpgouPvKrDrhkRq0+KC5kry1Shnsilw8TjVfZk5KnBMtTjETRNBVq0Vqz7aHkKjPFX
         2kYw==
X-Gm-Message-State: APjAAAVqeD2NZGN4PmputtzrR/zPzHOOo59dyH3FkACc4V0Tm6Yd2G64
        a/liwOKh6K4BO0VkARyEkp0=
X-Google-Smtp-Source: APXvYqzOkJbCb1tDC42UvJLO4MR8JQqMPih63a4PkW2MI0ufNAsO1tddY+knqudL7Ob5e2o1we2KHQ==
X-Received: by 2002:a37:a70b:: with SMTP id q11mr4578016qke.393.1576701615030;
        Wed, 18 Dec 2019 12:40:15 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t7sm993347qkm.136.2019.12.18.12.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:40:14 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 14/24] arch/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 15:39:52 -0500
Message-Id: <20191218204002.30512-15-nivedita@alum.mit.edu>
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
 arch/nios2/kernel/setup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
index 4cf35b09c0ec..3c6e3c813a0b 100644
--- a/arch/nios2/kernel/setup.c
+++ b/arch/nios2/kernel/setup.c
@@ -196,8 +196,4 @@ void __init setup_arch(char **cmdline_p)
 	 * get kmalloc into gear
 	 */
 	paging_init();
-
-#if defined(CONFIG_VT) && defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
-#endif
 }
-- 
2.24.1

