Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312F0C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCA2227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfLRUkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:40:09 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38930 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLRUkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:40:07 -0500
Received: by mail-qk1-f194.google.com with SMTP id c16so2738441qko.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:40:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RCSQ5QsujeKqOofk/5e8tL3S0uOIr5Ub3kx5O5FWQpQ=;
        b=kxDMvEn+goDDyTr+MhhAbM7RmB0wjtTUNOIOx27UC//acQp4Dux9qw44j3eayfw5NM
         FpmujovqUhM9jimCzw0pSvvaW5lYP3wNkD+k4gk9I49wvVapXzlQgYjocIQaa25CKRZC
         lSKKhdx8YFQGegK2nJimNo/a7NczqrfEOfPFdKIfwadw9MtoozV5qPRgat0XaMkZ2TE1
         iSM0FADH2b6Dhz/VUUuiukoReKp5CM9u3Jfm1nNjlpExZwK0JCokS1srckjDmmh3St8S
         VCMB1RYGygbXvHKsnUm6uB7qmUD7fhTrDHMhyW0rGLjQ4PI7cJdPmf1JytirxnEqx236
         ufYQ==
X-Gm-Message-State: APjAAAVb1czdhWx4pJuU9+hIChkiF0i9WpBjqXGpZgZNTG8iX0tpmKTI
        A1dRL850zuxIrkAIX50dwY3RuVWX
X-Google-Smtp-Source: APXvYqysbs6Ir7bje3ZMlQOnI4jPKLNtEXyTq/nz+zKMDsrETjDPlt+sxFEjJegticBVl1Tu5owQaQ==
X-Received: by 2002:a37:9c52:: with SMTP id f79mr4808088qke.371.1576701606291;
        Wed, 18 Dec 2019 12:40:06 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t7sm993347qkm.136.2019.12.18.12.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:40:05 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 03/24] arch/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 15:39:41 -0500
Message-Id: <20191218204002.30512-4-nivedita@alum.mit.edu>
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
 arch/alpha/kernel/setup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index 5d4c76a77a9f..f19aa577354b 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -655,8 +655,6 @@ setup_arch(char **cmdline_p)
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
 	conswitchp = &vga_con;
-#elif defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
 #endif
 #endif
 
-- 
2.24.1

