Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245CCCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E184921835
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572275686;
	bh=fcw6MA5Xb54tTu35HsCkCgMilzhNxa+Djhk1dazMxfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BTFfxA+QC8kTqAkHEivb1UXTjCmkA7Mp4iHaj5ivRl14hRC9QEHKr11JkJHGO5Yb5
	 wl14nb9lo7xqnnter+Z7Zrq/v/jVTxHMKdm9RhlCtnWVB1CUEWef4BN0Zmb+yjRq8b
	 2IHeJRO/hqQexQqxp7V1qNhwt+FHnJ1/DxQmnSOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390623AbfJ1POp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:14:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfJ1POo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:14:44 -0400
Received: from linux-8ccs.suse.cz (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2681020830;
        Mon, 28 Oct 2019 15:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572275684;
        bh=fcw6MA5Xb54tTu35HsCkCgMilzhNxa+Djhk1dazMxfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cCvVusphcFPpK3Tz0wGK1AKcAIPx4vHho3K/C8R0wBZi0BDU6ulRdO+Uex0pPjoLG
         yeZrwN4iHBwagFu7ilaoQPLsxd1DpQ37mBpsY78pAP9UOrW82IwtrSF6SRkZ2fVqeI
         9Ud+cmvZmrqvhmD663fu9vqsV4EB8YtpMAZhUwNM=
From:   Jessica Yu <jeyu@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthias Maennich <maennich@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH 3/4] nsdeps: remove stale .ns_deps files before generating new ones
Date:   Mon, 28 Oct 2019 16:14:26 +0100
Message-Id: <20191028151427.31612-3-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191028151427.31612-1-jeyu@kernel.org>
References: <20191028151427.31612-1-jeyu@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding or removing namespaces, calling `make` does not necessarily
remove existing stale .ns_deps files. That is, one could remove a
namespace, call make, and while modpost writes the correct, new .ns_deps
files, stale ones are not removed from the source tree, thus producing
incorrect results when running `make nsdeps`, i.e., inserting
MODULE_IMPORT_NS() statements for namespaces that have been removed.
Clean up old .ns_deps files before generating new ones with modpost.

Signed-off-by: Jessica Yu <jeyu@kernel.org>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index ffd7a912fc46..22f9894b346b 100644
--- a/Makefile
+++ b/Makefile
@@ -1685,6 +1685,8 @@ tags TAGS cscope gtags: FORCE
 PHONY += nsdeps
 
 nsdeps: modules
+	@find $(if $(KBUILD_EXTMOD), $(KBUILD_EXTMOD), .) $(RCS_FIND_IGNORE) \
+		-name '*.ns_deps' -type f -print | xargs rm -f
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost nsdeps
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/$@
 
-- 
2.16.4

