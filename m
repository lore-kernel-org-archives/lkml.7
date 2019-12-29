Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C251C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A1E207FD
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641443;
	bh=aQwAyh+Sp2IeI16kUaqLhGUu5rlmKirX7GMm9Icmtk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o689PDgbwLx+HM625N/37OAaYXDCRUIOGeq6aWM23nYzt9nX8rj0r3dnms7amy9G7
	 /BQnYX5J4CgReMfyBTbQBAfvzhXRrH0+ISIoxomgdjDMFGtKrZ0hxSV98so07r9Ni7
	 Ecv4iR/mhy3qrYdip3R3SVt1it4QUtTZaZBKqtyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfL2RoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:44:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:51854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730597AbfL2RoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:44:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99406222D9;
        Sun, 29 Dec 2019 17:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641440;
        bh=aQwAyh+Sp2IeI16kUaqLhGUu5rlmKirX7GMm9Icmtk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vob3vCZy5DcHc9BWXosw9Mq+odQobPQNEQojo5uI8ECW8Hwaz3kkCT/Dcop+PjaSb
         N3915GAra8E+9XBHjAeNfhtcL/DEpwjWbx6bsduGoEHWN6BNh0149NnO8jWCMtXRWb
         DMtkueG1MqoiOiDRfA8FidZwIsHRGcnqqvsK/uXc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 017/434] selftests: forwarding: Delete IPv6 address at the end
Date:   Sun, 29 Dec 2019 18:21:10 +0100
Message-Id: <20191229172703.337144299@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
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


