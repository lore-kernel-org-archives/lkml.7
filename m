Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48550C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7EC208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561596244;
	bh=gvVSKaqZrybsWTI5v1Ft2O1Gzqx5r/tj7z0gtcZMpDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XPMMSoJebtFd1zpmnnyGUNawyI+D7AuljNZ3xT8K5IyPphmb8p/p8RXlqPJHxKT62
	 O9NF1KECrYAOPEZfRqoKUP+aEpVIYW/nOQfDPCMn8M42CHvpX2w0T4/6jnIfEmuyTa
	 zkLISvLkELvC4PV1qd6GVDZya8qcn8ON+ptoFibE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfF0Ams (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:42:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727621AbfF0Amo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:42:44 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1124F21871;
        Thu, 27 Jun 2019 00:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561596164;
        bh=gvVSKaqZrybsWTI5v1Ft2O1Gzqx5r/tj7z0gtcZMpDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yiRQ21FHSIdViRnVJPAzmzQXEPNMbO/E2voEQK3fQiUmGPiaGA9Ic+P5JPrQ4MN4N
         RgBiu+n4i9Wc/1hLyDuICDCw92L6bWgLfAXXvf73zvgUodZv8dp9miVa18XisaEYy7
         chEenH9tziKJINuZkQy8E0O+bu5OAVaMvTf0JisM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chang-Hsien Tsai <luke.tw@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 02/12] samples, bpf: fix to change the buffer size for read()
Date:   Wed, 26 Jun 2019 20:42:24 -0400
Message-Id: <20190627004236.21909-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627004236.21909-1-sashal@kernel.org>
References: <20190627004236.21909-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chang-Hsien Tsai <luke.tw@gmail.com>

[ Upstream commit f7c2d64bac1be2ff32f8e4f500c6e5429c1003e0 ]

If the trace for read is larger than 4096, the return
value sz will be 4096. This results in off-by-one error
on buf:

    static char buf[4096];
    ssize_t sz;

    sz = read(trace_fd, buf, sizeof(buf));
    if (sz > 0) {
        buf[sz] = 0;
        puts(buf);
    }

Signed-off-by: Chang-Hsien Tsai <luke.tw@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/bpf_load.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/bpf_load.c b/samples/bpf/bpf_load.c
index da86a8e0a95a..e836b5ff2060 100644
--- a/samples/bpf/bpf_load.c
+++ b/samples/bpf/bpf_load.c
@@ -336,7 +336,7 @@ void read_trace_pipe(void)
 		static char buf[4096];
 		ssize_t sz;
 
-		sz = read(trace_fd, buf, sizeof(buf));
+		sz = read(trace_fd, buf, sizeof(buf) - 1);
 		if (sz > 0) {
 			buf[sz] = 0;
 			puts(buf);
-- 
2.20.1

