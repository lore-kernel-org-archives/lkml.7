Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF9AC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE5220866
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559690581;
	bh=UJSfZQyM0mKU3h4AXbdeOkP5roVDYNSWhjBQZXUeuNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O+TwFsMfbBsSneSTqqH8gdkadyhtFAjX+cfNU3ifMNsmFGvNWzdNB0PRp26kSSpvX
	 1yCRXZjcTBYk4BGTwrv2/i/OziI+AvAPbplOIMUSoQvW+I7IYjS73kqvygfqlNUHX6
	 ST/xASTfDT5Tzh0GROS+2kZmRTB/N+BNdBcNMfJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfFDXXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:23:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbfFDXW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:22:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 176B9206C1;
        Tue,  4 Jun 2019 23:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559690577;
        bh=UJSfZQyM0mKU3h4AXbdeOkP5roVDYNSWhjBQZXUeuNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J4I8yIrNk+bj/99etosDpKCSCLk5HXLPALhKobk46TfBiCUXIEfJwEnvXKkHGup9x
         oQmelra/XGjWXVmlZ8Z+Iac28We0DNvGUramPUIzdFVN2OZ8HFnTjNSDJIeAV2kcBI
         llL4Nb8JtjI51eFeRvxmcJa4IfBCP1C6vWKrZ/7c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 27/60] selftests/bpf: fix bpf_get_current_task
Date:   Tue,  4 Jun 2019 19:21:37 -0400
Message-Id: <20190604232212.6753-27-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604232212.6753-1-sashal@kernel.org>
References: <20190604232212.6753-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

[ Upstream commit 7ed4b4e60bb1dd3df7a45dfbde3a96efce9df7eb ]

Fix bpf_get_current_task() declaration.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/bpf_helpers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/selftests/bpf/bpf_helpers.h
index c81fc350f7ad..a43a52cdd3f0 100644
--- a/tools/testing/selftests/bpf/bpf_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_helpers.h
@@ -246,7 +246,7 @@ static int (*bpf_skb_change_type)(void *ctx, __u32 type) =
 	(void *) BPF_FUNC_skb_change_type;
 static unsigned int (*bpf_get_hash_recalc)(void *ctx) =
 	(void *) BPF_FUNC_get_hash_recalc;
-static unsigned long long (*bpf_get_current_task)(void *ctx) =
+static unsigned long long (*bpf_get_current_task)(void) =
 	(void *) BPF_FUNC_get_current_task;
 static int (*bpf_skb_change_tail)(void *ctx, __u32 len, __u64 flags) =
 	(void *) BPF_FUNC_skb_change_tail;
-- 
2.20.1

