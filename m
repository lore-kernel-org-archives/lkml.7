Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0732AC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1868205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564154860;
	bh=UyfIQBivq2x50CDqDZcg91an+jfzeSUAaFuFUk2Ijeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FABum4USw7S/XPEaUPNewN3A40MSKBqWSmISRwCKomRlgYXtfeAX0jjs7cdfi9KE+
	 mj5HGj3NaL4FdnDKN5jhICdPK1tQM+9mjUTxXEZchEBgNgUP0X19u6Ncs3yscvfQUb
	 AtlvT1ALNpMtLjaNX8Hk8OstkevBOeuT4KwqQezQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388263AbfGZP1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728534AbfGZP1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:27:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6092205F4;
        Fri, 26 Jul 2019 15:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564154854;
        bh=UyfIQBivq2x50CDqDZcg91an+jfzeSUAaFuFUk2Ijeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tspuasupDiluzgJcxlHLa6wQ3WtETQ5qXbJpjMDSvN099u1ocsnUk/S2faNx8vZxn
         1pJxHOVBiOJuBfQQgJZ2cQ5BYPYk+L5sS5DMVgPZ6sEAYBOCbj+9U4lnUsT+ro4xc/
         FsVQk/w8blPT98hgbUg112Q4lAxwLOP2DatBvSpQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-spi@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5.2 49/66] Revert "gpio/spi: Fix spi-gpio regression on active high CS"
Date:   Fri, 26 Jul 2019 17:24:48 +0200
Message-Id: <20190726152307.248624174@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152301.936055394@linuxfoundation.org>
References: <20190726152301.936055394@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

commit da7f134972f473053ea9d721a1d8397546476dc4 upstream.

This reverts commit fbbf145a0e0a0177e089c52275fbfa55763e7d1d.

It seems I was misguided in my fixup, which was working at the
time but did not work on the final v5.2.

The patch tried to avoid a quirk the gpiolib code not to treat
"spi-gpio" CS gpios "special" by enforcing them to be active
low, in the belief that since the "spi-gpio" driver was
parsing the device tree on its own, it did not care to inspect
the "spi-cs-high" attribute on the device nodes.

That's wrong. The SPI core was inspecting them inside the
of_spi_parse_dt() funtion and setting SPI_CS_HIGH on the
nodes, and the driver inspected this flag when driving the
line.

As of now, the core handles the GPIO and it will consistently
set the GPIO descriptor to 1 to enable CS, strictly requireing
the gpiolib to invert it. And the gpiolib should indeed
enforce active low on the CS line.

Device trees should of course put the right flag on the GPIO
handles, but it used to not matter. If we don't enforce active
low on "gpio-gpio" we may run into ABI backward compatibility
issues, so revert this.

Cc: linux-spi@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20190715204529.9539-1-linus.walleij@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpiolib-of.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -118,15 +118,8 @@ static void of_gpio_flags_quirks(struct
 	 * Legacy handling of SPI active high chip select. If we have a
 	 * property named "cs-gpios" we need to inspect the child node
 	 * to determine if the flags should have inverted semantics.
-	 *
-	 * This does not apply to an SPI device named "spi-gpio", because
-	 * these have traditionally obtained their own GPIOs by parsing
-	 * the device tree directly and did not respect any "spi-cs-high"
-	 * property on the SPI bus children.
 	 */
-	if (IS_ENABLED(CONFIG_SPI_MASTER) &&
-	    !strcmp(propname, "cs-gpios") &&
-	    !of_device_is_compatible(np, "spi-gpio") &&
+	if (IS_ENABLED(CONFIG_SPI_MASTER) && !strcmp(propname, "cs-gpios") &&
 	    of_property_read_bool(np, "cs-gpios")) {
 		struct device_node *child;
 		u32 cs;


