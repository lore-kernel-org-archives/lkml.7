Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FA0C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A3A2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555033449;
	bh=IT/7Jg1kbrxbRz/bY2HGp0aOHcVS5pkBRcqeoMqzhFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yRgSwzlMVhMJyWw2vO23p1wTmtTWf4MeDMfooki69QSI9Q2Mh1B0tbGrEXcr7+Pl4
	 WGDANhhpa5cRFNiuCEVuR9t37igXkYoCPX0tgyFcIW0u7ubMa9SXIpzPZgzDjmPP8x
	 E9Ir0cASy8/Y6kgos1SL4gPsmjdqaIarOEBAZnj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfDLBoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbfDLBoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:44:07 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [52.191.113.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E56CF20674;
        Fri, 12 Apr 2019 01:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555033447;
        bh=IT/7Jg1kbrxbRz/bY2HGp0aOHcVS5pkBRcqeoMqzhFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=deRFAGol0NaX9pEdDRb70Ar9taKNXVjPUpBghv6xBhe0Mia+zSliiSSRRHrChHPB5
         n3zCey03Z3hJ7W4/PYk6D4B+VaU32GvoGcQpg1Hoot1w7RcgvYyCNV4NvVKnyM+UPL
         Xjz/Yo7tTnTsfqGSBle4xhO2zr3RRdNyFRxmOpDg=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     josh@joshtriplett.org, keescook@chromium.org,
        Sinan Kaya <okaya@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Changbin Du <changbin.du@intel.com>
Subject: [PATCH v4 1/5] init: Introduce DEBUG_MISC option
Date:   Fri, 12 Apr 2019 01:43:51 +0000
Message-Id: <20190412014355.25307-2-okaya@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412014355.25307-1-okaya@kernel.org>
References: <20190412014355.25307-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce DEBUG_MISC ("Miscellaneous debug code that should be under a more
specific debug option but isn't"), make it depend on DEBUG_KERNEL and be
"default DEBUG_KERNEL" but allow itself to be turned off, and then
mechanically change the small handful of "#ifdef CONFIG_DEBUG_KERNEL" to
"#ifdef CONFIG_DEBUG_MISC".

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 lib/Kconfig.debug | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 0d9e81779e37..2f80ebaa6d9a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -438,6 +438,15 @@ config DEBUG_KERNEL
 	  Say Y here if you are developing drivers or trying to debug and
 	  identify kernel problems.
 
+config DEBUG_MISC
+	bool "Miscellaneous debug code"
+	default DEBUG_KERNEL
+	depends on DEBUG_KERNEL
+	help
+	  Say Y here if you need to enable Miscellaneous debug code that should
+	  be under a more specific debug option but isn't.
+
+
 menu "Memory Debugging"
 
 source "mm/Kconfig.debug"
-- 
2.21.0

