Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A01C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0132147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412987;
	bh=VEgicaEHlfH2RGmK4y7iKqZ9yM/dLMhJ0zsxGtNuX0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UGwjz00rpkRdoSux6FPJcuEoutFzkj+A/8k6gNAN3mgnNrwz3NG2xLc1suBljl8J0
	 kzTblJBeQgLMuTzXJuMeYc9uJyvIguB8B3bym+GYq2ZXBcjoTK2wK+aZqUEbLosRZN
	 2IAcBG8NgJ6ZX79GoyBQ9R0LxeBIqVcss7zFY2Dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbfCLROs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:14:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbfCLROA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:00 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8112206DF;
        Tue, 12 Mar 2019 17:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410840;
        bh=VEgicaEHlfH2RGmK4y7iKqZ9yM/dLMhJ0zsxGtNuX0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u0Xb3nQOZ+NZdMpJqnzTblWuxg17jESohqTIh0rnctuBncZRGfpHWemoyzxw/TR+I
         R5ekVOvH90PwOV5X4Agde8dyJDuFc19KYd4Z8bQ4a1++atVCQI9NU4Nnu2BDx2XMbQ
         fBgNTRzAkvWLBpSO5B5BEUCDBJINWJ3IEuyNsh7w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Francesco Ruggeri <fruggeri@arista.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 030/149] netfilter: ebtables: compat: un-break 32bit setsockopt when no rules are present
Date:   Tue, 12 Mar 2019 10:07:28 -0700
Message-Id: <20190312170352.242393474@linuxfoundation.org>
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



