Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80011C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564862084A
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560098653;
	bh=dsuY3ika3pM2TpW6IhoPArLRbVaGg/raG5jngM0Jwrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0y8CqsF5cxFHaptsnT/vwwxdzYF3b46kqZ4iijYcAB008Ujk2bsXzDrmbp88zpASC
	 Fm/0nl7OpVTTidJIXofq/usb+z57bjCYYzc32knLFxdWN2reF2q1kA7ZsgPR1QXWfE
	 Y3Lnt6nqpu0qMDrjVRmNPcMVnwA8m0YMyRycyZG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfFIQoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728858AbfFIQoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:44:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18CC52081C;
        Sun,  9 Jun 2019 16:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098648;
        bh=dsuY3ika3pM2TpW6IhoPArLRbVaGg/raG5jngM0Jwrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=clO6FwkA0HgHcVnI4iNdNCcn7VJiYwNO78Ne6pf6MnR1uQpABLbCUxGs4KICHPawy
         Q/iPQXvoRBipyis/irTCPViZA4/XQfWTSlGSAYDl23ohgPw98eZ/G6NmI6tDDv9Y/p
         s0X6SDut8gWiAbFFpru9RlhiJ8jqKZkuFjVaNqyE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Yaro Slav <yaro330@gmail.com>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <zenczykowski@gmail.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 11/70] Revert "fib_rules: return 0 directly if an exactly same rule exists when NLM_F_EXCL not supplied"
Date:   Sun,  9 Jun 2019 18:41:22 +0200
Message-Id: <20190609164128.113500257@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.541128197@linuxfoundation.org>
References: <20190609164127.541128197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 4970b42d5c362bf873982db7d93245c5281e58f4 ]

This reverts commit e9919a24d3022f72bcadc407e73a6ef17093a849.

Nathan reported the new behaviour breaks Android, as Android just add
new rules and delete old ones.

If we return 0 without adding dup rules, Android will remove the new
added rules and causing system to soft-reboot.

Fixes: e9919a24d302 ("fib_rules: return 0 directly if an exactly same rule exists when NLM_F_EXCL not supplied")
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Reported-by: Yaro Slav <yaro330@gmail.com>
Reported-by: Maciej Żenczykowski <zenczykowski@gmail.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/fib_rules.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -756,9 +756,9 @@ int fib_nl_newrule(struct sk_buff *skb,
 	if (err)
 		goto errout;
 
-	if (rule_exists(ops, frh, tb, rule)) {
-		if (nlh->nlmsg_flags & NLM_F_EXCL)
-			err = -EEXIST;
+	if ((nlh->nlmsg_flags & NLM_F_EXCL) &&
+	    rule_exists(ops, frh, tb, rule)) {
+		err = -EEXIST;
 		goto errout_free;
 	}
 


