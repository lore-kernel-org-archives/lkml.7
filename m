Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC98C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CD0245CA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186184;
	bh=JO9t+toFpyHBD5p8o0FuGhgcK2QSTx6WYWd9RpEEdWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zCmLlY6h/EwBhu4iHiRpBbd7AvHuIcIEpHHe1w8qCjXEBMO03aXnD8FjUZ5AzO5X3
	 iyuIXZQaew7UU+YcrcauvYMPFo8jalabvETDetGQT4HEQPxKO0lANGtMBMbyJwwUrS
	 RL27leu0tauB5v9fQTS7xZViG35NMWpv7japv+5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbfE3DQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:16:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728477AbfE3DNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:13:20 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 001FB24539;
        Thu, 30 May 2019 03:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186000;
        bh=JO9t+toFpyHBD5p8o0FuGhgcK2QSTx6WYWd9RpEEdWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v+z30e7r7PV8PtFJEspFTX8P02CkXdOl+O1H4OL64AFbAl1Ja/6E/Hb2zVHFXet0r
         kBcRfVuv+ldEk4MV3YLYCoGmKLtARMGXB4yXxlPT+rkF4X23TOaJSWrh2J0H1YCPQq
         VP8YnPV0jlFa6N1MWUQX3VRA7QNHHYaNvf9NyZFY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 050/346] tools/bpf: fix perf build error with uClibc (seen on ARC)
Date:   Wed, 29 May 2019 20:02:03 -0700
Message-Id: <20190530030543.456782991@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 88cbd110ae580..ddeb46c9eef2f 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -45,6 +45,8 @@
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



