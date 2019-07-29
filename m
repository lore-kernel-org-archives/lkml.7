Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0316C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F7E217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564428408;
	bh=ozoPLPXd/jrSdZ2FR3JHy5bVrMxX2dEdna7OTOZWhpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VKP2LY57jAbvibvoVfKeYyYvxJF095TjUingo27NuoBUh0bL+bpay40tunVrIxX+k
	 7e87Yaoj2pGpuPVhQLpLIvKK/JqYwYM6gU0kkTKFu0IVuPnR9fNiV82kqhrv/AGkZX
	 nreoA6oz+H7PcgkQEh0amFdKG9mhSTCKUS2EmA4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbfG2T0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:26:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729059AbfG2T0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:26:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BB6A20C01;
        Mon, 29 Jul 2019 19:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428405;
        bh=ozoPLPXd/jrSdZ2FR3JHy5bVrMxX2dEdna7OTOZWhpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kfx+icDotBcaPoL5hdgNpPG/X+heuWxzTWYBfAxYsHk8sAwhG5IjqrlzrpZR052DK
         avlpI8fzUjwHAQ8ScZ5daNjkG9y7fb1Qhb1bo3nKINqVpx9yv1JIQlO77UTZHGK46N
         d+Qbzj6pTskUtG+Eye7569yAABmL1FrvWbyDeKbk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Kirjanov <kda@linux-powerpc.org>,
        Doug Ledford <dledford@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 058/293] ipoib: correcly show a VF hardware address
Date:   Mon, 29 Jul 2019 21:19:09 +0200
Message-Id: <20190729190828.664445391@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 64d701c608fea362881e823b666327f5d28d7ffd ]

in the case of IPoIB with SRIOV enabled hardware
ip link show command incorrecly prints
0 instead of a VF hardware address.

Before:
11: ib1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 2044 qdisc pfifo_fast
state UP mode DEFAULT group default qlen 256
    link/infiniband
80:00:00:66:fe:80:00:00:00:00:00:00:24:8a:07:03:00:a4:3e:7c brd
00:ff:ff:ff:ff:12:40:1b:ff:ff:00:00:00:00:00:00:ff:ff:ff:ff
    vf 0 MAC 00:00:00:00:00:00, spoof checking off, link-state disable,
trust off, query_rss off
...
After:
11: ib1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 2044 qdisc pfifo_fast
state UP mode DEFAULT group default qlen 256
    link/infiniband
80:00:00:66:fe:80:00:00:00:00:00:00:24:8a:07:03:00:a4:3e:7c brd
00:ff:ff:ff:ff:12:40:1b:ff:ff:00:00:00:00:00:00:ff:ff:ff:ff
    vf 0     link/infiniband
80:00:00:66:fe:80:00:00:00:00:00:00:24:8a:07:03:00:a4:3e:7c brd
00:ff:ff:ff:ff:12:40:1b:ff:ff:00:00:00:00:00:00:ff:ff:ff:ff, spoof
checking off, link-state disable, trust off, query_rss off

v1->v2: just copy an address without modifing ifla_vf_mac
v2->v3: update the changelog

Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
Acked-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index e6ff16b27acd..1a93d3d58c8a 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1833,6 +1833,7 @@ static int ipoib_get_vf_config(struct net_device *dev, int vf,
 		return err;
 
 	ivf->vf = vf;
+	memcpy(ivf->mac, dev->dev_addr, dev->addr_len);
 
 	return 0;
 }
-- 
2.20.1



