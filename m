Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F16C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A1E253A7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559190275;
	bh=iz/wcUtn3HwNE5WJyUgZwR7jVEuVPxyiJJgdZNhCOAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vaVu6K+ygd5rI60iECKNDF8BvNFjZLMPPfY+spcb70jGjAWItyn4rZIrvpcJU1zxJ
	 ByJ6+eHsz4+OOzDcSLN794IZPYB9AK6lAZmJeJEA17CspfPSVtB7DD995wENeNV1gS
	 BuU8Tg+MezskW8/apzIQDBYqjBao85yaovNTkhUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbfE3EYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:24:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730024AbfE3DOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:14:51 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25AC92458A;
        Thu, 30 May 2019 03:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186091;
        bh=iz/wcUtn3HwNE5WJyUgZwR7jVEuVPxyiJJgdZNhCOAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vts2BPJ8XUtmNJoTzmIqCqyijEBdCM/YeITKDKzaPCdj5vdMAtNtWyrh6/prSblKV
         8cw1hkhThMOCeOCi0/dy5009f0Pv8412+yWmb7ADYifPl8hp1J7rzYnnoMLtWeILca
         ZDwHeHQW6yRU7MLfu7OUjHZ/uhcnvPntagQ6YZWc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Daniel T. Lee" <danieltimlee@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 222/346] selftests/bpf: ksym_search wont check symbols exists
Date:   Wed, 29 May 2019 20:04:55 -0700
Message-Id: <20190530030552.324126239@linuxfoundation.org>
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

[ Upstream commit 0979ff7992fb6f4eb837995b12f4071dcafebd2d ]

Currently, ksym_search located at trace_helpers won't check symbols are
existing or not.

In ksym_search, when symbol is not found, it will return &syms[0](_stext).
But when the kernel symbols are not loaded, it will return NULL, which is
not a desired action.

This commit will add verification logic whether symbols are loaded prior
to the symbol search.

Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/trace_helpers.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 4cdb63bf0521d..9a9fc6c9b70b5 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -52,6 +52,10 @@ struct ksym *ksym_search(long key)
 	int start = 0, end = sym_cnt;
 	int result;
 
+	/* kallsyms not loaded. return NULL */
+	if (sym_cnt <= 0)
+		return NULL;
+
 	while (start < end) {
 		size_t mid = start + (end - start) / 2;
 
-- 
2.20.1



