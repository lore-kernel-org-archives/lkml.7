Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84623C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFA121479
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561053740;
	bh=SqoleiGOWHSbLNyzRiUl/WkMDsDmCEUZ71PZV5wMf/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x9sXElCr0H9lz1mZo8xxs6MqNHwk95xhY42CR4X6EbcjkZnXc/cpxILGzSaTrAxNj
	 C7O0HZLAaovp4VjPr+Ipe+gYPDDYhKR9T0ILSDcKCXwRcFUoc+YB8LfBkQuVsI/Too
	 rLP/H8JhOyeDYouDAx0Z3lYpoh74IM+L0tLmCiZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfFTSCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:02:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727406AbfFTSCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:02:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAD7A2083B;
        Thu, 20 Jun 2019 18:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053733;
        bh=SqoleiGOWHSbLNyzRiUl/WkMDsDmCEUZ71PZV5wMf/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eXrnT8IFRSkcdfv9X1Apcyo6206vMS+nsFLOAf4TyyEzmBrCQhHHL2TnieoU8De8Y
         B7AyYV2bJBTOAAFyM7j2sby2foKz3Dm3ltsi8Voeix+PlKAISWi7BpDNUtw1d8r4/2
         08fI8PgDEzJX9+8zMWnqu4iUw8vXrnvvZVCRakPU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tianhao <tizhao@redhat.com>,
        Ivan Vecera <ivecera@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 64/84] be2net: Fix number of Rx queues used for flow hashing
Date:   Thu, 20 Jun 2019 19:57:01 +0200
Message-Id: <20190620174348.069285479@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174337.538228162@linuxfoundation.org>
References: <20190620174337.538228162@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Vecera <ivecera@redhat.com>

[ Upstream commit 718f4a2537089ea41903bf357071306163bc7c04 ]

Number of Rx queues used for flow hashing returned by the driver is
incorrect and this bug prevents user to use the last Rx queue in
indirection table.

Let's say we have a NIC with 6 combined queues:

[root@sm-03 ~]# ethtool -l enp4s0f0
Channel parameters for enp4s0f0:
Pre-set maximums:
RX:             5
TX:             5
Other:          0
Combined:       6
Current hardware settings:
RX:             0
TX:             0
Other:          0
Combined:       6

Default indirection table maps all (6) queues equally but the driver
reports only 5 rings available.

[root@sm-03 ~]# ethtool -x enp4s0f0
RX flow hash indirection table for enp4s0f0 with 5 RX ring(s):
    0:      0     1     2     3     4     5     0     1
    8:      2     3     4     5     0     1     2     3
   16:      4     5     0     1     2     3     4     5
   24:      0     1     2     3     4     5     0     1
...

Now change indirection table somehow:

[root@sm-03 ~]# ethtool -X enp4s0f0 weight 1 1
[root@sm-03 ~]# ethtool -x enp4s0f0
RX flow hash indirection table for enp4s0f0 with 6 RX ring(s):
    0:      0     0     0     0     0     0     0     0
...
   64:      1     1     1     1     1     1     1     1
...

Now it is not possible to change mapping back to equal (default) state:

[root@sm-03 ~]# ethtool -X enp4s0f0 equal 6
Cannot set RX flow hash configuration: Invalid argument

Fixes: 594ad54a2c3b ("be2net: Add support for setting and getting rx flow hash options")
Reported-by: Tianhao <tizhao@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/emulex/benet/be_ethtool.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/emulex/benet/be_ethtool.c
+++ b/drivers/net/ethernet/emulex/benet/be_ethtool.c
@@ -1050,7 +1050,7 @@ static int be_get_rxnfc(struct net_devic
 		cmd->data = be_get_rss_hash_opts(adapter, cmd->flow_type);
 		break;
 	case ETHTOOL_GRXRINGS:
-		cmd->data = adapter->num_rx_qs - 1;
+		cmd->data = adapter->num_rx_qs;
 		break;
 	default:
 		return -EINVAL;


