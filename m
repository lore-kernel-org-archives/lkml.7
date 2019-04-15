Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF5EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5AE72073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555353973;
	bh=uQVN4YjdpOiOYhOblB5qUPgSrZR6ogBCuS0yQjco0+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w32qpsVIJWxy0itgFDagpB/x3pBAf7gvuNpkgObg4SJbbVy/7bG/ePCaHBrhJFG1L
	 abtQ2KpT78MzjOo4fGLKYlPvzyAAB0RJ3atrOm/7h1mLlz4U5Kb4M0XkhKRNxXpXDB
	 8bFF88kid+YKiLxmIxULEE3sBYOdzu1jNSbEiF+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfDOSqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:46:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728511AbfDOSqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:46:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A76792087C;
        Mon, 15 Apr 2019 18:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353966;
        bh=uQVN4YjdpOiOYhOblB5qUPgSrZR6ogBCuS0yQjco0+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kuk5stXaVMWzwv+xRInFQ+Iz4CLKtRlJMHXg9XDBVHAZzA5/XxAwH3qi5uw8ARUc4
         oqW6n3I8SJna001IoH6ZvMuARY8OfhzeftzXdh+2byO805BkJ07Te9Iuq3qsMb5Qma
         +qvsAaHVFfJF8VVxA7o2bexKXKJaMIy9YSiorkmQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 36/76] powerpc/fsl: Add nospectre_v2 command line argument
Date:   Mon, 15 Apr 2019 20:44:00 +0200
Message-Id: <20190415183717.159908152@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit f633a8ad636efb5d4bba1a047d4a0f1ef719aa06 upstream.

When the command line argument is present, the Spectre variant 2
mitigations are disabled.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/setup.h |  5 +++++
 arch/powerpc/kernel/security.c   | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 23ee67e279ae..862ebce3ae54 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -65,6 +65,11 @@ void do_barrier_nospec_fixups_range(bool enable, void *start, void *end);
 static inline void do_barrier_nospec_fixups_range(bool enable, void *start, void *end) { };
 #endif
 
+#ifdef CONFIG_PPC_FSL_BOOK3E
+void setup_spectre_v2(void);
+#else
+static inline void setup_spectre_v2(void) {};
+#endif
 void do_btb_flush_fixups(void);
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index fc41bccd9ab6..6dc5cdc2b87c 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -27,6 +27,10 @@ static enum count_cache_flush_type count_cache_flush_type = COUNT_CACHE_FLUSH_NO
 
 bool barrier_nospec_enabled;
 static bool no_nospec;
+static bool btb_flush_enabled;
+#ifdef CONFIG_PPC_FSL_BOOK3E
+static bool no_spectrev2;
+#endif
 
 static void enable_barrier_nospec(bool enable)
 {
@@ -102,6 +106,23 @@ static __init int barrier_nospec_debugfs_init(void)
 device_initcall(barrier_nospec_debugfs_init);
 #endif /* CONFIG_DEBUG_FS */
 
+#ifdef CONFIG_PPC_FSL_BOOK3E
+static int __init handle_nospectre_v2(char *p)
+{
+	no_spectrev2 = true;
+
+	return 0;
+}
+early_param("nospectre_v2", handle_nospectre_v2);
+void setup_spectre_v2(void)
+{
+	if (no_spectrev2)
+		do_btb_flush_fixups();
+	else
+		btb_flush_enabled = true;
+}
+#endif /* CONFIG_PPC_FSL_BOOK3E */
+
 #ifdef CONFIG_PPC_BOOK3S_64
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
 {
-- 
2.19.1



