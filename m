Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3CFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6604E21734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413939;
	bh=qAeWiqtwp5bwBtW83/euPyB6J2yTSARzCCIZQm76hfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bdhx+Vh8OtxtylZ/sDzuSp5Fynx0Q8BkGW4yTGoOPVXHIOUD0kNAcybmSDiWe4fXQ
	 uwGcx6rqhR0FrzoMsKAygJjij7bPpswq12agUr67mHPbdAt4Nih199thMUIvUTTVUS
	 oLoRNUYExauo7jxHxVhl3J2LANIBRuT3LPPYchF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfCLSFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbfCLRMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:37 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FCC3217F5;
        Tue, 12 Mar 2019 17:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410756;
        bh=qAeWiqtwp5bwBtW83/euPyB6J2yTSARzCCIZQm76hfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kF8g6N7e2qnmSTMzyBE/MFWgvOSFrzEB58Biwn0GlPUgYYKelGslBDDsWU82Xbk4/
         ISdsXWarTXADGHNzXDokOgfjE4vf8zfswQOIC0HLic+72gcqe9Sl2xxfnKwPI+M82q
         Xaik6rMu0CxB2n+D/HcWNfHGhFOBPkQ2SuXJ3BZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Petr Vorel <pvorel@suse.cz>,
        John Johansen <john.johansen@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 057/171] apparmor: Fix warning about unused function apparmor_ipv6_postroute
Date:   Tue, 12 Mar 2019 10:07:17 -0700
Message-Id: <20190312170353.062939563@linuxfoundation.org>
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

[ Upstream commit a1a02062ad466052a34a8c4323143ccf9726eb52 ]

when compiled without CONFIG_IPV6:
security/apparmor/lsm.c:1601:21: warning: ‘apparmor_ipv6_postroute’ defined but not used [-Wunused-function]
 static unsigned int apparmor_ipv6_postroute(void *priv,
                     ^~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Jordan Glover <Golden_Miller83@protonmail.ch>
Tested-by: Jordan Glover <Golden_Miller83@protonmail.ch>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/lsm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 42446a216f3b..7d1eeb084968 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1598,12 +1598,14 @@ static unsigned int apparmor_ipv4_postroute(void *priv,
 	return apparmor_ip_postroute(priv, skb, state);
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
 static unsigned int apparmor_ipv6_postroute(void *priv,
 					    struct sk_buff *skb,
 					    const struct nf_hook_state *state)
 {
 	return apparmor_ip_postroute(priv, skb, state);
 }
+#endif
 
 static const struct nf_hook_ops apparmor_nf_ops[] = {
 	{
-- 
2.19.1



