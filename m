Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC67C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FC12182B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752599;
	bh=6jo4xVgw/OV6xwo5/lbcks/dKpfu3VSc8Qcf1YmyDJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bisba9FiRBm6J6JCPX+VZN22+TflR6ls0a4STtjIz1pzH4bOdkSj/v3u7ffyu6Lyu
	 uNEcLOfB+WjMpWJPUY0Q+Yrw5VB2qj5/YIBo6QoIGlFBkbFmIq8xtwv+nHaSvxppkb
	 XvexSJG3LJMrLnCZxBtko+SP+nhBLvcfTHF3Ynzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403878AbfHBN36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:29:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387722AbfHBNYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:24:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C1DD21852;
        Fri,  2 Aug 2019 13:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752282;
        bh=6jo4xVgw/OV6xwo5/lbcks/dKpfu3VSc8Qcf1YmyDJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Er3oYn8qt+DHBikN9MSmk67+TdIHr6RXDY2LwikN9ij4Qz8so0jbvc4rmCW5OQDm6
         6Faeh1De+X0XEXTGivqd49dW4xw06anxo6U2wGMYE6JiCjgNGyoqWRl/3sxD6t2BeC
         D1YkwKxy/7+2NCDWqCvf4RmoJMhU6CiR/j4xQwuA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20Gerhart?= <gerhart@posteo.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>, linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 08/30] hwmon: (nct6775) Fix register address and added missed tolerance for nct6106
Date:   Fri,  2 Aug 2019 09:24:00 -0400
Message-Id: <20190802132422.13963-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802132422.13963-1-sashal@kernel.org>
References: <20190802132422.13963-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Gerhart <gerhart@posteo.de>

[ Upstream commit f3d43e2e45fd9d44ba52d20debd12cd4ee9c89bf ]

Fixed address of third NCT6106_REG_WEIGHT_DUTY_STEP, and
added missed NCT6106_REG_TOLERANCE_H.

Fixes: 6c009501ff200 ("hwmon: (nct6775) Add support for NCT6102D/6106D")
Signed-off-by: Bjoern Gerhart <gerhart@posteo.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct6775.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index ca9941fa741b7..7e14143ed1191 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -769,7 +769,7 @@ static const u16 NCT6106_REG_TARGET[] = { 0x111, 0x121, 0x131 };
 static const u16 NCT6106_REG_WEIGHT_TEMP_SEL[] = { 0x168, 0x178, 0x188 };
 static const u16 NCT6106_REG_WEIGHT_TEMP_STEP[] = { 0x169, 0x179, 0x189 };
 static const u16 NCT6106_REG_WEIGHT_TEMP_STEP_TOL[] = { 0x16a, 0x17a, 0x18a };
-static const u16 NCT6106_REG_WEIGHT_DUTY_STEP[] = { 0x16b, 0x17b, 0x17c };
+static const u16 NCT6106_REG_WEIGHT_DUTY_STEP[] = { 0x16b, 0x17b, 0x18b };
 static const u16 NCT6106_REG_WEIGHT_TEMP_BASE[] = { 0x16c, 0x17c, 0x18c };
 static const u16 NCT6106_REG_WEIGHT_DUTY_BASE[] = { 0x16d, 0x17d, 0x18d };
 
@@ -3592,6 +3592,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->REG_FAN_TIME[0] = NCT6106_REG_FAN_STOP_TIME;
 		data->REG_FAN_TIME[1] = NCT6106_REG_FAN_STEP_UP_TIME;
 		data->REG_FAN_TIME[2] = NCT6106_REG_FAN_STEP_DOWN_TIME;
+		data->REG_TOLERANCE_H = NCT6106_REG_TOLERANCE_H;
 		data->REG_PWM[0] = NCT6106_REG_PWM;
 		data->REG_PWM[1] = NCT6106_REG_FAN_START_OUTPUT;
 		data->REG_PWM[2] = NCT6106_REG_FAN_STOP_OUTPUT;
-- 
2.20.1

