Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3182C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 03:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB33A217F4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 03:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578109063;
	bh=OMdL7w3tIP9+unUsVjrMVHBZVmASDJsoN3LWK+rdseI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wPQWea0OXGYuysbSO43Belp5ZXGx6hErGOvqkoyp0VVmPzJmX832NZX9DvL8ZXBwt
	 B+7r/zcmzJRWETOvXo97ReR9ImMLoAoIdydObfnrtv2q2i8cwuTRMee+xr4iIefdnQ
	 5N7maQt2i63x1uee768U2QwgPLrzmOwsFWPJnFbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgADDhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 22:37:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:37852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727612AbgADDgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 22:36:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D187B2464E;
        Sat,  4 Jan 2020 03:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578109007;
        bh=OMdL7w3tIP9+unUsVjrMVHBZVmASDJsoN3LWK+rdseI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KzX7Vxq856qw3ZV83w7xGWCS5WJgm3hOP0s55KUjKGj3DMaECCiDV1B9EJkdnnTrv
         pXpxha2DMO8cw89T+nMbDvp3TzZfRsze2CDp40b6xAvF6iQ3OKqGwKSRQ0l8FyCe+w
         ZQqMyN3xYBb/4gFIbP3ykeiawGYvckrXcPTV7Npg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 2/5] gpio: Fix error message on out-of-range GPIO in lookup table
Date:   Fri,  3 Jan 2020 22:36:41 -0500
Message-Id: <20200104033644.11121-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200104033644.11121-1-sashal@kernel.org>
References: <20200104033644.11121-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit d935bd50dd14a7714cbdba9a76435dbb56edb1ae ]

When a GPIO offset in a lookup table is out-of-range, the printed error
message (1) does not include the actual out-of-range value, and (2)
contains an off-by-one error in the upper bound.

Avoid user confusion by also printing the actual GPIO offset, and
correcting the upper bound of the range.
While at it, use "%u" for unsigned int.

Sample impact:

    -requested GPIO 0 is out of range [0..32] for chip e6052000.gpio
    +requested GPIO 0 (45) is out of range [0..31] for chip e6052000.gpio

Fixes: 2a3cf6a3599e9015 ("gpiolib: return -ENOENT if no GPIO mapping exists")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20191127095919.4214-1-geert+renesas@glider.be
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index b81a27c7f89c..5e2357fda934 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3749,8 +3749,9 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
 
 		if (chip->ngpio <= p->chip_hwnum) {
 			dev_err(dev,
-				"requested GPIO %d is out of range [0..%d] for chip %s\n",
-				idx, chip->ngpio, chip->label);
+				"requested GPIO %u (%u) is out of range [0..%u] for chip %s\n",
+				idx, p->chip_hwnum, chip->ngpio - 1,
+				chip->label);
 			return ERR_PTR(-EINVAL);
 		}
 
-- 
2.20.1

