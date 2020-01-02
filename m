Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2E1C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B3A22B48
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003199;
	bh=xnW7rkeCq03lAambOoxHgnTlWg2IdNBcrPVgd6k9tpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rQXbMR9RxkABq7ipvw2Bc3/5w7Axc7gWgT4GFKhkkLuOv1BEKY/ZAr/GPFP8SRXkV
	 8r7ryosDAXgnPkw31o3oU0+Us6xNyOQLOt93uxn/+wo6zEC+G6CohUs7E9gIawYB7X
	 qPlWsVQlfnZ9r8LSV95V+51hYVQR4wtEeWxRFuRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgABWNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:13:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:52940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbgABWNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:13:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C689222C3;
        Thu,  2 Jan 2020 22:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003196;
        bh=xnW7rkeCq03lAambOoxHgnTlWg2IdNBcrPVgd6k9tpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nd3JC7AmTXUPxCeqAR0Owb8aNBrexe6ARLzV098C9lkjRcyhih6k6qBVTY68PZNvk
         BOeR4rfbVdgHoV4XeoFt/yBi9Ac5eitB+KmEIIxuhosfWviB9fjybBgZpf9JXx7w+3
         hTld5J+JDrHWrh7ILnq49XFVxGg9bLkTy2049TnA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 034/191] leds: an30259a: add a check for devm_regmap_init_i2c
Date:   Thu,  2 Jan 2020 23:05:16 +0100
Message-Id: <20200102215833.636319117@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit fc7b5028f2627133c7c18734715a08829eab4d1f ]

an30259a_probe misses a check for devm_regmap_init_i2c and may cause
problems.
Add a check and print errors like other leds drivers.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-an30259a.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/leds/leds-an30259a.c b/drivers/leds/leds-an30259a.c
index 250dc9d6f635..82350a28a564 100644
--- a/drivers/leds/leds-an30259a.c
+++ b/drivers/leds/leds-an30259a.c
@@ -305,6 +305,13 @@ static int an30259a_probe(struct i2c_client *client)
 
 	chip->regmap = devm_regmap_init_i2c(client, &an30259a_regmap_config);
 
+	if (IS_ERR(chip->regmap)) {
+		err = PTR_ERR(chip->regmap);
+		dev_err(&client->dev, "Failed to allocate register map: %d\n",
+			err);
+		goto exit;
+	}
+
 	for (i = 0; i < chip->num_leds; i++) {
 		struct led_init_data init_data = {};
 
-- 
2.20.1



