Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45F4C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDC4227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfLRUkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:40:31 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36677 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbfLRUkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:40:22 -0500
Received: by mail-qk1-f193.google.com with SMTP id a203so3110506qkc.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:40:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wa3xpCF0PYCQcq/3TSDnS3wckgcLrmnEjegMcusCHSQ=;
        b=t0pyOC6p+aVu+JBn6dKy6zQgRb/oYmXp6Vkn9WR1R8QhFB+VgZiah1sxP7JxhvVAZ/
         9Xlhn6pKQqg8nmWUMBoO7KknvBbYT4ef7D0KGKPIlN1Hm5MZZbngPqqIwyn1+iawVDru
         G2JT2bWeiDY+GzGqjaVGxZkimh5DBFuUzYYlDpn6r1Y1Yzjlywd4w7w+AiN4eRYSoesO
         EqY+i5AV1o7PRcuc64/b4DqnNe8cJc1ffN2gO71Bblz9gagqEYxg36WwR8dXjeP2oK/6
         7y4vPSXgGENlyfmsSMPP/l2c+U//Hc/chun71MsQ+pPI6LmEAgD5Tj1W8Rwb4w59znx4
         JI/Q==
X-Gm-Message-State: APjAAAUQ0RCY1XFGEdWfTd8vV/zAsgnRnSgMsI/TflP2A3qjijBAofkv
        Gi/mtRHSAv4r3NsoVhwZDSk=
X-Google-Smtp-Source: APXvYqw2PMMVhqgbX+zRDdRPX1lpuMpZT3iFYLi2WICcbDrAVPYdYCAO+MaUCBxbuOMywILA2M1gdQ==
X-Received: by 2002:a37:8085:: with SMTP id b127mr4555863qkd.424.1576701621400;
        Wed, 18 Dec 2019 12:40:21 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t7sm993347qkm.136.2019.12.18.12.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:40:20 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 22/24] arch/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 15:40:00 -0500
Message-Id: <20191218204002.30512-23-nivedita@alum.mit.edu>
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
 arch/unicore32/kernel/setup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/unicore32/kernel/setup.c b/arch/unicore32/kernel/setup.c
index 95ae3b54df68..0c4242a5ee1d 100644
--- a/arch/unicore32/kernel/setup.c
+++ b/arch/unicore32/kernel/setup.c
@@ -270,8 +270,6 @@ void __init setup_arch(char **cmdline_p)
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
 	conswitchp = &vga_con;
-#elif defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
 #endif
 #endif
 	early_trap_init();
-- 
2.24.1

