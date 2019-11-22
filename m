Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C6BC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA7E2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420517;
	bh=1eXkFWEjcePNjzFPmGb5k9Ej3dTFFQjf7HftCKIGBz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tyhIMWbeu1yPc+i9I6B+WBA6COEZXF2x+CeKR9SooIVcD05fraWAiLMlCgd1K0Zqj
	 T6tGZUGpQUJP1ibD2IDbJa4DJ1HG00E1fCX1jv8TblUNo1KfnTaXJcOE4VpUng+gSs
	 ULNbPrezZM1Dq4KCcHbaxY08+nrW544QUopaI/9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbfKVLB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:01:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:54974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731233AbfKVLBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:01:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A9782075B;
        Fri, 22 Nov 2019 11:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420508;
        bh=1eXkFWEjcePNjzFPmGb5k9Ej3dTFFQjf7HftCKIGBz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b6btlVSPnE1lwu480mFYPQi3Tq9K6coz1kOnt0hxGmeNh776K9cCNQ2cHVLoTaIT6
         HryUBrg8i8Wi/srcpVIcu3YPEApwfodFtHgNYk+MjjbLxosIR4xfshknApvWKrZLDS
         bvpBWoE8gXfzJ9wNc2VIZ96C1yuB2EJ7W9PwHvbQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Kepplinger <martink@posteo.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 131/220] Input: st1232 - set INPUT_PROP_DIRECT property
Date:   Fri, 22 Nov 2019 11:28:16 +0100
Message-Id: <20191122100922.246941927@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Kepplinger <martink@posteo.de>

[ Upstream commit 20bbb312079494a406c10c90932e3c80837c9d94 ]

This is how userspace checks for touchscreen devices most reliably.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/st1232.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index d5dfa4053bbf2..b71673911aac3 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -195,6 +195,7 @@ static int st1232_ts_probe(struct i2c_client *client,
 	input_dev->id.bustype = BUS_I2C;
 	input_dev->dev.parent = &client->dev;
 
+	__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
 	__set_bit(EV_SYN, input_dev->evbit);
 	__set_bit(EV_KEY, input_dev->evbit);
 	__set_bit(EV_ABS, input_dev->evbit);
-- 
2.20.1



