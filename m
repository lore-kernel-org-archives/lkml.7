Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E87FC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B77217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558553040;
	bh=r4EtqetRWJlSKq7Cu5r6i4y2EfulVoRIH/P+h7Ui8AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0oijokgLMvXsiT2mulT/wTfy6jlb69BJ5t5lTgbr/GX3zp9KC/+AdMPErhKn7o+2i
	 QjEhTWUzCFWLfXt5IS4EhlxaXbzrjD0JK4TTOSrlZwhTtZXFHdFe4JJkwX13kE7GTu
	 qbU0q1Rk2cVZnKnJsaVS61Qb6wluxuHdshyE+puk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbfEVTX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731029AbfEVTXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:23:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97230217D7;
        Wed, 22 May 2019 19:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553033;
        bh=r4EtqetRWJlSKq7Cu5r6i4y2EfulVoRIH/P+h7Ui8AA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F6H7KdtNM0H51+cUncoONca2L2VYVFzbqrxBL6D2jFQl2OnYIAUubjUHe8iOPUTiQ
         uq50/DKOraqBD1SHhf6vcxvd3rg+KSGPHuxinCUeUoSjlTc3J6H3caGrhkQ5NMK30I
         L8cDefOPObxuyLMbnNrOepkL80GOFUyLRrOoCvQ0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 011/317] selftests/bpf: set RLIMIT_MEMLOCK properly for test_libbpf_open.c
Date:   Wed, 22 May 2019 15:18:32 -0400
Message-Id: <20190522192338.23715-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192338.23715-1-sashal@kernel.org>
References: <20190522192338.23715-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonghong Song <yhs@fb.com>

[ Upstream commit 6cea33701eb024bc6c920ab83940ee22afd29139 ]

Test test_libbpf.sh failed on my development server with failure
  -bash-4.4$ sudo ./test_libbpf.sh
  [0] libbpf: Error in bpf_object__probe_name():Operation not permitted(1).
      Couldn't load basic 'r0 = 0' BPF program.
  test_libbpf: failed at file test_l4lb.o
  selftests: test_libbpf [FAILED]
  -bash-4.4$

The reason is because my machine has 64KB locked memory by default which
is not enough for this program to get locked memory.
Similar to other bpf selftests, let us increase RLIMIT_MEMLOCK
to infinity, which fixed the issue.

Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_libbpf_open.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_libbpf_open.c b/tools/testing/selftests/bpf/test_libbpf_open.c
index 8fcd1c076add0..cbd55f5f8d598 100644
--- a/tools/testing/selftests/bpf/test_libbpf_open.c
+++ b/tools/testing/selftests/bpf/test_libbpf_open.c
@@ -11,6 +11,8 @@ static const char *__doc__ =
 #include <bpf/libbpf.h>
 #include <getopt.h>
 
+#include "bpf_rlimit.h"
+
 static const struct option long_options[] = {
 	{"help",	no_argument,		NULL, 'h' },
 	{"debug",	no_argument,		NULL, 'D' },
-- 
2.20.1

