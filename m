Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B78C28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8DD2600A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559192314;
	bh=iYzo/VRtevKekWWggl+QIhG1PwDIUuE4DzWTR6nh2n0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UGq4mi0JrJh4DH7yoVRJWMTEQB1F8WInWe33MVO5SvV5JKN7Gzx1ovwAP8QZJYngU
	 XEQg9scMkh2/iCtBh8dQch2pI5N8MLeaLXVUcoED91Uu9tU+aZZ18vYonm35AB0mpU
	 3KelPuvt/0Z940S3fmzwsAU45V1KTheVXO5vqy5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbfE3E6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:58:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbfE3DJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:09:48 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDE9124494;
        Thu, 30 May 2019 03:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185788;
        bh=iYzo/VRtevKekWWggl+QIhG1PwDIUuE4DzWTR6nh2n0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HrafJyIS3neoYnHPejYj65GJU+r4DN5enzJe+XdzDegTmkvDyaoDCpGJmqxPXMRDk
         owG0mD7/d600ay6S+aJZDo04cBI6YZfbF6b+UfLn3PKYeMW+nkuOFPztoX11IuELQd
         Glu6sTUL122kdxmnA/IEV8TfPVNJixZLrFA/oezU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 057/405] selftests/bpf: set RLIMIT_MEMLOCK properly for test_libbpf_open.c
Date:   Wed, 29 May 2019 20:00:55 -0700
Message-Id: <20190530030543.759081513@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 65cbd30704b5a..9e9db202d218a 100644
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



