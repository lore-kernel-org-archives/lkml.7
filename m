Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9AFC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323BE21849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DFBj8XV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732644AbfGST2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 15:28:31 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:39142 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728092AbfGST2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 15:28:30 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 99EF0C0ABA;
        Fri, 19 Jul 2019 19:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563564510; bh=Hdp/JPcL7+oZycXcOcMtk5gY76vQ+jEs/4pUwlrEtss=;
        h=From:To:Cc:Subject:Date:From;
        b=DFBj8XV0B/QuQE8aOgizpLS/br+cSX4K3124yNr6VkULKY9+CPMDapq+h3JPUpAOd
         v48bGz7ugdpJgBV/C2r44iKci7U/4fC/VWapZWK151pqxzQpPK5wJQZTxnejEkkBxb
         FgNFXRXjDOoIkfPIA2cxUcXdJmsgJgSGKRB2vjxeEfxTBnwpCtNEKxD0ZXcFnzsUOH
         7rlCUyuxnPQJ5XOTQrZ8x1A49hZ0UoNpCTm44eahzbiOl4Bso1QDvP2mDr3GT/eepi
         NXpCbmMpuMuVC/Ji29j5hCBD9XcOB0Y4+b0/Tp9pLJW7UlWBTnt/D6wkCyQwqRkAjg
         8M9uUbI69imuw==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.79])
        by mailhost.synopsys.com (Postfix) with ESMTP id 0E70FA0057;
        Fri, 19 Jul 2019 19:28:27 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [TRIVIAL PATCH] of: per-file dtc preprocessor flags
Date:   Fri, 19 Jul 2019 22:28:24 +0300
Message-Id: <20190719192824.24639-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of today we are able to pass custom flags to dtc compiler but not
to dtc preprocessor.
This ability is required for including some board-specific header files.
It allows us to pass defined constants to dts without their duplication
in several places.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 scripts/Makefile.lib | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index f1f38c8cdc74..f2595a608dce 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -166,6 +166,8 @@ dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
 		 $(addprefix -I,$(DTC_INCLUDE))                          \
 		 -undef -D__DTS__
 
+dtc_cpp_flags  += $(DTC_CPP_FLAGS_$(basetarget))
+
 # Useful for describing the dependency of composite objects
 # Usage:
 #   $(call multi_depend, multi_used_targets, suffix_to_remove, suffix_to_add)
-- 
2.21.0

