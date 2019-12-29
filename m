Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEFAC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C839206A4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642745;
	bh=kOl/wCCk7HSsLd79eEaxf+4dfnRKyYvAobj4NSmG0hQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eqhA+tVWzmW7GFkng3FK14zG3oNMdhOkHQ5Y+Z/+w29MJom1pzAniFN10id1HH3p+
	 +fwGAfiuXtADz0TXj3IQli4wOQ3UQBrpq0vBDFiIlN5HN9iLbt8DKwZfHQx6+/sZqX
	 w7ZZ6yS31Rlwkgr7sPsIWFGTwofVzUnxK1oZGwMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbfL2Ruz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:50:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:35614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731652AbfL2Rux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:50:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30D8420718;
        Sun, 29 Dec 2019 17:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641852;
        bh=kOl/wCCk7HSsLd79eEaxf+4dfnRKyYvAobj4NSmG0hQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UMSr3q7vpqe7G0pjqfDCarl52sDxb5fY4G05klIeGoW+bvrEdx2BzV9Yz/dtLdtub
         TRsT4OkcwUs0juylTVYx+HQk1T+aE4lk69ko4kIv//Bh1H2oaHKyARUbPHoiCdCI9A
         badZSb9CU4lFB7bsB+rITjgV9M+8WIfaqFvp2qLg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 195/434] regulator: core: Release coupled_rdevs on regulator_init_coupling() error
Date:   Sun, 29 Dec 2019 18:24:08 +0100
Message-Id: <20191229172714.780177897@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

[ Upstream commit 26c2c997aa1a6c5522f6619910ba025e53e69763 ]

This patch fixes memory leak which should happen if regulator's coupling
fails to initialize.

Fixes: d8ca7d184b33 ("regulator: core: Introduce API for regulators coupling customization")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Link: https://lore.kernel.org/r/20191025002240.25288-1-digetx@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a46be221dbdc..51ce280c1ce1 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5198,6 +5198,7 @@ unset_supplies:
 	regulator_remove_coupling(rdev);
 	mutex_unlock(&regulator_list_mutex);
 wash:
+	kfree(rdev->coupling_desc.coupled_rdevs);
 	kfree(rdev->constraints);
 	mutex_lock(&regulator_list_mutex);
 	regulator_ena_gpio_free(rdev);
-- 
2.20.1



