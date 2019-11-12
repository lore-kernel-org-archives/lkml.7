Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62169C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311C12084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nezus2jc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfKLNpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:45:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33778 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfKLNph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:45:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id a17so2387491wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 05:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=D37ooG4hj3d1tXGJWLb9ByvS8fwj2I3PRg/Yzi41kaQ=;
        b=nezus2jc7OyhXhqgc1ez0i9/RrmAQqe1UTXA3XYdV3hPCcxl10Ub3opRTLe1Q/DJMk
         ggvq1y3VTxomrMPHYbRglK4AeFSRI3j4h2e/mntAd9XPDz6HnmH4uXFhduoHJtpremlG
         r5yQy3F29PS0arfyr08JclHyCrgxj6UhjSnlNNBC1fOhIKSO//xl/Eg2/Ut+iGJFIQ/L
         FqLhlw1rggaROADNv39rHm/CrJumzJi9EEFV0BcBtP0UdndMU0fNii5bH6YjRUbwghuF
         EKecC48Z+vPctX6ZFqH0GPVY3fGRl1gXbHAwcyenvLhRt42AEq73nel1Bw+uQUtf4eZB
         DXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D37ooG4hj3d1tXGJWLb9ByvS8fwj2I3PRg/Yzi41kaQ=;
        b=EM7kST9dMM3cnMhM7/lOnmzdEG3ymrb6CbEHYvu7pRYDJBJOCYCJOqhA27x4sNLjRV
         2SMVUGbt2Cz9e2GHmdICgwWoFxvOmC683hfmorC9JbvguK2G0lmyJo6cIyy96gER5gEd
         uK+oINIcCWv5H7bmkXfje4/amhWbQhpnHg7a4j8cWV8v2pSrSvQyaU3wiVeb1OrHohKz
         OMPEG4n4grye9g+oWdLVA+hC8SlIH8t1LqJ09x/KPA2soa4F2gf5gfZI8mjsF/TALjKE
         XjF05PJdpD6YZZEv/TJBT89fjLZOMREUwhNsLUCiZVzP+WFDQrD3aB+KxfILk4dZ30mJ
         +SWA==
X-Gm-Message-State: APjAAAUX/9iUXyK7TSYsDxCWPNHLlJyRKdGNo+aEO/5ZwAtuhY7r/O1h
        0E5GZBATvV2kKHRRSD3bXd8=
X-Google-Smtp-Source: APXvYqz2i/h9avAb+ybByAsrmIjD/sDcoNqg8/CdBsf/EOV0pRTOoSKacvVW2lvRpXvSUQi86uXqXg==
X-Received: by 2002:a05:600c:2549:: with SMTP id e9mr3842177wma.177.1573566335889;
        Tue, 12 Nov 2019 05:45:35 -0800 (PST)
Received: from localhost.localdomain ([2a02:a58:8166:7500:7146:58dd:6d5e:970])
        by smtp.gmail.com with ESMTPSA id 4sm4496178wmd.33.2019.11.12.05.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 05:45:35 -0800 (PST)
From:   Ilie Halip <ilie.halip@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Ilie Halip <ilie.halip@gmail.com>,
        Peter Collingbourne <pcc@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] scripts/tools-support-relr.sh: un-quote variables
Date:   Tue, 12 Nov 2019 15:45:20 +0200
Message-Id: <20191112134522.12177-1-ilie.halip@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the CC variable contains quotes, e.g. when using
ccache (make CC="ccache <compiler>"), this script always
fails, so CONFIG_RELR is never enabled, even when the
toolchain supports this feature. Removing the /dev/null
redirect and invoking the script manually shows the issue:

    $ CC='/usr/bin/ccache clang' ./scripts/tools-support-relr.sh
    ./scripts/tools-support-relr.sh: 7: ./scripts/tools-support-relr.sh: /usr/bin/ccache clang: not found

Fix this by un-quoting the variables.

Before:
    $ make ARCH=arm64 CC='/usr/bin/ccache clang' LD=ld.lld \
        NM=llvm-nm OBJCOPY=llvm-objcopy defconfig
    $ grep RELR .config
    CONFIG_ARCH_HAS_RELR=y

With this change:
    $ make ARCH=arm64 CC='/usr/bin/ccache clang' LD=ld.lld \
        NM=llvm-nm OBJCOPY=llvm-objcopy defconfig
    $ grep RELR .config
    CONFIG_TOOLS_SUPPORT_RELR=y
    CONFIG_ARCH_HAS_RELR=y
    CONFIG_RELR=y

Fixes: 5cf896fb6be3 ("arm64: Add support for relocating the kernel with RELR relocations")
Reported-by: Dmitry Golovin <dima@golovin.in>
Link: https://github.com/ClangBuiltLinux/linux/issues/769
Cc: Peter Collingbourne <pcc@google.com>
Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
---
 scripts/tools-support-relr.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/tools-support-relr.sh b/scripts/tools-support-relr.sh
index 97a2c844a95e..45e8aa360b45 100755
--- a/scripts/tools-support-relr.sh
+++ b/scripts/tools-support-relr.sh
@@ -4,13 +4,13 @@
 tmp_file=$(mktemp)
 trap "rm -f $tmp_file.o $tmp_file $tmp_file.bin" EXIT
 
-cat << "END" | "$CC" -c -x c - -o $tmp_file.o >/dev/null 2>&1
+cat << "END" | $CC -c -x c - -o $tmp_file.o >/dev/null 2>&1
 void *p = &p;
 END
-"$LD" $tmp_file.o -shared -Bsymbolic --pack-dyn-relocs=relr -o $tmp_file
+$LD $tmp_file.o -shared -Bsymbolic --pack-dyn-relocs=relr -o $tmp_file
 
 # Despite printing an error message, GNU nm still exits with exit code 0 if it
 # sees a relr section. So we need to check that nothing is printed to stderr.
-test -z "$("$NM" $tmp_file 2>&1 >/dev/null)"
+test -z "$($NM $tmp_file 2>&1 >/dev/null)"
 
-"$OBJCOPY" -O binary $tmp_file $tmp_file.bin
+$OBJCOPY -O binary $tmp_file $tmp_file.bin
-- 
2.17.1

