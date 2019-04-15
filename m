Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2693AC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE4D20643
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355965;
	bh=66jNpKlnHtHHELWVA2FKqftkX/iHRLCI62WoKWFXWjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uhVoPdgp+7WM3K5QbtKq0IVXS23tszGSbixAIu5rzJgeeCRc6Jcd7LsSoDntXzjsG
	 6kZpND+33OtfOgUhE/1d8IqsbZ8evf432mbaDt9ZBxGTOf8Jp1yiOpalmMnzwx2so6
	 ClfLqKmC2q3Nhvn2/+pql4hyqqpraj7isyQDVfQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbfDOTKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:10:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731034AbfDOTKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:10:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0976620880;
        Mon, 15 Apr 2019 19:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355432;
        bh=66jNpKlnHtHHELWVA2FKqftkX/iHRLCI62WoKWFXWjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tXL06TIu8AtFpcDcMiboT/JeYlLbbNGP2idcZeOjPYQqC5RrQq610DiwSsz+sfSD9
         2Yq1eykQwr0guBNF3vy6dVr1kk7ruytDbx4TYZKJJXp3U6xTrdAsxefXq+zKrf6Unh
         hNxUeCoEt1E8GXNioSwsd9b4WVlcgGD+i6W8smYI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yotam Gigi <yotamg@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 018/117] net/sched: fix ->get helper of the matchall cls
Date:   Mon, 15 Apr 2019 20:59:48 +0200
Message-Id: <20190415183745.820537727@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/cls_matchall.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sched/cls_matchall.c b/net/sched/cls_matchall.c
index 0e408ee9dcec..5ba07cd11e31 100644
--- a/net/sched/cls_matchall.c
+++ b/net/sched/cls_matchall.c
@@ -125,6 +125,11 @@ static void mall_destroy(struct tcf_proto *tp, struct netlink_ext_ack *extack)
 
 static void *mall_get(struct tcf_proto *tp, u32 handle)
 {
+	struct cls_mall_head *head = rtnl_dereference(tp->root);
+
+	if (head && head->handle == handle)
+		return head;
+
 	return NULL;
 }
 
-- 
2.19.1



