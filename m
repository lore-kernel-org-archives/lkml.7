Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E676C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 22:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241BE218D2
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 22:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555195490;
	bh=X6t/SPDT3Ypw0fpLrVYQDCmU/g1fPn8mEDeOVXwiKTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xaC6QEEqY6gvmIHRYyF+1EBiR4B5QPbuTdNlRTuMAYuNFI7QZAh1TIdjupJ8dM3xg
	 kevtHUWwSlBcXsGl+989ckkAiaEgjpn+V1FkG8oz6kwVOH9iacpFL9QzWURSXvnfNS
	 bsX/MopMf9Z1syEjSDz9byAMEIXvzT4EBaihTy2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfDMWos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 18:44:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbfDMWor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 18:44:47 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.117.159.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF7C32147A;
        Sat, 13 Apr 2019 22:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555195486;
        bh=X6t/SPDT3Ypw0fpLrVYQDCmU/g1fPn8mEDeOVXwiKTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kaS9b6fPT6YTHZB5Hxlm+oJb9ozL9dpJP9TaT1NBdSqipo5vUHFyOIEztbieSgD0D
         b6hMZO9eYOsCbZsh4iq4nshp3LG6/4Qv3zo9JV3cVKmbQZhdWTrTirtsMbORh03PiK
         jBtw4VN4bncYUB8f7GrnaKqUbjj00Cbf/vhxClAQ=
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
Subject: [PATCH v5 1/5] init: Introduce DEBUG_MISC option
Date:   Sat, 13 Apr 2019 22:44:34 +0000
Message-Id: <20190413224438.10802-2-okaya@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190413224438.10802-1-okaya@kernel.org>
References: <20190413224438.10802-1-okaya@kernel.org>
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
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 lib/Kconfig.debug | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 0d9e81779e37..0103a092ce3d 100644
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
+	  Say Y here if you need to enable miscellaneous debug code that should
+	  be under a more specific debug option but isn't.
+
+
 menu "Memory Debugging"
 
 source "mm/Kconfig.debug"
-- 
2.21.0

