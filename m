Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEDCC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF46208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKIptMud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfDZPcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:32:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43661 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfDZPcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:32:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id e67so1893379pfe.10;
        Fri, 26 Apr 2019 08:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n9lwqiKGdUroDww2WFkm9jYtVCvbzItCk9Ugl1HYVfw=;
        b=HKIptMudEQ+6us8JHx15m5uF+NLQr5slcrd6kSybISCA6LP8MSN/2/RAk2zh2u1Mue
         XFTYBS8/AB8YRhZlWTsRsoNBXPlszGois3doU65bvodFDouOBsw/Ft7QXPXEwas+oG9j
         lo49GqZW4Nr1JwYozCaAQt9Ere888KXcKKFhU77aZOvP9HM3Ka/wcltEd+FBVzUODFAN
         4stURUq9mmPq+tCz0xMrsBi5eeXx3m2grZr3LHNH/cw2lWHNYNwtL+28sTAxHhPW3pXL
         FHRWL3He2hqfdwf7CX8wU/QLue80w3oVGNGP7emmdF8ty5N4f693NqShVjGSsotCnFXl
         7+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n9lwqiKGdUroDww2WFkm9jYtVCvbzItCk9Ugl1HYVfw=;
        b=r3vlJ5u+2eJliKgQDK7j/NuonG/ZOzpZL8FMbnIX6nHFwE8CDsDhx6JPUpfj6urIlc
         k/eNOeolgAvcc6ytETmhyu9KsqDE5iLLqap1HD7zw7F04my+mjCrq7VQf+87dEqVc+Kt
         ZdqmyAVfqweuQHKmQF6lxYYllDbjv8sS26gs3me+cTyUY1s43aqq/MJonb8IKMXrk6PT
         IsEvzP41hG8/n3+H9htCZ7MM4miQJZKFx68MFO6nSp5p6XOCBgpCFv1hJqsOM3qhBeAh
         WdtM4fabTd0u5Kgg3QRYXGzsIETiXv888jFcTQ+wl4QLiSVSpHYikUT5g0eQYLJgn/G5
         V2jg==
X-Gm-Message-State: APjAAAXdBno02RI5saA+y3SZFNrhWRXe3dLjDR36G/IeQEdjTOk/ZR84
        xlYmucmsVxbssooXg3WUpn4=
X-Google-Smtp-Source: APXvYqxF9PR+YusJwQ4Wt1zdaXFT9Q82Vdhg9k3YBt7amEk+kNEJJ5KKyiW0jHmhp+cB9936Z774YA==
X-Received: by 2002:a63:fb4d:: with SMTP id w13mr44723968pgj.397.1556292760600;
        Fri, 26 Apr 2019 08:32:40 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b1sm29024833pgq.15.2019.04.26.08.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 08:32:39 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 05/27] Documentation: x86: convert kernel-stacks to reST
Date:   Fri, 26 Apr 2019 23:31:28 +0800
Message-Id: <20190426153150.21228-6-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426153150.21228-1-changbin.du@gmail.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/x86/index.rst                   |  1 +
 .../x86/{kernel-stacks => kernel-stacks.rst}  | 20 ++++++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)
 rename Documentation/x86/{kernel-stacks => kernel-stacks.rst} (92%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index c0bfd0bd6000..489f4f4179c4 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -11,3 +11,4 @@ Linux x86 Support
    boot
    topology
    exception-tables
+   kernel-stacks
diff --git a/Documentation/x86/kernel-stacks b/Documentation/x86/kernel-stacks.rst
similarity index 92%
rename from Documentation/x86/kernel-stacks
rename to Documentation/x86/kernel-stacks.rst
index 9a0aa4d3a866..3e6bf5940db0 100644
--- a/Documentation/x86/kernel-stacks
+++ b/Documentation/x86/kernel-stacks.rst
@@ -1,5 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+Kernel Stacks
+=============
+
 Kernel stacks on x86-64 bit
----------------------------
+===========================
 
 Most of the text from Keith Owens, hacked by AK
 
@@ -57,7 +63,7 @@ IST events with the same code to be nested.  However in most cases, the
 stack size allocated to an IST assumes no nesting for the same code.
 If that assumption is ever broken then the stacks will become corrupt.
 
-The currently assigned IST stacks are :-
+The currently assigned IST stacks are :
 
 * DOUBLEFAULT_STACK.  EXCEPTION_STKSZ (PAGE_SIZE).
 
@@ -98,7 +104,7 @@ For more details see the Intel IA32 or AMD AMD64 architecture manuals.
 
 
 Printing backtraces on x86
---------------------------
+==========================
 
 The question about the '?' preceding function names in an x86 stacktrace
 keeps popping up, here's an indepth explanation. It helps if the reader
@@ -108,7 +114,7 @@ arch/x86/kernel/dumpstack.c.
 Adapted from Ingo's mail, Message-ID: <20150521101614.GA10889@gmail.com>:
 
 We always scan the full kernel stack for return addresses stored on
-the kernel stack(s) [*], from stack top to stack bottom, and print out
+the kernel stack(s) [1]_, from stack top to stack bottom, and print out
 anything that 'looks like' a kernel text address.
 
 If it fits into the frame pointer chain, we print it without a question
@@ -136,6 +142,6 @@ that look like kernel text addresses, so if debug information is wrong,
 we still print out the real call chain as well - just with more question
 marks than ideal.
 
-[*] For things like IRQ and IST stacks, we also scan those stacks, in
-    the right order, and try to cross from one stack into another
-    reconstructing the call chain. This works most of the time.
+.. [1] For things like IRQ and IST stacks, we also scan those stacks, in
+       the right order, and try to cross from one stack into another
+       reconstructing the call chain. This works most of the time.
-- 
2.20.1

