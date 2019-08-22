Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6974C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D26A233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566493869;
	bh=EsviltkPblFd/n3rlyUYCtG904XtDGAuI+ul5PpmfSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xkWctnXKg+fREoRSvrLwFygdZUlMAUXSSK7AH8wrBpjMK8GSw48fRZ5+WceO9TG4r
	 /NvCeFHQM9wHBw3fHq6jQuxuHenZmPnCFQw+a8A/Zd9fwArOlCYNHi/l786lFMjuoD
	 rBPQ0NQX9Y5l8JdWCMPvTczB6xfJrrMF36EcPYDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390892AbfHVRLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:11:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390719AbfHVRJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:09:17 -0400
Received: from sasha-vm.mshome.net (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94F53233FE;
        Thu, 22 Aug 2019 17:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566493756;
        bh=EsviltkPblFd/n3rlyUYCtG904XtDGAuI+ul5PpmfSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I4Pm2YOlLeYH6S+CjL/vKavG+J4N5ne7hSZ+cufKx2h7bdShyWxi9r4DyYBTcDeed
         QILphDUyOlzbgJPtCb0Trj+cyFslubPFec6nkBGcMfacJs+E5SzYhPDsN4cBzybDKz
         Wh7P2HQMfMbDGMydlCnTmCZO1BQxSU2VdK+j5CDQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.2 115/135] team: Add vlan tx offload to hw_enc_features
Date:   Thu, 22 Aug 2019 13:07:51 -0400
Message-Id: <20190822170811.13303-116-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822170811.13303-1-sashal@kernel.org>
References: <20190822170811.13303-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.2.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.2.10-rc1
X-KernelTest-Deadline: 2019-08-24T17:07+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 227f2f030e28d8783c3d10ce70ff4ba79cad653f ]

We should also enable team's vlan tx offload in hw_enc_features,
pass the vlan packets to the slave devices with vlan tci, let the
slave handle vlan tunneling offload implementation.

Fixes: 3268e5cb494d ("team: Advertise tunneling offload features")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/team/team.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 36916bf51ee6e..d1b4c7d8e2bcb 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1004,6 +1004,8 @@ static void __team_compute_features(struct team *team)
 
 	team->dev->vlan_features = vlan_features;
 	team->dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
+				     NETIF_F_HW_VLAN_CTAG_TX |
+				     NETIF_F_HW_VLAN_STAG_TX |
 				     NETIF_F_GSO_UDP_L4;
 	team->dev->hard_header_len = max_hard_header_len;
 
-- 
2.20.1

