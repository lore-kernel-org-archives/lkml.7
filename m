Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC723C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3FA24679
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfLRUl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:41:26 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45312 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbfLRUkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:40:08 -0500
Received: by mail-qk1-f195.google.com with SMTP id x1so2712377qkl.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:40:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rBoR9qFKudqjEn6RFPOy0vY1Hbe0MDRwH4FNr5Y5Tj0=;
        b=fL6QmBfG69mKddrfmv+N4VVULpBe+RfhenR4hI2JAvuJ65rp6KS554r3a5b2Upfl0R
         QiTiSEECjcxQJraJzL4iTLKbLOzp5hvqg2lCU1IelMASjTkNm+8DJHqHLLsaLSqHCZNk
         Uo75ARzvNzwPTi8de/uYMis+zwnJp7ByWzSYHQ8sl1MSxBFyTrS1UMdEIAzmOH0vGlce
         IPxHLREVl6FGpb2Q4wnALD9krnCnvp2ijgoUMsImKAdvyIbjC21578PsaPQVd/f21MNP
         dS0leagH/e0EMrKcwhHFF5LQr4Yc+Z3WnhaNQQcp2Vc1iBT1VhxKYFsawoNiNNNbW6/Z
         BhPw==
X-Gm-Message-State: APjAAAWlyM4Mul255o03RYa9CANNjImpJp+AwL1+vArU5G1fiAOfusU6
        q7ACkUxMFCPWX+Wfuce5bzDwYzk9
X-Google-Smtp-Source: APXvYqw7pSckKNxxvZoK+t2VtKfzFG/5kLQUyKOp3uo+wy/TXKY8vZwPlyLq6S+dC3piLdjIzHZQWg==
X-Received: by 2002:a05:620a:98f:: with SMTP id x15mr4654159qkx.462.1576701607991;
        Wed, 18 Dec 2019 12:40:07 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t7sm993347qkm.136.2019.12.18.12.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:40:07 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 05/24] arch/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 15:39:43 -0500
Message-Id: <20191218204002.30512-6-nivedita@alum.mit.edu>
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
 arch/arm/kernel/setup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index d0a464e317ea..d8e18cdd96d3 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1164,8 +1164,6 @@ void __init setup_arch(char **cmdline_p)
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
 	conswitchp = &vga_con;
-#elif defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
 #endif
 #endif
 
-- 
2.24.1

