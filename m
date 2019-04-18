Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE06C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209FD206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610951;
	bh=0UPkEvrKYdCW8jnBQghSe4seVAjovMENmuWztmSbG5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tQPn1ZI+VeLvMChZ0xmEnmlPOquoSGMNNs8kVHemWenFZynJGVwvvsFn4bQliG7Kn
	 UqM4byLaG4THbaNSHVO9ysLlWJ3QKSWPrGVKqfSUL93RCm3zX8D/w4gPrgHApyQHBr
	 IkzC1dzgb/32DJaMZYTE3p6+eBdnqjj+j/rri8nI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391845AbfDRSJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:09:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391533AbfDRSJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:09:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 254D121871;
        Thu, 18 Apr 2019 18:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610946;
        bh=0UPkEvrKYdCW8jnBQghSe4seVAjovMENmuWztmSbG5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=17uHAjykmSAEMIM0TpURzlCgjo5JcisSRgdMyq8osvQvb0ly0IVokAFlQBsyBnB9l
         0hiYxHFrSutY+6lQe6j5TuicYyGKyVugTDappVViDNrL3faqUTEOhUm5Ry2SfLVCQW
         M3ywr9qt1zWx6TtVR8C6dZrgMhc2W8B0CeKnlJRY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        clang-built-linux@googlegroups.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 25/50] x86/hw_breakpoints: Make default case in hw_breakpoint_arch_parse() return an error
Date:   Thu, 18 Apr 2019 19:57:36 +0200
Message-Id: <20190418160425.866241024@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160422.455656724@linuxfoundation.org>
References: <20190418160422.455656724@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 8771766d46b6..9954a604a822 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -352,6 +352,7 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 #endif
 	default:
 		WARN_ON_ONCE(1);
+		return -EINVAL;
 	}
 
 	/*
-- 
2.19.1



