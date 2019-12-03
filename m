Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F5CC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6074F21582
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413718;
	bh=zXt9GqHUeIEH2vibE824zaULD6dlD3GFqN4+W2MhxWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dnRTD8PwnwgwFxq/dKdK6NUb1wR7+crvIZt+fMyvOacn0opN088nSYrcqsir0NXXS
	 4dKyWLw3qOi+bcRHNEQ/djf6nxk5DusJpQmC1c7SWfrJtrFzVcxvyhk/zHsx1I0KUi
	 lbCsJnrJo5cpIpJK5wQEEICwBTA9wB5QTNuwwK1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbfLCWzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:55:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:49486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730246AbfLCWzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:55:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDCD420674;
        Tue,  3 Dec 2019 22:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413714;
        bh=zXt9GqHUeIEH2vibE824zaULD6dlD3GFqN4+W2MhxWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PDD88H4R8lOzmcCqy3C55o2P9E+dRI8wvffX6FzlMxRBtffViqKn/3rjSehcsYQH8
         4+iVGCk2xutDzzBipnPGmQhOosDFTIoXM8rIA4HxqEmg6vW6amLGcgbp9pG4Pw3LbK
         HrZcWb/pH2MhOzBSCAQs+PEF6uL/vUGzf2Q2mBQU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matteo Croce <mcroce@redhat.com>,
        Davide Caratti <dcaratti@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        Andrea Claudi <aclaudi@redhat.com>
Subject: [PATCH 4.19 234/321] geneve: change NET_UDP_TUNNEL dependency to select
Date:   Tue,  3 Dec 2019 23:35:00 +0100
Message-Id: <20191203223439.304940377@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@redhat.com>

[ Upstream commit a7603ac1fc8ce1409f8ff70e6ce505f308b2c002 ]

Due to the depends on NET_UDP_TUNNEL, at the moment it is impossible to
compile GENEVE if no other protocol depending on NET_UDP_TUNNEL is
selected.

Fix this changing the depends to a select, and drop NET_IP_TUNNEL from the
select list, as it already depends on NET_UDP_TUNNEL.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
Reviewed-and-tested-by: Andrea Claudi <aclaudi@redhat.com>
Tested-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 619bf1498a662..0652caad57ec1 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -197,9 +197,9 @@ config VXLAN
 
 config GENEVE
        tristate "Generic Network Virtualization Encapsulation"
-       depends on INET && NET_UDP_TUNNEL
+       depends on INET
        depends on IPV6 || !IPV6
-       select NET_IP_TUNNEL
+       select NET_UDP_TUNNEL
        select GRO_CELLS
        ---help---
 	  This allows one to create geneve virtual interfaces that provide
-- 
2.20.1



