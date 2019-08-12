Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EB9C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356D22070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vd9nPvrN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfHLVvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:51:33 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:55249 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLVvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:51:32 -0400
Received: by mail-qk1-f202.google.com with SMTP id x28so17908570qki.21
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 14:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0kDIUkQq74jS4s3L5upJ2sLFeJ4SQuXmh/iJl/tNzO8=;
        b=Vd9nPvrNsnO4tVGqvUzBIbfckrBlSRoUQ71ZP+FzvSNKEEhOuE681rboi5PXi4jYKq
         OY9v/yyXkJSEFM/SFETSH27C/UkgCU3JxUKwGMAyYh9yeqjjz6rNOCU2ceXdMw1LXfKW
         g4w1vs3y/w7FDQN3p1HEMS9FL8JXrsYqipn6zsbCxWPVF3CVt2wNKj/vkLmdJN+lktgz
         Us3tD4wd8wXVBIiHWmvQvmYWMeiU0jbuHcm0RVbTzPkoi7lBNBkyEiPNtaHoNNV0G/tW
         XFNS1krIhOH1G3jmt6d25VJw3BxZh00zqfGqlcb2OKw6p8kV57c1U99uFLWS4v8K9ikH
         DoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0kDIUkQq74jS4s3L5upJ2sLFeJ4SQuXmh/iJl/tNzO8=;
        b=m2fbZjTrY7TpHHtvN1ro0d+C4d36Iw6ZVtED4T0O9RtZDQXpjOxa8ZxPclAN11adyj
         /KMrsV9Gw7fOU5Co+0d+T0e7uyCOCQ01gL3tnGp+G4Vi85y37cjkvL2Bu86aeCG958fn
         A0/AAkomNqgT1LQ1fCH1scV9wiKpyeTRiwCuSSjVEqPW4Ww4SbYf6447+wVaZNn8MQiN
         UYPlUmzitVo42Sake72BFHBHwPqmK6xQkmCB6Kehekcsk02aPG7ku8rhikWvte9M5M14
         Hd+A2cEkHWZr3GVwns/3sDIp2qsYvWwa9XnMysD8VWd/CNDdYWb/U6knRfSbjrcBA3gh
         hs4A==
X-Gm-Message-State: APjAAAWrSkPnbQ4TqHhH7akwc6nCYEONh7DZ28r7kbb0LIiiqTmuU6xw
        VIxdzs4hFWBsT9kR5k2lWcQNwmthDUA3VjA+vN8=
X-Google-Smtp-Source: APXvYqzL9xoTa/IdedF1+fdf+8hstnyQibM73dfz4z6AyFXi+Fk60+vxTXikoA1YWpjXQrwItkwSdl3qBiQqejvfMUA=
X-Received: by 2002:a0c:af33:: with SMTP id i48mr31608806qvc.185.1565646691285;
 Mon, 12 Aug 2019 14:51:31 -0700 (PDT)
Date:   Mon, 12 Aug 2019 14:50:35 -0700
In-Reply-To: <20190812215052.71840-1-ndesaulniers@google.com>
Message-Id: <20190812215052.71840-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190812215052.71840-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH 02/16] arc: prefer __section from compiler_attributes.h
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     akpm@linux-foundation.org
Cc:     sedat.dilek@gmail.com, jpoimboe@redhat.com, yhs@fb.com,
        miguel.ojeda.sandonis@gmail.com,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arc/include/asm/linkage.h   | 8 ++++----
 arch/arc/include/asm/mach_desc.h | 3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arc/include/asm/linkage.h b/arch/arc/include/asm/linkage.h
index a0eeb9f8f0a9..d9ee43c6b7db 100644
--- a/arch/arc/include/asm/linkage.h
+++ b/arch/arc/include/asm/linkage.h
@@ -62,15 +62,15 @@
 #else	/* !__ASSEMBLY__ */
 
 #ifdef CONFIG_ARC_HAS_ICCM
-#define __arcfp_code __attribute__((__section__(".text.arcfp")))
+#define __arcfp_code __section(.text.arcfp)
 #else
-#define __arcfp_code __attribute__((__section__(".text")))
+#define __arcfp_code __section(.text)
 #endif
 
 #ifdef CONFIG_ARC_HAS_DCCM
-#define __arcfp_data __attribute__((__section__(".data.arcfp")))
+#define __arcfp_data __section(.data.arcfp)
 #else
-#define __arcfp_data __attribute__((__section__(".data")))
+#define __arcfp_data __section(.data)
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arc/include/asm/mach_desc.h b/arch/arc/include/asm/mach_desc.h
index 8ac0e2ac3e70..73746ed5b834 100644
--- a/arch/arc/include/asm/mach_desc.h
+++ b/arch/arc/include/asm/mach_desc.h
@@ -53,8 +53,7 @@ extern const struct machine_desc __arch_info_begin[], __arch_info_end[];
  */
 #define MACHINE_START(_type, _name)			\
 static const struct machine_desc __mach_desc_##_type	\
-__used							\
-__attribute__((__section__(".arch.info.init"))) = {	\
+__used __section(.arch.info.init) = {			\
 	.name		= _name,
 
 #define MACHINE_END				\
-- 
2.23.0.rc1.153.gdeed80330f-goog

