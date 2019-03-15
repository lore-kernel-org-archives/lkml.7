Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B202C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 04:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FB32186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 04:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Z/PQ9jGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfCOEU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 00:20:26 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:49906 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfCOEUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 00:20:25 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 09535CA3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 04:20:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id x25X4xSjTnJ3 for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 23:20:23 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id BE920666
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 23:20:23 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id o68so22514itb.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 21:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=APl3U981G0M/WzQa3rXjQkF87I1qlpKRBMosoA8rv88=;
        b=Z/PQ9jGuELbDuDKgsRpbNkWFm0mJ979njPPKEcmhzCXf+oj2RSI384YDjslElDngS5
         cYmkkIeXTgc48ppDIHTnJsObU3xYOsrCvDn7D1jS0dCFydU4crgJvB739lXGJ+lZlIzw
         auBGf6fcQKvAXvgU0nlqeEDF+6C8u3XTd2pMjdzXgPfMiMAtlBGeK2AFOtkswwHWhW0o
         qeuSKSzU8fiJyLW8DPSq9oZuR+YHGde7ViUjQVGMsb3ds/m66FgKUqvOV1wVMN3Rw7Ye
         pOs1UBrr3V5bRoQstVjIUoOd3korrtJYdQewLIM4PaFo157owp0x3fP9hCcBFkftl0iK
         wu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=APl3U981G0M/WzQa3rXjQkF87I1qlpKRBMosoA8rv88=;
        b=RcS6XV8kShrUXtDzgpDEpTQwaZeJy/BN472lMZsqZuxS+gLoUDhN52ANaM9F9niJ3Z
         QvFnPBXKgDdZ+x+TVIX56GtPCh2j90fB52rB8ho2vkUgA7FeRXEN42rFDb0Dggq1Qhy1
         XjJRV/5kedSitNMyc+wdBIySsPID5vO3Vw8sxT4WEUUsdFM/3q44sjGdMTtAKX0moUhO
         CAnetVkpJtc0ulgJxPiI16klnU+9zaSEjjsJjZvBvD2QnkqwGc6FRdmpPdRiMBFn7GC/
         ThmTYzHOtbI7IgCO5xUmKIP2YAvgBaX5eBQeFQaw8ugaSv+os976Aev9/0Mi7uJtBu3W
         EUuw==
X-Gm-Message-State: APjAAAU0zWzGIkxLRkuxm7a4oJwyuTWLNAqkUlorxOUcMxRsR54MAJt9
        s4bWKSeNNJDzDvl96oiEpIPoCNNUW2QMlvqRgDqdTqAIwLlcajU0PaXWyqCyO9T8HvT0ncdHGD0
        pkkT+vc0zNxulhtZ4ci570JSpfb8O
X-Received: by 2002:a24:5d44:: with SMTP id w65mr800518ita.143.1552623623389;
        Thu, 14 Mar 2019 21:20:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwUh+fwCcCz2f9eFbB/VP0sC7HR4HN8lATL4YDj1gO9lK+KdPw2wxryl+Pnh6PODBRNtAdFcQ==
X-Received: by 2002:a24:5d44:: with SMTP id w65mr800508ita.143.1552623623187;
        Thu, 14 Mar 2019 21:20:23 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id w74sm516253itb.44.2019.03.14.21.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 21:20:22 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        dev@openvswitch.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: openvswitch: fix a NULL pointer dereference
Date:   Thu, 14 Mar 2019 23:20:16 -0500
Message-Id: <20190315042016.3137-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

upcall is dereferenced even when genlmsg_put fails. The fix
goto out to avoid the NULL pointer dereference in this case.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 net/openvswitch/datapath.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 6679e96ab1dc..45d1469308b0 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -448,6 +448,10 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 
 	upcall = genlmsg_put(user_skb, 0, 0, &dp_packet_genl_family,
 			     0, upcall_info->cmd);
+	if (!upcall) {
+		err = -EINVAL;
+		goto out;
+	}
 	upcall->dp_ifindex = dp_ifindex;
 
 	err = ovs_nla_put_key(key, key, OVS_PACKET_ATTR_KEY, false, user_skb);
-- 
2.17.1

