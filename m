Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B841C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AB3206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907277;
	bh=RzAtCefQ3OD6Q8QN7QVo/Tz6csJDHqpBNS3hw4q8h/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K3rJKOU7mkojL3i+h2Z+bBx0icp8LCcEv0adXNv0sPtrGsJMLoDOZo+SXi4zT60Vp
	 bY9qan6gFaiwjwtgubo8M2aUHiEJLPz5xGcMMTe5KARkQh3+y94fLUokfNyYEi5yEf
	 /ALmfWf/ifRb6+Aph5bLe5I+uMzqjhTuvif3gxBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbfC3Ayf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:54:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731540AbfC3Ayb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:54:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39721218CD;
        Sat, 30 Mar 2019 00:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907271;
        bh=RzAtCefQ3OD6Q8QN7QVo/Tz6csJDHqpBNS3hw4q8h/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h/RnBBllXTE5tss2oDlGuzmwuLSibhm3daQw1AsPliG+FYSeTSf9YnoSwUnnHuGOI
         ZlfgUD8QgnkkTqazwPpPVaZTl1jFTBv1xZsMhGEx3wdydy779eWtk777QOEpcsn/n1
         sIvMPeFzQZh4i0VoSNUHYODh/NLOF1KrxFsULYe8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        clang-built-linux@googlegroups.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 49/52] x86/hw_breakpoints: Make default case in hw_breakpoint_arch_parse() return an error
Date:   Fri, 29 Mar 2019 20:52:56 -0400
Message-Id: <20190330005301.26868-49-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005301.26868-1-sashal@kernel.org>
References: <20190330005301.26868-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit e898e69d6b9475bf123f99b3c5d1a67bb7cb2361 ]

When building with -Wsometimes-uninitialized, Clang warns:

arch/x86/kernel/hw_breakpoint.c:355:2: warning: variable 'align' is used
uninitialized whenever switch default is taken
[-Wsometimes-uninitialized]

The default cannot be reached because arch_build_bp_info() initializes
hw->len to one of the specified cases. Nevertheless the warning is valid
and returning -EINVAL makes sure that this cannot be broken by future
modifications.

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: clang-built-linux@googlegroups.com
Link: https://github.com/ClangBuiltLinux/linux/issues/392
Link: https://lkml.kernel.org/r/20190307212756.4648-1-natechancellor@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/hw_breakpoint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 34a5c1715148..2882fe1d2a78 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -357,6 +357,7 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 #endif
 	default:
 		WARN_ON_ONCE(1);
+		return -EINVAL;
 	}
 
 	/*
-- 
2.19.1

