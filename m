Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE7EC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA2824650
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfLRUlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:41:00 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33450 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbfLRUkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:40:14 -0500
Received: by mail-qk1-f195.google.com with SMTP id d71so3114990qkc.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:40:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=32kCKTpHM98pefAWSVvrpnmAq3+xPjRFiMRfvmIlrcU=;
        b=RWHATSBC56GnnTupOVBbP77wJFhH0OYHtYz2nn8lVE/Xb/izepTOqzCuWpD62GoC8N
         2wxOVsQ/zjNFvcvn/PPfH23p+ojz09nLF8eCnzQZiO/RRgsBlhklSZhNVP1JxpYA1jO6
         SFznSt5wLWt7pyIAuxgQ3SBGcMrISJu8k2jF4mHl8zZg6yYjsGnm0OyX1ZHEiOuCZi65
         4yI5jkx0rROHv1tpp383N87+EV9R7wxggJFklYl7jiWLgwmeybTYykMzys3gDGIFFr6Q
         L/TCHSvFmeu4CyR4D/IlVaCqLIKyhVLu35yQgPYzx7SV5msh2w9DF8rW2TNo9iOhfjuB
         drIw==
X-Gm-Message-State: APjAAAVkhW0rQeEnyqp1MUcE8zfPmomCstkngmS2lpgX+BbJjfE7JEpU
        Fte+FYOrEr7N8oDTN36R4oE=
X-Google-Smtp-Source: APXvYqwx5D5XBpaO0WM9c/YT9hZaHDbvO3f119wvY6iSj/mBXM5g5CVOoX4O/eGtSMHQp8oEQKs4hw==
X-Received: by 2002:a05:620a:1522:: with SMTP id n2mr4654447qkk.108.1576701613721;
        Wed, 18 Dec 2019 12:40:13 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t7sm993347qkm.136.2019.12.18.12.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:40:13 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 12/24] arch/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 15:39:50 -0500
Message-Id: <20191218204002.30512-13-nivedita@alum.mit.edu>
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
 arch/mips/kernel/setup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index c3d4212b5f1d..a28057946ed1 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -796,8 +796,6 @@ void __init setup_arch(char **cmdline_p)
 #if defined(CONFIG_VT)
 #if defined(CONFIG_VGA_CONSOLE)
 	conswitchp = &vga_con;
-#elif defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
 #endif
 #endif
 
-- 
2.24.1

