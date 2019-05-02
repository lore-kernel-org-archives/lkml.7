Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2966DC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBDC2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556810905;
	bh=TDcYA3yCdFSvEvqNP5VLT/qJ0q6rfiqsgb0e7fcpklQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dNPPhoJjg+g9BWaf1/iXp4ai+YoUYzCjj5wRYoX9yYqWAdiA2CF0THprzcBiRy6JL
	 K5hVDiGqgMQvzj6WRb9T5T0lpMyecFMqMZmuImD7jKCTlxLnnFGtU8mJDXmLdaw7lA
	 iKebboLvPHY5ya4QwBD6Zx5r7aFZtY5g6kzXBoVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfEBP2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:28:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbfEBP2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:28:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C4CA2085A;
        Thu,  2 May 2019 15:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810901;
        bh=TDcYA3yCdFSvEvqNP5VLT/qJ0q6rfiqsgb0e7fcpklQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p9f70qYlXtFlqOuDr1rXj7rso2v5VxSPvQPpo01gm/R+xWinJpzpYvnkB7uDk1XUO
         fuHuSenNMMhtupwK+7uQPK2JgiOyJFYc7lp+bpaM3V90q4DCIAZ28ACt3IJD1MhD2r
         8GPFh+FNL8SHhNhfooISZRPx5QU8POkYMlzpJyZc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.19 72/72] leds: trigger: netdev: use memcpy in device_name_store
Date:   Thu,  2 May 2019 17:21:34 +0200
Message-Id: <20190502143338.948518662@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143333.437607839@linuxfoundation.org>
References: <20190502143333.437607839@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 909346433064b8d840dc82af26161926b8d37558 ]

If userspace doesn't end the input with a newline (which can easily
happen if the write happens from a C program that does write(fd,
iface, strlen(iface))), we may end up including garbage from a
previous, longer value in the device_name. For example

# cat device_name

# printf 'eth12' > device_name
# cat device_name
eth12
# printf 'eth3' > device_name
# cat device_name
eth32

I highly doubt anybody is relying on this behaviour, so switch to
simply copying the bytes (we've already checked that size is <
IFNAMSIZ) and unconditionally zero-terminate it; of course, we also
still have to strip a trailing newline.

This is also preparation for future patches.

Fixes: 06f502f57d0d ("leds: trigger: Introduce a NETDEV trigger")
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/leds/trigger/ledtrig-netdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 167a94c02d05..136f86a1627d 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -122,7 +122,8 @@ static ssize_t device_name_store(struct device *dev,
 		trigger_data->net_dev = NULL;
 	}
 
-	strncpy(trigger_data->device_name, buf, size);
+	memcpy(trigger_data->device_name, buf, size);
+	trigger_data->device_name[size] = 0;
 	if (size > 0 && trigger_data->device_name[size - 1] == '\n')
 		trigger_data->device_name[size - 1] = 0;
 
-- 
2.19.1



