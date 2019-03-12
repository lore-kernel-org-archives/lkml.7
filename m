Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36EDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767F62171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412395;
	bh=8v4VPzLD6WPRtg4XsXBEBK8rNKcdi4XI+D+MFAop5QA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y3KLUc4HbgVTaelQ4tadj1KzwcCs+3h9fF9A8eB/8LRU0Qt3QOjRfau/fR09EY9zh
	 FWdtq5fGYYOTS/KHbNI3i7go7T3I8kvcDgWblxCWxzQUUkwFMvQ3ZrFgAhQjmISi1R
	 gcXUoCQv4OJrD5YMRsQeSs+aWj02n2zV4dA+n+pk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbfCLRQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:16:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728668AbfCLRPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:18 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EDB421871;
        Tue, 12 Mar 2019 17:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410917;
        bh=8v4VPzLD6WPRtg4XsXBEBK8rNKcdi4XI+D+MFAop5QA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x9f9B93P/8ogHvpt/HEznX18i+1UDKWw0mcuLlAf24B0LElwp5PRpiBcCLfyaa1M8
         XlYRxWNWtrVFT2iwHECCZTNvR+zUKMskN8hal/2nUzzplg1EUL1QfAOIfOxx7CtNPd
         rk9Sc07pN+VFzsjRMUUdSTQE2OKQzcA2I58WBbSs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 136/149] netfilter: xt_TEE: add missing code to get interface index in checkentry.
Date:   Tue, 12 Mar 2019 10:09:14 -0700
Message-Id: <20190312170400.735421504@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 18c0ab87364ac5128a152055fdcb1d27e01caf01 ]

checkentry(tee_tg_check) should initialize priv->oif from dev if possible.
But only netdevice notifier handler can set that.
Hence priv->oif is always -1 until notifier handler is called.

Fixes: 9e2f6c5d78db ("netfilter: Rework xt_TEE netdevice notifier")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/xt_TEE.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/netfilter/xt_TEE.c b/net/netfilter/xt_TEE.c
index 673ad2099f97..1dae02a97ee3 100644
--- a/net/netfilter/xt_TEE.c
+++ b/net/netfilter/xt_TEE.c
@@ -104,6 +104,8 @@ static int tee_tg_check(const struct xt_tgchk_param *par)
 		return -EINVAL;
 
 	if (info->oif[0]) {
+		struct net_device *dev;
+
 		if (info->oif[sizeof(info->oif)-1] != '\0')
 			return -EINVAL;
 
@@ -115,6 +117,11 @@ static int tee_tg_check(const struct xt_tgchk_param *par)
 		priv->oif     = -1;
 		info->priv    = priv;
 
+		dev = dev_get_by_name(par->net, info->oif);
+		if (dev) {
+			priv->oif = dev->ifindex;
+			dev_put(dev);
+		}
 		mutex_lock(&tn->lock);
 		list_add(&priv->list, &tn->priv_list);
 		mutex_unlock(&tn->lock);
-- 
2.19.1



