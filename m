Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679D1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B262177E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368564;
	bh=flin8mdXjaVD25xk/6vgdvbM/euxZkxQ0Km8b3p4pSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kwxNvWYCRpcWwam6NyA3gEqJbQ1XUh0AyKxGq/evigh0bVTa2RmbXMECgGLdq01Fj
	 7m8AEMJx23pYVjscRrAL7Txi30MEwK82NYDmh68O1at1m5xXwuH4iylvn1hg2VWaqi
	 815KseJz1FzmvDuJdrpIsFIWGc5v1Hhkxd8sy7IY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731683AbfDDJCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:02:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731651AbfDDJCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:02:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE70D2183E;
        Thu,  4 Apr 2019 09:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368560;
        bh=flin8mdXjaVD25xk/6vgdvbM/euxZkxQ0Km8b3p4pSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FcgkoOrScTiDV8yB69zkSB6LHq4FauNlKBCeRI85I4dS2uSIpemMCHaem21IbmawX
         j1tge5u2f2ZprLXYRzgv4UZn75J9VzCamSZNlLrX37Osn6+6sCd3TsUE1cxXGPGF1C
         vzDfBtg8/0MPX2UP6SjieWyR7lZ/WP61tE+5hPzU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenyou Yang <wenyou.yang@microchip.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 084/187] media: ov7740: fix runtime pm initialization
Date:   Thu,  4 Apr 2019 10:47:01 +0200
Message-Id: <20190404084606.993507672@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 12aceee1f412c3ddc7750155fec06c906f14ab51 ]

The runtime PM of this device is enabled after v4l2_ctrl_handler_setup(),
and this makes this device's runtime PM usage count a negative value.

The ov7740_set_ctrl() tries to do something only if the device's runtime
PM usage counter is nonzero.

ov7740_set_ctrl()
{
	if (!pm_runtime_get_if_in_use(&client->dev))
		return 0;

	<do something>;

	pm_runtime_put(&client->dev);

	return ret;
}

However, the ov7740_set_ctrl() is called by v4l2_ctrl_handler_setup()
while the runtime PM of this device is not yet enabled.  In this case,
the pm_runtime_get_if_in_use() returns -EINVAL (!= 0).

Therefore we can't bail out of this function and the usage count is
decreased by pm_runtime_put() without increment.

This fixes this problem by enabling the runtime PM of this device before
v4l2_ctrl_handler_setup() so that the ov7740_set_ctrl() is always called
when the runtime PM is enabled.

Cc: Wenyou Yang <wenyou.yang@microchip.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Tested-by: Eugen Hristev <eugen.hristev@microchip.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov7740.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov7740.c b/drivers/media/i2c/ov7740.c
index 605f3e25ad82..f5a1ee90a6c5 100644
--- a/drivers/media/i2c/ov7740.c
+++ b/drivers/media/i2c/ov7740.c
@@ -1101,6 +1101,9 @@ static int ov7740_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
+	pm_runtime_set_active(&client->dev);
+	pm_runtime_enable(&client->dev);
+
 	ret = ov7740_detect(ov7740);
 	if (ret)
 		goto error_detect;
@@ -1123,8 +1126,6 @@ static int ov7740_probe(struct i2c_client *client,
 	if (ret)
 		goto error_async_register;
 
-	pm_runtime_set_active(&client->dev);
-	pm_runtime_enable(&client->dev);
 	pm_runtime_idle(&client->dev);
 
 	return 0;
@@ -1134,6 +1135,8 @@ error_async_register:
 error_init_controls:
 	ov7740_free_controls(ov7740);
 error_detect:
+	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
 	ov7740_set_power(ov7740, 0);
 	media_entity_cleanup(&ov7740->subdev.entity);
 
-- 
2.19.1



