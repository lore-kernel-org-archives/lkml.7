Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C287C2D0DA
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C86120722
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640483;
	bh=aQwAyh+Sp2IeI16kUaqLhGUu5rlmKirX7GMm9Icmtk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=egxfqaL5eE9lbs5J+Z57KmnY+9wrMVqaxloI90ZfkrNP/7mQCs96XZv4+NJ2n0Kc1
	 seecTUahmr9/lFt5ClzThwDRoWxORqTl6b4iEreKjsTxI0AfFE6uWSoJp4EoFPG6am
	 CPerMtCTBym4bf07NiyXa7ZOiaoN5pVr9KbTC6VM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfL2R2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:28:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:50818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728510AbfL2R16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:27:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFDFE20722;
        Sun, 29 Dec 2019 17:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640478;
        bh=aQwAyh+Sp2IeI16kUaqLhGUu5rlmKirX7GMm9Icmtk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kcFE7mr1DNyVwV2i6GIjObh5zBwoSp6mbWRuMtgriOEMwTtIYH85Ikg06ondrbVQC
         szmLVTuPkDMu74V381ZfP7EoNHvwgqcrPX3hDhcwqZ5rEPKmJM0rk42Nz9wTt1pswq
         L/qBvDRcLeqLzleGbesNaCrwRkNohANlKEXWrqFk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 013/219] selftests: forwarding: Delete IPv6 address at the end
Date:   Sun, 29 Dec 2019 18:16:55 +0100
Message-Id: <20191229162510.995471060@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit 65cb13986229cec02635a1ecbcd1e2dd18353201 ]

When creating the second host in h2_create(), two addresses are assigned
to the interface, but only one is deleted. When running the test twice
in a row the following error is observed:

$ ./router_bridge_vlan.sh
TEST: ping                                                          [ OK ]
TEST: ping6                                                         [ OK ]
TEST: vlan                                                          [ OK ]
$ ./router_bridge_vlan.sh
RTNETLINK answers: File exists
TEST: ping                                                          [ OK ]
TEST: ping6                                                         [ OK ]
TEST: vlan                                                          [ OK ]

Fix this by deleting the address during cleanup.

Fixes: 5b1e7f9ebd56 ("selftests: forwarding: Test routed bridge interface")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/forwarding/router_bridge_vlan.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/net/forwarding/router_bridge_vlan.sh
+++ b/tools/testing/selftests/net/forwarding/router_bridge_vlan.sh
@@ -36,7 +36,7 @@ h2_destroy()
 {
 	ip -6 route del 2001:db8:1::/64 vrf v$h2
 	ip -4 route del 192.0.2.0/28 vrf v$h2
-	simple_if_fini $h2 192.0.2.130/28
+	simple_if_fini $h2 192.0.2.130/28 2001:db8:2::2/64
 }
 
 router_create()


