Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C04C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDE120865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119350;
	bh=vg6DsUyf4XVIFXgZdWx6wo3jzA2TDOouGPZg9zo/8JY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eR1JQkM+fdfMhcSd1+IC4/jrchAMrr/CnNCxbXNJUdeaO68PsqaJxzASuUJg0HnoM
	 rSN4q4rgP6/cynoO/w2GEJaXqNNe7iS9fuGwQRRWJ5OAMbf+ASoYegm4UyMF1Qi1KV
	 FlZ7NxiS5ot7a5bpE0uRc0YFHtxUq+cqJnksCaTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388854AbfJCQPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:15:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732566AbfJCQPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:15:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 322AC2054F;
        Thu,  3 Oct 2019 16:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119346;
        bh=vg6DsUyf4XVIFXgZdWx6wo3jzA2TDOouGPZg9zo/8JY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iZtHcN+ax3zSip5rce+wXAqoqb63yC3OpHfeFoYh+xiMLXevTIbb/XSIgA3qO7GPj
         7h7ROv4XeTh6FnQmxal9auSy0g6Xds9tdWhFfue78ScnA7qTY1I+P1t7OJZWgylsfG
         PLDWOqGHitA55woVA2kPcx0gEpapM1ifu+28r/dU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>,
        Yotam Gigi <yotam.gi@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH 4.19 006/211] net/sched: act_sample: dont push mac header on ip6gre ingress
Date:   Thu,  3 Oct 2019 17:51:12 +0200
Message-Id: <20191003154448.643286322@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_sample.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/sched/act_sample.c
+++ b/net/sched/act_sample.c
@@ -134,6 +134,7 @@ static bool tcf_sample_dev_ok_push(struc
 	case ARPHRD_TUNNEL6:
 	case ARPHRD_SIT:
 	case ARPHRD_IPGRE:
+	case ARPHRD_IP6GRE:
 	case ARPHRD_VOID:
 	case ARPHRD_NONE:
 		return false;


