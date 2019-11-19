Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFC6C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC5220721
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142843;
	bh=8DD4osZh3pqSw/v3Z8lBeKCbS7/Ml7qR65jLNRSZyrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dqDO+NEZUVovBaYhM7u4zE1zwRWcsS75O701mGhRQPNEpGMY6kDXJGIdf3D9p5jWQ
	 ylOKkWlnPoa3qTBeoocsRc3GxK6kaSxzYrxRPM13MsPR4jRinLFzun7YgxpGjQrGHK
	 5EpTf1n6LmqVSyR54TMRaClFBia3rqfJQUCHMcYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfKSFyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:54:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:52018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732089AbfKSFx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:53:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C323D20885;
        Tue, 19 Nov 2019 05:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142838;
        bh=8DD4osZh3pqSw/v3Z8lBeKCbS7/Ml7qR65jLNRSZyrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q96bbmjN7Y3bMEayGT38i+bj+t5KcfW0GGsmjbsolXUa8uur0Er/UaKRIXLRNLK/A
         V5jDtq59YjapbE8zkNNy3snAOAp1r1uEiivLYMG/d/G8i5PPLVd6MIcnr4jDBe7Msr
         TrVbbkpv6fZ9O03UxNekvyH0KhYqdcVlFt79vZ3U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rachel Mozes <rachel.mozes@intel.com>,
        Dengcheng Zhu <dzhu@wavecomp.com>,
        Paul Burton <paul.burton@mips.com>, pburton@wavecomp.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 177/239] MIPS: kexec: Relax memory restriction
Date:   Tue, 19 Nov 2019 06:19:37 +0100
Message-Id: <20191119051334.361017208@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dengcheng Zhu <dzhu@wavecomp.com>

[ Upstream commit a6da4d6fdf8bd512c98d3ac7f1d16bc4bb282919 ]

We can rely on the system kernel and the dump capture kernel themselves in
memory usage.

Being restrictive with 512MB limit may cause kexec tool failure on some
platforms.

Tested-by: Rachel Mozes <rachel.mozes@intel.com>
Reported-by: Rachel Mozes <rachel.mozes@intel.com>
Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20568/
Cc: pburton@wavecomp.com
Cc: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/kexec.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/kexec.h b/arch/mips/include/asm/kexec.h
index 493a3cc7c39ad..cfdbe66575f4d 100644
--- a/arch/mips/include/asm/kexec.h
+++ b/arch/mips/include/asm/kexec.h
@@ -12,11 +12,11 @@
 #include <asm/stacktrace.h>
 
 /* Maximum physical address we can use pages from */
-#define KEXEC_SOURCE_MEMORY_LIMIT (0x20000000)
+#define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
 /* Maximum address we can reach in physical address mode */
-#define KEXEC_DESTINATION_MEMORY_LIMIT (0x20000000)
+#define KEXEC_DESTINATION_MEMORY_LIMIT (-1UL)
  /* Maximum address we can use for the control code buffer */
-#define KEXEC_CONTROL_MEMORY_LIMIT (0x20000000)
+#define KEXEC_CONTROL_MEMORY_LIMIT (-1UL)
 /* Reserve 3*4096 bytes for board-specific info */
 #define KEXEC_CONTROL_PAGE_SIZE (4096 + 3*4096)
 
-- 
2.20.1



