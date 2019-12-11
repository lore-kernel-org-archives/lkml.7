Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AF8C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E939724685
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077182;
	bh=91iWh5fmI1a06yBOSNjXj8il8TOi4Ro8Y8i/EzjO7lA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qfWdOBenHtg3Q7ALQuTQGglGIujbfOxq/rOVnETLH/3di6/neqzuH+XrYLsJ9X4OR
	 RJxh30lRTZzLwHhIMkGA1xluqv50TEcN4RUZhGFs5MHI3yjonNrgh7QmWsdXMWgNYO
	 2ps+yXDeom2vHSUM1mBqG2XlbHO72fIyE7ulNRkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbfLKPNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:13:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731213AbfLKPMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:12:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21B1F20663;
        Wed, 11 Dec 2019 15:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077162;
        bh=91iWh5fmI1a06yBOSNjXj8il8TOi4Ro8Y8i/EzjO7lA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gGGrDo5FbnSvVdMGO+eIOgRqfeXtjkOfJ+A0dAokOogkQzrn3FX70zpJgI+YqsWen
         E8DfihFU/JzbHJr3itsBYgTPBEQDckJ3H+ns11GvtjR/yY0cay5wjBQVkdpWYLXefd
         fAdDxhdX6WNsnt6qRiDG3Zr7g98YfK7Zb9oE+5Ds=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 048/134] clk: qcom: smd: Add missing pnoc clock
Date:   Wed, 11 Dec 2019 10:10:24 -0500
Message-Id: <20191211151150.19073-48-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211151150.19073-1-sashal@kernel.org>
References: <20191211151150.19073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>

[ Upstream commit ba1d366de261981c0dd04fac44d2ce3a5eba2eaa ]

When MSM8998 support was added, and analysis was done to determine what
clocks would be consumed.  That analysis had a flaw, which caused the
pnoc to be skipped.  The pnoc clock needs to be on to access the uart
for the console.  The clock is on from boot, but has no consumer votes
in the RPM.  When we attempt to boot the modem, it causes the RPM to
turn off pnoc, which kills our access to the console and causes CPU hangs.

We need pnoc to be defined, so that clk_smd_rpm_handoff() will put in
an implicit vote for linux and prevent issues when booting modem.
Hopefully pnoc can be consumed by the interconnect framework in future
so that Linux can rely on explicit votes.

Fixes: 6131dc81211c ("clk: qcom: smd: Add support for MSM8998 rpm clocks")
Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Link: https://lkml.kernel.org/r/20191107190615.5656-1-jeffrey.l.hugo@gmail.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index fef5e81570614..930fa4a4c52a8 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -648,6 +648,7 @@ static const struct rpm_smd_clk_desc rpm_clk_qcs404 = {
 };
 
 /* msm8998 */
+DEFINE_CLK_SMD_RPM(msm8998, pcnoc_clk, pcnoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 0);
 DEFINE_CLK_SMD_RPM(msm8998, snoc_clk, snoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 1);
 DEFINE_CLK_SMD_RPM(msm8998, cnoc_clk, cnoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 2);
 DEFINE_CLK_SMD_RPM(msm8998, ce1_clk, ce1_a_clk, QCOM_SMD_RPM_CE_CLK, 0);
@@ -670,6 +671,8 @@ DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, rf_clk2_pin, rf_clk2_a_pin, 5);
 DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, rf_clk3, rf_clk3_a, 6);
 DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, rf_clk3_pin, rf_clk3_a_pin, 6);
 static struct clk_smd_rpm *msm8998_clks[] = {
+	[RPM_SMD_PCNOC_CLK] = &msm8998_pcnoc_clk,
+	[RPM_SMD_PCNOC_A_CLK] = &msm8998_pcnoc_a_clk,
 	[RPM_SMD_SNOC_CLK] = &msm8998_snoc_clk,
 	[RPM_SMD_SNOC_A_CLK] = &msm8998_snoc_a_clk,
 	[RPM_SMD_CNOC_CLK] = &msm8998_cnoc_clk,
-- 
2.20.1

