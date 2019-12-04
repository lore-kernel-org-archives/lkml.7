Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9C7C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4C32081B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482455;
	bh=G+oSkkHo33aseX2yDHd1/cqRjidMk2lLRRLZuq3yOes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vRGtpGUrth/etZo3fmEQSIjqUu6qgUU9yn2//yfdF9gADM5GSnVmCO4SlPvcNfpVf
	 sd+aL9xwo2rCCABKYwcRpwn8XtnGWv9S6u/12LcPw4BTXB8JggXviRJImZyDAojKVI
	 +T4+pNzZnmFttnyqJCsXUcs0kNxb8egdhzgPZBUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbfLDSAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:00:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:40142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728650AbfLDSAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:00:50 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBE4D20675;
        Wed,  4 Dec 2019 18:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482450;
        bh=G+oSkkHo33aseX2yDHd1/cqRjidMk2lLRRLZuq3yOes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1zZtDUta/gdm1GG4NJ5oQNr5zD803DilqtxVAPn+dgRoTE4PqTfKE2XyWSCqKPrsa
         U56Wcm8wL7qt0itxAgCWw+1SwqSQm5A1o2eRME8PF466db+z8ZG5mHUeutvVPkZB+w
         aWxoq6XORRLQ77lE+mDRYBUriqTDl4Afd3Qi57ks=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 86/92] openvswitch: drop unneeded BUG_ON() in ovs_flow_cmd_build_info()
Date:   Wed,  4 Dec 2019 18:50:26 +0100
Message-Id: <20191204174335.355653224@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204174327.215426506@linuxfoundation.org>
References: <20191204174327.215426506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 8ffeb03fbba3b599690b361467bfd2373e8c450f ]

All the callers of ovs_flow_cmd_build_info() already deal with
error return code correctly, so we can handle the error condition
in a more gracefull way. Still dump a warning to preserve
debuggability.

v1 -> v2:
 - clarify the commit message
 - clean the skb and report the error (DaveM)

Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/openvswitch/datapath.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -904,7 +904,10 @@ static struct sk_buff *ovs_flow_cmd_buil
 	retval = ovs_flow_cmd_fill_info(flow, dp_ifindex, skb,
 					info->snd_portid, info->snd_seq, 0,
 					cmd, ufid_flags);
-	BUG_ON(retval < 0);
+	if (WARN_ON_ONCE(retval < 0)) {
+		kfree_skb(skb);
+		skb = ERR_PTR(retval);
+	}
 	return skb;
 }
 


