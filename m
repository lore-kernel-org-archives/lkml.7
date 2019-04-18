Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95222C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677272186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610532;
	bh=sfpjg2hSG6JaJNn1J3X2ihkVqkRPSQCekahtCyS4czQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kzJKxtvl2DdG5jsqJk7Ac3zdyvWohoGbRh7Hep819lbqVz34pkH0/i9fjMhVJfOW1
	 HG4iPf4Pz/7e9qOLYkHPOXwSEvKgR+s8sGuvR50VRTaWiY0SeKVeoiQZEoHveWrqiN
	 a3jLMezp5W/CPGZ7W2jSfehg7dErD5wsERsLcAIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390709AbfDRSCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:02:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390693AbfDRSCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:02:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C683C21871;
        Thu, 18 Apr 2019 18:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610526;
        bh=sfpjg2hSG6JaJNn1J3X2ihkVqkRPSQCekahtCyS4czQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vLNdLHcVEEzDmwtuMyppAajt5Tjti8rLdMkcCSpSLMvS3PL3J6sKRBeAASgRwEC5K
         6+KQ9SP+WIpOibi5m85aQLUVDq6OI8kccjtJaiHoATmD0S1GS29cP3hGvYuOkllsWL
         Ooxk4ilqO+qDRA/dPTL99Mg75ROfbP13n2qlZFog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 096/110] coresight: cpu-debug: Support for CA73 CPUs
Date:   Thu, 18 Apr 2019 19:57:25 +0200
Message-Id: <20190418160446.860807899@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a0f890aba2be33377f4eb24e13633c4a76a68f38 ]

This patch is to add the AMBA device ID for CA73 CPU, so that CPU debug
module can be initialized successfully when a SoC contain CA73 CPUs.

This patch has been verified on 96boards Hikey960.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-cpu-debug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index 45b2460f3166..e8819d750938 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -668,6 +668,10 @@ static const struct amba_id debug_ids[] = {
 		.id	= 0x000bbd08,
 		.mask	= 0x000fffff,
 	},
+	{       /* Debug for Cortex-A73 */
+		.id	= 0x000bbd09,
+		.mask	= 0x000fffff,
+	},
 	{ 0, 0 },
 };
 
-- 
2.19.1



