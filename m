Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FD0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA3520830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554931593;
	bh=QVv8aZaojPuNI9Nt+2Wqk0vL3kP4mygQQ00q6O048kw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=pRjVOHIYBmTO30k4n8uD1Fw3SJRzUjMb3ePQjs3FDSe+q8rH11G0RWdAmdK77i4U7
	 R8H9UDASoi+h3QmUT2m591owebYagTqBK1QngmZNcmIz64/pRNqvvx934cogZaJBmU
	 BbpIOcepXmSB9EwJJs59FNWzdd4R6G1QPLhveLac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfDJV0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:26:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbfDJV0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 17:26:32 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [23.96.42.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 772572082A;
        Wed, 10 Apr 2019 21:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554931591;
        bh=QVv8aZaojPuNI9Nt+2Wqk0vL3kP4mygQQ00q6O048kw=;
        h=From:To:Cc:Subject:Date:From;
        b=INnCM/2LoDGf9yNDcUDsBa+hvzGRiSU+IUZHWWXHCJeq7WI9ub2xGZ5unPsGQeUai
         ldi9xeyw0NnwOVq6EVnF6UVBGGFgRONavAyh4+/P0aVA+n5QqVETHVi1cKp6I+fAN9
         ed+gu7Lt/9JOGJUEEKZG3w8hrfm/UwQHzqELQl0o=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH v1] init: Do not select DEBUG_KERNEL by default
Date:   Wed, 10 Apr 2019 21:26:25 +0000
Message-Id: <20190410212627.29514-1-okaya@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't seem to have a kernel with CONFIG_EXPERT set but
CONFIG_DEBUG_KERNEL unset these days.

While some of the features under the CONFIG_EXPERT require
CONFIG_DEBUG_KERNEL, it doesn't apply for all features.

The meaning of CONFIG_EXPERT and CONFIG_DEBUG_KERNEL has been
mixed here.

It looks like CONFIG_KALLSYMS_ALL is the only feature that
requires CONFIG_DEBUG_KERNEL. Move the CONFIG_DEBUG_KERNEL
selection to where it really is needed.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 init/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 4592bf7997c0..0a6346feae8d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1206,8 +1206,6 @@ config BPF
 
 menuconfig EXPERT
 	bool "Configure standard kernel features (expert users)"
-	# Unhide debug options, to make the on-by-default options visible
-	select DEBUG_KERNEL
 	help
 	  This option allows certain base kernel options and settings
           to be disabled or tweaked. This is for specialized
@@ -1473,7 +1471,8 @@ config KALLSYMS
 
 config KALLSYMS_ALL
 	bool "Include all symbols in kallsyms"
-	depends on DEBUG_KERNEL && KALLSYMS
+	select DEBUG_KERNEL
+	depends on KALLSYMS
 	help
 	   Normally kallsyms only contains the symbols of functions for nicer
 	   OOPS messages and backtraces (i.e., symbols from the text and inittext
-- 
2.21.0

