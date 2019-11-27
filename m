Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD7FC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AE52158A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887545;
	bh=s6XzFskxKEy/0UPny9gW5Yu4Xr5VQWwj/YGBAcYZ4jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2COaT19A3OT5aZrrPAD/Tr2EgNdIZ0Q5+60haGdKObam1NqRvzdgYcVwJHmCHWy90
	 pGuJQwVyk6+cvdI/yrzNMGJZwkfmK8ws/Kh4tI8Kty1hCdw+C1+c1/L3IZDs3ZXz93
	 CqWJXuu7Vey8JCpOz749cFQ+q0E9st73BICRdaME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbfK0Upo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:45:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:56804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729308AbfK0Upl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:45:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A3B2217BC;
        Wed, 27 Nov 2019 20:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887540;
        bh=s6XzFskxKEy/0UPny9gW5Yu4Xr5VQWwj/YGBAcYZ4jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jKOfP3QNUh2wA8S7jZ/6wC7oqp+bfT0R2mwzbhwEoFssx/X14uSMBtutidszjD/0I
         kMkW75ncE4PBz8V1pbOM8xUaGHSMbU81cDzyf8rs6LJA7QP5z5WpRq6XmXLvgnAD5m
         6vyrqxx5J+/Om9F5jcbCqqZjxHIQ4JZTkMpOrubc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        "Christopher M. Riedl" <cmr@informatik.wtf>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH 4.9 149/151] powerpc/64s: support nospectre_v2 cmdline option
Date:   Wed, 27 Nov 2019 21:32:12 +0100
Message-Id: <20191127203047.641403632@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Christopher M. Riedl" <cmr@informatik.wtf>

commit d8f0e0b073e1ec52a05f0c2a56318b47387d2f10 upstream.

Add support for disabling the kernel implemented spectre v2 mitigation
(count cache flush on context switch) via the nospectre_v2 and
mitigations=off cmdline options.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Christopher M. Riedl <cmr@informatik.wtf>
Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20190524024647.381-1-cmr@informatik.wtf
Signed-off-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/security.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -29,7 +29,7 @@ static enum count_cache_flush_type count
 bool barrier_nospec_enabled;
 static bool no_nospec;
 static bool btb_flush_enabled;
-#ifdef CONFIG_PPC_FSL_BOOK3E
+#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_BOOK3S_64)
 static bool no_spectrev2;
 #endif
 
@@ -107,7 +107,7 @@ static __init int barrier_nospec_debugfs
 device_initcall(barrier_nospec_debugfs_init);
 #endif /* CONFIG_DEBUG_FS */
 
-#ifdef CONFIG_PPC_FSL_BOOK3E
+#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_BOOK3S_64)
 static int __init handle_nospectre_v2(char *p)
 {
 	no_spectrev2 = true;
@@ -115,6 +115,9 @@ static int __init handle_nospectre_v2(ch
 	return 0;
 }
 early_param("nospectre_v2", handle_nospectre_v2);
+#endif /* CONFIG_PPC_FSL_BOOK3E || CONFIG_PPC_BOOK3S_64 */
+
+#ifdef CONFIG_PPC_FSL_BOOK3E
 void setup_spectre_v2(void)
 {
 	if (no_spectrev2)
@@ -392,7 +395,17 @@ static void toggle_count_cache_flush(boo
 
 void setup_count_cache_flush(void)
 {
-	toggle_count_cache_flush(true);
+	bool enable = true;
+
+	if (no_spectrev2 || cpu_mitigations_off()) {
+		if (security_ftr_enabled(SEC_FTR_BCCTRL_SERIALISED) ||
+		    security_ftr_enabled(SEC_FTR_COUNT_CACHE_DISABLED))
+			pr_warn("Spectre v2 mitigations not under software control, can't disable\n");
+
+		enable = false;
+	}
+
+	toggle_count_cache_flush(enable);
 }
 
 #ifdef CONFIG_DEBUG_FS


