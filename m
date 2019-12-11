Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B9DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B961222C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576078718;
	bh=s+wMiJEOiQo89phfscHrYDvY1oc9mRfkQJW9+IN9xPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dseZzvC5uwq+Ewy57MjLmCiSW5k36wMGD1PCLvYZhBUp0T9FI0wsIQ2eFaZeVFWKu
	 NfQ/OfPPcGMO/uY1J2TzEbbw1UwxWHcnlTn8g9OMS0wnpe8hk+8aaUNT+ylF7s0FOT
	 6Td7fAJ7B87Gpa1l7RmPNGgbSwv9jj7N42BgSpIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388459AbfLKPih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:38:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:49034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388448AbfLKPid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:38:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D73312465A;
        Wed, 11 Dec 2019 15:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576078712;
        bh=s+wMiJEOiQo89phfscHrYDvY1oc9mRfkQJW9+IN9xPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NgroWYrxFJpBv1doUIAqgJrZ+GrDFw0y9fZ9ZdCVcNzW2lB/E4UqrDJqXgAuiXBnX
         Hdz5UIY9uVjwXE0neIM8SNFcHuYYG0V63nTnOZ6isVFsPTxqrcLDM8lL9x8q2PHqST
         9CbCwaJnBvAuVXaW8I5eW2dT6lM5mTwL6pj46/hk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>, Barry Song <Baohua.Song@csr.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 18/37] mfd: mfd-core: Honour Device Tree's request to disable a child-device
Date:   Wed, 11 Dec 2019 10:37:54 -0500
Message-Id: <20191211153813.24126-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211153813.24126-1-sashal@kernel.org>
References: <20191211153813.24126-1-sashal@kernel.org>
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
index 215bb5eeb5acf..85f4e55823717 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -177,6 +177,11 @@ static int mfd_add_device(struct device *parent, int id,
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

