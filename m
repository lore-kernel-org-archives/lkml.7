Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AB4ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FB220872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263447;
	bh=sa4eUBZuMlSSMi6W6tiquabBPrqcRrjXGCzvIZP5hbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NoUJblIXZwjooFF8Uiczug+GDABpT57+rCwhgD4Ghj1I8iRrQAksLzCXxZZMgRKay
	 CB6dOlBMYeh6Ko4tGpQ982THte9xGGSdeTbGI9prc9f/Fvh7yXfZe7ERz7DuAXvJv1
	 kcb3qCsGojI3IDc+ihJT7hptkWX3Gz6Jy+il8z5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406835AbfJPWEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:04:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438433AbfJPV7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:59:14 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E6C2218DE;
        Wed, 16 Oct 2019 21:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263153;
        bh=sa4eUBZuMlSSMi6W6tiquabBPrqcRrjXGCzvIZP5hbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fmXX370ttx2//i3VdFADpYVNXIoghpVHbXkez4XiTyjzh7K1dMLUJIT0VAeZn7UHK
         Rxg/NwK2LGJG6lZW4qe/QgkQki1Ay3Hl70PIg6+sqVo0nfqKFOjgGFfBqFrHPJfSkQ
         hwcUQu7Jj2Vej5rOREx4CEmLekXmH5L8j3pu1wnM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 081/112] gpio: fix getting nonexclusive gpiods from DT
Date:   Wed, 16 Oct 2019 14:51:13 -0700
Message-Id: <20191016214904.616631307@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214844.038848564@linuxfoundation.org>
References: <20191016214844.038848564@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Felsch <m.felsch@pengutronix.de>

[ Upstream commit be7ae45cfea97e787234e00e1a9eb341acacd84e ]

Since commit ec757001c818 ("gpio: Enable nonexclusive gpiods from DT
nodes") we are able to get GPIOD_FLAGS_BIT_NONEXCLUSIVE marked gpios.
Currently the gpiolib uses the wrong flags variable for the check. We
need to check the gpiod_flags instead of the of_gpio_flags else we
return -EBUSY for GPIOD_FLAGS_BIT_NONEXCLUSIVE marked and requested
gpiod's.

Fixes: ec757001c818 gpio: Enable nonexclusive gpiods from DT nodes
Cc: stable@vger.kernel.org
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
[Bartosz: the function was moved to gpiolib-of.c so updated the patch]
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
[Bartosz: backported to v5.3.y]
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d9074191edef4..e4203c1eb869d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4303,7 +4303,7 @@ struct gpio_desc *gpiod_get_from_of_node(struct device_node *node,
 	transitory = flags & OF_GPIO_TRANSITORY;
 
 	ret = gpiod_request(desc, label);
-	if (ret == -EBUSY && (flags & GPIOD_FLAGS_BIT_NONEXCLUSIVE))
+	if (ret == -EBUSY && (dflags & GPIOD_FLAGS_BIT_NONEXCLUSIVE))
 		return desc;
 	if (ret)
 		return ERR_PTR(ret);
-- 
2.20.1



