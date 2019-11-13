Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C889C17441
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4312084E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611528;
	bh=2mZNh7vjMLJ8VzjcNt4mAP3gxaWYiCtdp11s1HXRELc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VKQ/y3fwPWWvIgVCIaKaRITpRZWJTiZXVi7hE7SX6ONs5XsBlXwicqMNxQQgHOHjU
	 eFEM65qHHuGSN00TuAfjoMXMGqBFCC8e3ZKxUWOSlWw+fEuINTjXQwBzjavEJQHg1e
	 iK7qGTwdHCp3Og4fxVJYRIpv0uj2Dz8ImIbTpJB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfKMBzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:55:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:47052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729094AbfKMBz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:55:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1FB4222CD;
        Wed, 13 Nov 2019 01:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610125;
        bh=2mZNh7vjMLJ8VzjcNt4mAP3gxaWYiCtdp11s1HXRELc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xRTa8/gylhOKzUjejuwgTcN3YOeKgOkjp9W50sms7H+u8BrZPcsn8Z/ThgNFxA8wF
         IX4zCSO0TUqw5QvW1V9/ATRpirvgaMidCKZjn80FACgpmQcQbnEB3l9IPmcboOtdYe
         ovkdSzAStTNugXDjm2Kj9qMW9klPAuipFfZawlHg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenwen Wang <wang6495@umn.edu>, Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 177/209] bpf: btf: Fix a missing check bug
Date:   Tue, 12 Nov 2019 20:49:53 -0500
Message-Id: <20191113015025.9685-177-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wang6495@umn.edu>

[ Upstream commit 8af03d1ae2e154a8be3631e8694b87007e1bdbc2 ]

In btf_parse_hdr(), the length of the btf data header is firstly copied
from the user space to 'hdr_len' and checked to see whether it is larger
than 'btf_data_size'. If yes, an error code EINVAL is returned. Otherwise,
the whole header is copied again from the user space to 'btf->hdr'.
However, after the second copy, there is no check between
'btf->hdr->hdr_len' and 'hdr_len' to confirm that the two copies get the
same value. Given that the btf data is in the user space, a malicious user
can race to change the data between the two copies. By doing so, the user
can provide malicious data to the kernel and cause undefined behavior.

This patch adds a necessary check after the second copy, to make sure
'btf->hdr->hdr_len' has the same value as 'hdr_len'. Otherwise, an error
code EINVAL will be returned.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/btf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 138f0302692ec..378cef70341c4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -2114,6 +2114,9 @@ static int btf_parse_hdr(struct btf_verifier_env *env, void __user *btf_data,
 
 	hdr = &btf->hdr;
 
+	if (hdr->hdr_len != hdr_len)
+		return -EINVAL;
+
 	btf_verifier_log_hdr(env, btf_data_size);
 
 	if (hdr->magic != BTF_MAGIC) {
-- 
2.20.1

