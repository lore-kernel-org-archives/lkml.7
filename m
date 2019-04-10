Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3C3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E18A20854
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="psputOWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387755AbfDJQTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:19:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45467 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbfDJQTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:19:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id e24so1756709pfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 09:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=AoqQqD+QU8jtOUItI3aQmmNwCtheLZFPcuJhb0hgBWI=;
        b=psputOWCzEB8PrWPqHTWHtVXuQQSx2G5DvT7h7d4gnRidSdJqk4lBuS2qFo+OzG814
         bqqxieR29JQV3oXFEHGcNeZZ/W3RvR4YEfG3xFq5mzUTN930+W1rlDIbgl6JRn3x8sUq
         tl2cz0xHBzSQFEQTBt3nETg3va8Y1dMeY4RDfyT1O1c8DlXlhBGoxDDeQR8zCB9y5xG2
         Mvi9Z4QuawAkaJovGaxGeQmJUknXTEhdx6DdZTIxo5iWPuqr6sqVg6whrMUcXuNuKlbG
         H3gUm4BB7M3Ltx4cC2SdJWonF4NQLG5yulH7oUSjJZwsNQl50Jk6jB+/71G56LCLtFIE
         sBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AoqQqD+QU8jtOUItI3aQmmNwCtheLZFPcuJhb0hgBWI=;
        b=DqslDgrOQJEuPInNKJim+am9Rkv+7/V+m4tvv0JMp7jm6G38nqHTnzvM4FRbcvoh4a
         a/MyCLVBGky157H5t93R9rF+ZC+XeH6HbLfrpAOTfKBAb/TKgp6Dj/C+Z0S09R+5Jidl
         m4cjOCwKrutJklAQQgBp2kNkf9DwX8GnVRNPj6JkWU7YCy/rTJj5puDxcIXUUbbXwQQJ
         2Xm1nWsR1EtlnVl28P4QMw9P6a6oOs58i1Esz/9tK52Blso7VlDytvKCzR02MjtVODgJ
         OW/Y39Ex2GmZyXDNtQkMdlL1DsfwIT5VZKxZAWeCirW4Q5dfyHjrhJU92sv2sI6H8yPN
         WyPQ==
X-Gm-Message-State: APjAAAVQIYhtWaIKXPpFPd+IBIFP5OUJo3pBzPO/ZbvBSLx9O1mYCdYC
        8ix6GsJ1fnhsUFiBq312r331DgQORNI=
X-Google-Smtp-Source: APXvYqwHjV9eSVaHQ99dN6Vtzc34zLjuQQdDru3TT+GkYJpeoZ65eV0jF/nAcKfbVdZ0V/KeGD+KUA==
X-Received: by 2002:a63:e915:: with SMTP id i21mr41645496pgh.297.1554913187015;
        Wed, 10 Apr 2019 09:19:47 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id a80sm76194167pfj.61.2019.04.10.09.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:19:45 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: vexpress: Constify regulator_ops
Date:   Thu, 11 Apr 2019 00:19:37 +0800
Message-Id: <20190410161937.17224-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vexpress_regulator_ops_ro and vexpress_regulator_ops are never changed,
make them const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/vexpress-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/vexpress-regulator.c b/drivers/regulator/vexpress-regulator.c
index c810cbbd463f..ca4230fe9e77 100644
--- a/drivers/regulator/vexpress-regulator.c
+++ b/drivers/regulator/vexpress-regulator.c
@@ -46,11 +46,11 @@ static int vexpress_regulator_set_voltage(struct regulator_dev *regdev,
 	return regmap_write(reg->regmap, 0, min_uV);
 }
 
-static struct regulator_ops vexpress_regulator_ops_ro = {
+static const struct regulator_ops vexpress_regulator_ops_ro = {
 	.get_voltage = vexpress_regulator_get_voltage,
 };
 
-static struct regulator_ops vexpress_regulator_ops = {
+static const struct regulator_ops vexpress_regulator_ops = {
 	.get_voltage = vexpress_regulator_get_voltage,
 	.set_voltage = vexpress_regulator_set_voltage,
 };
-- 
2.17.1

