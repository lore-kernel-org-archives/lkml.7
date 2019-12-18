Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CD8C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA7624650
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfLRVqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:46:10 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38782 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfLRVpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:45:18 -0500
Received: by mail-qk1-f196.google.com with SMTP id k6so2907885qki.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:45:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=32kCKTpHM98pefAWSVvrpnmAq3+xPjRFiMRfvmIlrcU=;
        b=mVrO3Bcue5O4e+bliHh3LvLq4eZL/U1LXm8so8z6/Svz/zd6BWSDUExuotcqCtii2n
         AmrcyXk1UrQh8nc+9IgS/oNo6vPVCX7iKFrwsvQNBg0PfsRXwOKQkvJcAtrLf7cQBDmX
         Dm4H2daGICHBb58KyNv+H1nMeBiMcW6XFShgHB6rPvQzxbQtN2OzuToYYXgftYkZP+DA
         aOmtX0eN1DHweu7xokw7r5TPiwjYr1zgl2xy9yucRTzWq3jQx/+eUZXWAv/ccqoJVAng
         C46eEqlXj4PIDjCZA6Uacs+hIrcmgTFOq0mElg408RaMzqaBLIADhLmukIbH3k2o33FJ
         4eXQ==
X-Gm-Message-State: APjAAAUihonYSGswehU+LwsS8WwQ37AdYZ2HXZ7zFPJHaPOtQ+wTJcI1
        M3TY/7N4bqk+AMBxJn0lTl4=
X-Google-Smtp-Source: APXvYqydDbOFRzc4Ofkz2l3WBDOiGM+JOW1n98/H3eVXI4EGGKHQBTjMuwb0wNrHzbMIPuFZ7Nl0oA==
X-Received: by 2002:ae9:e704:: with SMTP id m4mr4862426qka.153.1576705517546;
        Wed, 18 Dec 2019 13:45:17 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u4sm1059851qkh.59.2019.12.18.13.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:45:16 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/24] arch/mips/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 16:44:54 -0500
Message-Id: <20191218214506.49252-13-nivedita@alum.mit.edu>
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
 arch/mips/kernel/setup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index c3d4212b5f1d..a28057946ed1 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -796,8 +796,6 @@ void __init setup_arch(char **cmdline_p)
 #if defined(CONFIG_VT)
 #if defined(CONFIG_VGA_CONSOLE)
 	conswitchp = &vga_con;
-#elif defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
 #endif
 #endif
 
-- 
2.24.1

