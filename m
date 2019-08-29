Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AF2C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CCF2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567075912;
	bh=r2NLeZ554bhmZAOjT99GenY02RjdypTtJwuhqPonDkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QM4veung3LFi00DNsFiscNtP3mzIyIKXQxLxgkD3XkfbsKyLtoLMFKYnXi/bSw8GA
	 5Hftf27pLsofxMRLVlqvBjxtemjYOvB7X6cl5zTTPqrzaIF4eVS70FNmgXwyFuc5P/
	 TRtSe5EzVBeU2PNgpIYyWfmkWHgbcaJO3IKgU9q8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfH2Kvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:51:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728598AbfH2KvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:51:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E008423405;
        Thu, 29 Aug 2019 10:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567075878;
        bh=r2NLeZ554bhmZAOjT99GenY02RjdypTtJwuhqPonDkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XeIQEed8rHRpNfMq2MCjcC1UQwXlR0HksGdPfub+ENFM1IDLcy7qebmrZvh6sZ86P
         UwU1CpVW4PJBGgQIOV5ICSpdROxMA1dVKytH0UpN6m4iu2rK/Km9vfoXbAFzDqq7bR
         XZx4IDCw1luMCxIj+fz0Dk3pcR+jLPS8pTro4RHs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 6/6] clk: s2mps11: Add used attribute to s2mps11_dt_match
Date:   Thu, 29 Aug 2019 06:51:10 -0400
Message-Id: <20190829105110.2748-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829105110.2748-1-sashal@kernel.org>
References: <20190829105110.2748-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 9c940bbe2bb47e03ca5e937d30b6a50bf9c0e671 ]

Clang warns after commit 8985167ecf57 ("clk: s2mps11: Fix matching when
built as module and DT node contains compatible"):

drivers/clk/clk-s2mps11.c:242:34: warning: variable 's2mps11_dt_match'
is not needed and will not be emitted [-Wunneeded-internal-declaration]
static const struct of_device_id s2mps11_dt_match[] = {
                                 ^
1 warning generated.

This warning happens when a variable is used in some construct that
doesn't require a reference to that variable to be emitted in the symbol
table; in this case, it's MODULE_DEVICE_TABLE, which only needs to hold
the data of the variable, not the variable itself.

$ nm -S drivers/clk/clk-s2mps11.o | rg s2mps11_dt_match
00000078 000003d4 R __mod_of__s2mps11_dt_match_device_table

Normally, with device ID table variables, it means that the variable
just needs to be tied to the device declaration at the bottom of the
file, like s2mps11_clk_id:

$ nm -S drivers/clk/clk-s2mps11.o | rg s2mps11_clk_id
00000000 00000078 R __mod_platform__s2mps11_clk_id_device_table
00000000 00000078 r s2mps11_clk_id

However, because the comment above this deliberately doesn't want this
variable added to .of_match_table, we need to mark s2mps11_dt_match as
__used to silence this warning. This makes it clear to Clang that the
variable is used for something, even if a reference to it isn't being
emitted.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Fixes: 8985167ecf57 ("clk: s2mps11: Fix matching when built as module and DT node contains compatible")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-s2mps11.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
index 785864893f9a6..14af5c916c9ca 100644
--- a/drivers/clk/clk-s2mps11.c
+++ b/drivers/clk/clk-s2mps11.c
@@ -307,7 +307,7 @@ MODULE_DEVICE_TABLE(platform, s2mps11_clk_id);
  * This requires of_device_id table.  In the same time this will not change the
  * actual *device* matching so do not add .of_match_table.
  */
-static const struct of_device_id s2mps11_dt_match[] = {
+static const struct of_device_id s2mps11_dt_match[] __used = {
 	{
 		.compatible = "samsung,s2mps11-clk",
 		.data = (void *)S2MPS11X,
-- 
2.20.1

