Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E15C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106C32184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565291266;
	bh=DAdtXfgx/bifb6FxOTO5QwM7dVYdmXyUQzw6mUtFeMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GLNrtG/rjCDzfgdUz5vwfFDy75CNvZgwF9mbUVEg/cmT2bbfkkAMnvS8mLGqNQNPX
	 Komd4beCbGNrzoMciJfeYCoEdCGBZ/65ijzuFEGkoOTfXvT9f2ElyHdg3v4UpgtQEX
	 V89n1TfZVvVMlARSN3zXcKeQ5Ob1mEcEg9GuQBbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404739AbfHHTHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:07:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404329AbfHHTHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:07:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72D172184E;
        Thu,  8 Aug 2019 19:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565291261;
        bh=DAdtXfgx/bifb6FxOTO5QwM7dVYdmXyUQzw6mUtFeMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ixte5Liq5kbSxZRE83oNHKuOvl83Ph3Tp7ACHNw9UL7mfcHiS+L0UV6d5tII/Ciaj
         pLYQltFuo8QSypuJhX+u/6SGrkNjLp73s8nkAGJi78hwEL+gaSmWbPuQc4swLx+OzW
         psY+FR6FgUBGi+h655MoARj6O8qyWRZobtU75bEI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        David Ahern <dsahern@gmail.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 49/56] rocker: fix memory leaks of fib_work on two error return paths
Date:   Thu,  8 Aug 2019 21:05:15 +0200
Message-Id: <20190808190455.173992870@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808190452.867062037@linuxfoundation.org>
References: <20190808190452.867062037@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 011f175428d46461f94a65dacb9a416529d08dda ]

Currently there are two error return paths that leak memory allocated
to fib_work. Fix this by kfree'ing fib_work before returning.

Addresses-Coverity: ("Resource leak")
Fixes: 19a9d136f198 ("ipv4: Flag fib_info with a fib_nh using IPv6 gateway")
Fixes: dbcc4fa718ee ("rocker: Fail attempts to use routes with nexthop objects")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/rocker/rocker_main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2208,6 +2208,7 @@ static int rocker_router_fib_event(struc
 
 			if (fen_info->fi->fib_nh_is_v6) {
 				NL_SET_ERR_MSG_MOD(info->extack, "IPv6 gateway with IPv4 route is not supported");
+				kfree(fib_work);
 				return notifier_from_errno(-EINVAL);
 			}
 		}


