Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1DCC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCCE20862
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383472;
	bh=yTCZzXZwVj7TwL77bpaZQocofKqPjqpWLCHKbD9N8BQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oAvyzmgHyqFafBaArtXtpTfZwLpRFlKuoI3jOBneKjj4aevZM6PrhpzOkmLmqdKC/
	 cPn4hxrdCYGOG6uIKVqD42GsQamjSYdnxEsdihzcdcl8ZRMQ0wCSfBg0lmxGGVFdNE
	 Urw6tz/8KeFhQZb+ccu1Ok+SbkG7OkwnMBJKNFVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfJFRhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:37:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730496AbfJFRhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:37:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80F7B20700;
        Sun,  6 Oct 2019 17:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383468;
        bh=yTCZzXZwVj7TwL77bpaZQocofKqPjqpWLCHKbD9N8BQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nije6OpE0M9gk/ocDiuqHE2UfajMHJUeyJXgbVmN/7ALEZAt4uoOHoI7zeTwr+T4q
         6Qqnmn5zc419a+Tt1S3/Z5ntn8l9S+Q9Oo7QfPDVRcjCzHhZaaX9GzUyIVSQXDXB4/
         0wJuuT7KtIRTZ98phlBMMFeCcE2Q3g/GpwKkINME=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 114/137] security: smack: Fix possible null-pointer dereferences in smack_socket_sock_rcv_skb()
Date:   Sun,  6 Oct 2019 19:21:38 +0200
Message-Id: <20191006171218.637222837@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171209.403038733@linuxfoundation.org>
References: <20191006171209.403038733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit 3f4287e7d98a2954f20bf96c567fdffcd2b63eb9 ]

In smack_socket_sock_rcv_skb(), there is an if statement
on line 3920 to check whether skb is NULL:
    if (skb && skb->secmark != 0)

This check indicates skb can be NULL in some cases.

But on lines 3931 and 3932, skb is used:
    ad.a.u.net->netif = skb->skb_iif;
    ipv6_skb_to_auditdata(skb, &ad.a, NULL);

Thus, possible null-pointer dereferences may occur when skb is NULL.

To fix these possible bugs, an if statement is added to check skb.

These bugs are found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smack_lsm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 4c5e5a438f8bd..5c9fc8ba6e572 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3925,6 +3925,8 @@ access_check:
 			skp = smack_ipv6host_label(&sadd);
 		if (skp == NULL)
 			skp = smack_net_ambient;
+		if (skb == NULL)
+			break;
 #ifdef CONFIG_AUDIT
 		smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
 		ad.a.u.net->family = family;
-- 
2.20.1



