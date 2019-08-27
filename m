Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51B8C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1F82186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893436;
	bh=pGPT17zemIypPs4484MhBsruKNxsWbR1OeIuUDDVENw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Ua91gVOSG3TsJGsUHErpvFvT2affyv2oI9V4tFyuqw9qhre/B1DXLoVI9FFIuIYR
	 5BML5sELBzm1YkG1oY1hEx5elMD6J9vLDKls+ocx9iWzg979wcbF4XuHazdEUCxNFf
	 DdKPR0aFsGpD1D2zceXDhTb6ZDPG6vsn7/bD6qLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbfH0ICa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:02:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731872AbfH0ICM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:02:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A7722189D;
        Tue, 27 Aug 2019 08:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892931;
        bh=pGPT17zemIypPs4484MhBsruKNxsWbR1OeIuUDDVENw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HUHHp5qBW/PWFZOqNADm6NNTHPfJWdm4eiSL1DeL8wpI1iJXnJ6E4p2zNdRiVTvMV
         vG9M0UxLZ2hrjj2NlxTAlWjygwuO0d0li8Rrc0q2RFhj+W6HXVm9x8YsL5S7BP6H+a
         wmF1jmrijLfLczagEEs5WGOg95C/X4+Rn3KtwFeQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 021/162] bpf: sockmap, sock_map_delete needs to use xchg
Date:   Tue, 27 Aug 2019 09:49:09 +0200
Message-Id: <20190827072739.059531604@linuxfoundation.org>
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

[ Upstream commit 45a4521dcbd92e71c9e53031b40e34211d3b4feb ]

__sock_map_delete() may be called from a tcp event such as unhash or
close from the following trace,

  tcp_bpf_close()
    tcp_bpf_remove()
      sk_psock_unlink()
        sock_map_delete_from_link()
          __sock_map_delete()

In this case the sock lock is held but this only protects against
duplicate removals on the TCP side. If the map is free'd then we have
this trace,

  sock_map_free
    xchg()                  <- replaces map entry
    sock_map_unref()
      sk_psock_put()
        sock_map_del_link()

The __sock_map_delete() call however uses a read, test, null over the
map entry which can result in both paths trying to free the map
entry.

To fix use xchg in TCP paths as well so we avoid having two references
to the same map entry.

Fixes: 604326b41a6fb ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock_map.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index be6092ac69f8a..1d40e040320d2 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -281,16 +281,20 @@ static int __sock_map_delete(struct bpf_stab *stab, struct sock *sk_test,
 			     struct sock **psk)
 {
 	struct sock *sk;
+	int err = 0;
 
 	raw_spin_lock_bh(&stab->lock);
 	sk = *psk;
 	if (!sk_test || sk_test == sk)
-		*psk = NULL;
+		sk = xchg(psk, NULL);
+
+	if (likely(sk))
+		sock_map_unref(sk, psk);
+	else
+		err = -EINVAL;
+
 	raw_spin_unlock_bh(&stab->lock);
-	if (unlikely(!sk))
-		return -EINVAL;
-	sock_map_unref(sk, psk);
-	return 0;
+	return err;
 }
 
 static void sock_map_delete_from_link(struct bpf_map *map, struct sock *sk,
-- 
2.20.1



