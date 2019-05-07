Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCBFC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 04:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB5420825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 04:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vhyvoPUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfEGEcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 00:32:10 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:39152 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfEGEcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 00:32:09 -0400
Received: by mail-pg1-f177.google.com with SMTP id w22so6291021pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 21:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fTkRPA9++VTze/Qkc23Bad5O9y5tDIP8aePsT2m72rc=;
        b=vhyvoPUwVOx1+2D7FzwRDR2Yhg8H16VC2BjFCzlZNAuiKBs+tl0iU1TdXk4V5Upb+O
         /90zmSKQRzBp2pKXil5DZFfD55yrrbiMWytaWD6SxhfJIvtWhZ6Q1371BvHtKYVXk0k5
         If26W5HP5Jhh/4rML9WIlf3JrLnuO4MQzV0Q/7gXSWNwnfgTjTH3IDsdfXg1Qia1dW96
         i1A4RdkzQocA/prkev4fyvqukzMe9WI7bpqQ6KLnVHmYqpCyBBkX3hrFBll8wzIcXgVm
         tktU9Et90UwP6Lxzj2RdTxhxJpfjlVx+FHTPAgpaUqRMQazhFKJZsMB1nUak8xNDiqiB
         A5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fTkRPA9++VTze/Qkc23Bad5O9y5tDIP8aePsT2m72rc=;
        b=jAY7Vqy/w5XwVe+i//ZEj/XbNuafpBbr1FqtDU0MHb+8oEMO0ivLE58e8Ohnw/a1kq
         YD1qKLzTcLXcRkmood9g0D0vZ09bu32jO4IFadHYaXjlWgrklitlEFtZdXLBQXF6eHFn
         zA2powsPjyJ0dq68r8yve5QvQRQZNvM73xPnd5xdOsk69JbYHKpJBFms4NGXh1tZx1Oh
         OAUun2zKg279WeF22SjxUZZFU2Z1ei3o/B0atWPk5jgFAdj/QflYYO727fIQBpGqwN8v
         eR0eikdcQNdNM8GxH2DmK9bhvjFYKEB6WmGda2Jb6UwRTjwr6bLSAXlZghEbr04sH6VH
         5sSA==
X-Gm-Message-State: APjAAAV2iV/PbX3TDE3ns/5keFNmpPMz40FKO9WCDU/81ZKvKxS/pQAQ
        fm9s4CUSqCPwOi00mR/Hmg==
X-Google-Smtp-Source: APXvYqxikycf8/iba9LTgTYN8hnQbkhkJc3yr8zc1FaLdrAfc0ab2b/Rw9OPWrRLLFxJtiOXQXuiLg==
X-Received: by 2002:a62:4351:: with SMTP id q78mr37851562pfa.86.1557203528974;
        Mon, 06 May 2019 21:32:08 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 25sm14108762pfo.145.2019.05.06.21.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 21:32:07 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCHv5 0/2]  x86/boot/KASLR: skip the specified crashkernel region
Date:   Tue,  7 May 2019 12:31:32 +0800
Message-Id: <1557203494-7939-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crashkernel=x@y or or =range1:size1[,range2:size2,...]@offset option may
fail to reserve the required memory region if KASLR puts kernel into the
region. To avoid this uncertainty, asking KASLR to skip the required
region.
And the parsing routine can be re-used at this early boot stage.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org
---
v3 -> v4:
  reuse the parse_crashkernel_xx routines
v4 -> v5:
  drop unnecessary initialization of crash_base in [2/2]

Pingfan Liu (2):
  kernel/crash_core: separate the parsing routines to
    lib/parse_crashkernel.c
  x86/boot/KASLR: skip the specified crashkernel region

 arch/x86/boot/compressed/kaslr.c |  40 ++++++
 kernel/crash_core.c              | 273 ------------------------------------
 lib/Makefile                     |   2 +
 lib/parse_crashkernel.c          | 289 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 331 insertions(+), 273 deletions(-)
 create mode 100644 lib/parse_crashkernel.c

-- 
2.7.4

