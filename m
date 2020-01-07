Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F76FC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1602072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431508;
	bh=LMGnbq7VsXdnreuMntaFzZg5sCR7w9Fdjn4OQKXrx6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IpAvoTJvG5KrygSRhRkuUj+BF+YEgWeoZJSS0xfvfy/pYl5wbwzUp4RCpsvPyDxR3
	 AdS4Fwou32qpXDg7uLcdCYFJZKKewUty0ockpTheknljFshwajI0LVOr/rlF/hj3Uc
	 qERDZpMVK4EZ5S9aRWdwFnjMydMR9amp3VOXXM50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbgAGVLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:11:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:40616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730129AbgAGVLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:11:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02CE72077B;
        Tue,  7 Jan 2020 21:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431500;
        bh=LMGnbq7VsXdnreuMntaFzZg5sCR7w9Fdjn4OQKXrx6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f8z9EPi7IaLefdETJSSp1YltmdO6JwqamO9If1WjF1r0eohIrw5NGi0DtQ+O8SnDJ
         jR5Ig+CyMF5imzCzbHSUAbHFazPx3VTkZfPmjrHNp3ouiYk9F8+Uuu0tv+qWJEjshT
         Sp/B3hDJmpxM7273McP6uYnCCsyUNB5NxQM04XZk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 64/74] selftests: rtnetlink: add addresses with fixed life time
Date:   Tue,  7 Jan 2020 21:55:29 +0100
Message-Id: <20200107205227.111178135@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205135.369001641@linuxfoundation.org>
References: <20200107205135.369001641@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 3cfa148826e3c666da1cc2a43fbe8689e2650636 ]

This exercises kernel code path that deal with addresses that have
a limited lifetime.

Without previous fix, this triggers following crash on net-next:
 BUG: KASAN: null-ptr-deref in check_lifetime+0x403/0x670
 Read of size 8 at addr 0000000000000010 by task kworker [..]

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/rtnetlink.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 891130daac7c..8a5066d98e72 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -195,6 +195,26 @@ kci_test_route_get()
 	echo "PASS: route get"
 }
 
+kci_test_addrlft()
+{
+	for i in $(seq 10 100) ;do
+		lft=$(((RANDOM%3) + 1))
+		ip addr add 10.23.11.$i/32 dev "$devdummy" preferred_lft $lft valid_lft $((lft+1))
+		check_err $?
+	done
+
+	sleep 5
+
+	ip addr show dev "$devdummy" | grep "10.23.11."
+	if [ $? -eq 0 ]; then
+		echo "FAIL: preferred_lft addresses remaining"
+		check_err 1
+		return
+	fi
+
+	echo "PASS: preferred_lft addresses have expired"
+}
+
 kci_test_addrlabel()
 {
 	ret=0
@@ -245,6 +265,7 @@ kci_test_rtnl()
 
 	kci_test_polrouting
 	kci_test_route_get
+	kci_test_addrlft
 	kci_test_tc
 	kci_test_gre
 	kci_test_bridge
-- 
2.20.1



