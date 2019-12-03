Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EC7C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1476420863
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413737;
	bh=aEig3xLJ0ayeEDQUT+Zv0DbOuIHBjOVxj1yI+WpZ7DI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nSQoP7dyT9umJKkAdtN+haYEH9Aab8l20gu0V9gL6yZJ308q/rf9uqco0j9E9En/P
	 vUCjon7C+laoZ6kA7OskiEzC6mp29DuxPNoRUxHZES3PxVkHlRRsJnLOy6GvnppZ3u
	 MZbwFsNa9HmGAQigXUM05ovAPRvKo/2Rpiof08Co=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbfLCWzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:55:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:49882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728988AbfLCWz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:55:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F72C217D9;
        Tue,  3 Dec 2019 22:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413728;
        bh=aEig3xLJ0ayeEDQUT+Zv0DbOuIHBjOVxj1yI+WpZ7DI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=to8Rl+XOr0izzPN9LUbGwKFx8DtTg1fZ8jPQH3IB0/bFlsKYtW477sX5JcX1+Crwc
         TNPXn9HCuquhAnIkgCetxAYvdyP5JpPJV8oA4dbu4sEsdDCheIvLCb1t43wiP9iigJ
         IQQUM9k4ISDlK5iWyswQaFC23nDtCDcJ+EZH/BK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peng Sun <sironhide0null@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 239/321] bpf: decrease usercnt if bpf_map_new_fd() fails in bpf_map_get_fd_by_id()
Date:   Tue,  3 Dec 2019 23:35:05 +0100
Message-Id: <20191203223439.576369519@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Sun <sironhide0null@gmail.com>

[ Upstream commit 781e62823cb81b972dc8652c1827205cda2ac9ac ]

In bpf/syscall.c, bpf_map_get_fd_by_id() use bpf_map_inc_not_zero()
to increase the refcount, both map->refcnt and map->usercnt. Then, if
bpf_map_new_fd() fails, should handle map->usercnt too.

Fixes: bd5f5f4ecb78 ("bpf: Add BPF_MAP_GET_FD_BY_ID")
Signed-off-by: Peng Sun <sironhide0null@gmail.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6e544e364821e..90bb0c05c10e9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1887,7 +1887,7 @@ static int bpf_map_get_fd_by_id(const union bpf_attr *attr)
 
 	fd = bpf_map_new_fd(map, f_flags);
 	if (fd < 0)
-		bpf_map_put(map);
+		bpf_map_put_with_uref(map);
 
 	return fd;
 }
-- 
2.20.1



