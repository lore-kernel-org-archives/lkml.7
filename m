Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1748AC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA337227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfLRUlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:41:02 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33181 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbfLRUkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:40:14 -0500
Received: by mail-qt1-f193.google.com with SMTP id d5so3076403qto.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:40:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nmjx11JNpZwOQu39J70e+ulTg+U7qJn54nAaK/uJESw=;
        b=MxKdNlZJ0a7qqnjKIlJnFaZo9yIc93Ku5SbELLA1je6sGSoFL67rJHc8n9GUPFXaDZ
         dFouuOs22VOWy7NXmu0SMUzLQvO1QRUI4AfTxQYXCa5MTbSsNWr3gDtKfFmaXSYtF9Fx
         ZM+wpa9IpIh6/8Xf2RBL2oghMmXRBrYmQiiRS3D5T5IscxfIAJoCtzGUQ3Jy7S+i/gnn
         wJ2G5o5WbRUTm4iotOhXfg7nna6Dxdj5OREn5B/46cYjuF7wkamODjWVQyLEUGtQQ3sX
         9TtO1/T9sC/fpepBSWB9a4jx98aix9MPG0H43/PM5SNYhrVnXro3d2HyBNwaSiXWitOp
         /gRA==
X-Gm-Message-State: APjAAAUivJIxy1v7f7HrZXYDiTY8/7pYSmpT1gkheqpfsGodTJagFtzM
        knW3x1q8W+LzVbFJ/Ly9h10=
X-Google-Smtp-Source: APXvYqy1PnAwJnBSQZDVFz4axeer8cA66BYquzlsvpCRF1Euvd3neThPjl0UOGWDxTRK0XbiX+H1Xg==
X-Received: by 2002:ac8:2af4:: with SMTP id c49mr4072963qta.367.1576701614268;
        Wed, 18 Dec 2019 12:40:14 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t7sm993347qkm.136.2019.12.18.12.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:40:13 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 13/24] arch/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 15:39:51 -0500
Message-Id: <20191218204002.30512-14-nivedita@alum.mit.edu>
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
 arch/nds32/kernel/setup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/nds32/kernel/setup.c b/arch/nds32/kernel/setup.c
index 31d29d92478e..a066efbe53c0 100644
--- a/arch/nds32/kernel/setup.c
+++ b/arch/nds32/kernel/setup.c
@@ -317,11 +317,6 @@ void __init setup_arch(char **cmdline_p)
 
 	unflatten_and_copy_device_tree();
 
-	if(IS_ENABLED(CONFIG_VT)) {
-		if(IS_ENABLED(CONFIG_DUMMY_CONSOLE))
-			conswitchp = &dummy_con;
-	}
-
 	*cmdline_p = boot_command_line;
 	early_trap_init();
 }
-- 
2.24.1

