Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA67C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48946218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfLRUkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:40:12 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38465 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbfLRUkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:40:10 -0500
Received: by mail-qt1-f196.google.com with SMTP id n15so3049849qtp.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:40:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RI4FfjUerUGerBdwMNUghyq+e/9oztb7saspiR/63kY=;
        b=Q2LP2ud9XF1WLyrpBCmnqhSSlUhV5hrks1PnxlCsIUnXutNYBe/sViB55I2QzuL7+W
         sqSsc57suGyKQ6PpgnOH6rK2UCeEd8Wdr1K1sZwz5FmzStHsWWuR8vomTGrLs1KwH7J5
         jcFJ2d3jAgDXoZOO8BU2MgdaWVl+uLksodol+1xg5GuqI9VGHIKcp1TSM/8i3j9+VtaO
         FKSLcfEp15Ug/5OxSenEp8BVENSChnnqiyxeffeTmRObdYCkrh5EztJliywEB/p3JkOG
         V0gN0wB1cPUn/wPUSzKfkM7KzshjIaMekR9ol37ak2wLkD/ssM57Pt9HGWT4ZaAVkCvM
         Yg1w==
X-Gm-Message-State: APjAAAW+UUNNq6X6nyPdFsmfotEElmWljuMeztz6vB8xsgJ4XN0zbW0G
        1BX9uS1hWt1/Vi68UefQFgs=
X-Google-Smtp-Source: APXvYqwluaUhUJ3BOqEqBzij3XaewXUwdek9wjBLj5fmFCxOOtyVZCoANogUKR2UMMWgVRSKGNI+HQ==
X-Received: by 2002:ac8:2310:: with SMTP id a16mr3978805qta.46.1576701609798;
        Wed, 18 Dec 2019 12:40:09 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t7sm993347qkm.136.2019.12.18.12.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:40:09 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 07/24] arch/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 15:39:45 -0500
Message-Id: <20191218204002.30512-8-nivedita@alum.mit.edu>
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

