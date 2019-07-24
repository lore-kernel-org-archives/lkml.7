Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB70C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2D021855
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998648;
	bh=5OxlVqyYuGqfPXvIWXg+iqCGtpLyfaMGVWk9GkLI9hM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YtyKiggTfIb8oVma9TYsdmsCq1Q2zo9+w3ffbDTTht9xPnAfdguuR7LsroTVp6nwc
	 NeyFJalkQB5e4nCKOIIp/Yx01aGzpRRLvHUZNWQ3u7htOj/LR6afOm+iTfCdTcPnFi
	 UA93SbF/oviDZMoQefn21gsbAMjLgpR5mXoh2uQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392450AbfGXUEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:04:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392425AbfGXUD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:03:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBC0C206BA;
        Wed, 24 Jul 2019 20:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998638;
        bh=5OxlVqyYuGqfPXvIWXg+iqCGtpLyfaMGVWk9GkLI9hM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C+jvlLVT7sZfAzzJPkfJN+6RO+o5DnbJ7pKGmdpugmJh0NRHBISo2j9o0eYYO9uPd
         6YUgJ/hakoSRbzSnpFY4DdE3AsVpg1Nz8Aag0/lReAkGyZDFsyitCIIVbhiDOWqA0j
         7Vm2Rb3bLWr0oIUAMAakHywdkve7vQCDicsr3kX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 063/271] regmap: fix bulk writes on paged registers
Date:   Wed, 24 Jul 2019 21:18:52 +0200
Message-Id: <20190724191700.594973869@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit db057679de3e9e6a03c1bcd5aee09b0d25fd9f5b ]

On buses like SlimBus and SoundWire which does not support
gather_writes yet in regmap, A bulk write on paged register
would be silently ignored after programming page.
This is because local variable 'ret' value in regmap_raw_write_impl()
gets reset to 0 once page register is written successfully and the
code below checks for 'ret' value to be -ENOTSUPP before linearising
the write buffer to send to bus->write().

Fix this by resetting the 'ret' value to -ENOTSUPP in cases where
gather_writes() is not supported or single register write is
not possible.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 0360a90ad6b6..6c9f6988bc09 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1618,6 +1618,8 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 					     map->format.reg_bytes +
 					     map->format.pad_bytes,
 					     val, val_len);
+	else
+		ret = -ENOTSUPP;
 
 	/* If that didn't work fall back on linearising by hand. */
 	if (ret == -ENOTSUPP) {
-- 
2.20.1



