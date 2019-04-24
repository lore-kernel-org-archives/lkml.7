Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC7DC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134092175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128203;
	bh=UNLLgMKNQAzTuNclvEHKie58NfvodMim7cloLLNN/OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mPdpcBsqDPzgVOtivzei9G0eiMLXRYHXtDwTlyfHvWKWUZ2YHH9OstpM08PKEZu7d
	 Q73jmWSWsAvNUKyWjj+7Slp85ordCCIJyrxpZtDcrEE6aENGRIkrfmrTerrVA95Xh2
	 M8D10h1zLjwDxJu0S7ziESl0k2JtIk4My1mVkvMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391267AbfDXRuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:50:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390549AbfDXRaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:30:00 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06F2820811;
        Wed, 24 Apr 2019 17:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126999;
        bh=UNLLgMKNQAzTuNclvEHKie58NfvodMim7cloLLNN/OY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L3u7GrbWh3jHJh/pHDgha0cPs76WGNcjIGoLinDb7PMqFoZE0x9GFD9LZ6iy5Z16/
         1hXOqC+3ZYYT6sYZB/6nn2G6Ekb4zmFCisv9NVJ+68H0E5ilyzRQl+cc3UOx8wSv+G
         kZmLbbT9TSFhpSZXtrCBgsE40xoyUgZjlxiL4pvU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pieter Jansen van Vuuren 
        <pieter.jansenvanvuuren@netronome.com>,
        Louis Peens <louis.peens@netronome.com>
Subject: [PATCH 4.19 23/96] nfp: flower: remove vlan CFI bit from push vlan action
Date:   Wed, 24 Apr 2019 19:09:28 +0200
Message-Id: <20190424170921.419526417@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>

[ Upstream commit 42cd5484a22f1a1b947e21e2af65fa7dab09d017 ]

We no longer set CFI when pushing vlan tags, therefore we remove
the CFI bit from push vlan.

Fixes: 1a1e586f54bf ("nfp: add basic action capabilities to flower offloads")
Signed-off-by: Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>
Signed-off-by: Louis Peens <louis.peens@netronome.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/flower/action.c |    3 +--
 drivers/net/ethernet/netronome/nfp/flower/cmsg.h   |    1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/net/ethernet/netronome/nfp/flower/action.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/action.c
@@ -80,8 +80,7 @@ nfp_fl_push_vlan(struct nfp_fl_push_vlan
 
 	tmp_push_vlan_tci =
 		FIELD_PREP(NFP_FL_PUSH_VLAN_PRIO, tcf_vlan_push_prio(action)) |
-		FIELD_PREP(NFP_FL_PUSH_VLAN_VID, tcf_vlan_push_vid(action)) |
-		NFP_FL_PUSH_VLAN_CFI;
+		FIELD_PREP(NFP_FL_PUSH_VLAN_VID, tcf_vlan_push_vid(action));
 	push_vlan->vlan_tci = cpu_to_be16(tmp_push_vlan_tci);
 }
 
--- a/drivers/net/ethernet/netronome/nfp/flower/cmsg.h
+++ b/drivers/net/ethernet/netronome/nfp/flower/cmsg.h
@@ -109,7 +109,6 @@
 #define NFP_FL_OUT_FLAGS_TYPE_IDX	GENMASK(2, 0)
 
 #define NFP_FL_PUSH_VLAN_PRIO		GENMASK(15, 13)
-#define NFP_FL_PUSH_VLAN_CFI		BIT(12)
 #define NFP_FL_PUSH_VLAN_VID		GENMASK(11, 0)
 
 /* LAG ports */


