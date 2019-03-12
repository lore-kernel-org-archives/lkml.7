Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF5DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9651B2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412607;
	bh=qA6bgsOk0k647B26e3mYGKXIXTZm1DNkzCVrB0Ke38U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cENXs0qBV8wKLsFEmaVJNr6t1YBmmVi8kgA3N4SBBFN+dJVoP6JQhG8lWFrfEiZo0
	 dVlHlVweIZONnRu1jNuZ+HhhLG4K/tvztO3FYqKLOUq69pOrOLutvyVkYpKpBuNwBd
	 kze9CR6wp7iadikfKDKu4URWg14A8Z/wQnFqLxy0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfCLRn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:43:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728887AbfCLRPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:49 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 697AF2184C;
        Tue, 12 Mar 2019 17:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410949;
        bh=qA6bgsOk0k647B26e3mYGKXIXTZm1DNkzCVrB0Ke38U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZprIPOWVjj1LzVloEIGl1CycYsOrSZ1IF89zd5Lh2HVzG6VlU4w24NrQgtEBnfNOL
         4tfzJ6MRUy36WYgSaAyqbWvvThq67GIbPJRd/YB6+LOkuaT31FUoF9gJohetnuv0sW
         zjbB1MXyqz5282l3kpUZVQ/H6itK9tYjJ0NK2yDM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 030/135] mpls: Return error for RTA_GATEWAY attribute
Date:   Tue, 12 Mar 2019 10:07:57 -0700
Message-Id: <20190312170343.917308146@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsahern@gmail.com>

[ Upstream commit be48220edd48ca0d569782992840488a52373a24 ]

MPLS does not support nexthops with an MPLS address family.
Specifically, it does not handle RTA_GATEWAY attribute. Make it
clear by returning an error.

Fixes: 03c0566542f4c ("mpls: Netlink commands to add, remove, and dump routes")
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mpls/af_mpls.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -1787,6 +1787,9 @@ static int rtm_to_route_config(struct sk
 				goto errout;
 			break;
 		}
+		case RTA_GATEWAY:
+			NL_SET_ERR_MSG(extack, "MPLS does not support RTA_GATEWAY attribute");
+			goto errout;
 		case RTA_VIA:
 		{
 			if (nla_get_via(nla, &cfg->rc_via_alen,


