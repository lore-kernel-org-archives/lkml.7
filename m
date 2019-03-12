Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64694C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35643214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfCLHsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:48:03 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:53614 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726463AbfCLHsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:48:02 -0400
Received: from mr2.cc.vt.edu (mr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x2C7m0lj022847
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 03:48:00 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x2C7ltLQ010130
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 03:48:00 -0400
Received: by mail-qt1-f197.google.com with SMTP id i3so1483114qtc.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 00:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=xTgDnXCD9HPnn/Lo/1BOnzwJRpZqsjZo/xIqSJRlodE=;
        b=CE7YUbUapxjlU1AkxjMxj1LI8+j7R7MQC5cq0flWyQe0hn0GMPUzvnj/4FzqSJt3fU
         Mk1OkZQ0yS/QJPTrkvDPhm7jRDilXSDOmlfiELcEUCG7FxGQ7ZAgjTOxc2+QZ4UQPazS
         BeGOH5b7S3Kg9KTgpUWNpjJthLM2R8epTqoXauKJZjST6Un21kRI7dA9xfHDdwr0KlkF
         pE6pHrN8Jnd2jI1+9Fs/HkTNj4TNPWht61L/GrLj9z44lPEXK4q6ZDJh/yHWYJ5YXRGm
         8TG9ZZ15Rc6mnkw7vd8NXnQU4+Li/k5tnefa2DyZSS5fHyiBES/dBsWBpe8FoP2rmvO/
         H3rg==
X-Gm-Message-State: APjAAAWdVJ7qBUbutWPMKPsTbg0Uc9Ykk4zef4lr3VWazkcB3GuGM/at
        XSS9154vxeQmX+q2IPCMmqWsHPcdQTJwLV01DpTQ+aWSPlzt7CWpgqtSg8UaUs693FlGLm+tHbs
        E0OUekxzuoiY2GilzzOQxkLC2Th6o8wRw+o8=
X-Received: by 2002:ac8:33dd:: with SMTP id d29mr4978915qtb.320.1552376875537;
        Tue, 12 Mar 2019 00:47:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxj7TspTzTbfjd6p6lOYPlTyNiJYhiy7qbYnaNvTO1uIw0Vxj4s1BUBAvx7QJTaO2TySEY6VA==
X-Received: by 2002:ac8:33dd:: with SMTP id d29mr4978905qtb.320.1552376875274;
        Tue, 12 Mar 2019 00:47:55 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::3b7])
        by smtp.gmail.com with ESMTPSA id g123sm11485594qkg.0.2019.03.12.00.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 00:47:54 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] b/arch/x86/mm/pti.c - make local symbols static
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 12 Mar 2019 03:47:53 -0400
Message-ID: <27680.1552376873@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With 'make C=2 W=1', sparse and gcc both complain:

  CHECK   arch/x86/mm/pti.c
arch/x86/mm/pti.c:84:3: warning: symbol 'pti_mode' was not declared. Should it be static?
arch/x86/mm/pti.c:605:6: warning: symbol 'pti_set_kernel_image_nonglobal' was not declared. Should it be static?
  CC      arch/x86/mm/pti.o
arch/x86/mm/pti.c:605:6: warning: no previous prototype for 'pti_set_kernel_image_nonglobal' [-Wmissing-prototypes]
  605 | void pti_set_kernel_image_nonglobal(void)
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

And indeed, the function at line 605 is only used locally. 'pti_mode' is more
subtle - there is another pti_mode in drivers/hwtracing/intel_th/pti.c, but
it's an array declared static, not an enum

Make both variables static.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

---
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 4fee5c3003ed..139b28a01ce4 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -77,7 +77,7 @@ static void __init pti_print_if_secure(const char *reason)
 		pr_info("%s\n", reason);
 }
 
-enum pti_mode {
+static enum pti_mode {
 	PTI_AUTO = 0,
 	PTI_FORCE_OFF,
 	PTI_FORCE_ON
@@ -602,7 +602,7 @@ static void pti_clone_kernel_text(void)
 	set_memory_global(start, (end_global - start) >> PAGE_SHIFT);
 }
 
-void pti_set_kernel_image_nonglobal(void)
+static void pti_set_kernel_image_nonglobal(void)
 {
 	/*
 	 * The identity map is created with PMDs, regardless of the

