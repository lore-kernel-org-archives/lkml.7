Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C4FC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B11218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWQmXxqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbfDWVmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:42:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37828 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfDWVmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 17:42:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id v13so2307377ljk.4;
        Tue, 23 Apr 2019 14:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=txB+of63SNu46wpVXF+9lUHfUB1Dh2QUimcwaZfAJys=;
        b=uWQmXxqTfrdKvfTL5mYC0M+f1vG1vLoHE1rqPmLHLMxKtestQFEuwztfGqWgWETxZ1
         08AWXNdViaZ0GNdi/789AHSSY/Ov9eG27guBxlbH7HeMAFAS2SWBpAIN0uLCjFV3t1gS
         HO6N6/tf5ybvbQymEa6fomTWARAPeXjen3n2LzndNSZDCGKRM0Rw8WcQZrHK4DOpn25s
         3HkSII1YTL1rwmghHrGthlebTbFVzb6/XbyZUqVbgNd5iDooraAELph4sr6j/T854/ze
         NMTZptC+Gme6lErfWG4odYvBuM3AkDQ69+ofMm2lbk05GJqmZ6vRibb1z7nVNYQJmyPc
         knew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=txB+of63SNu46wpVXF+9lUHfUB1Dh2QUimcwaZfAJys=;
        b=gwzFMgZGmksFWhS8UryZutS2SKzcBloS14fpQ6rSRyilYZ0wlwPeiLSGj3QAt8Biso
         w/30SVLX82XkvvFdd+niu7axZF9j8mM++cKC/atuvtiyaa0y1JfZTk/7itBTaqAp5TqZ
         5TULyQkVF48vbV/TW0AoHyUK9T4awB7OuBkzX+T5PDtbEttpMhte/xlRu5YLfePxXniI
         TD4fm48EEZ0v9Ym025PCcsuLkFgg5R9LeBBM2gPr9CJogjvMyLoFbUOX2w6iCI9LBPEb
         6fAir5KaVC0Bgar91WqWbjsI//2KX1oCvL1OIZvJSHp5xKLDXodbVaZPIdrI9lNwh87k
         3CcQ==
X-Gm-Message-State: APjAAAVsjqXKwJbkLeMIRBoGWDObKyyldRWB5YgKtlguWXZfy3nsU6fD
        fbLFmx5Rodd6qu1bALWUt6U=
X-Google-Smtp-Source: APXvYqxyEZwVSpME3EeyESHC7YVQ/r3xJLJLboB3IXxqj+ga2RhtFCYBR70oydXPV1ymtvHxCXhhnQ==
X-Received: by 2002:a05:651c:c3:: with SMTP id 3mr15253081ljr.8.1556055729106;
        Tue, 23 Apr 2019 14:42:09 -0700 (PDT)
Received: from localhost.localdomain (80-167-223-88-cable.dk.customer.tdc.net. [80.167.223.88])
        by smtp.gmail.com with ESMTPSA id z206sm3991128lfa.53.2019.04.23.14.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 14:42:08 -0700 (PDT)
From:   Daniel Gomez <dagmcr@gmail.com>
To:     Stefan Popa <stefan.popa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:ANALOG DEVICES INC AD5758 DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     dagmcr@gmail.com, javier@dowhile0.org,
        linux-iio@vger.kernel.org (open list:ANALOG DEVICES INC AD5758 DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] iio: dac: ad5758: declare missing of table
Date:   Tue, 23 Apr 2019 23:41:58 +0200
Message-Id: <1556055718-14782-1-git-send-email-dagmcr@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing <of_device_id> table for SPI driver relying on SPI
device match since compatible is in a DT binding or in a DTS.

Before this patch:
modinfo drivers/iio/dac/ad5758.ko | grep alias
alias:          spi:ad5758

After this patch:
modinfo drivers/iio/dac/ad5758.ko | grep alias
alias:          spi:ad5758
alias:          of:N*T*Cadi,ad5758C*
alias:          of:N*T*Cadi,ad5758

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
---
 drivers/iio/dac/ad5758.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
index 2bdf1b0..e8eaa48 100644
--- a/drivers/iio/dac/ad5758.c
+++ b/drivers/iio/dac/ad5758.c
@@ -11,6 +11,8 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/property.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/spi/spi.h>
 #include <linux/gpio/consumer.h>
 
@@ -904,9 +906,16 @@ static const struct spi_device_id ad5758_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, ad5758_id);
 
+static const struct of_device_id ad5758_of_match[] = {
+        { .compatible = "adi,ad5758" },
+        { },
+};
+MODULE_DEVICE_TABLE(of, ad5758_of_match);
+
 static struct spi_driver ad5758_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
+		.of_match_table = ad5758_of_match,
 	},
 	.probe = ad5758_probe,
 	.id_table = ad5758_id,
-- 
2.7.4

