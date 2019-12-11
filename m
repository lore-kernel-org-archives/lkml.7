Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C4FC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793012077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077722;
	bh=tXGxWGiCLf1tP9dGSPQuinYfaFl1pAiIalZ3u2Tyzks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AsPni+42C4I5+H2JjBpwJYRWfYbFbQdr0rr09bR8dhK64E5xraveWS/0I55mA6fuD
	 aaIRQeFjgFJs8r28R560XxuM6BVgM9XQ0trQp638jogp5GC7rkL8K1XKClrCZDOmTP
	 uVFbOxdkCv18u2Qf9Yi7/1w62sUtHFKjgztiQETw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732551AbfLKPWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:22:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:52490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731800AbfLKPV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:21:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BF8D2073D;
        Wed, 11 Dec 2019 15:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077718;
        bh=tXGxWGiCLf1tP9dGSPQuinYfaFl1pAiIalZ3u2Tyzks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yiy8DemKUYDKIUW4RNl4zy7IFYje9pMKn5WVTwdoTTpuIdptmQT+pcQrSJ1yI4kyC
         6rY7DNcTVZbxc+8Acl5G+pkS5CVIdWiL9DxYLyYqu1frwfoTAFP95OSFVlKjGseek8
         xaFM7cWwIhnLP9dOwEJAvLFZE9AIU3b4/aujls84=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 143/243] net/x25: fix called/calling length calculation in x25_parse_address_block
Date:   Wed, 11 Dec 2019 16:05:05 +0100
Message-Id: <20191211150348.818536126@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schiller <ms@dev.tdt.de>

[ Upstream commit d449ba3d581ed29f751a59792fdc775572c66904 ]

The length of the called and calling address was not calculated
correctly (BCD encoding).

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/x25/af_x25.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index f7f53f9ae7efb..3150648206b68 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -100,7 +100,7 @@ int x25_parse_address_block(struct sk_buff *skb,
 	}
 
 	len = *skb->data;
-	needed = 1 + (len >> 4) + (len & 0x0f);
+	needed = 1 + ((len >> 4) + (len & 0x0f) + 1) / 2;
 
 	if (!pskb_may_pull(skb, needed)) {
 		/* packet is too short to hold the addresses it claims
-- 
2.20.1



