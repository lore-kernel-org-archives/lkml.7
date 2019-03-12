Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A68DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE2E2084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfCLLjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:39:02 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:49674 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726109AbfCLLjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:39:00 -0400
Received: from mr2.cc.vt.edu (inbound.smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x2CBcwsR015399
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:38:58 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x2CBcrLI013751
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:38:58 -0400
Received: by mail-qk1-f197.google.com with SMTP id 207so1877214qkf.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 04:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=5OYWCE9xZTuX2WyLOz5FdUK9NvW3I8Nvwy1v6dd558c=;
        b=De7DupMBdAC1uusLLeX+GUk8QGZbv5TJbA0BKiUVO7qkK/GEaIVhZnvyWxqxFMviuk
         tGNOhawJbNybKPzJ89FBCJH/OzotcgqoJYBzg20nOX8NW2YVHJQbeUvPGy057AIlAcNd
         S0m4JmYzd1ESTdEWg56uXq/qVsULcnpSiSQu6iRomsCiphK2Z15+wDX8HA8PlHXaHz7y
         LEBvhCBZHHxiBJsUZsy9wUIv4Oz5Gdk70rfmdBhpiCBB2ZB/0xIInlRFxAoLVN3dSe4P
         Yk9j9TT+mNisZABlvxAL3ehnMwyK6wJMngl3O9XHxGrSiYOtKYBEmIoas05J1XyVcYir
         hlpA==
X-Gm-Message-State: APjAAAXAg0H1dt0AMYV0CSgtRaW9jOZ9mwfWq7U6WwyiCORMbb+I/Qn/
        ClC+1EzvEuKsSBAME11BdA/nfcL+xa3l1aeMSwTZRpZVgTgvrCEB4VjzecCHP4yEkuMcuxz8wnd
        7okxi6IY/4yUPj4mgTuQCQjnMfl+Z+QXGZT0=
X-Received: by 2002:a37:4ec2:: with SMTP id c185mr28980076qkb.244.1552390733720;
        Tue, 12 Mar 2019 04:38:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzR/Qvk6KwyH8RZPtyffN3m+BdWilIzypaewQVnjlWREpwSLXJfOEO6POdqbkwSIKSItxkVWQ==
X-Received: by 2002:a37:4ec2:: with SMTP id c185mr28980060qkb.244.1552390733455;
        Tue, 12 Mar 2019 04:38:53 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::3b7])
        by smtp.gmail.com with ESMTPSA id u187sm4885331qkf.59.2019.03.12.04.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 04:38:52 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/ras/debugfs.c - add missing #includes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 12 Mar 2019 07:38:51 -0400
Message-ID: <19985.1552390731@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with C=2 W=1 reports:

  CHECK   drivers/ras/debugfs.c
drivers/ras/debugfs.c:3:15: warning: symbol 'ras_debugfs_dir' was not declared. Should it be static?
drivers/ras/debugfs.c:7:5: warning: symbol 'ras_userspace_consumers' was not declared. Should it be static?
drivers/ras/debugfs.c:37:12: warning: symbol 'ras_add_daemon_trace' was not declared. Should it be static?
drivers/ras/debugfs.c:53:13: warning: symbol 'ras_debugfs_init' was not declared. Should it be static?
  CC      drivers/ras/debugfs.o
drivers/ras/debugfs.c:7:5: warning: no previous prototype for 'ras_userspace_consumers' [-Wmissing-prototypes]
    7 | int ras_userspace_consumers(void)
      |     ^~~~~~~~~~~~~~~~~~~~~~~
drivers/ras/debugfs.c:37:12: warning: no previous prototype for 'ras_add_daemon_trace' [-Wmissing-prototypes]
   37 | int __init ras_add_daemon_trace(void)
      |            ^~~~~~~~~~~~~~~~~~~~
drivers/ras/debugfs.c:53:13: warning: no previous prototype for 'ras_debugfs_init' [-Wmissing-prototypes]
   53 | void __init ras_debugfs_init(void)
      |             ^~~~~~~~~~~~~~~~

And indeed, there's 2 missing #include's.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/drivers/ras/debugfs.c b/drivers/ras/debugfs.c
index 501603057dff..12a161377f4f 100644
--- a/drivers/ras/debugfs.c
+++ b/drivers/ras/debugfs.c
@@ -1,4 +1,6 @@
 #include <linux/debugfs.h>
+#include <linux/ras.h>
+#include "debugfs.h"
 
 struct dentry *ras_debugfs_dir;
 

