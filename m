Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23300FC6195
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD512187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="rBMjZCqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389053AbfKGN2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:28:17 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46003 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389044AbfKGN2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:28:06 -0500
Received: by mail-lj1-f193.google.com with SMTP id n21so2247133ljg.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zXDgHEnXmAd5c8hm63wbideMGJDr2j+Jf+RGDuNusS4=;
        b=rBMjZCqHLRK4uxWE3Jn85OBeFCg3CIPM6/SBq/1nYky4z9Z8LfxMCO78o3o6il5kqj
         Hl+e7g08u6R8M2JBZt3wvjlwBW5rbrdROXabAdePH/8fgNHmOp34ydg0fsr1rIz437g2
         72/gOjwiBCmsnSgxYS7h4qhz8grxYzGuiMlEPMv6I6GS4wIsD87XRkqJZcT3aTGdXKCK
         Umu+mYlwuM6faJ01pr59Iz5lggc+vpcb+idodwaBaOaiocXbqmvNC8+Vw8oGwsL/TpIm
         2ezfyhwVN3C1vTt4a3DBiwdyhkBiuB0m5sZvCo3zJ71OF9x4uw59HFwMx/LYIYkHpxTl
         GuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zXDgHEnXmAd5c8hm63wbideMGJDr2j+Jf+RGDuNusS4=;
        b=TUTPqSKBy1HyKW5BUD+oXaygxUxEXKbAc4nkVHnwTomq0DXrVuJ6PysEgVTuDyL+MK
         lTGreKy4dttW8nJTolcg98qKl17xAmp/Lt7jZZR14+24uWuDU2SRxm/lICsR5iUdlo+2
         baTeYrcIqif6ZFPvOQyANnvAv6IXhmbFyRiG7pHV1oVTse3IQ9XwDXN7AJZiBGvVtBKx
         FOUeVZqiyYWB9vJ3G/X5V5HX8s6hgPudojbovvaExs0UeWHCmKhvinKv1j5Ix77qdGwo
         G4bgrkcFtFaccy2ra5o1AIPcQge3NDeE9DqKiTjcgmsSUKfArF89Y99f0ClsB92mpRev
         f72w==
X-Gm-Message-State: APjAAAWQmDDWTFJRzr3zGzBZTc02C0+fR9gERLFTon2s8bPYiCeEaBMx
        HUBXVh0SOzqY1e9kCNczsBQMQA==
X-Google-Smtp-Source: APXvYqyBWis+vPxpbD+JmZEOBgKo3ElSBxQQsXXtFqZF7NzkD09vQlT2OduOj2N3/n5Y1L41NCvgvA==
X-Received: by 2002:a2e:9e45:: with SMTP id g5mr2273176ljk.58.1573133284676;
        Thu, 07 Nov 2019 05:28:04 -0800 (PST)
Received: from mimer.lan (h-137-65.A159.priv.bahnhof.se. [81.170.137.65])
        by smtp.gmail.com with ESMTPSA id y20sm3151507ljd.99.2019.11.07.05.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 05:28:04 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     nicolas.dichtel@6wind.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH v3 5/6] net: namespace: allow setting NSIDs outside current namespace
Date:   Thu,  7 Nov 2019 14:27:54 +0100
Message-Id: <20191107132755.8517-6-jonas@norrbonn.se>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191107132755.8517-1-jonas@norrbonn.se>
References: <20191107132755.8517-1-jonas@norrbonn.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently it is only possible to move an interface to a new namespace if
the destination namespace has an ID in the interface's current namespace.
If the interface already resides outside of the current namespace, then
we may need to assign the destination namespace an ID in the interface's
namespace in order to effect the move.

This patch allows namespace ID's to be created outside of the current
namespace.  With this, the following is possible:

i)    Our namespace is 'A'.
ii)   The interface resides in namespace 'B'
iii)  We can assign an ID for NS 'A' in NS 'B'
iv)   We can then move the interface into our own namespace.

and

i)   Our namespace is 'A'; namespaces 'B' and 'C' also exist
ii)  We can assign an ID for namespace 'C' in namespace 'B'
iii) We can then create a VETH interface directly in namespace 'B' with
the other end in 'C', all without ever leaving namespace 'A'

Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 net/core/net_namespace.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 39402840025e..ebb01903d1f7 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -726,6 +726,7 @@ static int rtnl_net_newid(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct nlattr *tb[NETNSA_MAX + 1];
 	struct nlattr *nla;
 	struct net *peer;
+	struct net *target = NULL;
 	int nsid, err;
 
 	err = nlmsg_parse_deprecated(nlh, sizeof(struct rtgenmsg), tb,
@@ -754,6 +755,21 @@ static int rtnl_net_newid(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return PTR_ERR(peer);
 	}
 
+	if (tb[NETNSA_TARGET_NSID]) {
+		int id = nla_get_s32(tb[NETNSA_TARGET_NSID]);
+
+		target = rtnl_get_net_ns_capable(NETLINK_CB(skb).sk, id);
+		if (IS_ERR(target)) {
+			NL_SET_BAD_ATTR(extack, tb[NETNSA_TARGET_NSID]);
+			NL_SET_ERR_MSG(extack,
+				       "Target netns reference is invalid");
+			err = PTR_ERR(target);
+			goto out;
+		}
+
+		net = target;
+	}
+
 	spin_lock_bh(&net->nsid_lock);
 	if (__peernet2id(net, peer) >= 0) {
 		spin_unlock_bh(&net->nsid_lock);
@@ -775,6 +791,9 @@ static int rtnl_net_newid(struct sk_buff *skb, struct nlmsghdr *nlh,
 		NL_SET_BAD_ATTR(extack, tb[NETNSA_NSID]);
 		NL_SET_ERR_MSG(extack, "The specified nsid is already used");
 	}
+
+	if (target)
+		put_net(target);
 out:
 	put_net(peer);
 	return err;
-- 
2.20.1

