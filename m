Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244BAC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBD32173C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414029;
	bh=Er2fnYxoqvkpJmaxbgRNLg9D0ovEKsJp8wTV5mCY5eY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dBSA4iujoaaScWTNba1hDfzu4tUXViAseZMUgyBEAzs6a1eY7JDaCTERafDdt1t49
	 nMlaJ0Epvs4+pgjzX9uMlfa6ojIHtfZ9uy5mAgu1I4K5tXnC6vu/1Tt5g6HlmBEHaZ
	 AsZzPGnd/NZwsGfQa9VbjxRbVM7nAviD5Vw9Hevw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfCLRMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:12:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbfCLRMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:06 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E4D1217D4;
        Tue, 12 Mar 2019 17:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410726;
        bh=Er2fnYxoqvkpJmaxbgRNLg9D0ovEKsJp8wTV5mCY5eY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UBzn9YObY/vhxCG0mUkerLNRvAL/x2d3ssS7kyBAGb1B1VWg81voG4GpkVg3ms5V/
         1Y9vF2UABMpHuVeAZk4YtOlLn223kmDhjc4p9NWMPZVFDEGFvQPXh+2YBV5kGO3IMT
         6XOBZc23eJINEAM5vdMVpVQLmXfh/JzfD0tAIWiE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Francesco Ruggeri <fruggeri@arista.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 036/171] netfilter: ebtables: compat: un-break 32bit setsockopt when no rules are present
Date:   Tue, 12 Mar 2019 10:06:56 -0700
Message-Id: <20190312170351.167906120@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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
index 5e55cef0cec3..6693e209efe8 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2293,9 +2293,12 @@ static int compat_do_replace(struct net *net, void __user *user,
 
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



