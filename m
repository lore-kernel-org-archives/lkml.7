Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099B4C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBC5208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="ZFUpCXQy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TcvD6wq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfF1Cjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 22:39:44 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:50689 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726748AbfF1Cjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:39:42 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7E9093483;
        Thu, 27 Jun 2019 22:39:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 27 Jun 2019 22:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=ADqhvifrknPuz
        OYzjNxXRssrypRVqiE51aZTMCvODu0=; b=ZFUpCXQy6B8uj0ca88kY34wx9NsTW
        nUjr5VFG7dhZvf8CVFBWzSbgULrOcaxoe9sNPrLvUaj+oL3FhA06vVh5xgVPsG8K
        2j4bbWRrw3sheZhasI/Nw5SaE5C58EESA13xOH5kbckMjZIbSs8d50Tkoe5DMFjT
        GlVs7J1IgpNS6nWgcpVCz6EMZkLGatXOD/mjn4Pqzverr4M+aVDD63hs/SOwxeEV
        gdI7TTIuf4TEDXNdiJ3EdfRe/caTjxuRlT2lXEpnevJJ1IF5XgE/bDtgdJtjC0dM
        kIFhPUQOcC/3oHliOUQ2658UQwORvn33ROO/qzypdW3bMwgCvetbg5r/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ADqhvifrknPuzOYzjNxXRssrypRVqiE51aZTMCvODu0=; b=TcvD6wq/
        aS2ba3+jDjzka/vzn1IAo8Td4r8TE0/t1pxAaI4c5PRB6DYCbyNwz3cXMpGglyWB
        iz3OLf+Pd/LmyRKVkPL5Ib9Vs6expRxAJEArw7gWTuLoMiE+lJPwn6K4OpudHOoH
        FykfS3L496SpeQ4dyeNqOIUob3cTOln2H75YU2p5/BGgcf0FkL0r3qb/RBWojZlV
        Ie6aaPzonmsl3ViqvAvn90SeFDigpr75qT67pBCX9QcGMPX6NIfdQE4IAxwF9Iui
        +gSw43orPBJndzNTohgMwaLIxQ1dd62Q3+sZl2t0XM2P58/olpFkF07NwdtV1R/2
        lzfTh3/QlwJbfQ==
X-ME-Sender: <xms:7X0VXYAGuohFMY5g3ytuF5SFQ4MMGGRbnKTqdYf1i2QIuRM01KcW9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudelgdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughrvgif
    ucflvghffhgvrhihuceorghnughrvgifsegrjhdrihgurdgruheqnecukfhppedvtddvrd
    ekuddrudekrdeftdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdr
    ihgurdgruhenucevlhhushhtvghrufhiiigvpeef
X-ME-Proxy: <xmx:7X0VXcAt3aDT5XckrP3KkgvKfFd_FWCrgfgZTrQE_bOcgmFaGA1jiw>
    <xmx:7X0VXQJaVibh-beRUVk9rE9lsd826w2OsNjrZTTj8YJRbn5Znjqmrw>
    <xmx:7X0VXeTIa0G12SlZ49phXbBfGYUIwwm2w7JGMwYymGl8eDO8c6An8A>
    <xmx:7X0VXcJxIYy1E3Lqkxq9a_-_8O7rFr5daoopP9pglOX2jGdulDzVxA>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3F15A380074;
        Thu, 27 Jun 2019 22:39:37 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-gpio@vger.kernel.org
Cc:     ryan_chen@aspeedtech.com, Andrew Jeffery <andrew@aj.id.au>,
        linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        joel@jms.id.au, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johnny Huang <johnny_huang@aspeedtech.com>
Subject: [PATCH v2 6/8] pinctrl: aspeed: Clarify comment about strapping W1C
Date:   Fri, 28 Jun 2019 12:08:36 +0930
Message-Id: <20190628023838.15426-7-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628023838.15426-1-andrew@aj.id.au>
References: <20190628023838.15426-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Writes of 1 to SCU7C clear set bits in SCU70, the hardware strapping
register. The information was correct if you squinted while reading, but
hopefully switching the order of the registers as listed conveys it
better.

Cc: Johnny Huang <johnny_huang@aspeedtech.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Acked-by: Joel Stanley <joel@jms.id.au>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.c b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
index 4c775b8ffdc4..b510bb475851 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
@@ -209,7 +209,7 @@ static int aspeed_sig_expr_set(const struct aspeed_sig_expr *expr,
 		if (desc->ip == ASPEED_IP_SCU && desc->reg == HW_STRAP2)
 			continue;
 
-		/* On AST2500, Set bits in SCU7C are cleared from SCU70 */
+		/* On AST2500, Set bits in SCU70 are cleared from SCU7C */
 		if (desc->ip == ASPEED_IP_SCU && desc->reg == HW_STRAP1) {
 			unsigned int rev_id;
 
-- 
2.20.1

