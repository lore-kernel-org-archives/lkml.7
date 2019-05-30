Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36358C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D82B24A93
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186814;
	bh=Nmf83k/tJU31KQN/PoLuiZHPJEcaxrZfzZ6Fw9uzICY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x+wSme97ZmbmA+GBVOH38WKuZHN7G07ISYp+3pgQe+83Yqq8N/uZNdHXNNbBtWlNg
	 9i18VrwE3/vsoami3kx4kQqyU7K9wgA6xCcvF73pjCmXIGkVIUNWc3cDA/mf3uwEtC
	 HveODxOZTIQkTBDYKVNlc8MM+ShT5pvZtxan4ntQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387781AbfE3D0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:26:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730383AbfE3DTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:19:02 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D46B024725;
        Thu, 30 May 2019 03:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186341;
        bh=Nmf83k/tJU31KQN/PoLuiZHPJEcaxrZfzZ6Fw9uzICY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rqZldkN1xDSTt7kBBl4gei4A4VUwXG7wD6ZaDCnvC3mN3QCTgUWAIsscbyjpM51y9
         B0lHKRUFp5TvYb2WmogdR1+L24oTPky2278q0BJ91+QmQe6NKJdEkVTDWsAlmPpVzj
         sRnwYrrsXdshIy0qBVp7vffC1C67p7BArH4MRi+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Daniel T. Lee" <danieltimlee@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 068/193] libbpf: fix samples/bpf build failure due to undefined UINT32_MAX
Date:   Wed, 29 May 2019 20:05:22 -0700
Message-Id: <20190530030458.820580739@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030446.953835040@linuxfoundation.org>
References: <20190530030446.953835040@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 32e621e55496a0009f44fe4914cd4a23cade4984 ]

Currently, building bpf samples will cause the following error.

    ./tools/lib/bpf/bpf.h:132:27: error: 'UINT32_MAX' undeclared here (not in a function) ..
     #define BPF_LOG_BUF_SIZE (UINT32_MAX >> 8) /* verifier maximum in kernels <= 5.1 */
                               ^
    ./samples/bpf/bpf_load.h:31:25: note: in expansion of macro 'BPF_LOG_BUF_SIZE'
     extern char bpf_log_buf[BPF_LOG_BUF_SIZE];
                             ^~~~~~~~~~~~~~~~

Due to commit 4519efa6f8ea ("libbpf: fix BPF_LOG_BUF_SIZE off-by-one error")
hard-coded size of BPF_LOG_BUF_SIZE has been replaced with UINT32_MAX which is
defined in <stdint.h> header.

Even with this change, bpf selftests are running fine since these are built
with clang and it includes header(-idirafter) from clang/6.0.0/include.
(it has <stdint.h>)

    clang -I. -I./include/uapi -I../../../include/uapi -idirafter /usr/local/include -idirafter /usr/include \
    -idirafter /usr/lib/llvm-6.0/lib/clang/6.0.0/include -idirafter /usr/include/x86_64-linux-gnu \
    -Wno-compare-distinct-pointer-types -O2 -target bpf -emit-llvm -c progs/test_sysctl_prog.c -o - | \
    llc -march=bpf -mcpu=generic  -filetype=obj -o /linux/tools/testing/selftests/bpf/test_sysctl_prog.o

But bpf samples are compiled with GCC, and it only searches and includes
headers declared at the target file. As '#include <stdint.h>' hasn't been
declared in tools/lib/bpf/bpf.h, it causes build failure of bpf samples.

    gcc -Wp,-MD,./samples/bpf/.sockex3_user.o.d -Wall -Wmissing-prototypes -Wstrict-prototypes \
    -O2 -fomit-frame-pointer -std=gnu89 -I./usr/include -I./tools/lib/ -I./tools/testing/selftests/bpf/ \
    -I./tools/  lib/ -I./tools/include -I./tools/perf -c -o ./samples/bpf/sockex3_user.o ./samples/bpf/sockex3_user.c;

This commit add declaration of '#include <stdint.h>' to tools/lib/bpf/bpf.h
to fix this problem.

Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/bpf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index b8ea5843c39ee..e9423d6af9332 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -23,6 +23,7 @@
 
 #include <linux/bpf.h>
 #include <stddef.h>
+#include <stdint.h>
 
 int bpf_create_map_node(enum bpf_map_type map_type, int key_size,
 			int value_size, int max_entries, __u32 map_flags,
-- 
2.20.1



