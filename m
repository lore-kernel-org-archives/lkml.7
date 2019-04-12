Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624BEC10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AEE2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="qWIsZjxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfDLBye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:54:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41164 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfDLByd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:54:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id d1so4286369plj.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 18:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=rMz2fhDr9gEYL8MliPSj+taiTr5cAQ10NqThI2MA2kI=;
        b=qWIsZjxHjhNCJLnk+VWzXvlLsGB44vyCaeuk8u+JXOZFRh6oQ5A2dQjW3y3zIUmdCD
         eANDKivs94D/E7ATHzofY5H1ECblj0qlHBUxBjlzwvOln1T3rZn5zrvPVj7+V0kHZni9
         tOBRlVEkbSzv8326unVNvorIZ5IdBFo4cvuZX0E6LHMTtEJWIN2FCt3ZSDCfQGcp5r0L
         asy5RNzozYO+UfKyzKhT/mBYyeNCWdNKyFuwyoxWNrvgp7ApKoRpzODIphoNCkrkKwef
         5UcAqE2/9WyQIRbi/cgrEEvT/JQ6mcQZ+0juDHDRUyU0JhefoK+fEOe20ooQepVGgDxV
         GzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rMz2fhDr9gEYL8MliPSj+taiTr5cAQ10NqThI2MA2kI=;
        b=dpUmhOK7xsMKzQRzA/wkbWGUAjmPtOJfXPl9+YNYa22E8dTaf3IwppZMe3cSgYlGAt
         3zFTIyqgMefyC4Z/e0f9WhPrcHKaPCM+iOb1jCyzv1Dibe6U6+yVNToOrLntfET7aD/3
         zIUd4LFoVGA6mCUDcjbR4LohqOXQuQJHhiebXcetMtgbD6hUNckgG/X2vJMxmenlzhvc
         pJHRlzZyy35Ytz6rZ7Q0s3cTm/h+KPDuBokWcD5U7p8NvMM7sXlS2foagmNXc3CyC/sx
         yKLYxpIt1Drn6KE49/z/wtf92bg+YtIlbKcawC9RJMLo74ISy8Jfsdl4335jzRtaol+j
         02zw==
X-Gm-Message-State: APjAAAU+0+INeNAzuEYfgLcpZFFAj+7iy5Ciq0jEN1huNdigzQ/OUJhi
        Nc+6mB4dx/iMOWgKeWsRI4FSpe64erk=
X-Google-Smtp-Source: APXvYqyPcQVdFfjpC8SFPvuzWY6cnVMg7dUu3BxRTVYQNqGkdN7ypd6p12u1JU8oDpfhS8ssVeOOKA==
X-Received: by 2002:a17:902:b68e:: with SMTP id c14mr52585665pls.49.1555034072842;
        Thu, 11 Apr 2019 18:54:32 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id y12sm105977016pgq.64.2019.04.11.18.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 18:54:31 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bengt Jonsson <bengt.g.jonsson@stericsson.com>,
        Mattias Nilsson <mattias.i.nilsson@stericsson.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/3] regulator: db8500-prcmu: Constify regulator_ops
Date:   Fri, 12 Apr 2019 09:54:19 +0800
Message-Id: <20190412015421.27078-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These regulator_ops variables never need to be modified, make them const so
compiler can put them to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/db8500-prcmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/db8500-prcmu.c b/drivers/regulator/db8500-prcmu.c
index 7cec535cf0bc..863bd3de42a7 100644
--- a/drivers/regulator/db8500-prcmu.c
+++ b/drivers/regulator/db8500-prcmu.c
@@ -75,7 +75,7 @@ static int db8500_regulator_is_enabled(struct regulator_dev *rdev)
 }
 
 /* db8500 regulator operations */
-static struct regulator_ops db8500_regulator_ops = {
+static const struct regulator_ops db8500_regulator_ops = {
 	.enable			= db8500_regulator_enable,
 	.disable		= db8500_regulator_disable,
 	.is_enabled		= db8500_regulator_is_enabled,
@@ -200,7 +200,7 @@ static int db8500_regulator_switch_is_enabled(struct regulator_dev *rdev)
 	return info->is_enabled;
 }
 
-static struct regulator_ops db8500_regulator_switch_ops = {
+static const struct regulator_ops db8500_regulator_switch_ops = {
 	.enable			= db8500_regulator_switch_enable,
 	.disable		= db8500_regulator_switch_disable,
 	.is_enabled		= db8500_regulator_switch_is_enabled,
-- 
2.17.1

