Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C274C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ADC32064A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714178;
	bh=B79Hd6X3KLWO53HyK6zgiFcV+EC8nALm1QMiX27vHpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zyie0Kia2VDDBfcpLbLjq5SDux1GsZzIGs/IMAy9j/bNSZF/16aXOiaUcydNqZvd6
	 i0qJgMJiYeAGBhi03pCgevi2n/coS9YQWV24bWWUn4Ky76F10E+qcaa0tqpErh/zd2
	 GMujT7nuK5B/RAM1hGRYZ0lMwqmrEh7k2F4VsA98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388656AbfC0TQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:16:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732800AbfC0SJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:09:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B82592147C;
        Wed, 27 Mar 2019 18:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710148;
        bh=B79Hd6X3KLWO53HyK6zgiFcV+EC8nALm1QMiX27vHpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=woVdXMAxdCP8U5xPsduzWQ1E14kfAqlygnWfdFxXcr5GFTyDDnlO11Qr44qaW65fA
         yr1Mq1Y3sWhb0RpxQ8+jRlStrNcfroK63EM/tbLTGqQUGUKH62Uk8yYSKqkWR2vTcf
         DbH9UQRsP40/1qkdXOC5Mxn9Q4g1vC+3epLdjrA8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 218/262] selftests/bpf: suppress readelf stderr when probing for BTF support
Date:   Wed, 27 Mar 2019 14:01:13 -0400
Message-Id: <20190327180158.10245-218-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanislav Fomichev <sdf@google.com>

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

