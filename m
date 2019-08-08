Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A95C32751
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 00:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B5C2186A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 00:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389478AbfHHAif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 20:38:35 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:44176 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388448AbfHHAif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 20:38:35 -0400
Received: from mr5.cc.vt.edu (inbound.smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x780cXba014338
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 20:38:33 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x780cS4i024145
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 20:38:33 -0400
Received: by mail-qk1-f199.google.com with SMTP id p18so7306437qke.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 17:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=r5sfz4FpB5bgkq8l1haG7EShsrRXIQMrf/imnxO7Dlw=;
        b=BGk6OyzUKtZfBHeUZpttX2+J6NBDWBaV+xU0naHzRZ0P2z0thDx4+ob8KaQ7+7eemo
         mP25MVTHWktkd6ZUH+X5GlPC+vXcyPcX1cd84fEp7Jw+ATbyGW9IwGcFKJijq+efm2oV
         mLFjxjih+3lDIderGCwfiohiFaCE9zcVoxp+CpzR2CK0E0gKx3t/+Rfq3fxO3SnNhmMh
         jfzTTWBiKFij2ADO3kDWFRvReVTkYn+H1OcQI43nvgu/JOQ/mRrWB6eZYfm+TFX2kZr9
         pzEq1lwSPg31uAKgawh+4m2hZvdNRVBTFL1TejTLYi+IiTw12qF4BkBr0PeNgo8Tp2Hh
         9CiA==
X-Gm-Message-State: APjAAAUt9OCKYhY+W/SXh+WRz0UEYm9BCTzesq6fQQwKPbX5HrlBMrGd
        r/aVgZuclw34mWFxiBzxnAe98jqshaQC2ba3IAoLbV6JFLXJ8P2DPg/N8O+ZL4SLAisoFZwRx0d
        lY2Kkv4uGRXL/R53beYvEDb1/x3lmzoG5gLI=
X-Received: by 2002:a37:660c:: with SMTP id a12mr10922766qkc.52.1565224708216;
        Wed, 07 Aug 2019 17:38:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzg2ix5q8gsw/CsbrZ3OPejuc/vS3T6Vn9j/lr8XfkTGx3pLSh2/FrrX+xS2DjQlyTCMWVpaA==
X-Received: by 2002:a37:660c:: with SMTP id a12mr10922752qkc.52.1565224707922;
        Wed, 07 Aug 2019 17:38:27 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id x42sm47218992qth.24.2019.08.07.17.38.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 17:38:26 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Include proper prototypes for kernel/elfcore.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 07 Aug 2019 20:38:25 -0400
Message-ID: <29875.1565224705@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1, gcc properly complains that there's no prototypes:

  CC      kernel/elfcore.o
kernel/elfcore.c:7:17: warning: no previous prototype for 'elf_core_extra_phdrs' [-Wmissing-prototypes]
    7 | Elf_Half __weak elf_core_extra_phdrs(void)
      |                 ^~~~~~~~~~~~~~~~~~~~
kernel/elfcore.c:12:12: warning: no previous prototype for 'elf_core_write_extra_phdrs' [-Wmissing-prototypes]
   12 | int __weak elf_core_write_extra_phdrs(struct coredump_params *cprm, loff_t offset)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/elfcore.c:17:12: warning: no previous prototype for 'elf_core_write_extra_data' [-Wmissing-prototypes]
   17 | int __weak elf_core_write_extra_data(struct coredump_params *cprm)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~
kernel/elfcore.c:22:15: warning: no previous prototype for 'elf_core_extra_data_size' [-Wmissing-prototypes]
   22 | size_t __weak elf_core_extra_data_size(void)
      |               ^~~~~~~~~~~~~~~~~~~~~~~~

Provide the include file so gcc is happy, and we don't have potential code drift

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/kernel/elfcore.c b/kernel/elfcore.c
index fc482c8e0bd8..57fb4dcff434 100644
--- a/kernel/elfcore.c
+++ b/kernel/elfcore.c
@@ -3,6 +3,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/binfmts.h>
+#include <linux/elfcore.h>
 
 Elf_Half __weak elf_core_extra_phdrs(void)
 {

