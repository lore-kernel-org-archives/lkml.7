Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4D0C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE06F21556
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889641;
	bh=bh4SqCjFKFTC4hPHeEUDcPS3MRbmu9WKzAozBWFuTJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xD6UtxElIQA2YTZhGaCMoLqgjbU1kTVDZTeoXWi2Z6IzKPldmsjdzGeL8YbfwVyWm
	 mhugfkatZApUmR1hVJmht2okllGEoGuqy7AkKyW0MpizoQS+kVGDN/CH1zsi9cxHn1
	 w2VI9VAzCG/XsiSkWLg8Ds4EvQeCbMxc3pEuQr7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732771AbfK0VIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:08:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:35032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732372AbfK0VId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:08:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83349215F1;
        Wed, 27 Nov 2019 21:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888913;
        bh=bh4SqCjFKFTC4hPHeEUDcPS3MRbmu9WKzAozBWFuTJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bz8IDKxxHYMV72iz9YKt996O0yPekC0nYsheVeokRmqf40gpWksjBQrKrkaQ+8k3g
         fL4kAFqxIPe/YvsbG64Y3wozEKabNEnuevgqGq8YtG3AsVi+yleMQfdXqz1bZqRqYy
         2hXHyNn/VnuvFgDRoE8e+bUA7F8IQ6Hkt5sizxdE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 12/95] ipv6/route: return if there is no fib_nh_gw_family
Date:   Wed, 27 Nov 2019 21:31:29 +0100
Message-Id: <20191127202850.020132831@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202845.651587549@linuxfoundation.org>
References: <20191127202845.651587549@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 004b39427f945696db30abb2c4e1a3856ffff819 ]

Previously we will return directly if (!rt || !rt->fib6_nh.fib_nh_gw_family)
in function rt6_probe(), but after commit cc3a86c802f0
("ipv6: Change rt6_probe to take a fib6_nh"), the logic changed to
return if there is fib_nh_gw_family.

Fixes: cc3a86c802f0 ("ipv6: Change rt6_probe to take a fib6_nh")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -634,7 +634,7 @@ static void rt6_probe(struct fib6_nh *fi
 	 * Router Reachability Probe MUST be rate-limited
 	 * to no more than one per minute.
 	 */
-	if (fib6_nh->fib_nh_gw_family)
+	if (!fib6_nh->fib_nh_gw_family)
 		return;
 
 	nh_gw = &fib6_nh->fib_nh_gw6;


