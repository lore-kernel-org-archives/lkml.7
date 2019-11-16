Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298FEC43215
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFC72168B
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573921006;
	bh=RFeDsKAaoKwlp4/tSmQK0sxDKUceFFliSMPVIObqmk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ILSj+Hp9r6gA59+6qOF2hLGEud+qH4p+sALh4DxQHBJzLgVYV2ItHzne93n1JUwbn
	 DoE6Qnflsxe8sUclTPm4kzLXIJVQH5QMfcqY2tHeIKHyywb3YAAnpp1ZCBy4u4/cuC
	 Wnv9ZaARu462F8mZd4b+TCGxRIptVu03Askp+aDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfKPPq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:46:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:52706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729358AbfKPPqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:46:23 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E28F4207FA;
        Sat, 16 Nov 2019 15:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919183;
        bh=RFeDsKAaoKwlp4/tSmQK0sxDKUceFFliSMPVIObqmk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JiXUAvgmoWkSYjqNBGKMI1i5Y5ouvx5XB10UEoAnMToRtmxxazVJEJb3leDwY+hMX
         cPQqafRlNd/LGShMw9iJj+sEYsHCKxzkCdTZxD7IZsg8Mc8XbYqRM6L+RHzJJSeT7w
         5To9CE1jLcrCj7dRiXuZOVdApvmLz4v56Lxi0JpI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 191/237] sock_diag: fix autoloading of the raw_diag module
Date:   Sat, 16 Nov 2019 10:40:26 -0500
Message-Id: <20191116154113.7417-191-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

[ Upstream commit c34c1287778b080ed692c0a46a8e345206cc29e6 ]

IPPROTO_RAW isn't registred as an inet protocol, so
inet_protos[protocol] is always NULL for it.

Cc: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>
Fixes: bf2ae2e4bf93 ("sock_diag: request _diag module only when the family or proto has been registered")
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index 6c11078217769..ba4f843cdd1d1 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3347,6 +3347,7 @@ int sock_load_diag_module(int family, int protocol)
 
 #ifdef CONFIG_INET
 	if (family == AF_INET &&
+	    protocol != IPPROTO_RAW &&
 	    !rcu_access_pointer(inet_protos[protocol]))
 		return -ENOENT;
 #endif
-- 
2.20.1

