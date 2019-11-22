Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84524C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F9020731
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420039;
	bh=cJGzYbNWB0fR9aGWMHzBG04PDx7fXux7xRsDRm8L6VQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ffWJCyjDPubxoPahTgDQzKVsaMS7xFX8KDd3mWNNIjZcFpliJPSTXzJa6RJuint9Y
	 H1RwkwvYP32Lk57cf1QTCY/fM2LzEJ4ZRhErRA2bh+h0K6XKA2kkOE279UTsjMe+SO
	 NeSUCJqz9PEbkR3FCQr+8HGuxJaiFSP2PEkmmeXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbfKVKx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:53:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:38948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730010AbfKVKxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:53:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 813D820637;
        Fri, 22 Nov 2019 10:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420034;
        bh=cJGzYbNWB0fR9aGWMHzBG04PDx7fXux7xRsDRm8L6VQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BMvBHBApv7rY+z1vYJ2xhk+EiL31rGlWekzyCq3seMvaMcRgFriB5y7Asd9XCnQqR
         0f29R25ZZEJ2URAtYx+2MUnB9yT6E0bjrzVSStiT/cCSuteGDn4agOmTVZdj7lppYC
         gVNAdzutbsItvNfFimtPhL7cyt0LxWlm00xgArhk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Kepplinger <martink@posteo.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 076/122] Input: st1232 - set INPUT_PROP_DIRECT property
Date:   Fri, 22 Nov 2019 11:28:49 +0100
Message-Id: <20191122100816.416355396@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100722.177052205@linuxfoundation.org>
References: <20191122100722.177052205@linuxfoundation.org>
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
index be5615c6bf8ff..482f97e1c9d37 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -203,6 +203,7 @@ static int st1232_ts_probe(struct i2c_client *client,
 	input_dev->id.bustype = BUS_I2C;
 	input_dev->dev.parent = &client->dev;
 
+	__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
 	__set_bit(EV_SYN, input_dev->evbit);
 	__set_bit(EV_KEY, input_dev->evbit);
 	__set_bit(EV_ABS, input_dev->evbit);
-- 
2.20.1



