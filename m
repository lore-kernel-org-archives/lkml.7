Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DC4C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59E1204EC
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099269;
	bh=s77u5BBdPAx/VhzuZVY6EukQG/C5NNpAYtqwWLtQQwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JkIsvPNRDCgIFeHFsIZThOX6Dir8CEHynxLOlm3VbuCfBNZvLAJAQEdDovez6Osdm
	 lkToYMmaSJEK6m788OIRimz2dn/p4zLXRKV/ViAQor+72p7tIpRUkJfueJYbj8KvX2
	 4jkENxNfEYLxdAOWpPVv4OPyekTK/joVwWAWxYQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbfFIQy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:54:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732589AbfFIQyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:54:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56E6D206BB;
        Sun,  9 Jun 2019 16:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099264;
        bh=s77u5BBdPAx/VhzuZVY6EukQG/C5NNpAYtqwWLtQQwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AqvfxDUiPYFTmb/jDShlciWf8YiaKaNAMLA2IP6PUX4PdVXFIGAUuXMbnqrqcw23J
         de+UlWwyyvh+/aYrV2Zl7Hz68rygry2FmSW86MEj2RMnmnF0l5sLdYdhNegtnWqXZF
         cDxn7xh5uICUQ80pxJATzW5jg7GHL7YJ+uee1W/Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 4.9 69/83] Revert "fib_rules: fix error in backport of e9919a24d302 ("fib_rules: return 0...")"
Date:   Sun,  9 Jun 2019 18:42:39 +0200
Message-Id: <20190609164133.684337273@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.843327870@linuxfoundation.org>
References: <20190609164127.843327870@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit d5c71a7c533e88a9fcc74fe1b5c25743868fa300 as the
patch that this "fixes" is about to be reverted...

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/fib_rules.c |    1 -
 1 file changed, 1 deletion(-)

--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -430,7 +430,6 @@ int fib_nl_newrule(struct sk_buff *skb,
 		goto errout_free;
 
 	if (rule_exists(ops, frh, tb, rule)) {
-		err = 0;
 		if (nlh->nlmsg_flags & NLM_F_EXCL)
 			err = -EEXIST;
 		goto errout_free;


