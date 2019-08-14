Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4E8C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375142084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802810;
	bh=a7K/CS+9KoiJHQSFEdbPGxqR6o8sHxo9UoNAUT75B/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dJmGmpQQlKTDANk/p3YJT2o0wkceu2y8XIMNL6Ux71R4NamOXdmV/JUDErTn7lIhY
	 nJx1m4FMGwWcz88xeApMItmLmIca98eiut1WS9nbMsXtDyXlAFvFsWnZlHjaA8UemP
	 kxTjxJO6W1utuoNV51hpBxLi6++Vc5dwNx/QuB/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbfHNRN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:13:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730888AbfHNRNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:13:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D30AB2063F;
        Wed, 14 Aug 2019 17:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802805;
        bh=a7K/CS+9KoiJHQSFEdbPGxqR6o8sHxo9UoNAUT75B/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2TRUSEzQPFZwXpFOJbumQ/r3yFD6UUBlz7+riRwszFHM13KqwoRWwtEZQ/JIEJTFS
         rMymaiEetTJNnmDSVq5U7AMzL5ilrF9kvYtUUOk6Qp+zSRnSN+a5h9wgJnvOIsPpiq
         YEDvZ6sjr1E854uu/wjE9Jc4kDylTn8+oT3h6n5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bjoern Gerhart <gerhart@posteo.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 32/69] hwmon: (nct6775) Fix register address and added missed tolerance for nct6106
Date:   Wed, 14 Aug 2019 19:01:30 +0200
Message-Id: <20190814165747.750908238@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165744.822314328@linuxfoundation.org>
References: <20190814165744.822314328@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



