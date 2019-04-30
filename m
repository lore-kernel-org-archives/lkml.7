Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33574C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56BA2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556626032;
	bh=fWm8gL6jcVRsAtWMyM7LzS/5pdWEsFgaL8qSw+9s7mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cUsOO1K4mMkYu+PPQnz8sYtsLMqqPWs5hkgh/jqyRA30JWW/Z9fWWeYIMAWi39kr5
	 W4bT6wqF6F2Kse4bXlKQC2UOJPbJgyTMnw+Li80F9n+Mvkcfl18XzwPDIZLozzmDfZ
	 HoxX+yIiwmtux5p+8xy2zZtbr37TluAgzfXz32hI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfD3Lk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbfD3Lkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:40:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D77C821670;
        Tue, 30 Apr 2019 11:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624455;
        bh=fWm8gL6jcVRsAtWMyM7LzS/5pdWEsFgaL8qSw+9s7mo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ye8oVULt0Bjmcuky9G/e7sV/8KoWiPfXdk7H6k3p+uOPZxZHZFdK59F19OvlYUgLd
         59txAWKpcr1VFFhSqFemwFg0bZASW10uaVUI87qPinCgmcphl6nDh02IfiPbhT8v5c
         petAg7f0PI4hRXekEAFiX9g+vFD/X0scpGQPFzAs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+659574e7bcc7f7eb4df7@syzkaller.appspotmail.com,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.9 25/41] netfilter: ebtables: CONFIG_COMPAT: drop a bogus WARN_ON
Date:   Tue, 30 Apr 2019 13:38:36 +0200
Message-Id: <20190430113530.891306791@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113524.451237916@linuxfoundation.org>
References: <20190430113524.451237916@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

commit 7caa56f006e9d712b44f27b32520c66420d5cbc6 upstream.

It means userspace gave us a ruleset where there is some other
data after the ebtables target but before the beginning of the next rule.

Fixes: 81e675c227ec ("netfilter: ebtables: add CONFIG_COMPAT support")
Reported-by: syzbot+659574e7bcc7f7eb4df7@syzkaller.appspotmail.com
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bridge/netfilter/ebtables.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2056,7 +2056,8 @@ static int ebt_size_mwt(struct compat_eb
 		if (match_kern)
 			match_kern->match_size = ret;
 
-		if (WARN_ON(type == EBT_COMPAT_TARGET && size_left))
+		/* rule should have no remaining data after target */
+		if (type == EBT_COMPAT_TARGET && size_left)
 			return -EINVAL;
 
 		match32 = (struct compat_ebt_entry_mwt *) buf;


