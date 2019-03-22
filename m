Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB879C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AFE20850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255589;
	bh=o5md9FNCqxjpJwUylVkRiPnsoVPms3rpOojHdz9uA3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B5TXG7m7Cs7g6C9oSd45K6u99E0/V3IKxLPD27jFrJrIUKA5BAOOBpYggIfOak9yJ
	 +BaVhZy8TVARju4AzNQO6LpFuqfZpuIww2ssmvoLPVW4ZNEEdpkE8Q+F6Cv9r69gu5
	 Sc2kFk35TgP1VMm628uOeU09pDKEBWR3fUfD+5k0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732997AbfCVLxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:53:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732985AbfCVLxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:53:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59F962082C;
        Fri, 22 Mar 2019 11:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255581;
        bh=o5md9FNCqxjpJwUylVkRiPnsoVPms3rpOojHdz9uA3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPzyDEL3wRuz/7YpE3uRMx4pK11O9JSzb9kNm48EwqRoS5pbVbRIgSGbp0KJV+hYy
         xDaezQ5ld0VsH967S1It8G5QJGvds5vpTZqtOBtLiB6Fe2MIGoCzKSx0qMfa5V0HbI
         jNm6jqMNV6pB2KNCUMFapXUCMqfmIzcW+8mLRQLA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-stable@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.14 116/183] clk: uniphier: Fix update register for CPU-gear
Date:   Fri, 22 Mar 2019 12:15:44 +0100
Message-Id: <20190322111250.111843483@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

commit 521282237b9d78b9bff423ec818becd4c95841c2 upstream.

Need to set the update bit in UNIPHIER_CLK_CPUGEAR_UPD to update
the CPU-gear value.

Fixes: d08f1f0d596c ("clk: uniphier: add CPU-gear change (cpufreq) support")
Cc: linux-stable@vger.kernel.org
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/uniphier/clk-uniphier-cpugear.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/uniphier/clk-uniphier-cpugear.c
+++ b/drivers/clk/uniphier/clk-uniphier-cpugear.c
@@ -47,7 +47,7 @@ static int uniphier_clk_cpugear_set_pare
 		return ret;
 
 	ret = regmap_write_bits(gear->regmap,
-				gear->regbase + UNIPHIER_CLK_CPUGEAR_SET,
+				gear->regbase + UNIPHIER_CLK_CPUGEAR_UPD,
 				UNIPHIER_CLK_CPUGEAR_UPD_BIT,
 				UNIPHIER_CLK_CPUGEAR_UPD_BIT);
 	if (ret)


