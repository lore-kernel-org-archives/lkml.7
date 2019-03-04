Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BDBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B1720823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688083;
	bh=s4Y33NhIsdKCb6Fkbw2SwKpCmFt9TKcoU570gGa8RtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nTYyAIG1MPsj1C7A4qOpqJLkKyKAS4EFIDbQlOXzTFdNR0HFm93ZWAOVpFVCc/SZi
	 tsa/JBtWaZ4izp+PzXTQQlvz6Nmbbw+xnKN4SysNbkKOoA5dqOAM7N1QwpkRQhwaps
	 fVWjdj2tXMaVinfegzI2yhsTr//L4JEqSNILFVMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfCDI2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:28:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:52562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbfCDI15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:27:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAA3521019;
        Mon,  4 Mar 2019 08:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688076;
        bh=s4Y33NhIsdKCb6Fkbw2SwKpCmFt9TKcoU570gGa8RtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f3gBW9n85pasy3R3jtxHsjw+fQz69n8CA/QzT9b5ERpGqlP2BQG/rqpaw1Lpe0tse
         ze7WaNi02CmhkqKo0zuOqsLUtzrIGlCbBVYHPFF0HE2qZOFkjR7ruPCCdSB+uDD6yX
         6pypp37MeRNI6VtoHGz5cgc37Snty5LdJ5WI/3f4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 10/78] clk: tegra: dfll: Fix a potential Oop in remove()
Date:   Mon,  4 Mar 2019 09:21:53 +0100
Message-Id: <20190304081625.957342108@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d39eca547f3ec67140a5d765a426eb157b978a59 ]

If tegra_dfll_unregister() fails then "soc" is an error pointer.  We
should just return instead of dereferencing it.

Fixes: 1752c9ee23fb ("clk: tegra: dfll: Fix drvdata overwriting issue")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
index 269d3595758be..edc31bb56674a 100644
--- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
+++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
@@ -133,9 +133,11 @@ static int tegra124_dfll_fcpu_remove(struct platform_device *pdev)
 	struct tegra_dfll_soc_data *soc;
 
 	soc = tegra_dfll_unregister(pdev);
-	if (IS_ERR(soc))
+	if (IS_ERR(soc)) {
 		dev_err(&pdev->dev, "failed to unregister DFLL: %ld\n",
 			PTR_ERR(soc));
+		return PTR_ERR(soc);
+	}
 
 	tegra_cvb_remove_opp_table(soc->dev, soc->cvb, soc->max_freq);
 
-- 
2.19.1



