Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0084C04AB0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 09:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0C62184E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 09:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPmtw3rk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfEYJrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 05:47:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41750 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfEYJrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 05:47:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id z3so1772718pgp.8;
        Sat, 25 May 2019 02:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tGUCp9c5wnxFVDmV13FsPi0t87+DzwUF5FU9Ec++uMg=;
        b=nPmtw3rk6HBITFHR79yR9mZysxXRqXplFe/kkob+20rGnH3L/+pii/aBt0QB83xlkR
         JiiBxYAx7QdbZK/5ggKHjs8g7d9wiUyanQ9PgMN7sexESF87z2O9vqzPn7Kz65x9cfWp
         Z3WkzWGE/w4WnOcVuw7DZcdwZKVH9/8glkn4NPHBbDVF9M63wnlSuT+ubBIaKvCWJAzo
         +WXOA2E5yGnIg0fCR23aY0Z6Cnrv8ZSgSgtGqroK4a48VISar6x/uBAsk9VC0foTiidH
         3lIP1nU1S4g7hblj+B3Lbtm+zfR1/FDcZ2daXrfnctpj6zmoPF5+rklKOdswGD0z5x62
         zdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tGUCp9c5wnxFVDmV13FsPi0t87+DzwUF5FU9Ec++uMg=;
        b=odHblhbnlQ1lesjl7kv3Lmh7gxSudNLM/X51rTRw+Xb2abAWZtF+HX9g8WLbacTiH3
         SG/h6XkN2FzvyyO341/VZHubRIU4oH8IaBYERQkM6AAPqW1BdTYpSfaboeADwh3ZS6D7
         9tR26ROQqFIqUH9yk6CXraNlsIyEXGvfiVTrw+breSTtgvL8Jso4U2k29omoLXEYNjO8
         SZEEsB1fxjOM8yh1adskqE0xXmBVb+bsg+P9XicR0YeNzCYidFzNXlsg1RhG0bgofBhF
         /W1MHK6DN8qNxtkt3jxIH+D7uv3pdBQwiqyylhLlHsVnsL47rnjONfOBINRWOdtoA9Jn
         zIQQ==
X-Gm-Message-State: APjAAAV1Jf2FFJhgvDeei/ZLU3Lvlgjw/ZDw6m/WiB5oukj5xTXk9+rS
        2dZvU9n1FIvf6DKt9xZ45zVkYsg+
X-Google-Smtp-Source: APXvYqxBDdMYPfX4LiEuDvsvFv2L4bNgo8OPI9FMZHX+y01wVrBgbkYPADST31Iq0k+bYHOl5rsxUw==
X-Received: by 2002:aa7:8683:: with SMTP id d3mr73048882pfo.145.1558777629558;
        Sat, 25 May 2019 02:47:09 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id h14sm4391022pgj.8.2019.05.25.02.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 02:47:09 -0700 (PDT)
Date:   Sat, 25 May 2019 15:17:05 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: gpio: fix warning PTR_ERR_OR_ZERO can be used
Message-ID: <20190525094705.GA23374@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below warning reported by coccicheck

./drivers/spi/spi-gpio.c:302:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/spi/spi-gpio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 487ee55..8c5b98a 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -299,10 +299,8 @@ static int spi_gpio_request(struct device *dev, struct spi_gpio *spi_gpio)
 		return PTR_ERR(spi_gpio->miso);
 
 	spi_gpio->sck = devm_gpiod_get(dev, "sck", GPIOD_OUT_LOW);
-	if (IS_ERR(spi_gpio->sck))
-		return PTR_ERR(spi_gpio->sck);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(spi_gpio->sck);
 }
 
 #ifdef CONFIG_OF
-- 
2.7.4

