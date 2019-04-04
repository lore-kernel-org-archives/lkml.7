Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03B7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF1A20693
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369440;
	bh=cjtxhAYYAcIj1K6z5Piztr+1bMldhmBvEbfnugOxn9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NKNB/UG8ZoXB4YxqvgA5LSTt04NO2b0p/34K6icwoDZrzx2zm0PSIcHmp3wIMy6/C
	 x5PmfXVIwzVbe2B470QF4EfbkZNQJq2dRlRAEccCxU/oLMkwM5UJlT5x/U10l20e7M
	 F88nV/JSEyU3NiAGbJmZsUb08/K1HoYu5hOEZQY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388185AbfDDJRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:17:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388168AbfDDJRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:17:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED4BB2054F;
        Thu,  4 Apr 2019 09:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369433;
        bh=cjtxhAYYAcIj1K6z5Piztr+1bMldhmBvEbfnugOxn9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aVt1JcoGUGbx50ZHwwHWc48FgvbR+OGEpp9rxIkT4ej3NmqshBP9UGYTFxEdRLiXk
         t9mW4xmNEDKa6s2sYTsAGivaWdXYtt34Bj4zOIumc/g4PZXH1fl5OzKmq/Dg7xv4kg
         CX9djuKhtF8pIuYWaloNpimudUc4XidVnkc3IoSc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stanislav Fomichev <sdf@google.com>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 206/246] selftests/bpf: suppress readelf stderr when probing for BTF support
Date:   Thu,  4 Apr 2019 10:48:26 +0200
Message-Id: <20190404084626.403076071@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 2f0921262ba943fe9d9f59037a033927d8c4789b ]

Before:
$ make -s -C tools/testing/selftests/bpf
readelf: Error: Missing knowledge of 32-bit reloc types used in DWARF
sections of machine number 247
readelf: Warning: unable to apply unsupported reloc type 10 to section
.debug_info
readelf: Warning: unable to apply unsupported reloc type 1 to section
.debug_info
readelf: Warning: unable to apply unsupported reloc type 10 to section
.debug_info

After:
$ make -s -C tools/testing/selftests/bpf

v2:
* use llvm-readelf instead of redirecting binutils' readelf stderr to
  /dev/null

Signed-off-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 41ab7a3668b3..936f726f7cd9 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -96,6 +96,7 @@ $(BPFOBJ): force
 CLANG ?= clang
 LLC   ?= llc
 LLVM_OBJCOPY ?= llvm-objcopy
+LLVM_READELF ?= llvm-readelf
 BTF_PAHOLE ?= pahole
 
 PROBE := $(shell $(LLC) -march=bpf -mcpu=probe -filetype=null /dev/null 2>&1)
@@ -132,7 +133,7 @@ BTF_PAHOLE_PROBE := $(shell $(BTF_PAHOLE) --help 2>&1 | grep BTF)
 BTF_OBJCOPY_PROBE := $(shell $(LLVM_OBJCOPY) --help 2>&1 | grep -i 'usage.*llvm')
 BTF_LLVM_PROBE := $(shell echo "int main() { return 0; }" | \
 			  $(CLANG) -target bpf -O2 -g -c -x c - -o ./llvm_btf_verify.o; \
-			  readelf -S ./llvm_btf_verify.o | grep BTF; \
+			  $(LLVM_READELF) -S ./llvm_btf_verify.o | grep BTF; \
 			  /bin/rm -f ./llvm_btf_verify.o)
 
 ifneq ($(BTF_LLVM_PROBE),)
-- 
2.19.1



