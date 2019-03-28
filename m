Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DB4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6F02183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ns6buI0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfC1Ptz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:49:55 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:43833 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfC1Pty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:49:54 -0400
Received: by mail-qk1-f201.google.com with SMTP id m8so17900153qka.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 08:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2/8IdQUIVWJWCZfeigS/jK57K0sOUt/kPhjIPk0zH2o=;
        b=ns6buI0qbB8Dmf6A1cF8CTSKJIGq2prXu1Z2GauCuulb4+fa7azuapUC4ohZX1qu35
         5ggBj8h7Rnahth/tWN5UrOWSmWDXsBpgNV/BgqNkttlUC0GhY8iUQmQXDARslq6vheYH
         8SNkiejHoQzHvOZbackJgNrRtc2/QKi5BeD5sHR8nel7b9+MKaUxEliDtsSiSZ4ClbA8
         yKquXXWF/ssitdNkP2cavMHxDVC3tZqn6Jvat1KKuj25UMIylSGFoE7BIfKwVayTSKd8
         5A3285E2xTZNAruTgy/BthVgaRNo7IcfcHteoG0qwbWpIvyD5d7Ek0Qp9XTYHJfjJAu7
         94Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2/8IdQUIVWJWCZfeigS/jK57K0sOUt/kPhjIPk0zH2o=;
        b=AhWwMOthuU3KhGFzI/uuIFJP0RFokywFBMno6SeD5D5ptzvDXHUDCTLY7U4RqA5zcd
         VV6vWTb2TZhiV3A+RsuxX651GXptzxVZNThMpQD8860nvxcbK1ARJAofKrOiZ/pZfNNK
         cWZPCMScfspXHsbMQfMfcTnj3b+zrm0YifwTCAGRZhuPCB1/zGd4ZktKc4hypzqr7Hwv
         zE4Jn1Nk1dIy7G3EDApLJoQ+QORufRJsXz4kFYGEvO0Io7mhQE+wiK+SNb/n7wTNR5mZ
         10Gl/xuJr9EWYQ6FTBVblXqW9ULoEoxQqgu8Lg51DHng9b6zdjBBBtJR199KVelH5/96
         ZFJQ==
X-Gm-Message-State: APjAAAVL9Aa7dNScLszM5loG09rrJHidLVywsPEwRFR5aEbD2MgR9MQi
        cONI32wkfYgiZ05ZseRVC5x4CWjqWA==
X-Google-Smtp-Source: APXvYqxAQI3nFUvMgh8j7DZYfHWHvsxdncl9P4lQ6wzbUbNFEw2sX03Lxc+3G3iuDccNSefPCsq1gH69yw==
X-Received: by 2002:ac8:341a:: with SMTP id u26mr835519qtb.36.1553788193786;
 Thu, 28 Mar 2019 08:49:53 -0700 (PDT)
Date:   Thu, 28 Mar 2019 16:49:48 +0100
Message-Id: <20190328154948.152273-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] x86/cpufeature: fix __percpu annotation in this_cpu_has()
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, jannh@google.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

&cpu_info.x86_capability is __percpu, and the second argument of
x86_this_cpu_test_bit() is expected to be __percpu. Don't cast the __percpu
away and then implicitly add it again.
This gets rid of 106 lines of sparse warnings with the kernel config I'm
using.

Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/include/asm/cpufeature.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index ce95b8cbd229..0df88893e767 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -113,7 +113,8 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 
 #define this_cpu_has(bit)						\
 	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 : 	\
-	 x86_this_cpu_test_bit(bit, (unsigned long *)&cpu_info.x86_capability))
+	 x86_this_cpu_test_bit(bit,					\
+		(unsigned long __percpu *)&cpu_info.x86_capability))
 
 /*
  * This macro is for detection of features which need kernel
-- 
2.21.0.392.gf8f6787159e-goog

