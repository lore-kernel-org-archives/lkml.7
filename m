Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2771BC76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36D02053B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419864;
	bh=a9z8rCK1xSzHtj4ft+94eFAnnHdLi6TsvngDXLxFIjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kMzdRvH+eUMvzRxRfX3wJ3IIwVV01DQNzbV+6NDfuJEe2AW0OMhtDDMlxaJTmQEjS
	 MiIVlqSsIx3/zdjoI5uckUgg/1Y6/rh8cYPvkwSfZFG0X0QW7NmEZsgtwSHlwbuRFa
	 PPdA+7IFZZZSQhWWOPsvUfif3F0juQ7yTFD3J5Fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391772AbfGRDRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:17:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388695AbfGRDOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:14:24 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F2D72053B;
        Thu, 18 Jul 2019 03:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419663;
        bh=a9z8rCK1xSzHtj4ft+94eFAnnHdLi6TsvngDXLxFIjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DI2k3XYVuYXfprL0JHIeohL5aCMR2/+q7BcnCPp0/UZN1xzLokWplDhvvC/X6hlBj
         I+HhvQBW/ivbKH88FlcTKE/j1kHHHBHPKQkJCLYfhWc29LcYh1It9kN65a8jd6ykAP
         O9B1yEM9gQv+oPA0NDRCuk+qlONm0h/M8w1z2o7w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 01/40] Input: elantech - enable middle button support on 2 ThinkPads
Date:   Thu, 18 Jul 2019 12:01:57 +0900
Message-Id: <20190718030039.885612461@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030039.676518610@linuxfoundation.org>
References: <20190718030039.676518610@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit aa440de3058a3ef530851f9ef373fbb5f694dbc3 ]

Adding 2 new touchpad PNPIDs to enable middle button support.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/elantech.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 4c1e527f14a5..7b942ee364b6 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1191,6 +1191,8 @@ static const char * const middle_button_pnp_ids[] = {
 	"LEN2132", /* ThinkPad P52 */
 	"LEN2133", /* ThinkPad P72 w/ NFC */
 	"LEN2134", /* ThinkPad P72 */
+	"LEN0407",
+	"LEN0408",
 	NULL
 };
 
-- 
2.20.1



