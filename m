Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7939C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AD7204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963587;
	bh=i+JjBN1jzFpFdQR8509H4Spqc+UizChTcAJ1UAAzVoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GGSTC3Bo6yfF8Wt7TTvNzt5Eo+LPLVn9MfUtiq4WM0diZpBvuYImqprB1zTeCCwBD
	 deKUB8yx86p4TCfgPxtw9hVrKCkvJmM6YypB/N+6P3S0fRuX/WqjjSWJJUZkQH8zMi
	 K3PSRWV7Hpiil13iYQCM/8GizQ+TwNhxM0BBoA5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbfDVTob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:44:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729461AbfDVTo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:44:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACB67217D4;
        Mon, 22 Apr 2019 19:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962267;
        bh=i+JjBN1jzFpFdQR8509H4Spqc+UizChTcAJ1UAAzVoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VFG8Fq5sZNaLiaCqsScOp+irf/p0owdkX8gNjXG959HE+7BlM07es5hoOm4NQRvl+
         U++vRMcXXyDYPDPf+ThIO66b/YqZODzwYV4EIUcE6T4kP5mHQjyT/CHqmhzHjQFZis
         3xyaOhnPyaJmN5iTRyeIPprxl7+HKef87GD2G9TQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 75/98] kbuild: skip parsing pre sub-make code for recursion
Date:   Mon, 22 Apr 2019 15:41:42 -0400
Message-Id: <20190422194205.10404-75-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit 221cc2d27ddc49b3e06d4637db02bf78e70c573c ]

When Make recurses to the top Makefile with sub-make-done unset,
the code block surrounded by 'ifneq ($(sub-make-done),1) ... endif'
is parsed multiple times. This happens for in-tree building of
include/config/auto.conf, *-pkg, etc. with GNU Make 4.x.

This is a slight regression by commit 688931a5ad4e ("kbuild: skip
sub-make for in-tree build with GNU Make 4.x") in terms of performance
since that code block contains one $(shell ...) invocation.

Fix it by exporting the variable irrespective of sub-make being run.
I renamed it because GNU Make cannot properly export variables
containing hyphens. This is probably a bug of GNU Make, and the issue
in Kbuild had already been reported by commit 2bfbe7881ee0 ("kbuild:
Do not use hyphen in exported variable name").

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 Makefile | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index ef192ca04330..ed3ad29d2db7 100644
--- a/Makefile
+++ b/Makefile
@@ -31,7 +31,7 @@ _all:
 # descending is started. They are now explicitly listed as the
 # prepare rule.
 
-ifneq ($(sub-make-done),1)
+ifneq ($(sub_make_done),1)
 
 # Do not use make's built-in rules and variables
 # (this increases performance and avoids hard-to-debug behaviour)
@@ -159,6 +159,8 @@ need-sub-make := 1
 $(lastword $(MAKEFILE_LIST)): ;
 endif
 
+export sub_make_done := 1
+
 ifeq ($(need-sub-make),1)
 
 PHONY += $(MAKECMDGOALS) sub-make
@@ -168,12 +170,12 @@ $(filter-out _all sub-make $(CURDIR)/Makefile, $(MAKECMDGOALS)) _all: sub-make
 
 # Invoke a second make in the output directory, passing relevant variables
 sub-make:
-	$(Q)$(MAKE) sub-make-done=1 \
+	$(Q)$(MAKE) \
 	$(if $(KBUILD_OUTPUT),-C $(KBUILD_OUTPUT) KBUILD_SRC=$(CURDIR)) \
 	-f $(CURDIR)/Makefile $(filter-out _all sub-make,$(MAKECMDGOALS))
 
 endif # need-sub-make
-endif # sub-make-done
+endif # sub_make_done
 
 # We process the rest of the Makefile if this is the final invocation of make
 ifeq ($(need-sub-make),)
-- 
2.19.1

