Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4AFC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E504206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578432214;
	bh=YLoaA4tNyNuuKDFt662/r/YVwrSW+OM1l9CULpRehWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YrJWah/S/pXbCxg2mF6bl4hrX+dIP46hKywqzM6SnQXbicwajzd+D9XlSocorN1oZ
	 8N9IrYBYZKHY/avmUcOnIQvkKtLCeViO3azui4uJKyOkEfBfjpcgnGaoVWdKYF8PMP
	 0EQywYlLd4J4RC0ELikGVoHaI5Tf9WTL3M6GQuLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgAGVBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:01:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:37692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728145AbgAGVBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:01:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83BED21744;
        Tue,  7 Jan 2020 21:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430865;
        bh=YLoaA4tNyNuuKDFt662/r/YVwrSW+OM1l9CULpRehWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vGxWRkqh++CBtaz+XaB4RjcNfY3spXxi98ghqpTcCfzjePLEmVZF3EY9ksnQ27pa6
         uGNHVhKrmKM3eFnlOqUAzwJM1IMP5Lv+zeWz3ZeYeNtqjTbiC+hKlzy6rqaix+QN9a
         Vw7Q5GxvOc8OvWbhT1LrzUZ6sUXCtf8KzTXQU4Sg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 5.4 091/191] gcc-plugins: make it possible to disable CONFIG_GCC_PLUGINS again
Date:   Tue,  7 Jan 2020 21:53:31 +0100
Message-Id: <20200107205337.866321051@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit a5b0dc5a46c221725c43bd9b01570239a4cd78b1 upstream.

I noticed that randconfig builds with gcc no longer produce a lot of
ccache hits, unlike with clang, and traced this back to plugins
now being enabled unconditionally if they are supported.

I am now working around this by adding

   export CCACHE_COMPILERCHECK=/usr/bin/size -A %compiler%

to my top-level Makefile. This changes the heuristic that ccache uses
to determine whether the plugins are the same after a 'make clean'.

However, it also seems that being able to just turn off the plugins is
generally useful, at least for build testing it adds noticeable overhead
but does not find a lot of bugs additional bugs, and may be easier for
ccache users than my workaround.

Fixes: 9f671e58159a ("security: Create "kernel hardening" config area")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
Link: https://lore.kernel.org/r/20191211133951.401933-1-arnd@arndb.de
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/gcc-plugins/Kconfig |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/scripts/gcc-plugins/Kconfig
+++ b/scripts/gcc-plugins/Kconfig
@@ -14,8 +14,8 @@ config HAVE_GCC_PLUGINS
 	  An arch should select this symbol if it supports building with
 	  GCC plugins.
 
-config GCC_PLUGINS
-	bool
+menuconfig GCC_PLUGINS
+	bool "GCC plugins"
 	depends on HAVE_GCC_PLUGINS
 	depends on PLUGIN_HOSTCC != ""
 	default y
@@ -25,8 +25,7 @@ config GCC_PLUGINS
 
 	  See Documentation/core-api/gcc-plugins.rst for details.
 
-menu "GCC plugins"
-	depends on GCC_PLUGINS
+if GCC_PLUGINS
 
 config GCC_PLUGIN_CYC_COMPLEXITY
 	bool "Compute the cyclomatic complexity of a function" if EXPERT
@@ -113,4 +112,4 @@ config GCC_PLUGIN_ARM_SSP_PER_TASK
 	bool
 	depends on GCC_PLUGINS && ARM
 
-endmenu
+endif


