Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D58C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC262339E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HX5fMmMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfH1W4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:56:03 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:38894 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfH1W4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:56:01 -0400
Received: by mail-qk1-f201.google.com with SMTP id l64so1645183qkb.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 15:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Zg0X84lAW+jskRxv7RHMWautXvu8YhPHY9Jy+iSuQjU=;
        b=HX5fMmMuEEYiCC+kRp4pc9Noj2nY0gtJookY+HnsuC0mXP+Kpmrhc51OO/nr8AbUBU
         2JQeYXHoL+Q90dzJNfxKt1snDKKVrxKWTGVvY65zFmruqz8hJMR+8L0ijFwkTNGBOas+
         ZhmuebpDc6CG/EHVSgNFTYDscfBzeKeHsYuNePRiKLlErztkDeVuqPxy/2KV8r9DBf2l
         m64FPQGSujdzeeeO1A+1r5G9PdHaNAwlZOrcwXDQH/QX1vzPQmBylP09k0Ply+xaQ9J/
         KV/Acv/+IJICMJhT7i0vVWsqoooa2WlGa1IpXoIUKzLpwGn8rBQg8Hk6kOHhY5n5sKvZ
         h5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Zg0X84lAW+jskRxv7RHMWautXvu8YhPHY9Jy+iSuQjU=;
        b=CSnIIoYCf6p8BkQtlPIrKBMEqUw14jELymY0gZeMb8Cwq/Q8rwuQyWPuCmXF/akTX2
         N0GBt0+qf9BUb+BDh69DuM8GkWEzE9hYOmbvzUm6Sl9MmtlxyIObksc7JD5JP04M31m7
         U7kMoaUQcJltavpKqpwRvncDLOg7dJK87afLZOOSTcpwJ9R2JpLvBgCIsNN+K0giB9Fh
         Bpndjysmq/hk6JjB1RnNOpMlPTGcE3LKwIbb7oSGh6vxvYwWBAk/wlMtDeyc0YiDW8iw
         HFJqgzVzvgpX8Ha+h47TKi/ENYaUk3qMYWIzKalbk6rSAvlmEXcvXJdrdDLEo0y9kk1g
         eWIg==
X-Gm-Message-State: APjAAAWizX30FjhNqTnK24ApcZfJ7eCdYwDmz1xW6MJFcJ40045LnxQm
        QwIffCFA8MfUtMLwn114MaH4B+1qRp8E6X7/mkQ=
X-Google-Smtp-Source: APXvYqyKJD2WIhJboov3y1pn4kD8Kt1yMxBU5meeqweAf29Li5tjLu8wPW9JcN7Dyr29WJjeg2SEZx2cNjjz/sAMJDo=
X-Received: by 2002:a0c:ea89:: with SMTP id d9mr4725816qvp.16.1567032960447;
 Wed, 28 Aug 2019 15:56:00 -0700 (PDT)
Date:   Wed, 28 Aug 2019 15:55:22 -0700
In-Reply-To: <20190828225535.49592-1-ndesaulniers@google.com>
Message-Id: <20190828225535.49592-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190828225535.49592-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 01/14] s390/boot: fix section name escaping
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     miguel.ojeda.sandonis@gmail.com
Cc:     sedat.dilek@gmail.com, will@kernel.org, jpoimboe@redhat.com,
        naveen.n.rao@linux.vnet.ibm.com, davem@davemloft.net,
        paul.burton@mips.com, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC unescapes escaped string section names while Clang does not. Because
__section uses the `#` stringification operator for the section name, it
doesn't need to be escaped.

Instead, we should:
1. Prefer __section(.section_name_no_quotes).
2. Only use __attribute__((__section__(".section"))) when creating the
section name via C preprocessor (see the definition of __define_initcall
in arch/um/include/shared/init.h).

This antipattern was found with:
$ grep -e __section\(\" -e __section__\(\" -r

See the discussions in:
Link: https://bugs.llvm.org/show_bug.cgi?id=42950
Link: https://marc.info/?l=linux-netdev&m=156412960619946&w=2
Link: https://github.com/ClangBuiltLinux/linux/issues/619
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
2.23.0.187.g17f5b7556c-goog

