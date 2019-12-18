Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FB7C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD3C218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfLRUkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:40:19 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33185 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbfLRUkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:40:16 -0500
Received: by mail-qt1-f194.google.com with SMTP id d5so3076490qto.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:40:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dfoBv1/fajBVFYCXkRzHX94CB9r4wEDcgyCOURmAgAg=;
        b=WHejrjxfViaqebV5rN8PKIiiDO7bLaHBqNTragW0n3W59eAYfvYkYrTzYP6eXdOYNq
         SnQCnhbXitys10V5j7bzgabdN/qoAIm82ULjo0/M+87D/veCBcPavAbmM2TP6sA9r9FM
         51ooZudxOChyWtrwipCXtCpCKnc+wWDH5iWnP2F/ptKaVD5YhyQTp9W0VRbI8pLxM90L
         pGLEMGQsKp/yS6Op1yLWLZrVn54hguGL7hK+jVox63PhVNII1z8e+ZkBPiyXxPkUkFe5
         ThqUB7OGkLxIvLDdmLzi5GMFn4inTOdfzoICQWAhpqnhgwr3DDYDsLeGx17744e0LNx6
         M+HQ==
X-Gm-Message-State: APjAAAU4bZ6lKTZohLQyVbwGJyIUvdAKwJKq6VLvMalKEsXS4IU8tU5s
        /ZEkbiC4jKLMhlMJIPTj4+4=
X-Google-Smtp-Source: APXvYqxuZbfbwpw8Bjq2lKNGawk2MTB2qkCeQDRvwZF8A4N7oER64iftTfa/KEGvsbRG9PazQVtngw==
X-Received: by 2002:ac8:148d:: with SMTP id l13mr3989620qtj.173.1576701615849;
        Wed, 18 Dec 2019 12:40:15 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t7sm993347qkm.136.2019.12.18.12.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:40:15 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 15/24] arch/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 15:39:53 -0500
Message-Id: <20191218204002.30512-16-nivedita@alum.mit.edu>
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
 arch/openrisc/kernel/setup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index d668f5be3a99..c0a774b51e45 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -308,11 +308,6 @@ void __init setup_arch(char **cmdline_p)
 	/* paging_init() sets up the MMU and marks all pages as reserved */
 	paging_init();
 
-#if defined(CONFIG_VT) && defined(CONFIG_DUMMY_CONSOLE)
-	if (!conswitchp)
-		conswitchp = &dummy_con;
-#endif
-
 	*cmdline_p = boot_command_line;
 
 	printk(KERN_INFO "OpenRISC Linux -- http://openrisc.io\n");
-- 
2.24.1

