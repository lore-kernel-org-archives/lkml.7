Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E915C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456FF2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560544420;
	bh=z8hc2If14umpMNWoQq+tqOqn1Cwo7yZ54o2Weu9Fmrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rvZYARG5/gToGYSNvFEX5mpQnIFyXWdCPLQ4Yejs89NX40ODVePX57NZHG/cF07EJ
	 PfqwhIKaropVZX5xlX0qQMJqkvgk3kfdoofqwm+vV2/AHA7DY+GIzW0bJ8/V/gwO5c
	 2fzWqfAtAlQg54I1iNwZoqTU5dZnJtVexy/XDmLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfFNUdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:33:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727617AbfFNUa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:30:27 -0400
Received: from sasha-vm.mshome.net (unknown [131.107.159.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F07A2184C;
        Fri, 14 Jun 2019 20:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560544226;
        bh=z8hc2If14umpMNWoQq+tqOqn1Cwo7yZ54o2Weu9Fmrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uBGf2Fmx7A0ZzOrZgYlXJvaO6WoeG/2kZgFbeOkUNFxxSGQdD+29oyaLTZqy6zq3k
         imnXtWsAkU01YHdPeo+/inW+jk013H1Gzlu+vhfuZw3h585XtDMrWfVhEztARxhF2s
         zVnID3JRNQR/21Tps/nluJ7UN36wOPidbvjdWmdw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-xtensa@linux-xtensa.org
Subject: [PATCH AUTOSEL 4.14 11/27] xtensa: Fix section mismatch between memblock_reserve and mem_reserve
Date:   Fri, 14 Jun 2019 16:30:00 -0400
Message-Id: <20190614203018.27686-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614203018.27686-1-sashal@kernel.org>
References: <20190614203018.27686-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit adefd051a6707a6ca0ebad278d3c1c05c960fc3b ]

Since commit 9012d011660ea5cf2 ("compiler: allow all arches to enable
CONFIG_OPTIMIZE_INLINING"), xtensa:tinyconfig fails to build with section
mismatch errors.

WARNING: vmlinux.o(.text.unlikely+0x68): Section mismatch in reference
	from the function ___pa()
	to the function .meminit.text:memblock_reserve()
WARNING: vmlinux.o(.text.unlikely+0x74): Section mismatch in reference
	from the function mem_reserve()
	to the function .meminit.text:memblock_reserve()
FATAL: modpost: Section mismatches detected.

This was not seen prior to the above mentioned commit because mem_reserve()
was always inlined.

Mark mem_reserve(() as __init_memblock to have it reside in the same
section as memblock_reserve().

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-Id: <1559220098-9955-1-git-send-email-linux@roeck-us.net>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/xtensa/kernel/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index 08175df7a69e..66eefe1919a4 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -310,7 +310,8 @@ extern char _SecondaryResetVector_text_start;
 extern char _SecondaryResetVector_text_end;
 #endif
 
-static inline int mem_reserve(unsigned long start, unsigned long end)
+static inline int __init_memblock mem_reserve(unsigned long start,
+					      unsigned long end)
 {
 	return memblock_reserve(start, end - start);
 }
-- 
2.20.1

