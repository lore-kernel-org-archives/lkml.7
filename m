Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADDACA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494342087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L6nedrmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfJaQrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:47:06 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:36528 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728900AbfJaQrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:47:03 -0400
Received: by mail-yw1-f73.google.com with SMTP id r64so4897830ywb.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 09:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ISQCDuiClH+Ob0sv0IF5h/3w79WcDO0VBPNi/N63ddM=;
        b=L6nedrmEU6JvkHcsnA5dyzyzZUdFX15pwpo+PGFFiFEz0adILiGuaSNCBEk5zwayGV
         E9E9rgsrq5/1A2h2MtticPSYVLesH41cnymaor0lAwHnDlDWxTf5/4qQBQJbY1uWFtLZ
         C6sr+tdm50IQTwMHAjyoVlcXkjLcFiHznGojckMYMtDoi/bOtSH0IlV0Tnioy87094XS
         ezKAXvoCEbuRluKXTl7DxPY8VwUTSt5guCPWasnZX2NkFzFDs5i1SJLDNnu+b65KtE/0
         /kLy//TY9FnsnLxzNsp6fluwupXbn29fiFnAO1x5t8/AaHOuDntvEDf7xlit3hYA7ljG
         EZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ISQCDuiClH+Ob0sv0IF5h/3w79WcDO0VBPNi/N63ddM=;
        b=lpdlkkMagkJmSIgDS1NRo0s2nV9IDnv9U1uFHwTLxvCrPtkQ3wwLdmoIT3aSx1sYxx
         ajd54g1vTlmZLWJVBBwQIR35SDRFrMH7UJiwm0gC/jUAktvXk5xdYkaiJlI94qMSdfKq
         AyQJqx7VwNqHOUHlJc1P8Yjv+o9pPOINCOq4VaacHPFMZhwipuOHdMZlPa9Zn1ZMnRLU
         F2d5zCsugGlWp3JNx5OdfdoeLWg6nxTrnBPzlYb21cvGXueqc2tB46AcCP8SxxGKJArF
         buGFPBPG2Haa9PHRUaFl9LfoeIfX/2c1EAeV2b4TI2i9J9xDcUQpMdnTxHOuNweA7NEg
         Pmhg==
X-Gm-Message-State: APjAAAWNK5r+XKrZ4cp+vWIDJBR6OtKvKK8SeHYz17d1Gv8fdVZfsbEw
        QAI4boBXBGaJolW98j4dl/itBXX+9/Gl86cOsZg=
X-Google-Smtp-Source: APXvYqylBnOlY6J5yphs6OUfcffeYpoUMccmhuKdcTOrwjC05s5MJ0bhS5H4FPPnPRXOHEgt796GjMyXraMpNUfDtLU=
X-Received: by 2002:a0d:e987:: with SMTP id s129mr5018878ywe.111.1572540422670;
 Thu, 31 Oct 2019 09:47:02 -0700 (PDT)
Date:   Thu, 31 Oct 2019 09:46:27 -0700
In-Reply-To: <20191031164637.48901-1-samitolvanen@google.com>
Message-Id: <20191031164637.48901-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191031164637.48901-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v3 07/17] scs: add support for stack usage debugging
From:   samitolvanen@google.com
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implements CONFIG_DEBUG_STACK_USAGE for shadow stacks.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/scs.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/kernel/scs.c b/kernel/scs.c
index 7780fc4e29ac..67c43af627d1 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -167,6 +167,44 @@ int scs_prepare(struct task_struct *tsk, int node)
 	return 0;
 }
 
+#ifdef CONFIG_DEBUG_STACK_USAGE
+static inline unsigned long scs_used(struct task_struct *tsk)
+{
+	unsigned long *p = __scs_base(tsk);
+	unsigned long *end = scs_magic(tsk);
+	uintptr_t s = (uintptr_t)p;
+
+	while (p < end && *p)
+		p++;
+
+	return (uintptr_t)p - s;
+}
+
+static void scs_check_usage(struct task_struct *tsk)
+{
+	static DEFINE_SPINLOCK(lock);
+	static unsigned long highest;
+	unsigned long used = scs_used(tsk);
+
+	if (used <= highest)
+		return;
+
+	spin_lock(&lock);
+
+	if (used > highest) {
+		pr_info("%s: highest shadow stack usage %lu bytes\n",
+			__func__, used);
+		highest = used;
+	}
+
+	spin_unlock(&lock);
+}
+#else
+static inline void scs_check_usage(struct task_struct *tsk)
+{
+}
+#endif
+
 bool scs_corrupted(struct task_struct *tsk)
 {
 	return *scs_magic(tsk) != SCS_END_MAGIC;
@@ -181,6 +219,7 @@ void scs_release(struct task_struct *tsk)
 		return;
 
 	WARN_ON(scs_corrupted(tsk));
+	scs_check_usage(tsk);
 
 	scs_account(tsk, -1);
 	task_set_scs(tsk, NULL);
-- 
2.24.0.rc0.303.g954a862665-goog

