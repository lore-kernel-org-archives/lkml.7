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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E890C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F0F233A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K8RHoPgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfH1W4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:56:37 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:39731 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbfH1W4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:56:34 -0400
Received: by mail-qt1-f201.google.com with SMTP id z15so1409081qtq.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 15:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LzcRbLdLn8n10++XwDQc5vyYA3PF12gHibA7BtY6a0Q=;
        b=K8RHoPgM+mJAwqXlvEcSR/kuV73Nvjs0NviMvA+6/v0063urVipIsN+d8mlpENBRzA
         AIukuHkBYMxwEyNRQHbmPq/nktcLZUEzaTIHtmSEaLFMToKN8Bxjr+nWG4R2tJ/LnYOt
         9n/pUgMBMpf76Jt7D0dXCQVThxHNybR+6+omky9JLxGLVpYxP/GO535I3f3GaQzlOCj1
         pSVTjTbhZVosKLfoak/7Vdf4TFkOQCAFvrWNPlLcI0gT+Q0otmxwA3geurBCbjcyHt3S
         h/BlerhzfZusOFatfX7QUJX5mAIdGff06HBCjzEfOmhXm4JitbWIVjIz8ABXnaCNrW7S
         /Mag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LzcRbLdLn8n10++XwDQc5vyYA3PF12gHibA7BtY6a0Q=;
        b=GAXtC+k4Qfx+gQqAEi+VgCVUCxah0l8DBzCyc7uTQJGOD/8YuacNxTJliAQZC3n4N7
         Ctj3Tn7MYHFT3pU8zPbOJXz2kAKAlusRUkIjW0HmsVdYBragwY8dLn+KMbtnqbNxrnIt
         8A+D7cn4hBglHxCcqebZraXX2skVubP+ic3EpOnpeYp3OS6xbV4Qb7xZMjLW2vsS2vGO
         gkzlpox7zFpD5Be/ygBw5ztQ6P/ddMzK5Qhajw6abwb0MWbxFFdzKcB8C/RjW45uQMOP
         thwQcJFeq7jvEnzkGgiBf7oe0y0Mi1pd94q3t5C+OW+uev5WtTFRqkF5JjRrCnKA9nho
         oX+w==
X-Gm-Message-State: APjAAAXTSXDZwbiqc2IglyJgG72QcQOmPrKOT6bkA2lTp3lk2o4ZGk5i
        DTzPWWQdv8M+QZRz6Da4FZxY2gcaQYqM1Oeb4/Q=
X-Google-Smtp-Source: APXvYqyUBnKnhLJrMSEh/bBPW4Fbssoyu1ReOCoNelzrlzhIFs2+9XpsstFpbNIT7qW6T9s0F3unpGFROlV0128fBy4=
X-Received: by 2002:a05:620a:130d:: with SMTP id o13mr6782091qkj.285.1567032993987;
 Wed, 28 Aug 2019 15:56:33 -0700 (PDT)
Date:   Wed, 28 Aug 2019 15:55:35 -0700
In-Reply-To: <20190828225535.49592-1-ndesaulniers@google.com>
Message-Id: <20190828225535.49592-15-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190828225535.49592-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 14/14] compiler_attributes.h: add note about __section
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
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/compiler_attributes.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 6b318efd8a74..f8c008d7f616 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -225,6 +225,16 @@
 #define __pure                          __attribute__((__pure__))
 
 /*
+ *  Note: Since this macro makes use of the "stringification operator" `#`, a
+ *        quoted string literal should not be passed to it. eg.
+ *        prefer:
+ *        __section(.foo)
+ *        to:
+ *        __section(".foo")
+ *        unless the section name is dynamically built up, in which case the
+ *        verbose __attribute__((__section__(".foo" x))) should be preferred.
+ *        See also: https://bugs.llvm.org/show_bug.cgi?id=42950
+ *
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-section-function-attribute
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-section-variable-attribute
  * clang: https://clang.llvm.org/docs/AttributeReference.html#section-declspec-allocate
-- 
2.23.0.187.g17f5b7556c-goog

