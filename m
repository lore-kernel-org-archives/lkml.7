Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D10C4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD42921907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931031;
	bh=hg3v9mNCEl88hPyO4T2hxcD97UjdZDKcsaSktvnl8vA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cN9nxhEAlxHoCoNqc9DkpAdqzdecABP8HsuhWnDAUnlsISrsWNC6m/MQdULBVGHLr
	 UQvqIm0xY2dYQAUzZDZ/oQ/AaWxnGLCgDtKaQtS1PtqoqDvHsZ0HuvLFYZ3w4k8uEp
	 ERmayJS4tVI8hd6HtAOa9aIEm+8AgoxwnyQR1mqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405669AbfISWKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:10:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405657AbfISWKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:10:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 130F021920;
        Thu, 19 Sep 2019 22:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931019;
        bh=hg3v9mNCEl88hPyO4T2hxcD97UjdZDKcsaSktvnl8vA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p/N+SMv/hNZSSPrTdPQSaQSFyNlVXDJYSE2sDg/pEKMkl0RBNYGJPrgsOnFmcxLjL
         EITlsWLQSm1fKYg6CB3F2sTkD/cUBRQaEudjl8uIViKZiDz1Wd0INBo5n59A6HSnUO
         J3Tn38fkuoFTElaNd4wqnwGJfIIPp+rKv25KBPVA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Todd Seidelmann <tseidelmann@linode.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 071/124] netfilter: xt_physdev: Fix spurious error message in physdev_mt_check
Date:   Fri, 20 Sep 2019 00:02:39 +0200
Message-Id: <20190919214821.585914950@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214819.198419517@linuxfoundation.org>
References: <20190919214819.198419517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Seidelmann <tseidelmann@linode.com>

[ Upstream commit 3cf2f450fff304be9cf4868bf0df17f253bc5b1c ]

Simplify the check in physdev_mt_check() to emit an error message
only when passed an invalid chain (ie, NF_INET_LOCAL_OUT).
This avoids cluttering up the log with errors against valid rules.

For large/heavily modified rulesets, current behavior can quickly
overwhelm the ring buffer, because this function gets called on
every change, regardless of the rule that was changed.

Signed-off-by: Todd Seidelmann <tseidelmann@linode.com>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/xt_physdev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/xt_physdev.c b/net/netfilter/xt_physdev.c
index ead7c60222086..b92b22ce8abd3 100644
--- a/net/netfilter/xt_physdev.c
+++ b/net/netfilter/xt_physdev.c
@@ -101,11 +101,9 @@ static int physdev_mt_check(const struct xt_mtchk_param *par)
 	if (info->bitmask & (XT_PHYSDEV_OP_OUT | XT_PHYSDEV_OP_ISOUT) &&
 	    (!(info->bitmask & XT_PHYSDEV_OP_BRIDGED) ||
 	     info->invert & XT_PHYSDEV_OP_BRIDGED) &&
-	    par->hook_mask & ((1 << NF_INET_LOCAL_OUT) |
-	    (1 << NF_INET_FORWARD) | (1 << NF_INET_POST_ROUTING))) {
+	    par->hook_mask & (1 << NF_INET_LOCAL_OUT)) {
 		pr_info_ratelimited("--physdev-out and --physdev-is-out only supported in the FORWARD and POSTROUTING chains with bridged traffic\n");
-		if (par->hook_mask & (1 << NF_INET_LOCAL_OUT))
-			return -EINVAL;
+		return -EINVAL;
 	}
 
 	if (!brnf_probed) {
-- 
2.20.1



