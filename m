Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4055DC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162D1214DA
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559994346;
	bh=2OsoB8m9Gzt3yzqnapTW350BeoFyLj5MY7DLQ9WyQl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Eva1gOjV7cgqJC8CLCywlioY3avFQw/QT+yErSrz2DyEh2Up6cjMCbW5QcbxhXap1
	 Aah6sNUT6krLcI8P14J+JUpxpTQeZBAEyJFRH5whu8SNj/pAgiFzxwNbzl/HnENWvl
	 RCKkQNu7SRKGC9RtObclIMD8RPApnwNZg0cY/wCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfFHLpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:45:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728866AbfFHLpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:45:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8543214D8;
        Sat,  8 Jun 2019 11:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559994340;
        bh=2OsoB8m9Gzt3yzqnapTW350BeoFyLj5MY7DLQ9WyQl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kXkR8Fmik1AaLCrxZHSEH91eNfQP5QYJrhmYs49Kj1rXl7qJfy/axOfrfGjT03Hry
         /30Vx4lX/OW3ipADyrJfL85I8XgRnTMGOfPdy6LGvOA2KNTmTqRbS5xPTrgjre6iUa
         ALf+fSUFqty1DCChMuc4yRFrye0ZypAfS2G/8Jyo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 38/49] arm64: fix syscall_fn_t type
Date:   Sat,  8 Jun 2019 07:42:19 -0400
Message-Id: <20190608114232.8731-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190608114232.8731-1-sashal@kernel.org>
References: <20190608114232.8731-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sami Tolvanen <samitolvanen@google.com>

[ Upstream commit 8ef8f368ce72b5e17f7c1f1ef15c38dcfd0fef64 ]

Syscall wrappers in <asm/syscall_wrapper.h> use const struct pt_regs *
as the argument type. Use const in syscall_fn_t as well to fix indirect
call type mismatches with Control-Flow Integrity checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/syscall.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index ad8be16a39c9..58102652bf9e 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -20,7 +20,7 @@
 #include <linux/compat.h>
 #include <linux/err.h>
 
-typedef long (*syscall_fn_t)(struct pt_regs *regs);
+typedef long (*syscall_fn_t)(const struct pt_regs *regs);
 
 extern const syscall_fn_t sys_call_table[];
 
-- 
2.20.1

