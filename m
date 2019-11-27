Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6FCC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EAC215F2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889921;
	bh=pDHn+HksLh2BBFaUeCFU7cSKTlRwKXjRdFc2nsgwYLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dPPfOwqqQqcL9iaO7PzmhPWS5u/w1/042faqF/Oavjyy+TGbqdDtAWzBqjTZvUku1
	 OuumHto893JUBXI9OTBiaolqtATtQ/LYw9cl224UqKkU2v0ZdrjW6kFzsJ+RW0l4gP
	 vFLWxAUiZhwHjeDxibV0UY0BRM935/RlVD4TPNTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731803AbfK0VB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:01:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:54354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731789AbfK0VBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:01:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8B20215A4;
        Wed, 27 Nov 2019 21:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888512;
        bh=pDHn+HksLh2BBFaUeCFU7cSKTlRwKXjRdFc2nsgwYLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x2r5qdc1HY+egJZJoG7VA5cDLh10iAVntuAGCA4Ar5MGdQLulW/DEmxoOxfQcPrB8
         PKFOx4k9x7CK6cN3FJgEz6+zLiN/CqnCBIOgYg1H7recDaRWNixXktDb3E2E/w4cz+
         jrRCuZmhu0WjcrZJYwPppZjbUPXueWktpj1acDoM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 163/306] selftests/powerpc/switch_endian: Fix out-of-tree build
Date:   Wed, 27 Nov 2019 21:30:13 +0100
Message-Id: <20191127203127.374696406@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 266bac361d5677e61a6815bd29abeb3bdced2b07 ]

For the out-of-tree build to work we need to tell switch_endian_test
to look for check-reversed.S in $(OUTPUT).

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/powerpc/switch_endian/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/powerpc/switch_endian/Makefile b/tools/testing/selftests/powerpc/switch_endian/Makefile
index fcd2dcb8972ba..bdc081afedb0f 100644
--- a/tools/testing/selftests/powerpc/switch_endian/Makefile
+++ b/tools/testing/selftests/powerpc/switch_endian/Makefile
@@ -8,6 +8,7 @@ EXTRA_CLEAN = $(OUTPUT)/*.o $(OUTPUT)/check-reversed.S
 top_srcdir = ../../../../..
 include ../../lib.mk
 
+$(OUTPUT)/switch_endian_test: ASFLAGS += -I $(OUTPUT)
 $(OUTPUT)/switch_endian_test: $(OUTPUT)/check-reversed.S
 
 $(OUTPUT)/check-reversed.o: $(OUTPUT)/check.o
-- 
2.20.1



