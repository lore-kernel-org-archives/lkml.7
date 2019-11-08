Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EA5FC6195
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1858D2196F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240223;
	bh=pYlfOBiE2VU8kE9GC7vZ0A+8mGE3O+QqTgyGarP6vBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iN9+NZwOm7v8W/hZSM+WkTBPuH9NTVMIl0jNR2hHwF2pBu26XJFBK1020/9GVJRMP
	 gC4wuJGYQXO1VyH0MzKaqgA4kKE3u66lt+9aHJdI6GfWdCCGSJWxhzY6NDEhnYz8cY
	 E8SgGos/+A81A5V5C1W533zH1M7dqt6JuKEBkPO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732544AbfKHTKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:10:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391507AbfKHTKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:10:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E47720673;
        Fri,  8 Nov 2019 19:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573240218;
        bh=pYlfOBiE2VU8kE9GC7vZ0A+8mGE3O+QqTgyGarP6vBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gzgqh8ntGPIZLoidfV5mNDhTidYhW7N9T8VwQr5PkUfWedbyy69Y6X2aVpkne1/TF
         JawuuGSTlfo671RWW83mow8Q3BqKWCTnH9zu66Cb0wtBNiAiHTKYTntVDfw4c7H6/k
         wQM+xulO8/WJBqL4A8byx67fS8vEZpVMzQEKRBOI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 130/140] net: netem: correct the parents backlog when corrupted packet was dropped
Date:   Fri,  8 Nov 2019 19:50:58 +0100
Message-Id: <20191108174912.837811783@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit e0ad032e144731a5928f2d75e91c2064ba1a764c ]

If packet corruption failed we jump to finish_segs and return
NET_XMIT_SUCCESS. Seeing success will make the parent qdisc
increment its backlog, that's incorrect - we need to return
NET_XMIT_DROP.

Fixes: 6071bd1aa13e ("netem: Segment GSO packets on enqueue")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_netem.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -616,6 +616,8 @@ finish_segs:
 		}
 		/* Parent qdiscs accounted for 1 skb of size @prev_len */
 		qdisc_tree_reduce_backlog(sch, -(nb - 1), -(len - prev_len));
+	} else if (!skb) {
+		return NET_XMIT_DROP;
 	}
 	return NET_XMIT_SUCCESS;
 }


