Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AE0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6BE214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901331;
	bh=nw+76Cll/wlpncitzBPnBttRYe9uCRGQzog4Z0z4ano=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a0Xj2fx40uLJdZaFJeN0v974fiqwSvHY5iBtIaKqLovGMf51hgYmwEuzSNxVLrhgF
	 1j6KpvQ0WW9328uhtOSVTqKLkwHZAx8LFOp3KWO83MaOvhEQRY4R6mcjq3/8bNI76c
	 +lii26U26fF9sMp8ysYVqfLGEcT2SOaqtROxFBSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfCRJ2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:28:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728120AbfCRJ2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:28:46 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E03AB2087C;
        Mon, 18 Mar 2019 09:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901325;
        bh=nw+76Cll/wlpncitzBPnBttRYe9uCRGQzog4Z0z4ano=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fvm4Es3tkTVyRwhE8bHWWc9cTynKLx7iQzHCb5e0f7Dtg7VfoKJybW5DLF3LQGn9h
         9wCesEpbmnGrdtOp5p4YNJGP3119zzvg/Vxbc6P45UdJUJbKlAZzi3ia+vDUEhS/DW
         nP/6oom+hmAt/LwTx0X0ZVaXOSDslQC5+UyuxEKM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tianhao Zhao <tizhao@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 03/52] ipv4/route: fail early when inet dev is missing
Date:   Mon, 18 Mar 2019 10:24:50 +0100
Message-Id: <20190318083843.807685936@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083843.398913295@linuxfoundation.org>
References: <20190318083843.398913295@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 22c74764aa2943ecdf9f07c900d8a9c8ba6c9265 ]

If a non local multicast packet reaches ip_route_input_rcu() while
the ingress device IPv4 private data (in_dev) is NULL, we end up
doing a NULL pointer dereference in IN_DEV_MFORWARD().

Since the later call to ip_route_input_mc() is going to fail if
!in_dev, we can fail early in such scenario and avoid the dangerous
code path.

v1 -> v2:
 - clarified the commit message, no code changes

Reported-by: Tianhao Zhao <tizhao@redhat.com>
Fixes: e58e41596811 ("net: Enable support for VRF with ipv4 multicast")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/route.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2144,12 +2144,13 @@ int ip_route_input_rcu(struct sk_buff *s
 		int our = 0;
 		int err = -EINVAL;
 
-		if (in_dev)
-			our = ip_check_mc_rcu(in_dev, daddr, saddr,
-					      ip_hdr(skb)->protocol);
+		if (!in_dev)
+			return err;
+		our = ip_check_mc_rcu(in_dev, daddr, saddr,
+				      ip_hdr(skb)->protocol);
 
 		/* check l3 master if no match yet */
-		if ((!in_dev || !our) && netif_is_l3_slave(dev)) {
+		if (!our && netif_is_l3_slave(dev)) {
 			struct in_device *l3_in_dev;
 
 			l3_in_dev = __in_dev_get_rcu(skb->dev);


