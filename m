Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985C1C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7640F227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfLRUlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:41:04 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45220 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbfLRUkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:40:14 -0500
Received: by mail-qt1-f194.google.com with SMTP id l12so3014269qtq.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:40:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L92CVkon/nLqJ4vOLY/kKoM5pQOZuk1/nWVb5NREnUs=;
        b=jAo0uaog/+Ze6bFdbRjEVRNEXfOp+kyCmk3OY8bFdGZjXsyXwdh9yhHxuuEDpW2yTA
         bWoEdIkYVWRT/XsfKDgWfuFNmwzapsS8+ErbD/6qR2zQStWLaQ4KNE+tFeC+wNnGXRyJ
         NkFTmsOstlzxGYlzD+la9I+J/NzrOV5ipEU/yCaDiP5FGmlPAcTAnJkTCckKcOTFC6WH
         183ObPKEudBxSVHWWDeO3WggRRK+5xP+ES450UrYgdQPppm8+0LkyMZU2anTlpH/Kuzc
         grMAGpeBMupne1Fy90I0czyZW33jntJAlYni/ICcMLuiI44tP4QIIMWPJJeIuHkIy2zt
         ndSg==
X-Gm-Message-State: APjAAAVcEdO0uHNBAwRCAmRiZnxpjp1V5epbejnOLR8s/hvSbUEYCsRv
        4u+NpfkD9RHvsDA3RSfcgH8=
X-Google-Smtp-Source: APXvYqxya7db/F5pjRrOziSBVdjfcTmFrGMrR9VGIBFV0c8MYfKhw6dzmO4zxnH36U6M3JWLVvO6Ng==
X-Received: by 2002:ac8:644:: with SMTP id e4mr3954576qth.302.1576701613082;
        Wed, 18 Dec 2019 12:40:13 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t7sm993347qkm.136.2019.12.18.12.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:40:12 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 11/24] arch/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 15:39:49 -0500
Message-Id: <20191218204002.30512-12-nivedita@alum.mit.edu>
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

