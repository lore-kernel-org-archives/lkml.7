Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1C8C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A3E21882
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573919659;
	bh=H6bctPRfq8XqJuzYNECQWMiThWRjYOGOSX2ux+jZzI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bwpqNJAVOTmDu5R0GVh3dwHgwNC5g7XIATNmDH9q+4JVp+Bn2qP8MjfFDuRVLFDRU
	 wKm4XUk9au7eRXXD6xpiqnYiEoL/GtHvJv80KseVXZaEJHPl6N2hAqk4Im5lgVYuiW
	 3jGtMa9D9Wi3s311ZzRTwXVZr6CyMUR+ve+5EVH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731418AbfKPPyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:54:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:35518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731388AbfKPPyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:54:04 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDB8421920;
        Sat, 16 Nov 2019 15:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919644;
        bh=H6bctPRfq8XqJuzYNECQWMiThWRjYOGOSX2ux+jZzI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o19lAeaZjt+dpcPLUY9/6AaHYHr+vcfw3CK9HwLnx4PLwjbCK8ec/rJzzIX73FLWy
         U9HsM8xAeJ90kGgkMc0qX+baO3w0oXVMQCJBf6z9Ccw6ukos/OfDnGewy9P1G7P1x6
         zWwkGwvhEQ9XXBFRPyG9yp2uEfA0De+DixifRpKc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kyeongdon Kim <kyeongdon.kim@lge.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 22/77] net: fix warning in af_unix
Date:   Sat, 16 Nov 2019 10:52:44 -0500
Message-Id: <20191116155339.11909-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116155339.11909-1-sashal@kernel.org>
References: <20191116155339.11909-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kyeongdon Kim <kyeongdon.kim@lge.com>

[ Upstream commit 33c4368ee2589c165aebd8d388cbd91e9adb9688 ]

This fixes the "'hash' may be used uninitialized in this function"

net/unix/af_unix.c:1041:20: warning: 'hash' may be used uninitialized in this function [-Wmaybe-uninitialized]
  addr->hash = hash ^ sk->sk_type;

Signed-off-by: Kyeongdon Kim <kyeongdon.kim@lge.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/unix/af_unix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index b1a72615fdc30..b5e2ef242efe7 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -224,6 +224,8 @@ static inline void unix_release_addr(struct unix_address *addr)
 
 static int unix_mkname(struct sockaddr_un *sunaddr, int len, unsigned int *hashp)
 {
+	*hashp = 0;
+
 	if (len <= sizeof(short) || len > sizeof(*sunaddr))
 		return -EINVAL;
 	if (!sunaddr || sunaddr->sun_family != AF_UNIX)
-- 
2.20.1

