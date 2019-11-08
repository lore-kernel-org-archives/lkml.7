Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472C7FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1333920674
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240711;
	bh=6elECeKqNAc5dMrEOCSnn8CogZkyVM4opF6iM+8jqVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tER2TGsPLR7pGBAtrnBJxu3haPW9GqiyKvArcvQ+5qWDN2NbneAwDiTPyOnJBP/qE
	 tTPpeo1Hc1P7QJZJOkQrJSO41Z5MatuK3vNf3DCDv2z9mCtt3r4KNkzscg7BSoejfn
	 m46LINPGXaZ5YpAqCDDuqR10ejcP/yDWcfTKBURs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390835AbfKHTS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:18:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:57250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389661AbfKHTAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:00:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4501C2249E;
        Fri,  8 Nov 2019 18:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239522;
        bh=6elECeKqNAc5dMrEOCSnn8CogZkyVM4opF6iM+8jqVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=brVdx65ta34UdAItiunlDJzBmcW9PfflIBn7qtpcquDeOcL935n0WeIYBZGDaFyX3
         gQ9Gg7AeUiOk9+S/0oTmQfDXcjWzuAfMjv5AxjtgfEqrEh/ljSXarRH8VwAEdzoosl
         d5ejq7UcSI29wC/xe1MFiq35Vb87C5+rc9vstjIA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Wei Wang <weiwan@google.com>,
        Craig Gallek <cgallek@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 33/62] selftests: net: reuseport_dualstack: fix uninitalized parameter
Date:   Fri,  8 Nov 2019 19:50:21 +0100
Message-Id: <20191108174744.651770471@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174719.228826381@linuxfoundation.org>
References: <20191108174719.228826381@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Wang <weiwan@google.com>

[ Upstream commit d64479a3e3f9924074ca7b50bd72fa5211dca9c1 ]

This test reports EINVAL for getsockopt(SOL_SOCKET, SO_DOMAIN)
occasionally due to the uninitialized length parameter.
Initialize it to fix this, and also use int for "test_family" to comply
with the API standard.

Fixes: d6a61f80b871 ("soreuseport: test mixed v4/v6 sockets")
Reported-by: Maciej Żenczykowski <maze@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Wei Wang <weiwan@google.com>
Cc: Craig Gallek <cgallek@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/reuseport_dualstack.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/net/reuseport_dualstack.c
+++ b/tools/testing/selftests/net/reuseport_dualstack.c
@@ -129,7 +129,7 @@ static void test(int *rcv_fds, int count
 {
 	struct epoll_event ev;
 	int epfd, i, test_fd;
-	uint16_t test_family;
+	int test_family;
 	socklen_t len;
 
 	epfd = epoll_create(1);
@@ -146,6 +146,7 @@ static void test(int *rcv_fds, int count
 	send_from_v4(proto);
 
 	test_fd = receive_once(epfd, proto);
+	len = sizeof(test_family);
 	if (getsockopt(test_fd, SOL_SOCKET, SO_DOMAIN, &test_family, &len))
 		error(1, errno, "failed to read socket domain");
 	if (test_family != AF_INET)


