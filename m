Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72D2C43141
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8426D20874
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920574;
	bh=9B51i506uoit8PvzKsp8Hnm676PvlawhR2kOkoqXzLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=svzT2cKmPFLGrPOsdL+VKSqjDwRcp8Tp5aK/fiE9L1AFll0wC1rzpTLEgNgAGy5fa
	 dUqhsakdnk/GplR9n3SkNlRCZMBcAVxq+KnNQ6xyLrwh9aTpGJz02VNmyzwt/2QtV+
	 JOZ2C4LS2Z5WJ1WGbg2us12qcJU9S9E4ZrKS6Iew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbfKPPtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:49:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:57208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728815AbfKPPtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:49:33 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33F9A20895;
        Sat, 16 Nov 2019 15:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919373;
        bh=9B51i506uoit8PvzKsp8Hnm676PvlawhR2kOkoqXzLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nX2O6OwdqasLwJ4lGVUxeO6mAjfHhofzRl5v7H6JOM4Jy5p4APYhZYFDQyFQnvL4q
         ZSf+7mZntz6XWI1xuagsAI94Mc67syN0151iyVZVpwsGq9Cs/ENGMAmMPdFqhbrzMo
         D0PMlg97RSCtQW2oSlUAp4k9a5yMQKIedSZFG52s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 092/150] selftests/powerpc/cache_shape: Fix out-of-tree build
Date:   Sat, 16 Nov 2019 10:46:30 -0500
Message-Id: <20191116154729.9573-92-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154729.9573-1-sashal@kernel.org>
References: <20191116154729.9573-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 69f8117f17b332a68cd8f4bf8c2d0d3d5b84efc5 ]

Use TEST_GEN_PROGS and don't redefine all, this makes the out-of-tree
build work. We need to move the extra dependencies below the include
of lib.mk, because it adds the $(OUTPUT) prefix if it's defined.

We can also drop the clean rule, lib.mk does it for us.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/powerpc/cache_shape/Makefile | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/powerpc/cache_shape/Makefile b/tools/testing/selftests/powerpc/cache_shape/Makefile
index 1be547434a49c..7e0c175b82978 100644
--- a/tools/testing/selftests/powerpc/cache_shape/Makefile
+++ b/tools/testing/selftests/powerpc/cache_shape/Makefile
@@ -1,11 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-TEST_PROGS := cache_shape
-
-all: $(TEST_PROGS)
-
-$(TEST_PROGS): ../harness.c ../utils.c
+TEST_GEN_PROGS := cache_shape
 
 include ../../lib.mk
 
-clean:
-	rm -f $(TEST_PROGS) *.o
+$(TEST_GEN_PROGS): ../harness.c ../utils.c
-- 
2.20.1

