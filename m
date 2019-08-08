Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD13C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AD7217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390221AbfHHSTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 14:19:07 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:52256 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731038AbfHHSTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:19:04 -0400
Received: from mr2.cc.vt.edu (mr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x78IJ30D025399
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 14:19:03 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x78IIwmq028748
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 14:19:03 -0400
Received: by mail-qt1-f197.google.com with SMTP id j10so4136530qtl.23
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 11:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=BKPbzs/c+/DyQBCxHuXukcW7gypCNR/lx2Nn+xY4yL8=;
        b=J25JnZb2MspKyuSC4TfsQf0bnD7US0EYBk+d00r/N8LV5X64ru6SStkU7GQq8PFzcs
         uUGsUVZyrXTymuSCIyaUi95xwQITXke8nQLbRxPV1VksClIcQfolBhiIp7b0HPLlxMzH
         6N0NE5LhPpzFu7kBSSdl96cALLW2oVAsBJv1/Pia6yV+T2pi3GZDr0/ohdVQa8d9xWh6
         giPUGHg/kfKYSETt4hFkl6J96PB9KYAHK3sl41hnKCT6GzEWuAUeOTg3LUt3v7DDnNFL
         NPyLni3IHLpmLyb3V8sY7PSSyybWyBo1w0Rky5xqvELlaDXoe+9lwcgR04nTVForJAkl
         bEWQ==
X-Gm-Message-State: APjAAAVQHpmbKHisGOdjQ0hXekWgrSwWBe4Rl8LcTrlvKQy2H78WqVsG
        bEelD+6xYmYevvXpwpoGalJYAAISDY/tVDkuMSvxuA1nGNH4mvJnjtZ2OGqQwtrpB7bH+Ani8DX
        IYe7nC0rXiRHxh5geJpAn9rQQRl3bs+A7sYM=
X-Received: by 2002:ac8:4117:: with SMTP id q23mr5687989qtl.305.1565288337932;
        Thu, 08 Aug 2019 11:18:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyyvRNY7cu8Qm3FAbdy+PiYVLMMtHKLtwbXgE9JDuk2/NJtSyx0DIcScHnxk8317Hz/bAT/zw==
X-Received: by 2002:ac8:4117:: with SMTP id q23mr5687975qtl.305.1565288337656;
        Thu, 08 Aug 2019 11:18:57 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id j78sm42577980qke.102.2019.08.08.11.18.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 11:18:56 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH] arch/x86/kernel/cpu/common.c - add proper prototypes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Thu, 08 Aug 2019 14:18:55 -0400
Message-ID: <131213.1565288335@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building withW=1, we get a warning..

  CC      arch/x86/kernel/cpu/common.o
arch/x86/kernel/cpu/common.c:1952:6: warning: no previous prototype for 'arch_smt_update' [-Wmissing-prototypes]
 1952 | void arch_smt_update(void)
      |      ^~~~~~~~~~~~~~~

Provide the proper #include so the prototype is found.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index e0489d2860d3..b8ed6d8e55df 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -14,6 +14,7 @@
 #include <linux/sched/mm.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/task.h>
+#include <linux/sched/smt.h>
 #include <linux/init.h>
 #include <linux/kprobes.h>
 #include <linux/kgdb.h>

