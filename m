Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160DDC48BD7
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 01:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34782086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 01:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xsAnA6we"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfFZBKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 21:10:49 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37158 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfFZBKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 21:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UtW5OvMCSjQYk0vQjDM8NYHUQEBuLOBRls0IoB2nKTs=; b=xsAnA6weNkKTfYGnYr65dpdaI0
        IowfByeZt/ku9RrguyPceaIexJ4vtqnZGbqKx1+1cpwAVxkNt46HoYucOCKRWgu/GlykISrhxQr0r
        s7FS3+vjwjB2DRbaBR0v/oTzKUOAL/mKXzjjs4YwQ4EvTcOlj8GuJsPwCz9h1we9G/8ppsxr0/vUx
        62PSjolrNJIr/rrwJJyeJabZKFu1wXyrdmk/+HLc5DDsejRhK4LieK3WDT2JFKEkZQ80SWIMsG68G
        0VVpU01ii5XAnZe2K7MqB4WQtSHOKs1ya8IILXlK0MkMku2eWM5EPG/NJX/lzxD/N9ZSHajbYh0EZ
        oZCp2GFA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfwSQ-0002pd-J8; Wed, 26 Jun 2019 01:10:43 +0000
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] extcon: fix fsa9480 Kconfig warning and build errors
Message-ID: <1075ea60-6657-ce8d-b527-639b4fc896ec@infradead.org>
Date:   Tue, 25 Jun 2019 18:10:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix Kconfig dependency warning and subsequent build errors caused by
the Kconfig entry for EXTCON-FSA9480.  It should not select
REGMAP_I2C unless I2C is already set/enabled.

WARNING: unmet direct dependencies detected for REGMAP_I2C
  Depends on [n]: I2C [=n]
  Selected by [y]:
  - EXTCON_FSA9480 [=y] && EXTCON [=y] && INPUT [=y]

../drivers/base/regmap/regmap-i2c.c: In function ‘regmap_smbus_byte_reg_read’:
../drivers/base/regmap/regmap-i2c.c:25:2: error: implicit declaration of function ‘i2c_smbus_read_byte_data’ [-Werror=implicit-function-declaration]
  ret = i2c_smbus_read_byte_data(i2c, reg);
  ^
../drivers/base/regmap/regmap-i2c.c: In function ‘regmap_smbus_byte_reg_write’:
../drivers/base/regmap/regmap-i2c.c:43:2: error: implicit declaration of function ‘i2c_smbus_write_byte_data’ [-Werror=implicit-function-declaration]
  return i2c_smbus_write_byte_data(i2c, reg, val);
../drivers/base/regmap/regmap-i2c.c: In function ‘regmap_smbus_word_reg_read’:
../drivers/base/regmap/regmap-i2c.c:61:2: error: implicit declaration of function ‘i2c_smbus_read_word_data’ [-Werror=implicit-function-declaration]
  ret = i2c_smbus_read_word_data(i2c, reg);
../drivers/base/regmap/regmap-i2c.c: In function ‘regmap_smbus_word_reg_write’:
../drivers/base/regmap/regmap-i2c.c:79:2: error: implicit declaration of function ‘i2c_smbus_write_word_data’ [-Werror=implicit-function-declaration]
  return i2c_smbus_write_word_data(i2c, reg, val);
../drivers/base/regmap/regmap-i2c.c: In function ‘regmap_smbus_word_read_swapped’:
../drivers/base/regmap/regmap-i2c.c:97:2: error: implicit declaration of function ‘i2c_smbus_read_word_swapped’ [-Werror=implicit-function-declaration]
  ret = i2c_smbus_read_word_swapped(i2c, reg);
../drivers/base/regmap/regmap-i2c.c: In function ‘regmap_smbus_word_write_swapped’:
../drivers/base/regmap/regmap-i2c.c:115:2: error: implicit declaration of function ‘i2c_smbus_write_word_swapped’ [-Werror=implicit-function-declaration]
  return i2c_smbus_write_word_swapped(i2c, reg, val);
../drivers/base/regmap/regmap-i2c.c: In function ‘regmap_i2c_write’:
../drivers/base/regmap/regmap-i2c.c:129:2: error: implicit declaration of function ‘i2c_master_send’ [-Werror=implicit-function-declaration]
  ret = i2c_master_send(i2c, data, count);
../drivers/base/regmap/regmap-i2c.c: In function ‘regmap_i2c_gather_write’:
../drivers/base/regmap/regmap-i2c.c:150:2: error: implicit declaration of function ‘i2c_check_functionality’ [-Werror=implicit-function-declaration]
  if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_NOSTART))
../drivers/base/regmap/regmap-i2c.c:163:2: error: implicit declaration of function ‘i2c_transfer’ [-Werror=implicit-function-declaration]
  ret = i2c_transfer(i2c->adapter, xfer, 2);
../drivers/base/regmap/regmap-i2c.c: In function ‘regmap_i2c_smbus_i2c_write’:
../drivers/base/regmap/regmap-i2c.c:218:2: error: implicit declaration of function ‘i2c_smbus_write_i2c_block_data’ [-Werror=implicit-function-declaration]
  return i2c_smbus_write_i2c_block_data(i2c, ((u8 *)data)[0], count,
../drivers/base/regmap/regmap-i2c.c: In function ‘regmap_i2c_smbus_i2c_read’:
../drivers/base/regmap/regmap-i2c.c:233:2: error: implicit declaration of function ‘i2c_smbus_read_i2c_block_data’ [-Werror=implicit-function-declaration]
  ret = i2c_smbus_read_i2c_block_data(i2c, ((u8 *)reg)[0], val_size, val);

../drivers/extcon/extcon-fsa9480.c: In function ‘fsa9480_module_init’:
../drivers/extcon/extcon-fsa9480.c:383:2: error: implicit declaration of function ‘i2c_add_driver’ [-Werror=implicit-function-declaration]
  return i2c_add_driver(&fsa9480_i2c_driver);
../drivers/extcon/extcon-fsa9480.c: In function ‘fsa9480_module_exit’:
../drivers/extcon/extcon-fsa9480.c:389:2: error: implicit declaration of function ‘i2c_del_driver’ [-Werror=implicit-function-declaration]
  i2c_del_driver(&fsa9480_i2c_driver);

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
---
Found in mmotm; applies to linux-next.

To extcon maintainers:  there are a few more extcon driver Kconfig
entries that seem to have this same problem of selecting REGMAP_I2C
without checking that I2C is set/enabled.

 drivers/extcon/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- mmotm-2019-0625-1620.orig/drivers/extcon/Kconfig
+++ mmotm-2019-0625-1620/drivers/extcon/Kconfig
@@ -39,7 +39,7 @@ config EXTCON_AXP288
 
 config EXTCON_FSA9480
 	tristate "FSA9480 EXTCON Support"
-	depends on INPUT
+	depends on INPUT && I2C
 	select IRQ_DOMAIN
 	select REGMAP_I2C
 	help


