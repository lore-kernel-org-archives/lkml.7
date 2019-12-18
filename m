Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EC7C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8460221D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfLRVpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:45:25 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33643 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfLRVpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:45:24 -0500
Received: by mail-qt1-f193.google.com with SMTP id d5so3231324qto.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:45:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D9pT2S8k/algrgf4ExBtGqGPejHqjkU67Sg1NKhWPfA=;
        b=C9LTwtb8ICVt3jFPjRB63z0JTmq5jCFBlc8nt/CGw3cMz7Z9QOWSNCA9wtlYu9XSUY
         Pbggtd/owU1N28N2Pi8xceFFNGsR+NII/av95+8tW+Kbx7MS6kIWN34rPP/0Pr65qAnw
         9vN0tvrZ7Ikp5M336DWmLcN9FjluwLdImw1wJMT6wlUMh9bI4lNNdLRnidF27v8wIRVm
         tbQ6U+Zg7Wrgog7mJLjGHSlNZGTo4aMIjNrBNRTxjnb7UZ6iG9j6nasOqlA9mcjbJvTT
         0K3CLMPPThDkT/hmADKkaCkTnaP+r4FDMgjNci7zGASuo8a4pzELL3t8W85IzKM4p54u
         3rcw==
X-Gm-Message-State: APjAAAX8WVsBkuIjiXh0MoJB1TRP+y7So2707SYqw+6uvOG/V7q+J500
        /Nx1sYfaDoEDhv6PgdIqCEM=
X-Google-Smtp-Source: APXvYqxgM9DLUoP4ysfbHmTDmTMxLtRgelR3zOIU1ZoMj0aWbBmkxr5is/UTyQ8Ycb++OmklUh0flA==
X-Received: by 2002:ac8:3526:: with SMTP id y35mr4043668qtb.97.1576705523447;
        Wed, 18 Dec 2019 13:45:23 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u4sm1059851qkh.59.2019.12.18.13.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:45:22 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/24] arch/s390/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 16:45:01 -0500
Message-Id: <20191218214506.49252-20-nivedita@alum.mit.edu>
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

