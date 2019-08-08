Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07517C32751
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DC42186A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbfHHD1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 23:27:25 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:43466 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728019AbfHHD1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 23:27:25 -0400
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x783ROYl018688
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 23:27:24 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x783RJSA018057
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 23:27:24 -0400
Received: by mail-qt1-f198.google.com with SMTP id e22so18582279qtp.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 20:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=fvOWh+rvGS6miPZm2H4Gkscxc7S2xIkpR9di9jTjOek=;
        b=Ey4htkJjfbYcylhOJRru4j4zBEPU+cCHYhLLMB+OtUHPEXYdnlrwh8HryuoxO3dPhv
         vtcRhhWTgICjYbYG8ttS/xdtExgL/od+L5mBqBl1Nhj7xVPFILZLlDVvzesnX58E/mb5
         SVKTKkFWAZ/UOlqDXCFyiPVscsAdMr6pnYX6vMdSkzpU3d98z5ZqIryn3rllvJ/pZTEu
         ktBIhgjUVel3PTjqwgwblRG9BZ63IfTyLvz9sZnb8KPQnUWfTOoPyid/cmlECkyhcJBh
         EhJh2galD3fIdZT4M2nqc47W7sa94BPLF0zB0I/6ARuS6erdQjzEkWZoWVjzMJq/sVWn
         iM1g==
X-Gm-Message-State: APjAAAXwAeRB79rKel/KGYvwlmWQgX5yNo5njrfkOsgsE3Z4dNvcpBf1
        g18DxpGl4bNWQX6TGGoeGsJBMWeF5nZnMlNflUDXpSog50MhCJgRnUw/2AFR7lLA5mWvdxtw19X
        dlmIjG5UMZS4RHmzNSeIq2hffQKmGfeAWQ7s=
X-Received: by 2002:a37:4b46:: with SMTP id y67mr11481080qka.66.1565234839103;
        Wed, 07 Aug 2019 20:27:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwxO6eB8a8V2/ak1Xv1mZup9wPcMMw34fGfAbJAfdYw9OPqDnMQj8B2JciMQB34nv+EhlZlrw==
X-Received: by 2002:a37:4b46:: with SMTP id y67mr11481069qka.66.1565234838802;
        Wed, 07 Aug 2019 20:27:18 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id o33sm45594199qtd.72.2019.08.07.20.27.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 20:27:17 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH] arch/x86/lib/cpu-c - missing prototypes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 07 Aug 2019 23:27:17 -0400
Message-ID: <42513.1565234837@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1, we get warnings about missing prototypes:

  CC      arch/x86/lib/cpu.o
arch/x86/lib/cpu.c:5:14: warning: no previous prototype for 'x86_family' [-Wmissing-prototypes]
    5 | unsigned int x86_family(unsigned int sig)
      |              ^~~~~~~~~~
arch/x86/lib/cpu.c:18:14: warning: no previous prototype for 'x86_model' [-Wmissing-prototypes]
   18 | unsigned int x86_model(unsigned int sig)
      |              ^~~~~~~~~
arch/x86/lib/cpu.c:33:14: warning: no previous prototype for 'x86_stepping' [-Wmissing-prototypes]
   33 | unsigned int x86_stepping(unsigned int sig)
      |              ^~~~~~~~~~~~

Add the proper include file so the prototypes are there.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/arch/x86/lib/cpu.c b/arch/x86/lib/cpu.c
index 04967cdce5d1..7ad68917a51e 100644
--- a/arch/x86/lib/cpu.c
+++ b/arch/x86/lib/cpu.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/types.h>
 #include <linux/export.h>
+#include <asm/cpu.h>
 
 unsigned int x86_family(unsigned int sig)
 {

