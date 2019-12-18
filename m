Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1181BC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF23D2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfLRVp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:45:28 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37201 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfLRVpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:45:25 -0500
Received: by mail-qt1-f193.google.com with SMTP id w47so3212140qtk.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dH6KnRsKCyeD6IBXbwILG8yB9gp5H5I7proIDgAuGXI=;
        b=qn7F06ur5Oy4G3ZyKp5Wk/4kdLHKmXO0S52VTo0I+vE5EbiIwqmEsl3ApLVMBz0V7b
         uuIuVcs9jukbB4t7Be5BYUYqGDXDFONO7lvAtGy03coiZSY36QWLZitW/8OoMOcucJJo
         9R6gmkB/Fp0j50wvXx5MpjPUwjZTzX2KSJQfxE4MyiO8dclw7q2umzSrL/szAIERR1CT
         4ceJhMG4r3iCIeglQEI8jIkDF2Z0O/0mxaEZDn3T39tNzh4w90z5Y2MXQM0oppLTfj1W
         ekGIxs1JuPJnBcQsxCrcpjMwE12TPqNJl7YZO092Iy4EbCPkzE7TCaNvtLviKQzYyau+
         gJfw==
X-Gm-Message-State: APjAAAWTcMSutUSLXsimYfuMeznYCcmGT28wirgSDv7IkXsXDwbcmsZt
        epRt7gFGnUp8J5L7KU+rzeo=
X-Google-Smtp-Source: APXvYqy/nnkyRnL6UjN0syVOpxjT2eFpPMB7ETXloZYYbQq/cRnbUbB3d/r9/YlMds47AX8Kh2DxLg==
X-Received: by 2002:ac8:1851:: with SMTP id n17mr4346100qtk.305.1576705524168;
        Wed, 18 Dec 2019 13:45:24 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u4sm1059851qkh.59.2019.12.18.13.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:45:23 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/24] arch/sh/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 16:45:02 -0500
Message-Id: <20191218214506.49252-21-nivedita@alum.mit.edu>
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
 arch/sh/kernel/setup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index d232cfa01877..67f5a3b44c2e 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -341,10 +341,6 @@ void __init setup_arch(char **cmdline_p)
 
 	paging_init();
 
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
-
 	/* Perform the machine specific initialisation */
 	if (likely(sh_mv.mv_setup))
 		sh_mv.mv_setup(cmdline_p);
-- 
2.24.1

