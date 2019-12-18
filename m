Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0152C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFDA2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfLRVph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:45:37 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:35941 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfLRVp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:45:28 -0500
Received: by mail-qv1-f67.google.com with SMTP id m14so1386314qvl.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=waxKuIHxOhP/uUMeh5H5HFDUl/+Vy4TJ7vfzF1KKkIs=;
        b=FqITdHWqbt8Jzd4SOo18Ld/0rdAdWVZZpcteZrXWGZ98xgASSnflpXB/ZOo6J1MJGN
         x+jPloYVP9fHUBEegKQ7LLhlXzVhM+b2CJRe7xb4yZtIQr9mzzWwDseeW9fG1a7HtMzt
         Hm0xCcu2aRgKMzj/cAU0F8bvFzwPLcyHPU3CSnh0AwJF1s1GqPGJtPLGfeWLgi/H6k/u
         G6jIO7XiijfiBg31HqCzbK1NHsF/ykc8/KcVW4mdm0/hND6pwzuELFlU8rVt2L5qUt9P
         p4WmfrezhGer0fGyKEe1PT6d836HeicX4exQLQxQGeW5U0cl1zoeCixePX4K1urEiw04
         6ngw==
X-Gm-Message-State: APjAAAXRdNtoV0S0NP9jDtlpWdQPU27ahKf8vKQsvdshIV17QET4tD8a
        45smhdRQaGjClVrbbrLxqvk=
X-Google-Smtp-Source: APXvYqzMxa8kH4PYCcP5so3uciAKTWjxwAyedl2+Ynob8BNenAiWlSexCNe2nB2KKGn1fK6S2cnOhw==
X-Received: by 2002:a0c:e8c7:: with SMTP id m7mr4602352qvo.128.1576705527382;
        Wed, 18 Dec 2019 13:45:27 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u4sm1059851qkh.59.2019.12.18.13.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:45:26 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/24] arch/xtensa/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 16:45:06 -0500
Message-Id: <20191218214506.49252-25-nivedita@alum.mit.edu>
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
 arch/xtensa/kernel/setup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index 0f93b67c7a5a..adead45debe8 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -405,8 +405,6 @@ void __init setup_arch(char **cmdline_p)
 #ifdef CONFIG_VT
 # if defined(CONFIG_VGA_CONSOLE)
 	conswitchp = &vga_con;
-# elif defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
 # endif
 #endif
 }
-- 
2.24.1

