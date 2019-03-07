Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2345C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3F320684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caYHqgSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfCGV2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:28:19 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35865 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCGV2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:28:18 -0500
Received: by mail-ed1-f65.google.com with SMTP id g9so14731278eds.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 13:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KLsZ2PTpOID17VWfknh/BsdEBNNxq4yzb/dwENnabik=;
        b=caYHqgSG60kUfebf8AV0B+VCGTkvsx3jliKsl79dbbk0p7vQXOILtpneFvc6599CcR
         hYUnRoTbm7TzDsczW59FihyAorgHCw8RoGpAup52QZupHLc2I6uxkXX7y848qbAo0+h2
         fGQ5XBKRvIPle5HE/xiCpDJhz3coY0CrBl/0FULxg4ahOcWdBGyU6/DXnRWpW0mtGaPA
         4OIbY1yvzxL/ZVQN51ymtiGz2VOamUXNI1tCuQlNRZqSmsAHzABBSbtarnqoROOF5p+t
         KifoQ/ap2cr6G9diMZo3eCe8+jX3Wah5+I5bjAcCf05DGl310PEW5rXk9wSecI4UE4xl
         Spvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KLsZ2PTpOID17VWfknh/BsdEBNNxq4yzb/dwENnabik=;
        b=XTgVv/5wnTmy+vNv8vND5cbfzq/+DKCRlFfH39+D556mC0IwDpQbcEeBtEch91KerR
         7mYQ9bp10Qu8syswDLhP7ecCCjRzbskg3kT1BtY3JJG2ioBC8ZaswHi8MRvZNg+9R+b6
         oBxdK8xS7whIw7d7pC31vzRxurtsgUiZkF30jBxrGnSu+WFdplyWkfaen5p0peu39a6e
         8lpZzBoMwz4xRTAMA5WFdw4ncmwAHbWwjppRlzHAl98B8SMSPivG/JVBFwY8OZe9kBaB
         P8s/9BDRYlf9r9t/X6fVTqTgDanQoZJJUkBzDl78AJJjLN3IizxiTqAerfHuUa5UyDkB
         QO8g==
X-Gm-Message-State: APjAAAXyp0X3Fsu6zYtDLVgBXjyu4booyDfSM+SU0bgoK6vgMME0FxPC
        88hHNy8YdVcjPifQuecHzhA=
X-Google-Smtp-Source: APXvYqzMpAKo4Ksv3cmQLX3fakTVs22wCT6n3eX6OlelUd+rP39qSAGmdJfRcrNMnwTbZhueH+VUZg==
X-Received: by 2002:aa7:d987:: with SMTP id u7mr29145246eds.194.1551994096740;
        Thu, 07 Mar 2019 13:28:16 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id a51sm1654713edd.57.2019.03.07.13.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 13:28:15 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] x86/hw_breakpoints: Return -EINVAL in default case in hw_breakpoint_arch_parse
Date:   Thu,  7 Mar 2019 14:27:56 -0700
Message-Id: <20190307212756.4648-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Wsometimes-uninitialized, Clang warns:

arch/x86/kernel/hw_breakpoint.c:355:2: warning: variable 'align' is used
uninitialized whenever switch default is taken
[-Wsometimes-uninitialized]

It's not wrong but we can see that arch_build_bp_info will only ever
initialize hw->len to one of the specified switch cases. We can easily
silence Clang by just returning -EINVAL in the default case so that we
can never use align without initializing it first.

Link: https://github.com/ClangBuiltLinux/linux/issues/392
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/x86/kernel/hw_breakpoint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index ff9bfd40429e..d73083021002 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -354,6 +354,7 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 #endif
 	default:
 		WARN_ON_ONCE(1);
+		return -EINVAL;
 	}
 
 	/*
-- 
2.21.0

