Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556D0C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CC9227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfLRUkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:40:13 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44802 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbfLRUkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:40:11 -0500
Received: by mail-qt1-f194.google.com with SMTP id t3so3024728qtr.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:40:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XK7YmmLGQlfcgUyNbnddM2ijtu/hYGP9ckYtCpSRDMs=;
        b=Cf2duRLZo4oZ2YXZEIAl3TJ1gfX96YFQKDrMZ5R9x1LyIKLbrW88TuE/VXD4eAuTey
         9GiPqibk4edTik3v0gJvRKzbMCy+lfS0R7Oc2xmf2W+K4In+/3SeqJcSLJZhGM0nc1CY
         SJpyfAxeA/1t23NigocM48tfvFIC37MM3UwlrJ+iYpj6GZ/ylvuY4HNxr5GuN5sNWMe1
         i6Y9NzbDuD6ANDsClsGUBzcLCsbOUMSN024lV0plOJe7efbkqDw6dA40fY7ZaT4hZNhq
         Ojf7uu8hwKLpSbp8s/B8EhM23Wq22GE5+vjLNMtSpK+yv9BfshhTK6FT3fYr2JGBB/bT
         AhvA==
X-Gm-Message-State: APjAAAWaCCccJn3J/KHVusFogoBkAUiqFZBykjkZ6eunaKsp1E3hSHIV
        SP11v7g9tpy6iV7wOkLlKkk=
X-Google-Smtp-Source: APXvYqzXuoKoARd9cnp/4qN6JVBS2BvMxP2ipRdT7U3Cv+cOQ5G2aYs68i4ArZoByueJsgKANwRfbw==
X-Received: by 2002:aed:2047:: with SMTP id 65mr4000493qta.78.1576701610807;
        Wed, 18 Dec 2019 12:40:10 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t7sm993347qkm.136.2019.12.18.12.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:40:10 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 08/24] arch/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 15:39:46 -0500
Message-Id: <20191218204002.30512-9-nivedita@alum.mit.edu>
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
 arch/csky/kernel/setup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
index 23ee604aafdb..52eaf31ba27f 100644
--- a/arch/csky/kernel/setup.c
+++ b/arch/csky/kernel/setup.c
@@ -136,10 +136,6 @@ void __init setup_arch(char **cmdline_p)
 #ifdef CONFIG_HIGHMEM
 	kmap_init();
 #endif
-
-#if defined(CONFIG_VT) && defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
-#endif
 }
 
 unsigned long va_pa_offset;
-- 
2.24.1

