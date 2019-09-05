Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFF4C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6E522CEC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388503AbfIELcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 07:32:09 -0400
Received: from dd10532.kasserver.com ([85.13.133.80]:50680 "EHLO
        dd10532.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbfIELcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:32:09 -0400
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Sep 2019 07:32:07 EDT
Received: from odsus.home.arpa (p57B0B64C.dip0.t-ipconnect.de [87.176.182.76])
        by dd10532.kasserver.com (Postfix) with ESMTPSA id B21111F430B7;
        Thu,  5 Sep 2019 13:22:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by odsus.home.arpa (Postfix) with ESMTP id E9E943C97F;
        Thu,  5 Sep 2019 13:22:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at home.arpa
Received: from odsus.home.arpa ([127.0.0.1])
        by localhost (odsus.home.arpa [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PbkwYIGYv5fO; Thu,  5 Sep 2019 13:22:35 +0200 (CEST)
Received: from [192.168.201.4] (unknown [192.168.201.4])
        by odsus.home.arpa (Postfix) with ESMTP id A18A43C5BF;
        Thu,  5 Sep 2019 13:22:35 +0200 (CEST)
To:     linux-amlogic@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@vger.kernel.org
From:   Otto Meier <gf435@gmx.net>
Subject: [BUG] wrong pinning definition or uart_c in pinctrl-meson-gxbb.c
Message-ID: <b5370b4b-3347-1b95-aba2-1841f786b5a8@gmx.net>
Date:   Thu, 5 Sep 2019 13:22:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------C12424836F50E32A0F35C7C7"
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C12424836F50E32A0F35C7C7
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi i tried to use uart_C of the the odroid-c2.

I enabled it int the dts file. During boot it crashed when the
the sdcard slot is addressd.

After long search in the net i found this:

https://forum.odroid.com/viewtopic.php?f=139&t=25371&p=194370&hilit=uart_C#p177856


After changing the pin definitios accordingly erverything works.

Uart_c is functioning and sdcard ist working.

Patch attached

Bye Otto




--------------C12424836F50E32A0F35C7C7
Content-Type: text/x-patch;
 name="uart_c_pins.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="uart_c_pins.diff"

Hi i tried to use uart_C of the the odroid-c2.

I enabled it int the dts file. During boot it crashed when the
the sdcard slot is addressd.

After long search in the net i found this:

https://forum.odroid.com/viewtopic.php?f=139&t=25371&p=194370&hilit=uart_C#p177856


After changing the pin definitios accordingly erverything works.

Uart_c is functioning and sdcard ist working.



--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c        2019-08-26 18:24:45.450089334 +0200
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c        2019-09-05 13:07:38.518637214 +0200
@@ -192,8 +192,8 @@ static const unsigned int uart_rts_b_pin
 
 static const unsigned int uart_tx_c_pins[]     = { GPIOY_13 };
 static const unsigned int uart_rx_c_pins[]     = { GPIOY_14 };
-static const unsigned int uart_cts_c_pins[]    = { GPIOX_11 };
-static const unsigned int uart_rts_c_pins[]    = { GPIOX_12 };
+static const unsigned int uart_cts_c_pins[]    = { GPIOY_11 };
+static const unsigned int uart_rts_c_pins[]    = { GPIOY_12 };
 
 static const unsigned int i2c_sck_a_pins[]     = { GPIODV_25 };
 static const unsigned int i2c_sda_a_pins[]     = { GPIODV_24 };
@@ -439,10 +439,10 @@ static struct meson_pmx_group meson_gxbb
        GROUP(pwm_f_x,          3,      18),
 
        /* Bank Y */
-       GROUP(uart_cts_c,       1,      19),
-       GROUP(uart_rts_c,       1,      18),
-       GROUP(uart_tx_c,        1,      17),
-       GROUP(uart_rx_c,        1,      16),
+       GROUP(uart_cts_c,       1,      17),
+       GROUP(uart_rts_c,       1,      16),
+       GROUP(uart_tx_c,        1,      19),
+       GROUP(uart_rx_c,        1,      18),
        GROUP(pwm_a_y,          1,      21),
        GROUP(pwm_f_y,          1,      20),
        GROUP(i2s_out_ch23_y,   1,      5),

signed off Otto Meier gf435@gmx.net

--------------C12424836F50E32A0F35C7C7--
