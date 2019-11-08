Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56D6FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3832067B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240949;
	bh=L8xFWu/+/7/Nkr5p+5Zx106+m2sJDDPUmMD7Cw6e4JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=itVqDRrmnY7i0UZPoP64ZZFT1PjZjk3GVX4dcaqQYKreg41RWQn+ikqVD6Ytinsoe
	 +QoUm7c76w2SgvZDoqMnCctiA3NGcDhc2izXiOTZCjGlmV5/IyfUpuDnp2CzrjYpv6
	 CXJnvVSGLfc6pETkqGrhmGkvtWUYAy6QM3s+dGJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389755AbfKHTW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:22:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:54038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732317AbfKHS40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:56:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A79F214DB;
        Fri,  8 Nov 2019 18:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239385;
        bh=L8xFWu/+/7/Nkr5p+5Zx106+m2sJDDPUmMD7Cw6e4JQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q7z3BhGw43Nsvi1dD0UOQkAT3Zd/kmT/wYUM8w//5bJorj7XcyWEHFiMQ3b37QD/b
         3a8rq4j3jx5YVBA1MM8Jd0MUEBZxb39yZ/QQTS+Cs7brpIee0up/T3nHG7dX7F+Fr0
         PG8oDr7fp0jPHJ5GCH9htQew8MCrMocITQ7+OW9E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Wei Wang <weiwan@google.com>,
        Craig Gallek <cgallek@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 22/34] selftests: net: reuseport_dualstack: fix uninitalized parameter
Date:   Fri,  8 Nov 2019 19:50:29 +0100
Message-Id: <20191108174643.100159854@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174618.266472504@linuxfoundation.org>
References: <20191108174618.266472504@linuxfoundation.org>
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
@@ -128,7 +128,7 @@ static void test(int *rcv_fds, int count
 {
 	struct epoll_event ev;
 	int epfd, i, test_fd;
-	uint16_t test_family;
+	int test_family;
 	socklen_t len;
 
 	epfd = epoll_create(1);
@@ -145,6 +145,7 @@ static void test(int *rcv_fds, int count
 	send_from_v4(proto);
 
 	test_fd = receive_once(epfd, proto);
+	len = sizeof(test_family);
 	if (getsockopt(test_fd, SOL_SOCKET, SO_DOMAIN, &test_family, &len))
 		error(1, errno, "failed to read socket domain");
 	if (test_family != AF_INET)


