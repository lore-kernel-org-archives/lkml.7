Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3231C47E49
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 08:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866EB208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 08:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="24wqhJT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbfKAINx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 04:13:53 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:32221 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730157AbfKAINx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 04:13:53 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id xA18BsBQ023869;
        Fri, 1 Nov 2019 17:11:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com xA18BsBQ023869
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1572595923;
        bh=dMOvEpUrv3gUpGiwcs/+Eb8AZVQbVFB1v4ogmdr2bko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=24wqhJT7RJMf50vgPNVtuOw7sfdCTIBCGMN1/+85H2fjdBWjCBMgKq4Gi/Zo8KO2Y
         VlgD461HyHetk8JzsJ7Ekalb9WtIQBjoIaG78+XXVkIjX89OQ/6jth0bvnMY7mY/Zy
         kZ1FsZLs884Twsxjffd5wE/JArN05kQGyzXNHNkQnzTcfwsuqyMuM02JwDm5mdrvDY
         5imCL2rnn/7JQ+QTDtFB+kbwLTgcoxcrAjnIIPElUvBT0solhQTWvr+EhskjVm4OS1
         vqipju34mMQPwLWkDveV8HSaTxr8C3ugI1gbtT2+b+racWCIlXeZnHt+T/q7S8T8kL
         VV3/6jEArBPKQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        David Gibson <david@gibson.dropbear.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] libfdt: define INT32_MAX and UINT32_MAX in libfdt_env.h
Date:   Fri,  1 Nov 2019 17:11:48 +0900
Message-Id: <20191101081148.23274-4-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101081148.23274-1-yamada.masahiro@socionext.com>
References: <20191101081148.23274-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The libfdt in the upstream DTC project added references to (U)INT32_MAX
by the following commits:

  Commit 812b1956a076 ("libfdt: Tweak data handling to satisfy Coverity")
  Commit 7fcf8208b8a9 ("libfdt: add fdt_append_addrrange()")

The kernel needs to adjust libfdt_env.h before pulling in the changes.

As for the user-space programs, <stdint.h> defines (U)INT32_MAX along
with (u)int32_t.

In the kernel, on the other hand, we usually use s32 / u32 instead of
(u)int32_t for the fixed-width types.

Accordingly, we already have S32_MAX / U32_MAX for their max values.
So, we won't add (U)INT32_MAX to <linux/limits.h> any more.

Instead, add them to the in-kernel libfdt_env.h to compile fdt.c and
fdt_addresses.c

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
 - Fix ppc libfdt_env.h

 arch/powerpc/boot/libfdt_env.h | 2 ++
 include/linux/libfdt_env.h     | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/powerpc/boot/libfdt_env.h b/arch/powerpc/boot/libfdt_env.h
index 2abc8e83b95e..9757d4f6331e 100644
--- a/arch/powerpc/boot/libfdt_env.h
+++ b/arch/powerpc/boot/libfdt_env.h
@@ -6,6 +6,8 @@
 #include <string.h>
 
 #define INT_MAX			((int)(~0U>>1))
+#define UINT32_MAX		((u32)~0U)
+#define INT32_MAX		((s32)(UINT32_MAX >> 1))
 
 #include "of.h"
 
diff --git a/include/linux/libfdt_env.h b/include/linux/libfdt_env.h
index edb0f0c30904..0bd83bdb2482 100644
--- a/include/linux/libfdt_env.h
+++ b/include/linux/libfdt_env.h
@@ -11,6 +11,9 @@ typedef __be16 fdt16_t;
 typedef __be32 fdt32_t;
 typedef __be64 fdt64_t;
 
+#define INT32_MAX	S32_MAX
+#define UINT32_MAX	U32_MAX
+
 #define fdt32_to_cpu(x) be32_to_cpu(x)
 #define cpu_to_fdt32(x) cpu_to_be32(x)
 #define fdt64_to_cpu(x) be64_to_cpu(x)
-- 
2.17.1

