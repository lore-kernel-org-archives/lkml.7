Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15478C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5672064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334821;
	bh=92KM0Hg7I0+v96nTiX4I0Il58DgOijqfraiDVrrXDGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WaXWXcC8kNv9skdVud+moNx6OkcsOEvB55cNRwbCqUX4CTDkdmxn6MqtJp98paAzz
	 TiKL6mGV0n7l5/oM/SYsUaPXr2dsRW++28C/UBwnPp+5utInKRQuutMtD2JLKVruy8
	 QG5FgFZwxVi5XWMfE65EzMgEL6hV5Qq2YlbSpP2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfCKUHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:07:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729178AbfCKT5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:57:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32E3C2084F;
        Mon, 11 Mar 2019 19:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334265;
        bh=92KM0Hg7I0+v96nTiX4I0Il58DgOijqfraiDVrrXDGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ypHPubJW2KL5o+8WNEWMm9lOvKDb203RSC9OcIKftPsQ7vfTtZtaDDa7TTPl3Tz06
         m+g8irpIkmNVVaSolm6DD9UsKN35+AWR0QQ6Slzn9MczI74RgHQ4uB4vhZV4o9jzWe
         ocdJ7F9F5AbJCERxT9CnWqpsk9RipCK8D9BnW/M0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 24/44] Input: ps2-gpio - flush TX work when closing port
Date:   Mon, 11 Mar 2019 15:56:40 -0400
Message-Id: <20190311195700.138462-24-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195700.138462-1-sashal@kernel.org>
References: <20190311195700.138462-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 33a841ce5cef4ca6c18ad333248b6d273f54c839 ]

To ensure that TX work is not running after serio port has been torn down,
let's flush it when closing the port.

Reported-by: Sven Van Asbroeck <thesven73@gmail.com>
Acked-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/serio/ps2-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/serio/ps2-gpio.c b/drivers/input/serio/ps2-gpio.c
index c62cceb97bb1..5e8d8384aa2a 100644
--- a/drivers/input/serio/ps2-gpio.c
+++ b/drivers/input/serio/ps2-gpio.c
@@ -76,6 +76,7 @@ static void ps2_gpio_close(struct serio *serio)
 {
 	struct ps2_gpio_data *drvdata = serio->port_data;
 
+	flush_delayed_work(&drvdata->tx_work);
 	disable_irq(drvdata->irq);
 }
 
-- 
2.19.1

