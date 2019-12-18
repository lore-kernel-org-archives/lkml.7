Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90035C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690952176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfLRVp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:45:29 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:44677 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfLRVp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:45:27 -0500
Received: by mail-qv1-f65.google.com with SMTP id n8so1367305qvg.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j5XzsPTW77IQ+wYXeiRlE/nsYq/nq9N3u2AC5HLtW6I=;
        b=r0jZxaeq7sHzmfSvKlcFV4GCFLRkYLEusFGAH9WOq0hLjvcYyjZCJ7RbT+VpcwBYX+
         795k4qYM8NWStisJNFlkIWI59Pnw9WlmZd/66a2yKTjJUAsv8kz9PQTSUkEAwAHgNLb/
         BZM/nG+NcrXC0rFB7PDEj2nlbumYy7wFh2g2YOpfIh9rsNk2buvOlrxmCzhQQO06NESr
         lA2RR1jAsISkOe9MXCt356Cl/47dU4vuj4rYjLuTDo9MMj6PHoUMBQKCDvbLzbAeC835
         waWEVW8hYSOwtcJyp9vp0uvC8TwiDefdehTUFAMBAWTuQ9s7NkFYExAgkw/JwLC9F7aw
         cbCw==
X-Gm-Message-State: APjAAAUGDRstxRBGrESYSMzQLJz6DtgUqURXi220gndTpGLoJ2sruQou
        yGe3SbN+68TuSXdBynVCCF8=
X-Google-Smtp-Source: APXvYqzkVTGyoE716kc1fyg48V/n4Sy5sWV0M+UuWso6TGHU0zgcThkCQD3wX1ub7wPTAyi0AqZ7ag==
X-Received: by 2002:a0c:e1ce:: with SMTP id v14mr4449541qvl.39.1576705526581;
        Wed, 18 Dec 2019 13:45:26 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u4sm1059851qkh.59.2019.12.18.13.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:45:25 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/24] arch/x86/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 16:45:05 -0500
Message-Id: <20191218214506.49252-24-nivedita@alum.mit.edu>
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
 arch/x86/kernel/setup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index cedfe2077a69..8ad29fa05d00 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1295,8 +1295,6 @@ void __init setup_arch(char **cmdline_p)
 #if defined(CONFIG_VGA_CONSOLE)
 	if (!efi_enabled(EFI_BOOT) || (efi_mem_type(0xa0000) != EFI_CONVENTIONAL_MEMORY))
 		conswitchp = &vga_con;
-#elif defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
 #endif
 #endif
 	x86_init.oem.banner();
-- 
2.24.1

