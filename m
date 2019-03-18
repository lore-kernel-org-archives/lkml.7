Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE02C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D64E21738
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901564;
	bh=6P/M/6HUDh8X0KQ/qS8Dcnh5Ku/F1JqyRDlCyyRNt/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x59QucWXk4jiuYVvvwTwoCHkCTN+7KX1gdWBBmKMJZj5I8Y1kSTZEx8dKdTj/g8JQ
	 MuIsUahCj1ZiG57ivNbucyL9bUBAEqDzbx30EvGbLvzg9UIACs/DKYAHGlaI0StvHe
	 vxdDOB72Ar0oDAarS5NJmIz8X28HSl7wsq96opUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfCRJcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:32:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728752AbfCRJcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:32:39 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 353C12083D;
        Mon, 18 Mar 2019 09:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901558;
        bh=6P/M/6HUDh8X0KQ/qS8Dcnh5Ku/F1JqyRDlCyyRNt/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TN4JaeIaZlu0xfVRQ5ha5Me7ZR/bUTzOaK6FRhvtI1ov51zQzg5RQMoxhsdI/5O4W
         jN/OdLCww+G8QC3kQfO7TfREAyLjZfXeLbR5Z3/GQXK8LoHxHGjUIYVulIvvQVAjQG
         R+JiBgM4GkrTVw7FpzNzxEbnsWfXAxAYe+c4OL4g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tianhao Zhao <tizhao@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 03/52] ipv4/route: fail early when inet dev is missing
Date:   Mon, 18 Mar 2019 10:25:00 +0100
Message-Id: <20190318084013.931108154@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084013.532280682@linuxfoundation.org>
References: <20190318084013.532280682@linuxfoundation.org>
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
@@ -2155,12 +2155,13 @@ int ip_route_input_rcu(struct sk_buff *s
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


