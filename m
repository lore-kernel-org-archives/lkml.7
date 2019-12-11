Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96381C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6349F2073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079096;
	bh=iPKEUpxeHG0qUl3OMucyM2UZH4qGOdLTBgm4315lIpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HanIij5RCbGGYGcrpLuujl/A//VfE9w/ckAUQRpztxg+gqC6A3hYOXZKiW+P8JcNW
	 QC4+zTMnv+E1H6X5hT/PxRQ4AzKJpjJ9TnuJGrzyTdKSzBdK8H553ETvH2AwTIKAax
	 WcJbPgR0wmQzQGpRpAFo1WYiICdkJoA4/VQPQjAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732699AbfLKPoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:44:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:32906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733305AbfLKP1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:27:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 877CE24671;
        Wed, 11 Dec 2019 15:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576078039;
        bh=iPKEUpxeHG0qUl3OMucyM2UZH4qGOdLTBgm4315lIpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FVDpqUvzPCwgbxEyFO1hXnXKQTaK7c5zrSixKTcvQyfsSC7e274FRV37SHfH8AIqd
         Kpgab8xzORBbV75zihdxj12xw9vnKMcughD8XrTd6RPqOzkV3vE/Qg2ftK66S/PAgb
         +yeUVD2UPJJXhVApDz6cdIEMIK20hdO5dM/Wis+g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>, Barry Song <Baohua.Song@csr.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 33/79] mfd: mfd-core: Honour Device Tree's request to disable a child-device
Date:   Wed, 11 Dec 2019 10:25:57 -0500
Message-Id: <20191211152643.23056-33-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211152643.23056-1-sashal@kernel.org>
References: <20191211152643.23056-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lee Jones <lee.jones@linaro.org>

[ Upstream commit 6b5c350648b857047b47acf74a57087ad27d6183 ]

Until now, MFD has assumed all child devices passed to it (via
mfd_cells) are to be registered. It does not take into account
requests from Device Tree and the like to disable child devices
on a per-platform basis.

Well now it does.

Link: https://www.spinics.net/lists/arm-kernel/msg366309.html
Link: https://lkml.org/lkml/2019/8/22/1350

Reported-by: Barry Song <Baohua.Song@csr.com>
Reported-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/mfd-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 182973df1aed4..99a9c5c56ea99 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -178,6 +178,11 @@ static int mfd_add_device(struct device *parent, int id,
 	if (parent->of_node && cell->of_compatible) {
 		for_each_child_of_node(parent->of_node, np) {
 			if (of_device_is_compatible(np, cell->of_compatible)) {
+				if (!of_device_is_available(np)) {
+					/* Ignore disabled devices error free */
+					ret = 0;
+					goto fail_alias;
+				}
 				pdev->dev.of_node = np;
 				pdev->dev.fwnode = &np->fwnode;
 				break;
-- 
2.20.1

