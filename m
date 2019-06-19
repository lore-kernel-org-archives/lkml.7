Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6783C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A29208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfFSON0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:13:26 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34712 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfFSONZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:13:25 -0400
Received: from localhost (unknown [144.121.20.163])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9F5FB15224149;
        Wed, 19 Jun 2019 07:13:24 -0700 (PDT)
Date:   Wed, 19 Jun 2019 10:13:23 -0400 (EDT)
Message-Id: <20190619.101323.1146505723758856038.davem@davemloft.net>
To:     sfr@canb.auug.org.au
Cc:     netdev@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldir@darbyshire-bryant.me.uk,
        yamada.masahiro@socionext.com
Subject: Re: linux-next: build failure after merge of the net-next tree
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190619132326.1846345b@canb.auug.org.au>
References: <20190619132326.1846345b@canb.auug.org.au>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 19 Jun 2019 07:13:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I've fixed this as follows, thanks:

====================
From 23cdf8752b26d4edbd60a6293bca492d83192d4d Mon Sep 17 00:00:00 2001
From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 19 Jun 2019 10:12:58 -0400
Subject: [PATCH] act_ctinfo: Don't use BIT() in UAPI headers.

Use _BITUL() instead.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 include/uapi/linux/tc_act/tc_ctinfo.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/tc_act/tc_ctinfo.h b/include/uapi/linux/tc_act/tc_ctinfo.h
index da803e05a89b..32337304fbe5 100644
--- a/include/uapi/linux/tc_act/tc_ctinfo.h
+++ b/include/uapi/linux/tc_act/tc_ctinfo.h
@@ -27,8 +27,8 @@ enum {
 #define TCA_CTINFO_MAX (__TCA_CTINFO_MAX - 1)
 
 enum {
-	CTINFO_MODE_DSCP	= BIT(0),
-	CTINFO_MODE_CPMARK	= BIT(1)
+	CTINFO_MODE_DSCP	= _BITUL(0),
+	CTINFO_MODE_CPMARK	= _BITUL(1)
 };
 
 #endif
-- 
2.20.1

