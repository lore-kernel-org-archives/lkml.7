Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968CFC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DA921906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948224;
	bh=kl6y0PIDllbuDfQrNxUtupro8sXWdcpAf3l3oGOT+VQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JsfnmOLIMnvpCdD8P5mU/GNoMyckE1LcWrR1p539XX7hqeL0rGwofiK8KU8o9vQeQ
	 BAy6gQmealrmFhx1wqMEllUT6Q7mKcY8du1yBp+KPkSWGYdLQgPezueXL84BvqDyTr
	 MQ96eeelyRGiHc5/AtLogLkSvBwvfyHlQooDffTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732718AbfJAQnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:43:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732798AbfJAQne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:43:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AE2820B7C;
        Tue,  1 Oct 2019 16:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948214;
        bh=kl6y0PIDllbuDfQrNxUtupro8sXWdcpAf3l3oGOT+VQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yToVYshRSWwdDugHqI1dEpVxEY7WGsZA3DDg1D7PgGpMAznHnRvr/DAgZbmll4I0z
         AsiBbXGRRoZDQgFdG8yVk2r6ZTKMBrLSKk7eIK9L/TSmLvy4qXMhmpyThMhyh4XpdG
         JZBm8EOvsKtW6rdIQ99MRufw++76V7EQRUlEJT7M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Davide Caratti <dcaratti@redhat.com>,
        Yotam Gigi <yotam.gi@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 16/43] net/sched: act_sample: don't push mac header on ip6gre ingress
Date:   Tue,  1 Oct 2019 12:42:44 -0400
Message-Id: <20191001164311.15993-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001164311.15993-1-sashal@kernel.org>
References: <20191001164311.15993-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit 92974a1d006ad8b30d53047c70974c9e065eb7df ]

current 'sample' action doesn't push the mac header of ingress packets if
they are received by a layer 3 tunnel (like gre or sit); but it forgot to
check for gre over ipv6, so the following script:

 # tc q a dev $d clsact
 # tc f a dev $d ingress protocol ip flower ip_proto icmp action sample \
 > group 100 rate 1
 # psample -v -g 100

dumps everything, including outer header and mac, when $d is a gre tunnel
over ipv6. Fix this adding a missing label for ARPHRD_IP6GRE devices.

Fixes: 5c5670fae430 ("net/sched: Introduce sample tc action")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Reviewed-by: Yotam Gigi <yotam.gi@gmail.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_sample.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
index 98635311a5a0b..ea0738ceb5bb8 100644
--- a/net/sched/act_sample.c
+++ b/net/sched/act_sample.c
@@ -134,6 +134,7 @@ static bool tcf_sample_dev_ok_push(struct net_device *dev)
 	case ARPHRD_TUNNEL6:
 	case ARPHRD_SIT:
 	case ARPHRD_IPGRE:
+	case ARPHRD_IP6GRE:
 	case ARPHRD_VOID:
 	case ARPHRD_NONE:
 		return false;
-- 
2.20.1

