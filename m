Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB54C28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A030251CF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189615;
	bh=qhycpso+IZXbfcRj7SNcCkbbQIkpdKDQtAqUnRwjlu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IsvZuJCJm9kU7oQ+vMaECl70aPa3fKWukLHUQxUVU0/Jde92YuPEqopqJRjm4cgsQ
	 G9BZGQH10lHYK6Q1H+VN7b8wQUqIkqixXpRRNpSjwLc7oZgVD+IUNGqRNWH3ZbAfoz
	 tKw4qSLxrZ6gfNd2zvph33lOY9uVhKr/XcDG7OB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730861AbfE3ENK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:13:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729728AbfE3DQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:16:24 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 470FF245BB;
        Thu, 30 May 2019 03:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186184;
        bh=qhycpso+IZXbfcRj7SNcCkbbQIkpdKDQtAqUnRwjlu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=clFHIPr3Xe5Jfu6iRf0AvVpDt2PqQI/4MmcDYIsfE768zZ0nNY+WQtO/9rRlOKyd7
         oYkNaXsKwAxznDeqUiTZwNM/R5n10pfj7lw84V6OpBlmoAtOcTd3sZYldkKy3qlu+i
         q8Ex+Ry5RbUHvPk0Vb2vJua/ajqWSjFNG0t9d4pI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 050/276] tools/bpf: fix perf build error with uClibc (seen on ARC)
Date:   Wed, 29 May 2019 20:03:28 -0700
Message-Id: <20190530030528.063355706@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
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
index 7a0014794bff7..dd0b68d1f4be0 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -53,6 +53,8 @@
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



