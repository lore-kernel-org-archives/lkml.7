Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C729C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36678205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100586;
	bh=hNB1wprvtxnjsYwue8uW3eaTDIfm1Io0/AFQvzzbeUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2VMV5dDk+nV5QlwpfV9dZQG5HofqYBVlYryt+W0YghsaVZRX9G4EK2NAJEfi9uzZ6
	 freYlVldtWcicjbK5pRqYQ+fUzO0SzMB+Rs6SnGTgri9diFMOwxVdG1brctzTjNN/u
	 4x0YzZtwikp+bZx1j3AxlAAjBI5bOXBt5rWixYgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733015AbfFIRQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:16:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732390AbfFIQxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:53:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F16D0206C3;
        Sun,  9 Jun 2019 16:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099205;
        bh=hNB1wprvtxnjsYwue8uW3eaTDIfm1Io0/AFQvzzbeUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iDOneP5vaHXyS3nHNfjW/NzCN9iI1ii62vdZeCENB1PP81DiMRyi1oTrneix3MtTY
         oPza9dhaxXd5XcCr3TGSRLQv/lVUXn83SjMH/q7uMJgkQ4HQBe6xX9b1AZ4RNDRXru
         R4gtAizs7zeWbZyErWAa8FaubmrWZdZgjUqvFvyg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 4.9 47/83] gcc-plugins: Fix build failures under Darwin host
Date:   Sun,  9 Jun 2019 18:42:17 +0200
Message-Id: <20190609164131.941678976@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.843327870@linuxfoundation.org>
References: <20190609164127.843327870@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

commit 7210e060155b9cf557fb13128353c3e494fa5ed3 upstream.

The gcc-common.h file did not take into account certain macros that
might have already been defined in the build environment. This updates
the header to avoid redefining the macros, as seen on a Darwin host
using gcc 4.9.2:

 HOSTCXX -fPIC scripts/gcc-plugins/arm_ssp_per_task_plugin.o - due to: scripts/gcc-plugins/gcc-common.h
In file included from scripts/gcc-plugins/arm_ssp_per_task_plugin.c:3:0:
scripts/gcc-plugins/gcc-common.h:153:0: warning: "__unused" redefined
^
In file included from /usr/include/stdio.h:64:0,
                from /Users/hns/Documents/Projects/QuantumSTEP/System/Library/Frameworks/System.framework/Versions-jessie/x86_64-apple-darwin15.0.0/gcc/arm-linux-gnueabi/bin/../lib/gcc/arm-linux-gnueabi/4.9.2/plugin/include/system.h:40,
                from /Users/hns/Documents/Projects/QuantumSTEP/System/Library/Frameworks/System.framework/Versions-jessie/x86_64-apple-darwin15.0.0/gcc/arm-linux-gnueabi/bin/../lib/gcc/arm-linux-gnueabi/4.9.2/plugin/include/gcc-plugin.h:28,
                from /Users/hns/Documents/Projects/QuantumSTEP/System/Library/Frameworks/System.framework/Versions-jessie/x86_64-apple-darwin15.0.0/gcc/arm-linux-gnueabi/bin/../lib/gcc/arm-linux-gnueabi/4.9.2/plugin/include/plugin.h:23,
                from scripts/gcc-plugins/gcc-common.h:9,
                from scripts/gcc-plugins/arm_ssp_per_task_plugin.c:3:
/usr/include/sys/cdefs.h:161:0: note: this is the location of the previous definition
^

Reported-and-tested-by: "H. Nikolaus Schaller" <hns@goldelico.com>
Fixes: 189af4657186 ("ARM: smp: add support for per-task stack canaries")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/gcc-plugins/gcc-common.h |    4 ++++
 1 file changed, 4 insertions(+)

--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -135,8 +135,12 @@ extern void print_gimple_expr(FILE *, gi
 extern void dump_gimple_stmt(pretty_printer *, gimple, int, int);
 #endif
 
+#ifndef __unused
 #define __unused __attribute__((__unused__))
+#endif
+#ifndef __visible
 #define __visible __attribute__((visibility("default")))
+#endif
 
 #define DECL_NAME_POINTER(node) IDENTIFIER_POINTER(DECL_NAME(node))
 #define DECL_NAME_LENGTH(node) IDENTIFIER_LENGTH(DECL_NAME(node))


