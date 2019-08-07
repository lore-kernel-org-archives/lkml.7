Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673FAC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471E72186A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbfHGW7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:59:39 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:59242 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729938AbfHGW7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 18:59:38 -0400
Received: from mr1.cc.vt.edu (mr1.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:31:1732:8aa4])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x77MxbdF029678
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 18:59:37 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x77MxWS5023922
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 18:59:37 -0400
Received: by mail-qk1-f197.google.com with SMTP id s25so80435975qkj.18
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 15:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=4WYp0sFtiquOnD7XFesrru7HLnSgpz+A8nRbXA9HLg4=;
        b=g9BADXek+jiNiChzWzeuhQaI5Ad4Uu1CdS6cBLP5955A4GBEA2tyLG3WQnyAOdzGmH
         tK2Otsb+X3Wo2qCMCADuHs7Io3ZQPIti2olMYehMQIKi9K1sq/9tM/ENbGDZ/M2i02E+
         H1oYrzCNmx+/c+tWJWwwhE7D4HDZ5SA49WhToxfvHzZmbjkwymR1j+gjax/4JAY7RUQJ
         rPId5JEiWOHypAbHPE61nFaWmeKrHWVNl9WrjKM7kVmen2/3Cfxo4JiKyDnYdvsi5Kqc
         PXLztS/xFgxlMSLs+OjgCFDAOoMdQKqcalED9bzLcrbyzGMuOveFssBLPF61gMtITxVI
         mbcA==
X-Gm-Message-State: APjAAAVZekNXI7JxvJvmNCFIWqHPw+cVFBKAwqgNdX0BSitlP9Nwwzvg
        R271xHhpPTsgwVeOB1ZwjbLtH5+sScBd4Mog/UJRI07ajGo1Ajv1b6Ii3caL/k0qGaiPEAM3umY
        mMbTaRJUo16mvocC15T7Jveq4sLmZ312pfeQ=
X-Received: by 2002:a05:6214:10ea:: with SMTP id q10mr10566673qvt.4.1565218771720;
        Wed, 07 Aug 2019 15:59:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw7F2Hr9hT2NBDVe2YHVe7q0mBNo/npy18I5/nmkItyMv2lMne1h0RZ53W+4zzzlkquIcAqwg==
X-Received: by 2002:a05:6214:10ea:: with SMTP id q10mr10566668qvt.4.1565218771488;
        Wed, 07 Aug 2019 15:59:31 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id h4sm39655853qkk.39.2019.08.07.15.59.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 15:59:30 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drivers/ras/debugfs.c - fix prototype warnings
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 07 Aug 2019 18:59:29 -0400
Message-ID: <7168.1565218769@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with C=2 and/or W=1, legitimate warnings are issued
about missing prototypes.  Provide the proper includes.

  CHECK   drivers/ras/debugfs.c
drivers/ras/debugfs.c:4:15: warning: symbol 'ras_debugfs_dir' was not declared. Should it be static?
drivers/ras/debugfs.c:8:5: warning: symbol 'ras_userspace_consumers' was not declared. Should it be static?
drivers/ras/debugfs.c:38:12: warning: symbol 'ras_add_daemon_trace' was not declared. Should it be static?
drivers/ras/debugfs.c:54:13: warning: symbol 'ras_debugfs_init' was not declared. Should it be static?
  CC      drivers/ras/debugfs.o
drivers/ras/debugfs.c:8:5: warning: no previous prototype for 'ras_userspace_consumers' [-Wmissing-prototypes]
    8 | int ras_userspace_consumers(void)
      |     ^~~~~~~~~~~~~~~~~~~~~~~
drivers/ras/debugfs.c:38:12: warning: no previous prototype for 'ras_add_daemon_trace' [-Wmissing-prototypes]
   38 | int __init ras_add_daemon_trace(void)
      |            ^~~~~~~~~~~~~~~~~~~~
drivers/ras/debugfs.c:54:13: warning: no previous prototype for 'ras_debugfs_init' [-Wmissing-prototypes]
   54 | void __init ras_debugfs_init(void)
      |             ^~~~~~~~~~~~~~~~

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/drivers/ras/debugfs.c b/drivers/ras/debugfs.c
index 9c1b717efad8..0d4f985afbf3 100644
--- a/drivers/ras/debugfs.c
+++ b/drivers/ras/debugfs.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/debugfs.h>
+#include <linux/ras.h>
+#include "debugfs.h"
 
 struct dentry *ras_debugfs_dir;
 



