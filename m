Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A22C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 02:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A55F2075C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 02:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfLFCgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 21:36:17 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:44772 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726109AbfLFCgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 21:36:16 -0500
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xB62aFZY013989
        for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2019 21:36:15 -0500
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xB62aAZx015423
        for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2019 21:36:15 -0500
Received: by mail-qk1-f200.google.com with SMTP id b9so3554608qkl.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 18:36:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=VNaCZVoj7p19TxD+DmPLrQHC5SpZdHhWhKjaLRQ5bLI=;
        b=MoHhJ1/S5zUBpsCmS3atnQVNG/1R+gL8S9DjGIuPM0LC4vUO13Yu2Bf0jpwA70eple
         LmcycjAnT64J3HRFvWQaU7+S4yRppoQ2DuFBQhHLlfufI8t7dhXJJbP9MxKgohD/1R6t
         W786YC8f4EJNp0nYk3b4LpwsReCcMf1YsrX4aWZJNBvfOHutPmUvwOlHhJ9qKXHlUmdx
         QiNSJJ2k6dDkIwSuM6KxqCSBktma1KGQ43INLYXZMRIql/Z3EXj7pqD34y8Ns+zepURl
         hQjf/yEa7qXtBLr9xlLyBliwcIt2YFJkXfk8d7B4BnfMcz0KVxUgrwtiaP7Q3ArH9oam
         HE5A==
X-Gm-Message-State: APjAAAVuXcj1TVOtW15yx4q6dPKo68sRP2XoGYUeg0O2FUwljHfPRj+L
        pexTFPJYCbkb+9Aw5KATUTnoz4fiDiYVSYwQ38fQrOj8lhjHW9Enk9Y98agLvfFmYoAiNW9rPc7
        qAEeaFNPE8IN6ni6fRPwAFoJn+4jUA14S8ac=
X-Received: by 2002:a05:620a:9cf:: with SMTP id y15mr11572549qky.483.1575599770466;
        Thu, 05 Dec 2019 18:36:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqx7akEUIduvr9jnHUq98NcXFKUomxTvqILuPNeCKfEgDWyKRtFo9PvsKMtfDzbhzLp0z9BB0w==
X-Received: by 2002:a05:620a:9cf:: with SMTP id y15mr11572536qky.483.1575599770179;
        Thu, 05 Dec 2019 18:36:10 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id v7sm5935692qtk.89.2019.12.05.18.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 18:36:08 -0800 (PST)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/vdso: Provide missing include file
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Thu, 05 Dec 2019 21:36:07 -0500
Message-ID: <36224.1575599767@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with C=1, sparse issues a warning:

  CHECK   arch/x86/entry/vdso/vdso32-setup.c
arch/x86/entry/vdso/vdso32-setup.c:28:28: warning: symbol 'vdso32_enabled' was not declared. Should it be static?

Provide the missing header file.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/arch/x86/entry/vdso/vdso32-setup.c b/arch/x86/entry/vdso/vdso32-setup.c
index 240626e7f55a..43842fade8fa 100644
--- a/arch/x86/entry/vdso/vdso32-setup.c
+++ b/arch/x86/entry/vdso/vdso32-setup.c
@@ -11,6 +11,7 @@
 #include <linux/smp.h>
 #include <linux/kernel.h>
 #include <linux/mm_types.h>
+#include <linux/elf.h>
 
 #include <asm/processor.h>
 #include <asm/vdso.h>

