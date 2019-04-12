Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3882CC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F394F20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="RQ/+NnbZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfDLOML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:12:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37383 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLOML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:12:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so5278960pgc.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 07:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=fJflmz6PFa1tCBvtzQ/6bcSxyx73G9r1lquodsIUxN4=;
        b=RQ/+NnbZO6xchHZjV+/so1nxhSDsjLQSz3M0n9QOL7gZf+794qE1lOS8dp1n3xF0bU
         O+Kz5JFMfMCdO35UIDmYEO/mcAmIeE0VJ8BtX7D1F/YrRgIX+DyXAqY+nWT13ZWElPwi
         LiM8/1Lq1y5xLGmAxDzzR4tkyFae7nJZ4Wi7K82p6gE/M7e22UUqgjBtn2uYxIDiH9NK
         gBoW8Xccwod1c4rD2ZGXPV3BEZO43A4PhssiFpg1EZ16GxpsSelgnZs4OQmqXS92+wkO
         cx8KdYLoL9PsG5rmgtXye6dVbxlmcewtrZRkhefYxCvir8aGbXrgtUkJzqamoOweZWje
         hzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fJflmz6PFa1tCBvtzQ/6bcSxyx73G9r1lquodsIUxN4=;
        b=pSLRaJOO7J4oLxHAFBqTm2Gxfje718Q0E/8Ac/xbOW0MPq4WltPxQzbbaBRLgEDrCC
         UgXrrl4Dx0o/Sb57YhYcCrlW45QFZbiQ3T6lVCsq+EVndVvmcVFLwSIUhZp1C1xBtnQE
         eeYCV+N//cJebGDcn9ZAJG4TCi7WuheVaTbEuAVOujeK7/aaAjyJIR5MzwbxGowR3TSj
         k+L2mPjhG5pp0NRR9eXRV38VNEl2nzCDUFymcUgos6+WQf/cbt1zihGTAF//SD6497SS
         0EYrfh84EV82xDPXoHIHG+oYquSf8LoZZlIOXL9goN6Hs09yY0Yt2Dr/XWgpjSvFZNJa
         SrdA==
X-Gm-Message-State: APjAAAWPxVWS+wRxrzTf814Cx9lgS7wNhnERzQNT+1k19OZf8fCud4Hl
        /C6SYAOwmEV2WT5qJem2gVuk+w==
X-Google-Smtp-Source: APXvYqyFb/53GA+6GqflfaW2XqWn6cerekOrBMzxHE1/k0WzJKOkjGBXFGpmjBeesR/HRg6beis9Zg==
X-Received: by 2002:a63:2c55:: with SMTP id s82mr51523793pgs.356.1555078330462;
        Fri, 12 Apr 2019 07:12:10 -0700 (PDT)
Received: from localhost.localdomain (36-239-234-188.dynamic-ip.hinet.net. [36.239.234.188])
        by smtp.gmail.com with ESMTPSA id j67sm76750819pfc.72.2019.04.12.07.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 07:12:09 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: ab8500: Constify regulator_ops
Date:   Fri, 12 Apr 2019 22:11:57 +0800
Message-Id: <20190412141158.21246-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These regulator_ops variables never need to be modified, make them const so
compiler can put them to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/ab8500.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index 83dba3fbfe0c..6b9a3463f1fd 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -510,7 +510,7 @@ static int ab8500_regulator_set_voltage_sel(struct regulator_dev *rdev,
 	return ret;
 }
 
-static struct regulator_ops ab8500_regulator_volt_mode_ops = {
+static const struct regulator_ops ab8500_regulator_volt_mode_ops = {
 	.enable			= ab8500_regulator_enable,
 	.disable		= ab8500_regulator_disable,
 	.is_enabled		= ab8500_regulator_is_enabled,
@@ -522,7 +522,7 @@ static struct regulator_ops ab8500_regulator_volt_mode_ops = {
 	.list_voltage		= regulator_list_voltage_table,
 };
 
-static struct regulator_ops ab8500_regulator_volt_ops = {
+static const struct regulator_ops ab8500_regulator_volt_ops = {
 	.enable		= ab8500_regulator_enable,
 	.disable	= ab8500_regulator_disable,
 	.is_enabled	= ab8500_regulator_is_enabled,
@@ -531,7 +531,7 @@ static struct regulator_ops ab8500_regulator_volt_ops = {
 	.list_voltage	= regulator_list_voltage_table,
 };
 
-static struct regulator_ops ab8500_regulator_mode_ops = {
+static const struct regulator_ops ab8500_regulator_mode_ops = {
 	.enable			= ab8500_regulator_enable,
 	.disable		= ab8500_regulator_disable,
 	.is_enabled		= ab8500_regulator_is_enabled,
@@ -541,14 +541,14 @@ static struct regulator_ops ab8500_regulator_mode_ops = {
 	.list_voltage		= regulator_list_voltage_table,
 };
 
-static struct regulator_ops ab8500_regulator_ops = {
+static const struct regulator_ops ab8500_regulator_ops = {
 	.enable			= ab8500_regulator_enable,
 	.disable		= ab8500_regulator_disable,
 	.is_enabled		= ab8500_regulator_is_enabled,
 	.list_voltage		= regulator_list_voltage_table,
 };
 
-static struct regulator_ops ab8500_regulator_anamic_mode_ops = {
+static const struct regulator_ops ab8500_regulator_anamic_mode_ops = {
 	.enable		= ab8500_regulator_enable,
 	.disable	= ab8500_regulator_disable,
 	.is_enabled	= ab8500_regulator_is_enabled,
-- 
2.17.1

