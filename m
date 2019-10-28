Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43A4CA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A10D218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572275682;
	bh=iGJhZZvWzc81rBbu1L5ll3Y6yFxp0f7lhnL7sJDWN84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m3ibpIKRKvXvFS6bnQviuUGux+xdIWFgIGuRD62XTsHCkSNtjcziXeRi4iCnOf/xc
	 oLru0E3Kae5eMInOb6bYM1ldX+snpB0VTd57It+ixmzkM4VlpX5y4rU8MGMW0z+0Qc
	 r3IMRhGe5x1b9BSFF88grlWwcnLe4hLMoOG4ZRdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390612AbfJ1POl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:14:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfJ1POk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:14:40 -0400
Received: from linux-8ccs.suse.cz (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 807EB20830;
        Mon, 28 Oct 2019 15:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572275680;
        bh=iGJhZZvWzc81rBbu1L5ll3Y6yFxp0f7lhnL7sJDWN84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r+bVc7aueSK51nQIzm5mYymgMEP+C6PTs66YQrHj8M3ZRHGO0c0azgQKUvXAZvMqf
         0VNj6ymo+Wt4audxgGhuZkUNmrBzaxdZ6fOFtQZaojSOFJ4wCNdeOUgT7VbsCinHKe
         6JFIBc1ioaMiKcCjrbpT+Cpd2wxXNbjluZcSvegE=
From:   Jessica Yu <jeyu@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthias Maennich <maennich@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH 2/4] scripts/nsdeps: don't prepend $srctree if *.mod already contains full paths
Date:   Mon, 28 Oct 2019 16:14:25 +0100
Message-Id: <20191028151427.31612-2-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191028151427.31612-1-jeyu@kernel.org>
References: <20191028151427.31612-1-jeyu@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building in-tree modules, the *.mod file contains relative paths.
When building external modules, the resulting *.mod file contains absolute
paths. Allow for the nsdeps script to account for both types of paths and
only prepend $srctree in the case of relative paths.  Otherwise, the script
will append $srctree to the path regardless and it will error out with file
not found errors if the path was already absolute to begin with.

Signed-off-by: Jessica Yu <jeyu@kernel.org>
---

The sed regex is getting more ugly. It's not my strong point :/ If anyone
has a better regex to prepend $srctree for every relative path encountered
while ignoring absolute paths, I'm all ears.

 scripts/nsdeps | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/nsdeps b/scripts/nsdeps
index 54d2ab8f9e5c..9ddcd5cb96b1 100644
--- a/scripts/nsdeps
+++ b/scripts/nsdeps
@@ -33,7 +33,7 @@ generate_deps() {
 	if [ ! -f "$ns_deps_file" ]; then return; fi
 	local mod_source_files=`cat $mod_file | sed -n 1p                      \
 					      | sed -e 's/\.o/\.c/g'           \
-					      | sed "s|[^ ]* *|${srctree}/&|g"`
+					      | sed -E "s%(^|\s)([^/][^ ]*)%\1$srctree/\2%g"`
 	for ns in `cat $ns_deps_file`; do
 		echo "Adding namespace $ns to module $mod_name (if needed)."
 		generate_deps_for_ns $ns $mod_source_files
-- 
2.16.4

