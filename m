Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9965CC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BBE218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354944;
	bh=/r+1RXDhGMvpkON4sP+q2RhQlyIUMdumIH8ArT0FEWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i6bWUFFkN265AXiDEKto2jAp2F5miBsMC0zPapA0GzO4njFOmVQPuWHkaRRWgeKeq
	 EbiBZf67OU7y49N1Iz/ZCmo9srpYBAVKCK2vfwilbKn4O8MhCCSUq26KY/iXNDcy3G
	 ePT47NLKZytN4mcjKIrzPhn9QNsT9LNG2IBQ38Wk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfDOTCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:02:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728659AbfDOTCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:02:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E00F02087C;
        Mon, 15 Apr 2019 19:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354940;
        bh=/r+1RXDhGMvpkON4sP+q2RhQlyIUMdumIH8ArT0FEWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xaYdVZpBDoPMGDA1Kl6PaSg259Ho6KKHc78H5IJ65+27IrcD/NT3lvxjG6Q1QsVjf
         aFcBQwmkfT+u8b3dgFW6daSlcIJ9aykeCsIWrEakZzaj+zZofNi6BKYG29NmZa/vc+
         nimPqIQQTyWKjYYDTOdWk3GscRcOTYlpwr8w4yS4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yotam Gigi <yotamg@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 22/69] net/sched: fix ->get helper of the matchall cls
Date:   Mon, 15 Apr 2019 20:58:40 +0200
Message-Id: <20190415183730.445550198@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>

[ Upstream commit 0db6f8befc32c68bb13d7ffbb2e563c79e913e13 ]

It returned always NULL, thus it was never possible to get the filter.

Example:
$ ip link add foo type dummy
$ ip link add bar type dummy
$ tc qdisc add dev foo clsact
$ tc filter add dev foo protocol all pref 1 ingress handle 1234 \
	matchall action mirred ingress mirror dev bar

Before the patch:
$ tc filter get dev foo protocol all pref 1 ingress handle 1234 matchall
Error: Specified filter handle not found.
We have an error talking to the kernel

After:
$ tc filter get dev foo protocol all pref 1 ingress handle 1234 matchall
filter ingress protocol all pref 1 matchall chain 0 handle 0x4d2
  not_in_hw
        action order 1: mirred (Ingress Mirror to device bar) pipe
        index 1 ref 1 bind 1

CC: Yotam Gigi <yotamg@mellanox.com>
CC: Jiri Pirko <jiri@mellanox.com>
Fixes: fd62d9f5c575 ("net/sched: matchall: Fix configuration race")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_matchall.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/sched/cls_matchall.c
+++ b/net/sched/cls_matchall.c
@@ -125,6 +125,11 @@ static void mall_destroy(struct tcf_prot
 
 static void *mall_get(struct tcf_proto *tp, u32 handle)
 {
+	struct cls_mall_head *head = rtnl_dereference(tp->root);
+
+	if (head && head->handle == handle)
+		return head;
+
 	return NULL;
 }
 


