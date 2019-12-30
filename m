Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0658CC2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AC12071E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577726890;
	bh=k8CPM6BW2PVS9PMxVy+ar41ppg5zunSy4syN8in4/c4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rhyQ3nj9wCUb593CIoTQ/QNPPKLfuvmLTT8Y84e+ktFSSyn0daBSGYXI/zLnCKvYV
	 A9M0AbBrsjRhMr3nHwhLrEveFS+shVu9PFDu7YkpJhyoJTdTb7htcvaL9xJm0EQJ+W
	 RZA+a3Y5LEXQMRB5i0v2sIm9MMkG+gHk+e5Ty8u0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfL3R2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 12:28:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:33620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbfL3R2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 12:28:06 -0500
Received: from localhost.localdomain (unknown [194.230.155.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99C7F2077B;
        Mon, 30 Dec 2019 17:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577726886;
        bh=k8CPM6BW2PVS9PMxVy+ar41ppg5zunSy4syN8in4/c4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cSh6/dKUCMROG2xOErpjYStNBbcTGXO/Dk1nPTT5VrWTqt3OiGYhGk6xoylm/aFLv
         LLXwqwWOKhWDvXW74xXWTQbNYnbOD0LlZueTpUj3BXoSPfpENWKVJDAwTfPJf3TxcN
         Pw2ZdigonOCeHKfKf0qold9wNb55ieT/1Qq5XyaA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jean Delvare <jdelvare@suse.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Max Staudt <max@enpas.org>,
        Juergen Fitschen <jfi@ssv-embedded.de>,
        Elie Morisse <syniurge@gmail.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/5] i2c: highlander: Use proper printk format for iomem pointer
Date:   Mon, 30 Dec 2019 18:27:49 +0100
Message-Id: <20191230172751.17985-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230172751.17985-1-krzk@kernel.org>
References: <20191230172751.17985-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iomem pointers should be printed with pointer format to hide the
actual value and fix warnings when compiling on 64-bit platform (e.g. with
COMPILE_TEST):

    drivers/i2c/busses/i2c-highlander.c: In function ‘highlander_i2c_smbus_xfer’:
    drivers/i2c/busses/i2c-highlander.c:325:22: warning:
        format ‘%d’ expects argument of type ‘int’,
        but argument 3 has type ‘size_t {aka long unsigned int}’ [-Wformat=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/i2c/busses/i2c-highlander.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-highlander.c b/drivers/i2c/busses/i2c-highlander.c
index abfe3094c047..803dad70e2a7 100644
--- a/drivers/i2c/busses/i2c-highlander.c
+++ b/drivers/i2c/busses/i2c-highlander.c
@@ -322,7 +322,7 @@ static int highlander_i2c_smbus_xfer(struct i2c_adapter *adap, u16 addr,
 		tmp |= (SMMR_MODE0 | SMMR_MODE1);
 		break;
 	default:
-		dev_err(dev->dev, "unsupported xfer size %d\n", dev->buf_len);
+		dev_err(dev->dev, "unsupported xfer size %zu\n", dev->buf_len);
 		return -EINVAL;
 	}
 
-- 
2.17.1

