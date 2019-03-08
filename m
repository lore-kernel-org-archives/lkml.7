Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6452C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872DE2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049757;
	bh=DPACkLGR2+MUTKET1zcwFuMN8zABKshZkCUQ46c3/mY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eAk029dtcXZ9E9lCuXmKwHeYgTW9ftH2CF/WkIic1bY7ZwGkxpjNJ1adyvgMO8Psd
	 6Jcnisyb/u3A/26QPdNe/fLKYFXmoZSehqSf+sfOJHgtxXTvFajr076Wk+HzSI+fFf
	 zE3cYJ+2uKMBvElLUQSDYEb3wkTrWR+JD2Ef0zFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfCHMz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:55:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbfCHMzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:55:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE7AC20449;
        Fri,  8 Mar 2019 12:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049753;
        bh=DPACkLGR2+MUTKET1zcwFuMN8zABKshZkCUQ46c3/mY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQSY/LzaR7/FMOXuAqWjZ+7TbRQLCxle7yCiOu1BP1BxNVIH3LBxZmV8/mlfPt9Bd
         zhOyEQyVoBje43pO4WzPEYjivT6cAHg29erZ1hXcLhSUHIZnVjJ6BAByLeMjK32RTU
         sxjmz0alhEn9CF3ukxv/FPww3DQXTt9gBrD9ara4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 53/76] mpls: Return error for RTA_GATEWAY attribute
Date:   Fri,  8 Mar 2019 13:50:05 +0100
Message-Id: <20190308124916.683905923@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1838,6 +1838,9 @@ static int rtm_to_route_config(struct sk
 				goto errout;
 			break;
 		}
+		case RTA_GATEWAY:
+			NL_SET_ERR_MSG(extack, "MPLS does not support RTA_GATEWAY attribute");
+			goto errout;
 		case RTA_VIA:
 		{
 			if (nla_get_via(nla, &cfg->rc_via_alen,


