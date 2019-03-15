Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6316C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD612184C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="aMybzQA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfCOGLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 02:11:33 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:45696 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfCOGLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 02:11:33 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 0D788CA9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 06:11:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id n6uS-wTDgYtZ for <linux-kernel@vger.kernel.org>;
        Fri, 15 Mar 2019 01:11:31 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id CE14F6C0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 01:11:31 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id 9so6744557ita.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 23:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=glKVrF76DqYG8OwLc+rWqwZpUefQ0RPQdTYZl6DR47A=;
        b=aMybzQA/MOMJBJlh9J78iiM02qZgDQCclqKM/TTG9K9HzBP0i7IkT26UtVvgbImcJE
         RaIDm1ipvzgqcWSX0xdbeL+PzhV5WP9V/iyQS4qDHUUnYQVinWVKvXnDF/UzKQBezDB/
         oxg0mJ960Vd7bV9ZQVzsCLj29bhtB4jbPmTV/Pb7Tl4iVW+rAlacMC+nnAzUJHZnn6U9
         mZx0wdIV3cioE7lKIUkEz3UAUkxayybiybN0B6p9NQIEYLp2k2vOUgwWlf1NtnAEEDwI
         WxLeKHAtsQekwJ3Y0ea03d5buLf5z2m9zwe9hgqjUs95pJNwlgYwBuD2p1iq2koFigI/
         Q1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=glKVrF76DqYG8OwLc+rWqwZpUefQ0RPQdTYZl6DR47A=;
        b=RI+sncS9l9uqiZaBi9VXBFsnnvY/nzg5BF7JWJbl27PjddxKtn5U8+lcwz6DYS67+3
         2Lip11mxT3zofo23M6iNuyMtYsej9cOPwi5FpvR4ZQMwNJEF869TQlnW+MgORTuLC5XB
         BJLcr8xGpcP/5KC/L5Vzp+83Zya9QZHuTatmk7T9B0r/PgetkoD6HHEOF+0pVa0FyRsA
         ToSYGMnzgKPwwA5j6EiO7qLc8H+SPPiiN2tzF2NgWmZrsVmsW4jAPBEnOK27LouV/c1f
         qLdYtpgPi4IGTbLYFG83AMnMrfNMTRNMTJDhfhL9SNY6d1Q56M6FXRAGKBgIIjbq+BN2
         AbVw==
X-Gm-Message-State: APjAAAVxsslGlKf/MuzdiA+hYcLN2Q4CnU/vDGmD7ookcFILJQorTFOK
        CQfmlzdyMlcHa+l0yhm5Z9dRFzZHFzTqwpDbUTFrIzEgXYX74hHja/h1ndymrzEOn0WBcarw66i
        scZMarbPK6MfH6ZmtMwtR039ojl2L
X-Received: by 2002:a24:7d94:: with SMTP id b142mr944978itc.136.1552630291502;
        Thu, 14 Mar 2019 23:11:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzbby7QsMsLC1zjVYbBuBwXb1+XwLhmSLSax1o6hC4nUHSQ+xPUU+GJ+menSwRVbIjLd7FpHg==
X-Received: by 2002:a24:7d94:: with SMTP id b142mr944968itc.136.1552630291265;
        Thu, 14 Mar 2019 23:11:31 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id o9sm612087itb.23.2019.03.14.23.11.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 23:11:30 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        dev@openvswitch.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: openvswitch: fix missing checks for nla_nest_start
Date:   Fri, 15 Mar 2019 01:11:22 -0500
Message-Id: <20190315061122.14794-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nla_nest_start may fail and thus deserves a check.
The fix returns -EMSGSIZE when it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 net/openvswitch/datapath.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 45d1469308b0..9dd158ab51b3 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -464,6 +464,10 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 
 	if (upcall_info->egress_tun_info) {
 		nla = nla_nest_start(user_skb, OVS_PACKET_ATTR_EGRESS_TUN_KEY);
+		if (!nla) {
+			err = -EMSGSIZE;
+			goto out;
+		}
 		err = ovs_nla_put_tunnel_info(user_skb,
 					      upcall_info->egress_tun_info);
 		BUG_ON(err);
@@ -472,6 +476,10 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 
 	if (upcall_info->actions_len) {
 		nla = nla_nest_start(user_skb, OVS_PACKET_ATTR_ACTIONS);
+		if (!nla) {
+			err = -EMSGSIZE;
+			goto out;
+		}
 		err = ovs_nla_put_actions(upcall_info->actions,
 					  upcall_info->actions_len,
 					  user_skb);
-- 
2.17.1

