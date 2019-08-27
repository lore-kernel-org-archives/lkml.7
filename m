Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5619C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37D921872
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892505;
	bh=vTCvNG1ZV1DaV2Mn8Q8qtNA19FljW55xpo00S5DeUxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZJmRCmVzAbjTjGsLrZBL53lPjmH/4OkmLYMmcTfTc4vwphKZA/+araSocH7qXZiDD
	 v3v0V0f5AWPpV9fkD3QGr080dvtzuTdluSal0JpXe8gmJM/o7eA2OH5azRRu5725rB
	 w2SdKkkz1VogpoEQ1odbETzjFsxGbUrxrowUyT1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbfH0HzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730203AbfH0Hy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:54:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A542206BF;
        Tue, 27 Aug 2019 07:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892497;
        bh=vTCvNG1ZV1DaV2Mn8Q8qtNA19FljW55xpo00S5DeUxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZaCPbbFDft1X7EuV0rWK02ddwUSL0KeS84GoDwlEvgbklKOkYEgIA63aLYohsrO+r
         nj+XG/xzHpgeADNvgwGwfu7Et3etBA856pudYXYsCXrtNVsh2sPsW3AHnv6+V+Tjin
         KuSngZ/VDIcUFMBAgxjsvCE/o5wwVy20Q4ePb+hM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrey Ignatov <rdna@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 06/98] selftests/bpf: fix sendmsg6_prog on s390
Date:   Tue, 27 Aug 2019 09:49:45 +0200
Message-Id: <20190827072718.496182542@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072718.142728620@linuxfoundation.org>
References: <20190827072718.142728620@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c8eee4135a456bc031d67cadc454e76880d1afd8 ]

"sendmsg6: rewrite IP & port (C)" fails on s390, because the code in
sendmsg_v6_prog() assumes that (ctx->user_ip6[0] & 0xFFFF) refers to
leading IPv6 address digits, which is not the case on big-endian
machines.

Since checking bitwise operations doesn't seem to be the point of the
test, replace two short comparisons with a single int comparison.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Andrey Ignatov <rdna@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/sendmsg6_prog.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/sendmsg6_prog.c b/tools/testing/selftests/bpf/sendmsg6_prog.c
index 5aeaa284fc474..a680628204108 100644
--- a/tools/testing/selftests/bpf/sendmsg6_prog.c
+++ b/tools/testing/selftests/bpf/sendmsg6_prog.c
@@ -41,8 +41,7 @@ int sendmsg_v6_prog(struct bpf_sock_addr *ctx)
 	}
 
 	/* Rewrite destination. */
-	if ((ctx->user_ip6[0] & 0xFFFF) == bpf_htons(0xFACE) &&
-	     ctx->user_ip6[0] >> 16 == bpf_htons(0xB00C)) {
+	if (ctx->user_ip6[0] == bpf_htonl(0xFACEB00C)) {
 		ctx->user_ip6[0] = bpf_htonl(DST_REWRITE_IP6_0);
 		ctx->user_ip6[1] = bpf_htonl(DST_REWRITE_IP6_1);
 		ctx->user_ip6[2] = bpf_htonl(DST_REWRITE_IP6_2);
-- 
2.20.1



