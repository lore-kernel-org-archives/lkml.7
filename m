Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC41BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 11:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E1512184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 11:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571742269;
	bh=dx/S7X7xlxDH2/Ivln7aj+hAf93S/iBfkZvcLWS9HuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jSYhcrxNM1bj9SereE4h3M+UEwvZ4Tv06i6wNAyHFK/3zHZ2fBZWBKiS9JjegsyqB
	 4HXmGWh5OzJDpVxlbW18EAPmnPnIh39NGYnXjwktXhYyo2B/Qa2PdBh3C6tFPZmOSC
	 cAwgNEe3f+Cg6oprjhnpKnosVuQ0PpD8UqZhIWX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbfJVLEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 07:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729458AbfJVLEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 07:04:14 -0400
Received: from linux-8ccs.suse.cz (ip5f5ade81.dynamic.kabel-deutschland.de [95.90.222.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BABB72184C;
        Tue, 22 Oct 2019 11:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571742253;
        bh=dx/S7X7xlxDH2/Ivln7aj+hAf93S/iBfkZvcLWS9HuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SSubpzMEKNnVIrEhijpMg66rLSZ4kuBBe+lbUbvSLLH2CY0BcAWH62iGFMucCgh01
         ANkzsACwD8AySLRS1ogA822MdpKqF7qgrAZkirrPRN1/WwhskpkBRCP9vSpD0npeid
         i0g7kVDVY1wQsqD4GEPikZrC3hDPufiap6B4WbEc=
From:   Jessica Yu <jeyu@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthias Maennich <maennich@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH v3] scripts/nsdeps: use alternative sed delimiter
Date:   Tue, 22 Oct 2019 13:04:03 +0200
Message-Id: <20191022110403.29715-1-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191021160419.28270-1-jeyu@kernel.org>
References: <20191021160419.28270-1-jeyu@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing an out of tree build with O=, the nsdeps script constructs
the absolute pathname of the module source file so that it can insert
MODULE_IMPORT_NS statements in the right place. However, ${srctree}
contains an unescaped path to the source tree, which, when used in a sed
substitution, makes sed complain:

++ sed 's/[^ ]* *//home/jeyu/jeyu-linux\/&/g'
sed: -e expression #1, char 12: unknown option to `s'

The sed substitution command 's' ends prematurely with the forward
slashes in the pathname, and sed errors out when it encounters the 'h',
which is an invalid sed substitution option. To avoid escaping forward
slashes ${srctree}, we can use '|' as an alternative delimiter for
sed instead to avoid this error.

Signed-off-by: Jessica Yu <jeyu@kernel.org>
---

v3: don't need to escape '/' since we're using a different delimiter.

 scripts/nsdeps | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/nsdeps b/scripts/nsdeps
index 3754dac13b31..dda6fbac016e 100644
--- a/scripts/nsdeps
+++ b/scripts/nsdeps
@@ -33,7 +33,7 @@ generate_deps() {
 	if [ ! -f "$ns_deps_file" ]; then return; fi
 	local mod_source_files=`cat $mod_file | sed -n 1p                      \
 					      | sed -e 's/\.o/\.c/g'           \
-					      | sed "s/[^ ]* */${srctree}\/&/g"`
+					      | sed "s|[^ ]* *|${srctree}/&|g"`
 	for ns in `cat $ns_deps_file`; do
 		echo "Adding namespace $ns to module $mod_name (if needed)."
 		generate_deps_for_ns $ns $mod_source_files
-- 
2.16.4

