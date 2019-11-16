Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6E1C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAD8206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920469;
	bh=Y4lAoQyQxZwgpe8S14AlWKNoT/13S/b0oclnwxddKWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KKliNqdFdBFnGCiHU6LiSrF96xYrmoNTWICAV0DCV370Qvf3aBJ3mBzH3BK/TWlXt
	 kMpYwHtFdtVoVMEfZEBPKuPj8o0tMBC795ZiztBU+5XM9dVoko+mLa/0qSepZ4Y96k
	 bAkyELFfdy+AX0vpTKHq8APw8DJUQbE9M4NYc+O8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbfKPPuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:50:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729080AbfKPPuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:50:17 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2C8F21823;
        Sat, 16 Nov 2019 15:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919417;
        bh=Y4lAoQyQxZwgpe8S14AlWKNoT/13S/b0oclnwxddKWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pQ3qO/z4rrg30wuzjmUYSqC0QrBFPUCQAQ1Cgf0H5ZMqsJNDhP8iGni0fPIhFj/i5
         RcTTviVlr+LUZXfhA4+iRbdDhqls4NjgHydm8Ef6Fnz/oKfFh7wgM00wRGr1uxz+FN
         ePavOa9wtirMlMA0PhPcrhHEoIYBwF8HiUB2HF08=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        dev@openvswitch.org
Subject: [PATCH AUTOSEL 4.14 116/150] openvswitch: fix linking without CONFIG_NF_CONNTRACK_LABELS
Date:   Sat, 16 Nov 2019 10:46:54 -0500
Message-Id: <20191116154729.9573-116-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154729.9573-1-sashal@kernel.org>
References: <20191116154729.9573-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit a277d516de5f498c91d91189717ef7e01102ad27 ]

When CONFIG_CC_OPTIMIZE_FOR_DEBUGGING is enabled, the compiler
fails to optimize out a dead code path, which leads to a link failure:

net/openvswitch/conntrack.o: In function `ovs_ct_set_labels':
conntrack.c:(.text+0x2e60): undefined reference to `nf_connlabels_replace'

In this configuration, we can take a shortcut, and completely
remove the contrack label code. This may also help the regular
optimization.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/openvswitch/conntrack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 0171b27a2b81b..48d81857961ca 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -1083,7 +1083,8 @@ static int ovs_ct_commit(struct net *net, struct sw_flow_key *key,
 					 &info->labels.mask);
 		if (err)
 			return err;
-	} else if (labels_nonzero(&info->labels.mask)) {
+	} else if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) &&
+		   labels_nonzero(&info->labels.mask)) {
 		err = ovs_ct_set_labels(ct, key, &info->labels.value,
 					&info->labels.mask);
 		if (err)
-- 
2.20.1

