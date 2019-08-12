Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17619C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE482070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fAfaiSlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfHLVvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:51:24 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:40684 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfHLVvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:51:23 -0400
Received: by mail-pl1-f201.google.com with SMTP id s13so6011087plp.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 14:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VzbGHvSiySq50YMMXV5wIRss5YK1rFgm4/UGnmN70Bc=;
        b=fAfaiSlH3IJrNJyZYLgYtoIVY8VZlqGfi5Z1XEd34Hclac8Tlt1XU022vSoo6lpHqW
         WT5ZYdOnF51c3AJ+HgQLgSxq1DFgNbpPZFxvoOpgOi8CLocNEf/zT6VX0F2CI56S+DGU
         emR9pGJLtKNGCGQGSx/vmN9VKkZcYZVXI6eXGk1DQEFDNeHCD/bdYD6Zet1y/2Gzi9uE
         yf/jN+kbTfyFtb4u9PsKcmr7JPvUHlj3Oa0vtajMh2hl9bXBiepZSxxAR7vIHlyXgTiy
         3qSQ1ycRcwY27pQbPVEKnAVbB3qlQm8NnHi8Ju6BN+Yoi5wFlqrTPtF5AwdB6r/eozZn
         AJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VzbGHvSiySq50YMMXV5wIRss5YK1rFgm4/UGnmN70Bc=;
        b=Gbf3ux6UgSyCO2vJETA40hh6IMCtcmuA2KekA9B+8g07lrF1Y3bXRwcxn90JGYJqPQ
         X8dXCDjikRC2zFBcBjoj39IDiofQaFgG+GfsMKUb+8UlZqqejfemET0gzUxsjBmMpJWk
         i++7UQnAtkzbOpmd6ErsDTk0FFMA3kTl40cwAPRSquPIg+ua7urVi1gxpnKbkx69k1Qq
         lnymK/OjjGHVmWSPds/sIax+znQ05GGhR0i1J8CAJtI5yZcri9EM8ljN67hqCNq05hzh
         NLLFS3Vl8tEnN+Qt3OMPmyXj/NuOUQuo1KDKu9uYJAiFaHE4cLkHNCeAKeoaNND6KBmq
         FiWQ==
X-Gm-Message-State: APjAAAWEXAJgb2NfdzSUPdYmCIBE8Z6c/7PnNQJ33Lct4GSnOMgGoPda
        aH2OrAEuOspYbsmIF0UOWkdMtGcFVpxeYIiCAhM=
X-Google-Smtp-Source: APXvYqxzQCyThBwBKrfD6856yni3bdzA7zdg2TImP8qBYmAZ8RHmc6ZzA/B5OR4SphKOBUyy2O28WZ+h0SMYwe93/kc=
X-Received: by 2002:a63:2685:: with SMTP id m127mr31628780pgm.6.1565646682512;
 Mon, 12 Aug 2019 14:51:22 -0700 (PDT)
Date:   Mon, 12 Aug 2019 14:50:34 -0700
Message-Id: <20190812215052.71840-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH 01/16] s390/boot: fix section name escaping
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     akpm@linux-foundation.org
Cc:     sedat.dilek@gmail.com, jpoimboe@redhat.com, yhs@fb.com,
        miguel.ojeda.sandonis@gmail.com,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC unescapes escaped string section names while Clang does not. Because
__section uses the `#` stringification operator for the section name, it
doesn't need to be escaped.

This antipattern was found with:
$ grep -e __section\(\" -e __section__\(\" -r

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/s390/boot/startup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index 7b0d05414618..26493c4ff04b 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -46,7 +46,7 @@ struct diag_ops __bootdata_preserved(diag_dma_ops) = {
 	.diag0c = _diag0c_dma,
 	.diag308_reset = _diag308_reset_dma
 };
-static struct diag210 _diag210_tmp_dma __section(".dma.data");
+static struct diag210 _diag210_tmp_dma __section(.dma.data);
 struct diag210 *__bootdata_preserved(__diag210_tmp_dma) = &_diag210_tmp_dma;
 void _swsusp_reset_dma(void);
 unsigned long __bootdata_preserved(__swsusp_reset_dma) = __pa(_swsusp_reset_dma);
-- 
2.23.0.rc1.153.gdeed80330f-goog

