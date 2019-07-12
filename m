Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961B1C742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE7C2080A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562935151;
	bh=dp4M8rQrAaTgjPwwffn68Wo9uAGJPQymsN7j5QJ7dO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RVxPX/A72xs0xVABNvM5z6++JQYFdGHRcToRvcOjNqXkdIVZtC2c6M4aNwg2QnQHG
	 IYLuLt1OtbHyJqj9SCJi8/HdRY/lolZEzvlz427Wjr55Gs47wezdhEMyVDljmYc5Dn
	 f9bR43Z1Of37A8UeTi6pFncY/A2AdDoPsCn2IPdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfGLM1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:27:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728658AbfGLM1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:27:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E4772084B;
        Fri, 12 Jul 2019 12:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934463;
        bh=dp4M8rQrAaTgjPwwffn68Wo9uAGJPQymsN7j5QJ7dO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dSdN3wOQnM/pKqlFzoQUSPRp38Ztc/2athyZ7rPGpiOZFu7q/C9vp0aQ0hVb+UpxH
         n8XVTn9Sgx7jpQaM3qA7uICo1IR4ufdaZe57sAii3Bv1Gl8OPCS3//38X3IBtgEm8H
         dR+6Fa/DIgvA0BbEqyneYpJ9jxYl4AZvOreDbLsQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 062/138] cfg80211: util: fix bit count off by one
Date:   Fri, 12 Jul 2019 14:18:46 +0200
Message-Id: <20190712121631.057125752@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121628.731888964@linuxfoundation.org>
References: <20190712121628.731888964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1a473d6092d5d182914bea854ce0b21e6d12519d ]

The bits of Rx MCS Map in VHT capability were enumerated
with index transform - index i -> (i + 1) bit => nss i. BUG!
while it should be -   index i -> (i + 1) bit => (i + 1) nss.

The bug was exposed in commit a53b2a0b1245 ("iwlwifi: mvm: implement VHT
extended NSS support in rs.c"), where iwlwifi started using the
function.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Fixes: b0aa75f0b1b2 ("ieee80211: add new VHT capability fields/parsing")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 5a03f38788e7..5ac66a571e33 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1989,7 +1989,7 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
 			continue;
 
 		if (supp >= mcs_encoding) {
-			max_vht_nss = i;
+			max_vht_nss = i + 1;
 			break;
 		}
 	}
-- 
2.20.1



