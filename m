Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2B4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CEF2080F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="td11rjQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbfCYX5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:57:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37196 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfCYX5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 19:57:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id q206so7351634pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 16:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=skqrng7+CHrbhyFbBjUURESa0erLz8SL58W/3mje0eE=;
        b=td11rjQ5ADwW7DCCLqGneU3b6JiX4KeasWIPRbh54d1q8EScDIcvVj5HLOfyyNcqmy
         g1Wt8VRx/kJNkZztTWpVi111krxXgMCa/JG9Q31Kb8Fg3xS345Mc5DVY+Bi+ZfRMEqOu
         CPIcHwK37Vp0kPaHHDS1oiOWGVWcwzbKSASPOF92MKBeqZlojVtad6gkJFnOhhtczHqC
         qXMxkq+/z8dKWypaHaMN8SSz9BNHG8oS0h0Z7hCSWpRQmcLbMYz0PM/D5+Hiyp3PeVLb
         DWZwGqfR9yVvolV0fd8FopqZaZ2XVtbXKs1nNP1QG3htWkF6GTb2Ay8k7XTsN/FoMnef
         d78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=skqrng7+CHrbhyFbBjUURESa0erLz8SL58W/3mje0eE=;
        b=KfxOZrZxvVbK7lz7aLlQK5rhPKAgJlls7DHFi1Zo6i0f/22SsjKUe0Snl74OJ9WBcO
         oYvFnsJwGmNoOtzgobFCTmCNNsTuH0WIi+JBd8QFbMFoHqs6PbcjMfqzV5gpy1TBMkyM
         +id7M7Xlwbu3agwyp1keFplVoWm0ghaTrVGIbmt121zcLhJbaPOHRcJ7htTOgEPjVTtJ
         su9xevQvApUNLfP/+GbBodNffCUSYVzRtJ6O7Jn+ktMbKO1hQHZnCbM+8fqWn8dwEgsR
         TQO97eEk7vL0RR4GGZkklqdaEw/jyQgo6wWqS87RKfvwCG1771cOtku4/S7bVBxFQxWq
         T0fg==
X-Gm-Message-State: APjAAAW7ZF7dB12y1pMaUdr4AZ45ykTnNVnSVagKw1tFfWdO7KG/2Epi
        xP49v6Su6HMY/jOrnhM4bJ8bJA==
X-Google-Smtp-Source: APXvYqw0SCh9aBjUjQnye1+od/El744lSBp12xTa10imxlI44zvjO0KsI7fXGYhUhMQuApbJgaEOhQ==
X-Received: by 2002:a65:62c2:: with SMTP id m2mr25506755pgv.348.1553558270780;
        Mon, 25 Mar 2019 16:57:50 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id j17sm15876550pfa.51.2019.03.25.16.57.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 16:57:49 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Erick Chen <erick.chen@spreadtrum.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: sc2731: Constify regulators
Date:   Tue, 26 Mar 2019 07:57:39 +0800
Message-Id: <20190325235739.26085-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regulators array should never need to be modified, make it const so
compiler can put it to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/sc2731-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/sc2731-regulator.c b/drivers/regulator/sc2731-regulator.c
index eb2bdf060b7b..0f21f95c8981 100644
--- a/drivers/regulator/sc2731-regulator.c
+++ b/drivers/regulator/sc2731-regulator.c
@@ -146,7 +146,7 @@ static const struct regulator_ops sc2731_regu_linear_ops = {
 	.vsel_mask		= vmask,			\
 }
 
-static struct regulator_desc regulators[] = {
+static const struct regulator_desc regulators[] = {
 	SC2731_REGU_LINEAR(BUCK_CPU0, SC2731_POWER_PD_SW,
 			   SC2731_DCDC_CPU0_PD_MASK, SC2731_DCDC_CPU0_VOL,
 			   SC2731_DCDC_CPU0_VOL_MASK, 3125, 400000, 1996875),
-- 
2.17.1

