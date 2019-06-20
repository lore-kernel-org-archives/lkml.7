Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E34C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E503214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054242;
	bh=Iz+s5FrWakQFdWSwoRfCM8MiMavQPXKCX7ztijiLTUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UjQEWqmV1C+hw1wMXuKO0RszpePEl39t4B4MxMEQPDPTPwyhp8HOeVP3rrYJCJojQ
	 ywoSijVsBiFcY5BUoIXUQqKtQnUD1TOOLzEXdAShOFo/1vmrzI99Y8awkL/QvW9Di+
	 4lwzACzhcE0xNuNzEeVp7yIyR1lY5GzkYVFcHSUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfFTSKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbfFTSKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:10:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96E4B214AF;
        Thu, 20 Jun 2019 18:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054238;
        bh=Iz+s5FrWakQFdWSwoRfCM8MiMavQPXKCX7ztijiLTUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JoTMmaBIZKd6bao18NCXEVcYh+8T+oezzZE5/RQez/a5p7VsO8XCJOgHfGkMjsilR
         anuBy7XqFe+qoCdEK7Of8Nq7y/zzWRE09XpUucobhS5QKBZw91RmhDQ4sbHA0WmobB
         oXi/fjyhwmhed2OvHNAlR65kDiBJ64JudK8mPz2Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jeffrin Jose T <jeffrin@rajagiritech.edu.in>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 21/61] selftests: netfilter: missing error check when setting up veth interface
Date:   Thu, 20 Jun 2019 19:57:16 +0200
Message-Id: <20190620174340.892636886@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174336.357373754@linuxfoundation.org>
References: <20190620174336.357373754@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 82ce6eb1dd13fd12e449b2ee2c2ec051e6f52c43 ]

A test for the basic NAT functionality uses ip command which needs veth
device. There is a condition where the kernel support for veth is not
compiled into the kernel and the test script breaks. This patch contains
code for reasonable error display and correct code exit.

Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/netfilter/nft_nat.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/netfilter/nft_nat.sh b/tools/testing/selftests/netfilter/nft_nat.sh
index 8ec76681605c..f25f72a75cf3 100755
--- a/tools/testing/selftests/netfilter/nft_nat.sh
+++ b/tools/testing/selftests/netfilter/nft_nat.sh
@@ -23,7 +23,11 @@ ip netns add ns0
 ip netns add ns1
 ip netns add ns2
 
-ip link add veth0 netns ns0 type veth peer name eth0 netns ns1
+ip link add veth0 netns ns0 type veth peer name eth0 netns ns1 > /dev/null 2>&1
+if [ $? -ne 0 ];then
+    echo "SKIP: No virtual ethernet pair device support in kernel"
+    exit $ksft_skip
+fi
 ip link add veth1 netns ns0 type veth peer name eth0 netns ns2
 
 ip -net ns0 link set lo up
-- 
2.20.1



