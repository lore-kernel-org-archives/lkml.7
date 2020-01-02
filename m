Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13680C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D659121D7D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003177;
	bh=To3ybeRrIJZsIK2I51g9pmOYOKb3+uskSjOVbVV6dzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JOfkTB8ZJGio/9alAMlCXH8leZB1r7HO7OOifMP0aBkazNLWpCG4ak7+7yO3Z6mEr
	 IOC7FOdLPt3fi+t7DHGMzAoJBsp4qTPLrgte5pFlYHz7+U7fK1lHwRXQNvwh21tdLz
	 eqjGrr6vqU8+ALL0L4fn7ZugA/V5wbCq5yF9mK3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgABWM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:12:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:52314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbgABWMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:12:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F5F221D7D;
        Thu,  2 Jan 2020 22:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003172;
        bh=To3ybeRrIJZsIK2I51g9pmOYOKb3+uskSjOVbVV6dzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dIN3yvgnqXhRmLVLSOHojjMlVdHI5yRb3WijGN7SyEakp3NYTgW1HGmv4fNebU99g
         KsfRG4BLnhbLffCYitrZcUglydMdskB7dOdxWGF4BJFJhE7fBEb5eIAtbTnqaL/Sm9
         IFxvJsSCesJwq79DDBGPoVN4hN7PxpCgcm8/ch4A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 049/191] clk: qcom: smd: Add missing pnoc clock
Date:   Thu,  2 Jan 2020 23:05:31 +0100
Message-Id: <20200102215835.167420054@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index fef5e8157061..930fa4a4c52a 100644
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



