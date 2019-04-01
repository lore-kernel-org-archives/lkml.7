Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBC4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F13720883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141886;
	bh=/aI0XT5ZZJ1QiEWrwz/JwDd848hKTZRioVqDiI5Ntoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pWyQgwbWMPP7q/FqQZp8ZV5ZFfwb2v2kRMtUhPh+Qa1uK4JiqAz1hvgHMh6LBUrJQ
	 grgpOoUeB4wz5hL0TkOtFScNjREOPh9DOWeiFWNa6oa23Nr5O5A4IUuJ9xBIXYGdmi
	 JUQBeiFGyOtIL/Vh1Cw14X0igTj0+8dZqWVvP8L0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbfDASEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729085AbfDARNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:13:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0194321934;
        Mon,  1 Apr 2019 17:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138826;
        bh=/aI0XT5ZZJ1QiEWrwz/JwDd848hKTZRioVqDiI5Ntoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uZDi/XVZKMEkj9ltjb93p+U7Tdg0qjLKL4tcmFnMqOXoUd0AOJrOSFqu3w03c6l8P
         fcI+xipnZZpg5boiC+ivsh5iDmTc8i+7+y74vuj8hPxEaGqUhAO8k5+Lz7wxKMqye1
         AJD3LEOep3ske/0oTXrw4U9LVLRFvFQnVvswLtUk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matteo Croce <mcroce@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 006/134] gtp: change NET_UDP_TUNNEL dependency to select
Date:   Mon,  1 Apr 2019 19:00:42 +0200
Message-Id: <20190401170044.911827118@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matteo Croce <mcroce@redhat.com>

[ Upstream commit c22da36688d6298f2e546dcc43fdc1ad35036467 ]

Similarly to commit a7603ac1fc8c ("geneve: change NET_UDP_TUNNEL
dependency to select"), GTP has a dependency on NET_UDP_TUNNEL which
makes impossible to compile it if no other protocol depending on
NET_UDP_TUNNEL is selected.

Fix this by changing the depends to a select, and drop NET_IP_TUNNEL from
the select list, as it already depends on NET_UDP_TUNNEL.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -213,8 +213,8 @@ config GENEVE
 
 config GTP
 	tristate "GPRS Tunneling Protocol datapath (GTP-U)"
-	depends on INET && NET_UDP_TUNNEL
-	select NET_IP_TUNNEL
+	depends on INET
+	select NET_UDP_TUNNEL
 	---help---
 	  This allows one to create gtp virtual interfaces that provide
 	  the GPRS Tunneling Protocol datapath (GTP-U). This tunneling protocol


