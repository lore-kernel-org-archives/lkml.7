Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687A2C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3576321847
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887820;
	bh=9B51i506uoit8PvzKsp8Hnm676PvlawhR2kOkoqXzLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mXjhrQEVW2jq3Vp7Q+v4mUHfB2CZqbinLgrHUsehk2hrfPf16oQJLxrYqY5Ip9fIk
	 mz0DSrJvFX2GPozOYN7wP9MVOF5o6frll/HB6q4JMGlSMJ2uEgGvSkY/UrHVV4gA/3
	 bAt/aB3FyyUv4xDWqvR1FWBABgY3+9lkMK4T6OzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfK0UuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:50:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:36118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729927AbfK0UuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:50:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5905121847;
        Wed, 27 Nov 2019 20:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887815;
        bh=9B51i506uoit8PvzKsp8Hnm676PvlawhR2kOkoqXzLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=omi2j4pAGFp0JR173ACENYnk56QFyoiERU3N04TQOTGLk7b1ZNX3zrjiqmp2wAWnS
         M42A+HmDSoG2Sx1VPca4N5ojWlpk47vGQqIHCu+nzZKu4pARQSM8ODTaeyPLcDs8yi
         ejtmO1E2uRFkhtbDLb1aWGi60lVBSHbFAWkCm+Eo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 106/211] selftests/powerpc/cache_shape: Fix out-of-tree build
Date:   Wed, 27 Nov 2019 21:30:39 +0100
Message-Id: <20191127203104.016375778@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203049.431810767@linuxfoundation.org>
References: <20191127203049.431810767@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



