Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B290C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 04:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44C720684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 04:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VsOh1kg5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N4gILg8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbfCFEHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 23:07:45 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49984 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfCFEHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 23:07:44 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 868AB60A24; Wed,  6 Mar 2019 04:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551845263;
        bh=/asR2Qjz0d9WAlNDXFdxjKSoDY1lbd+7ANCQifI625A=;
        h=From:To:Cc:Subject:Date:From;
        b=VsOh1kg5TaQsJVOF5Wozi85QFPh9deuTLckfRs25pfp2gkrqjA7OS/kFGH0N0XBds
         +H0HTP1mlUkIHq/AViOodr646xw5OW0H+SwJLt5rV+EPSbc7uYwaLDY+Z4/3WzPEN5
         HA7qGa8W+lnRmh4jmDqW+qrqoAdR0zVl+vf8nPjs=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CFE9C6030B;
        Wed,  6 Mar 2019 04:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551845262;
        bh=/asR2Qjz0d9WAlNDXFdxjKSoDY1lbd+7ANCQifI625A=;
        h=From:To:Cc:Subject:Date:From;
        b=N4gILg8iqr5ux7Jnfh1T9zKcKANWwnGeUFolEjBaJVzJnPEwEdMpzBprCe+lyo8aU
         Xi3ejHgNDyQ19A1krrZvVY/yD3YURG+eB8swJNdADPTP5ecQ1fFVrA1Ay/Tv6myK6n
         5zNGZkZWeEn75c8HtciXFd66wfrogI/k/FCl9WgA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CFE9C6030B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH] OPP: Fix handling of multiple power domains
Date:   Wed,  6 Mar 2019 09:37:26 +0530
Message-Id: <20190306040726.1930-1-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We seem to rely on the number of phandles specified in the
'required-opps' property to identify cases where a device is
associated with multiple power domains and hence would have
multiple virtual devices that have to be dealt with.

In cases where we do have devices with multiple power domains
but with only one of them being scalable, this logic seems to
fail.

Instead read the number of power domains from DT to identify
such cases.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/opp/of.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 06f0f632ec47..443c305ae100 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -172,7 +172,7 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 	struct opp_table **required_opp_tables;
 	struct device **genpd_virt_devs = NULL;
 	struct device_node *required_np, *np;
-	int count, i;
+	int count, count_pd, i;
 
 	/* Traversing the first OPP node is all we need */
 	np = of_get_next_available_child(opp_np, NULL);
@@ -185,7 +185,19 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 	if (!count)
 		goto put_np;
 
-	if (count > 1) {
+	/*
+	 * Check the number of power-domains to know if we need to deal
+	 * with virtual devices. In some cases we have devices with multiple
+	 * power domains but with only one of them being scalable, hence
+	 * 'count' could be 1, but we still have to deal with multiple genpds
+	 * and virtual devices.
+	 */
+	count_pd = of_count_phandle_with_args(dev->of_node, "power-domains",
+					      "#power-domain-cells");
+	if (!count_pd)
+		goto put_np;
+
+	if (count_pd > 1) {
 		genpd_virt_devs = kcalloc(count, sizeof(*genpd_virt_devs),
 					GFP_KERNEL);
 		if (!genpd_virt_devs)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

