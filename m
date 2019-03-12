Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE96C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23A4206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412429;
	bh=i/mUroHlzJrzsPIKr2wQ3/bSTaDWHxxLyoN/RoNhrmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BW1IqB+MTzX6bbQo7nQn8XrEWGn5bPHyQa7wLS2ycG24DZYhGEgTVf7X6/26Zq4wJ
	 qDh/Fpr/AwBuzY+/z/zg2gbgEati2/hKyZotrQQ56C2Z+Pnd9EeDIZwhBNvHMBVEe9
	 fKBtBGfwekCNkV0XL/SUu8Wh2eZvz7gA1Y+rlpn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfCLRk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728650AbfCLRQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:14 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FF9E21850;
        Tue, 12 Mar 2019 17:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410973;
        bh=i/mUroHlzJrzsPIKr2wQ3/bSTaDWHxxLyoN/RoNhrmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zOKReG7Az2/pVRXcBuCatCUx6G0ePN81ZBWSPS+VTl5bntIIVBBtOLL010OGuXtVZ
         1RxCecIljdSlJIHVIHg+uS4SxXjuul9pGcdexcvE7OY96YPDvu5u4f/daaRhk3sNGT
         x2ZhWjSxxiop8L5bqR5Kv8JlEOMuM0hSFpjTWxZc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Francesco Ruggeri <fruggeri@arista.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 063/135] netfilter: ebtables: compat: un-break 32bit setsockopt when no rules are present
Date:   Tue, 12 Mar 2019 10:08:30 -0700
Message-Id: <20190312170347.107634092@linuxfoundation.org>
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

[ Upstream commit 2035f3ff8eaa29cfb5c8e2160b0f6e85eeb21a95 ]

Unlike ip(6)tables ebtables only counts user-defined chains.

The effect is that a 32bit ebtables binary on a 64bit kernel can do
'ebtables -N FOO' only after adding at least one rule, else the request
fails with -EINVAL.

This is a similar fix as done in
3f1e53abff84 ("netfilter: ebtables: don't attempt to allocate 0-sized compat array").

Fixes: 7d7d7e02111e9 ("netfilter: compat: reject huge allocation requests")
Reported-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/netfilter/ebtables.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 22e4c15a1fc3..53392ac58b38 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2292,9 +2292,12 @@ static int compat_do_replace(struct net *net, void __user *user,
 
 	xt_compat_lock(NFPROTO_BRIDGE);
 
-	ret = xt_compat_init_offsets(NFPROTO_BRIDGE, tmp.nentries);
-	if (ret < 0)
-		goto out_unlock;
+	if (tmp.nentries) {
+		ret = xt_compat_init_offsets(NFPROTO_BRIDGE, tmp.nentries);
+		if (ret < 0)
+			goto out_unlock;
+	}
+
 	ret = compat_copy_entries(entries_tmp, tmp.entries_size, &state);
 	if (ret < 0)
 		goto out_unlock;
-- 
2.19.1



