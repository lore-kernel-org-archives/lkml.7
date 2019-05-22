Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F51C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF67E217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558553336;
	bh=ZEOaOa7/cjki/9csMBailtCVQE5L3VElXMQNTLJbohU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QrFD/WtUZMSfQ7PtzDzcmmwPk8kXlbs/q5LhEAjsFKeMOoP23Pyqe5rPvR1KSoFaD
	 AEh6dFnfvE27ozt9tCT9eF99WJFPYXkUN2AGC+WC8zY+sFs41on9ero6fhEW+/ejK1
	 l5V6Oq2uQC5OUX9Fe6wnBRvGhXg5cHu0tihtsygo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732687AbfEVT2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:28:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732668AbfEVT2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:28:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E4682177E;
        Wed, 22 May 2019 19:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553332;
        bh=ZEOaOa7/cjki/9csMBailtCVQE5L3VElXMQNTLJbohU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rK/lYH+KQZJddOlHBaz9BKnwnOlqOe3SCKwGUm4DV5OgtbQyFDHtA6S02vTQP0bbB
         NSeMbVt3qO7NOoXppHwcaHMKyyq1h7COFIiQa0fGFv7FCLKUHc07qOUQ60aWqVxxv7
         eYj5CIYi54gh59zO0A/hGZqHZAGkGBMOLS5YXurM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 007/167] tools/bpf: fix perf build error with uClibc (seen on ARC)
Date:   Wed, 22 May 2019 15:26:02 -0400
Message-Id: <20190522192842.25858-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192842.25858-1-sashal@kernel.org>
References: <20190522192842.25858-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineet Gupta <Vineet.Gupta1@synopsys.com>

[ Upstream commit ca31ca8247e2d3807ff5fa1d1760616a2292001c ]

When build perf for ARC recently, there was a build failure due to lack
of __NR_bpf.

| Auto-detecting system features:
|
| ...                     get_cpuid: [ OFF ]
| ...                           bpf: [ on  ]
|
| #  error __NR_bpf not defined. libbpf does not support your arch.
    ^~~~~
| bpf.c: In function 'sys_bpf':
| bpf.c:66:17: error: '__NR_bpf' undeclared (first use in this function)
|  return syscall(__NR_bpf, cmd, attr, size);
|                 ^~~~~~~~
|                 sys_bpf

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/bpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 1d6907d379c99..976b28137d836 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -41,6 +41,8 @@
 #  define __NR_bpf 349
 # elif defined(__s390__)
 #  define __NR_bpf 351
+# elif defined(__arc__)
+#  define __NR_bpf 280
 # else
 #  error __NR_bpf not defined. libbpf does not support your arch.
 # endif
-- 
2.20.1

