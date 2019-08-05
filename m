Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC812C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4F420880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565010644;
	bh=LfdDGE9zo2n/W7A62nkEXpDTR+YgBiGfYmzTUL8n6nU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X2tXrKh9F0bCmk7woZ51RudbQyBY7eZ2Hm9fjrptEEdjtrLXVILuwCMy+o5eWcgyN
	 /z5YdR4brHj/jfn3VMOnYx7MfbmSntbch/jP6RJ013GNyI/Tk0WR7pVpThu12TJLol
	 C2wShW1ipWpV9xk7Y1edyHmoiA7PyBZt10388HDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbfHENKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:10:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729255AbfHENKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:10:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 000212173B;
        Mon,  5 Aug 2019 13:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565010639;
        bh=LfdDGE9zo2n/W7A62nkEXpDTR+YgBiGfYmzTUL8n6nU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QP/0M5S43vfeEA1ZgfwBNLumEoIYhqazZvjXBMTs9dUuW+BDJjHhPWZF5mgfawXF1
         2e8MQiHYoXVgn8cVEgcwkpLVYo/3hwrMFqucdX9CnsKU4XbXzRoTv19Blhwwc+oib+
         mFDpwmG2RTYJhkS4Z/dQpfiZhUZ1Eis/O0y0J4aA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alim Akhtar <alim.akhtar@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 46/74] mmc: dw_mmc: Fix occasional hang after tuning on eMMC
Date:   Mon,  5 Aug 2019 15:02:59 +0200
Message-Id: <20190805124939.613665562@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124935.819068648@linuxfoundation.org>
References: <20190805124935.819068648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

commit ba2d139b02ba684c6c101de42fed782d6cd2b997 upstream.

In commit 46d179525a1f ("mmc: dw_mmc: Wait for data transfer after
response errors.") we fixed a tuning-induced hang that I saw when
stress testing tuning on certain SD cards.  I won't re-hash that whole
commit, but the summary is that as a normal part of tuning you need to
deal with transfer errors and there were cases where these transfer
errors was putting my system into a bad state causing all future
transfers to fail.  That commit fixed handling of the transfer errors
for me.

In downstream Chrome OS my fix landed and had the same behavior for
all SD/MMC commands.  However, it looks like when the commit landed
upstream we limited it to only SD tuning commands.  Presumably this
was to try to get around problems that Alim Akhtar reported on exynos
[1].

Unfortunately while stress testing reboots (and suspend/resume) on
some rk3288-based Chromebooks I found the same problem on the eMMC on
some of my Chromebooks (the ones with Hynix eMMC).  Since the eMMC
tuning command is different (MMC_SEND_TUNING_BLOCK_HS200
vs. MMC_SEND_TUNING_BLOCK) we were basically getting back into the
same situation.

I'm hoping that whatever problems exynos was having in the past are
somehow magically fixed now and we can make the behavior the same for
all commands.

[1] https://lkml.kernel.org/r/CAGOxZ53WfNbaMe0_AM0qBqU47kAfgmPBVZC8K8Y-_J3mDMqW4A@mail.gmail.com

Fixes: 46d179525a1f ("mmc: dw_mmc: Wait for data transfer after response errors.")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Alim Akhtar <alim.akhtar@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/dw_mmc.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2038,8 +2038,7 @@ static void dw_mci_tasklet_func(unsigned
 				 * delayed. Allowing the transfer to take place
 				 * avoids races and keeps things simple.
 				 */
-				if ((err != -ETIMEDOUT) &&
-				    (cmd->opcode == MMC_SEND_TUNING_BLOCK)) {
+				if (err != -ETIMEDOUT) {
 					state = STATE_SENDING_DATA;
 					continue;
 				}


