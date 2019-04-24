Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B80EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DAB2190C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126461;
	bh=2vUkXzwiZvwceuwDRHJCi2E8A0VPYvPLI95wgSnagGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SjVmvo62czQImIem07KQl7fdco+cfXsFIM3B36Jd0haMl+vW8vVSmKpq4mgtSdz2Z
	 vX9DNj0F7mxf5/ZLP7Kq088l4uNZionfqR8YYLPXmkFrS8jcn9U4uZbigQNQ//k0Y3
	 7MURDDgjReb0T8AosUuGc9CGfT2VAqrMrthCGOKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389264AbfDXRVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:21:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388888AbfDXRU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:20:58 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24ABB20675;
        Wed, 24 Apr 2019 17:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126457;
        bh=2vUkXzwiZvwceuwDRHJCi2E8A0VPYvPLI95wgSnagGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QY7P3X/GOwj0o7O1FTNXTSnJVDx7dvPgKuzAkMVwlJOhowr8t6SPngk1kEjFMNUP5
         FsaINdVKBRaSwxVSM4w84ELsWbaQyz7KAzDotwwGeLlSBhg0V6KzwPX59aZXj4Vcjx
         RCO4o0mF16OBw0DZvyasOjF67HEN9C/DMQzy1H7Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        clang-built-linux@googlegroups.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 116/168] x86/hw_breakpoints: Make default case in hw_breakpoint_arch_parse() return an error
Date:   Wed, 24 Apr 2019 19:09:20 +0200
Message-Id: <20190424170930.323441614@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
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
index 2bcfb5f2bc44..433f17d154e2 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -351,6 +351,7 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 #endif
 	default:
 		WARN_ON_ONCE(1);
+		return -EINVAL;
 	}
 
 	/*
-- 
2.19.1



