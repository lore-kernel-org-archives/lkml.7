Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E6AC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFE321721
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pD5jK+Uy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfFSSSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 14:18:48 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:49672 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfFSSSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:18:48 -0400
Received: by mail-pf1-f201.google.com with SMTP id x9so109977pfm.16
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 11:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9SP6MUWk873Ch/qsaQOv86zFySgp2PlyOeK7M/kFehU=;
        b=pD5jK+Uyg8ZNOAIvhEa7UgdPRgCtjB2BbMy+UMTUUXAYL6W0Kl2ujwK8pGy1NdmPIh
         IlfCkHrjHyEFesgPjd5PE5S+ZLL55lO0tbyvO0lgPWAW1nR7V8kERali+1SESilx8ZjA
         zwvBpKHO2uW4wPZoGCLtzbIJGXYSzvSETdA7A/Uzc8jDArSRyFV4b9HAAiLhalYrztWd
         z76Rr9DxKZpunPUre9f8SAFv1ZMYTXdI/EIeo9A2/ttvoYP7xdGzz8cWHYrSiUPQDGuf
         y80PuvDZOimgRDHNYbrkIBtLhoHajrzVi4OztO1/hkhn02RCOhxsJ77px2KN+XbEN5Nf
         Dvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9SP6MUWk873Ch/qsaQOv86zFySgp2PlyOeK7M/kFehU=;
        b=LlhEr+z6nhKK9ysj/bJg+GJg/z5i8cyhsAipsoM8HuVdBL/0ACcerSBQKzbB1oTPH0
         2hK8ZEhSFhCc1Es9RzPlsxNU5pTAUMlTTJWQaiQWboXS9zwjI/ULfZfEsFWok+tylEs8
         zFlUJXDqRHxTER2bPZkjHA9qqSBwyeLAMpjOoBkFMao00c/DWCYIzDcmWslbG1GLiX7D
         N69tg7jbnlv5rWRtBW5dsWJA+fM/30pM+5itO+9OjK88ZYYE0D78pCK+ehD++e1QCXE7
         Jw4MAiCxlNKGjpq6PTW1KGpE/Q4AbebTJeC95Ue3C4kPfoUc/Lf+n4RGmHTY+9vpH7RH
         MoEQ==
X-Gm-Message-State: APjAAAU5wXtjnELTYjeDLYOH19N0HXvMU78VzWgHjmLzBN/ABJaQUe1P
        ZA5N5lSmmOZivawDMeFgXPZxz0OWegkA+HAu4yA=
X-Google-Smtp-Source: APXvYqykVq7KmiJ6FaseWDZ/iHfU1QNxPCm9zuhYfrBj1sRQJAEwGxl/VdGd9CFiQ2Isa0mjFBRFo6JhpKhaB5tGgBI=
X-Received: by 2002:a63:151a:: with SMTP id v26mr9065451pgl.9.1560968327444;
 Wed, 19 Jun 2019 11:18:47 -0700 (PDT)
Date:   Wed, 19 Jun 2019 11:18:44 -0700
Message-Id: <20190619181844.57696-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] MAINTAINERS: add CLANG/LLVM BUILD SUPPORT info
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     akpm@linux-foundation.org
Cc:     clang-built-linux@googlegroups.com, joe@perches.com,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add keyword support so that our mailing list gets cc'ed for clang/llvm
patches. We're pretty active on our mailing list so far as code review.
There are numerous Googlers like myself that are paid to support
building the Linux kernel with Clang and LLVM.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Thanks for Joe Perches for help on the syntax for the case insensitive
syntax.

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ef58d9a881ee..fa798cc48e34 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3940,6 +3940,14 @@ M:	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
 S:	Maintained
 F:	.clang-format
 
+CLANG/LLVM BUILD SUPPORT
+L: clang-built-linux@googlegroups.com
+W: https://clangbuiltlinux.github.io/
+B: https://github.com/ClangBuiltLinux/linux/issues
+C: irc://chat.freenode.net/clangbuiltlinux
+S: Supported
+K: \b(?i:clang|llvm)\b
+
 CLEANCACHE API
 M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
 L:	linux-kernel@vger.kernel.org
-- 
2.22.0.410.gd8fdbe21b5-goog

