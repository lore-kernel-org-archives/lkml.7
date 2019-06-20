Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15411C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E090820675
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054648;
	bh=Hh+/0dLR3lXaoa/X7xixagvLxOl2uk4rmHTiPO7TSgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vkyhV0cybiXmr46K/Ud3bVcxNRg3/6Sr4TzYIaeKanHkqzsnZnIG7W9B+td5zBTe/
	 QrWeWLeYbhMVyeImlEzkO+w2ZduR1ioZ8HmUb8CfJiGzz5kr5cj0UqZKNmzcLx90hf
	 83QVSSukLYf8kpoYdCl7oI+PEge7Vxme8inj/teU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbfFTSR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:17:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729916AbfFTSRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:17:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7B922089C;
        Thu, 20 Jun 2019 18:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054642;
        bh=Hh+/0dLR3lXaoa/X7xixagvLxOl2uk4rmHTiPO7TSgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0+hF3n2KU880f5ogHu2bgrBKGHCMh2UogXZ4kIUDQauJyCTOmT4gYoA714fDP8mTt
         +FcYDj8AUnx8jFfZh09aJ14UmABQsDl2/ySREowq5ekEri5XBXwwUX+un6DPbAZhwu
         9BSHaT7My8Q6Nj3wyEbIe897dEi6fpeubZz9RWtc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 79/98] arm64: fix syscall_fn_t type
Date:   Thu, 20 Jun 2019 19:57:46 +0200
Message-Id: <20190620174353.242096782@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174349.443386789@linuxfoundation.org>
References: <20190620174349.443386789@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index a179df3674a1..6206ab9bfcfc 100644
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



