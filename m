Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8CEC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF7F2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ghlYQWDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403958AbfHHPug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 11:50:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35633 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbfHHPug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 11:50:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x78FoDj93231487
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 08:50:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x78FoDj93231487
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565279413;
        bh=2EhV3UUchDNp7G9rPc3u23hbunHjf9oyCF/tDuNK5QQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ghlYQWDidQ5C9HX1EyGcxqpOPAg2moJuNNm3vuCj7bBYDmwQW4kIKu2UlOBklX9WV
         a35vl+I/o7SOvnHVHDxpAmfZe9X1kuTZhY11ND63usEf+qi1Hz5xEjNIqoo2RE7sU8
         DBeBciCgFRaZg0DoHH4K6vSvwavOlQ/7BNcIhbkWbkA0+LICqimtNLmDIa/mgirrQn
         K1mcevIixzDnKyf5RMYqgWgAwBd4A8UcXlhQn/kUqU5HihOYMmLhBZ14hHfEoKWlZd
         JWfO3gZtGXhci1X+q5HV48xxlSzcpZS0gvCd3ibUZVw31nbQYaZN6a1ReVllz2uIw+
         0ZFkiCqSiCjog==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x78FoCPI3231480;
        Thu, 8 Aug 2019 08:50:12 -0700
Date:   Thu, 8 Aug 2019 08:50:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valdis Kletnieks <tipbot@zytor.com>
Message-ID: <tip-b6ff24f7b5101101ff897dfdde3f37924e676bc2@git.kernel.org>
Cc:     mingo@kernel.org, valdis.kletnieks@vt.edu, tglx@linutronix.de,
        tony.luck@intel.com, linux-kernel@vger.kernel.org, bp@suse.de,
        hpa@zytor.com, lkp@intel.com
Reply-To: hpa@zytor.com, lkp@intel.com, bp@suse.de,
          linux-kernel@vger.kernel.org, tony.luck@intel.com,
          tglx@linutronix.de, valdis.kletnieks@vt.edu, mingo@kernel.org
In-Reply-To: <7053.1565218556@turing-police>
References: <7053.1565218556@turing-police>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] RAS: Build debugfs.o only when enabled in Kconfig
Git-Commit-ID: b6ff24f7b5101101ff897dfdde3f37924e676bc2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b6ff24f7b5101101ff897dfdde3f37924e676bc2
Gitweb:     https://git.kernel.org/tip/b6ff24f7b5101101ff897dfdde3f37924e676bc2
Author:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
AuthorDate: Thu, 8 Aug 2019 16:32:27 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 8 Aug 2019 17:44:02 +0200

RAS: Build debugfs.o only when enabled in Kconfig

In addition, the 0day bot reported this build error:

  >> drivers/ras/debugfs.c:10:5: error: redefinition of 'ras_userspace_consumers'
      int ras_userspace_consumers(void)
          ^~~~~~~~~~~~~~~~~~~~~~~
     In file included from drivers/ras/debugfs.c:3:0:
     include/linux/ras.h:14:19: note: previous definition of 'ras_userspace_consumers' was here
      static inline int ras_userspace_consumers(void) { return 0; }
                      ^~~~~~~~~~~~~~~~~~~~~~~

for a riscv-specific .config where CONFIG_DEBUG_FS is not set. Fix all
that by making debugfs.o depend on that define.

 [ bp: Rewrite commit message. ]

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac@vger.kernel.org
Cc: x86@kernel.org
Link: http://lkml.kernel.org/r/7053.1565218556@turing-police
---
 drivers/ras/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
index ef6777e14d3d..6f0404f50107 100644
--- a/drivers/ras/Makefile
+++ b/drivers/ras/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_RAS)	+= ras.o debugfs.o
+obj-$(CONFIG_RAS)	+= ras.o
+obj-$(CONFIG_DEBUG_FS)	+= debugfs.o
 obj-$(CONFIG_RAS_CEC)	+= cec.o
