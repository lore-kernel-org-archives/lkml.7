Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1D6C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01E7218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfLRUkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:40:21 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35137 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbfLRUkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:40:19 -0500
Received: by mail-qt1-f195.google.com with SMTP id e12so3067597qto.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D9pT2S8k/algrgf4ExBtGqGPejHqjkU67Sg1NKhWPfA=;
        b=gLALY1RgdyhV4Q858giS5rbwu4sTzltkUX7VwsKNwhQFxrinLBbAA0mWDf0ERgeQD6
         MOfJus3J7ZnennF24WsA6EyyuLysKm2SG4R4f8eXP/nly+/Wxgx7tHMFyBO7pnv3d9zm
         Vz/xqOXkQ584fAgi3GdIZVyp1VeluWLomEEJw+RcA8djB+uwfWf5NKGTyTW8Be6KrqBQ
         ATMSw1vhbXuoIuUCigI79SBbg5ZhYoVKBeZNipuNMkrs4Fa//EyPapctdCAm1BJ+5at/
         OJGYkZfpJMFoFbwyFSFBqoRYphyAByfFo4Zm/yg5KejTAl2uNdwhNm+sCt7r+CJWEnCO
         ITiA==
X-Gm-Message-State: APjAAAXW2PtmNO6BJHTIJagXQYdKR1jQ2gFWAAH2wCPIXdJF7LdP0wP9
        NNYKdz/BDMVRnWkamoGb2u8=
X-Google-Smtp-Source: APXvYqzVTlQvLv/OzDLkhogEbLXHaOpN0ZkCeqfiPbdsKZu9bV0rnwmm9fpAjKqc/CEiHIYXauk63g==
X-Received: by 2002:ac8:104:: with SMTP id e4mr3927836qtg.37.1576701618946;
        Wed, 18 Dec 2019 12:40:18 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t7sm993347qkm.136.2019.12.18.12.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:40:18 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 19/24] arch/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 15:39:57 -0500
Message-Id: <20191218204002.30512-20-nivedita@alum.mit.edu>
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
 arch/s390/kernel/setup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 9cbf490fd162..703cfbca2d25 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -241,8 +241,6 @@ static void __init conmode_default(void)
 		SET_CONSOLE_SCLP;
 #endif
 	}
-	if (IS_ENABLED(CONFIG_VT) && IS_ENABLED(CONFIG_DUMMY_CONSOLE))
-		conswitchp = &dummy_con;
 }
 
 #ifdef CONFIG_CRASH_DUMP
-- 
2.24.1

