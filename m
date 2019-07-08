Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F7EC606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C93320665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600369;
	bh=p9xirMo3Akn2+iFlX+haPMDpXhsTu+pv8pcY2BZgfF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hkN0OSJmWbqalWDgkB8RWZqUvH4WE9Fgo8la56J5y+MQ+davd/KoFKu6rQGrXNIEV
	 g8M5s4P1ZHo5fG2NqcKFcN+UzazpgG+4poxe7g/EuyQN/Y8R1hV3btltwjPdInfEMq
	 jDWAEn/Q5PTWo9bW/8iQcvUcVtKicsJDfOZB+y3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390777AbfGHPj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:39:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389484AbfGHP32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:29:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01F2C21707;
        Mon,  8 Jul 2019 15:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599768;
        bh=p9xirMo3Akn2+iFlX+haPMDpXhsTu+pv8pcY2BZgfF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y3/bFSGk4IxVO5yte1BDCvsqEuvKFQWW9DyKGG22iTvIn5iTkImVw7J97hc2Omg2r
         Wkj+3IRUlzvCZ/0+h/D6VOhFXrt/DVJ+XUBQnpzbT2q1a72IT9pipeB5B9S30clS7O
         yO9usLtyJwCFsSaK715Dn0pO0NOEhrDXFTe/OONY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 71/90] selftests: fib_rule_tests: Fix icmp proto with ipv6
Date:   Mon,  8 Jul 2019 17:13:38 +0200
Message-Id: <20190708150525.918247892@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150521.829733162@linuxfoundation.org>
References: <20190708150521.829733162@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 15d55bae4e3c43cd9f87fd93c73a263e172d34e1 ]

A recent commit returns an error if icmp is used as the ip-proto for
IPv6 fib rules. Update fib_rule_tests to send ipv6-icmp instead of icmp.

Fixes: 5e1a99eae8499 ("ipv4: Add ICMPv6 support when parse route ipproto")
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/fib_rule_tests.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index dbd90ca73e44..1ba069967fa2 100755
--- a/tools/testing/selftests/net/fib_rule_tests.sh
+++ b/tools/testing/selftests/net/fib_rule_tests.sh
@@ -148,8 +148,8 @@ fib_rule6_test()
 
 	fib_check_iproute_support "ipproto" "ipproto"
 	if [ $? -eq 0 ]; then
-		match="ipproto icmp"
-		fib_rule6_test_match_n_redirect "$match" "$match" "ipproto icmp match"
+		match="ipproto ipv6-icmp"
+		fib_rule6_test_match_n_redirect "$match" "$match" "ipproto ipv6-icmp match"
 	fi
 }
 
-- 
2.20.1



