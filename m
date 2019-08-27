Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C66DC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492FD23405
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892819;
	bh=69ojnWV26qPJI+NpxCShDkke1IE8/Jk1d6Z9qxuxKJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VP2ZOVgr4R8wPUozU8LC6KRSf0cfzWktCblkFQ8koPSd4sZFC9AfSp46omVnyYC8O
	 BxJ4xLvGlTE/VTuPVTDnZi54I3t/BoK2glkbKJy0C2xqH2H2nf0FM9g6XugSQze5iU
	 agUUl2lUwbNqz2P7fnZncP/BDb1Zz95CXBk3fISU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbfH0IAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729561AbfH0IAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:00:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEFE821872;
        Tue, 27 Aug 2019 08:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892812;
        bh=69ojnWV26qPJI+NpxCShDkke1IE8/Jk1d6Z9qxuxKJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iMTt2CW3qVSZrzMqUnkWpO81mz7cApgWSvzQWSOBHik+yZWdo0GFF5RiAklj+gVLJ
         nXw32/w3yQVGr6hiiMi6lS9PcQhmkUujc1s/DcHKvDA0JDEU4IKfwALdpdZsbaW3ya
         Y45iTyd6o74hxhZ/UsAHYLH5wBgfHLJWcpdncmZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 023/162] bpf: sockmap, only create entry if ulp is not already enabled
Date:   Tue, 27 Aug 2019 09:49:11 +0200
Message-Id: <20190827072739.118866463@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072738.093683223@linuxfoundation.org>
References: <20190827072738.093683223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 0e858739c2d2eedeeac1d35bfa0ec3cc2a7190d8 ]

Sockmap does not currently support adding sockets after TLS has been
enabled. There never was a real use case for this so it was never
added. But, we lost the test for ULP at some point so add it here
and fail the socket insert if TLS is enabled. Future work could
make sockmap support this use case but fixup the bug here.

Fixes: 604326b41a6fb ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock_map.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index bbc91597d8364..8a4a45e7c29df 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -339,6 +339,7 @@ static int sock_map_update_common(struct bpf_map *map, u32 idx,
 				  struct sock *sk, u64 flags)
 {
 	struct bpf_stab *stab = container_of(map, struct bpf_stab, map);
+	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct sk_psock_link *link;
 	struct sk_psock *psock;
 	struct sock *osk;
@@ -349,6 +350,8 @@ static int sock_map_update_common(struct bpf_map *map, u32 idx,
 		return -EINVAL;
 	if (unlikely(idx >= map->max_entries))
 		return -E2BIG;
+	if (unlikely(icsk->icsk_ulp_data))
+		return -EINVAL;
 
 	link = sk_psock_init_link();
 	if (!link)
-- 
2.20.1



