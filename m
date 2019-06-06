Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E91C28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FCB2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u8eNaOVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfFFCyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 22:54:37 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35685 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfFFCyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 22:54:37 -0400
Received: by mail-pl1-f193.google.com with SMTP id p1so308286plo.2;
        Wed, 05 Jun 2019 19:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=s+7lr2H+u7i6ID4Ai1tpWyQC0UkxA3TAgm7evxTJ6qE=;
        b=u8eNaOVLDLEUVqfPAqmzfPhSExZas58X/7iAdf2ykjSHjs9eRPrQ9DcbXcHMk2a2hE
         DBKUK+RUtgBp8Zg9Qfc107vqJgK9EK12crQsvFBXUBKuEReBnwOhcdrEt1YzFoOCGmSY
         U1bSxA9mUuKjFoVu3PcA4U81eIVLDNOKhJ8sc7QLs+o7pRj2sROQbI0lMN8QX5Sbm3X+
         9E0j2SoDOnZMYb8OBHP7OORC0E8kfGFQxlJETSoULu15xanexFpx6kLfkXrkiifmqE2z
         /J9scOzw3+GwwkKIu4fo2x1p5zU/tEJ9izZjzwf4Fl56W3Frvqj+xQuVCXhcqpmAb0cu
         rG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s+7lr2H+u7i6ID4Ai1tpWyQC0UkxA3TAgm7evxTJ6qE=;
        b=nfG32VLnEwzQtM/ryele5MYkn/LWcUIiE2od1+dtoJjeo10W3s4WJtJ9p/ldH5CLKH
         H9cN0o8tSAfG2dTmMmdUDVVa62L3dpbEHbo0E7UJixiYnyU+1vqyenvbL2xadR1B0eVM
         QoPhtFb1FzbzJqKhUr/ZBKwrWJwR/2m4xp2gp+lBTRf1I3fyxoN7QqX6xFHElUU7Mcfs
         llwqkNjh44ukhF4Ko33Ce4W9RtLUy77Fa3NeRA0+y3j34XRi1t1bkZ/eeRJdnKqod7lx
         rYcqrmCP8WNml0ienFLh+3pHsQi6aDrl1ib+VGGg5einZierqvZiHNTMzisT9jRnHIkY
         P3/Q==
X-Gm-Message-State: APjAAAUNhBLGrDuLZSqHiVj0XJ13lf9jC6KNJnS6vT1gAHRIvkw6Qfzs
        0OTKqW6phpzvuqbVrCatNpI=
X-Google-Smtp-Source: APXvYqwFCB3rK+XsNvbU16d8J80QxZie3ZAPBZKaGZLjyb6jvM1MgtM3KChSPTxX0bm369kRhbxW3g==
X-Received: by 2002:a17:902:6b47:: with SMTP id g7mr12559604plt.105.1559789676770;
        Wed, 05 Jun 2019 19:54:36 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id q12sm302128pjp.17.2019.06.05.19.54.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 19:54:36 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V1 0/6] USB: serial: f81232: Add F81534A support
Date:   Thu,  6 Jun 2019 10:54:10 +0800
Message-Id: <1559789656-15847-1-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series patches will add Fintek F81532A/534A/535/536 support and
refactoring some source code.

The Fintek F81532A/534A/535/536 is USB-to-2/4/8/12 serial ports device.
It cotains a HUB, a GPIO device and 2/4/8/12 serial ports. The F81534A
series will default enable only HUB & GPIO device when plugged and disable
UARTs as default. We need control GPIO device to enable serial port with
special sequence.

The most serial port features of F81534A series is same with F81232.
That's the difference with following:
	1. More RX FIFO and cache. (128byte FIFO + max to 128bytes*4 cache)
	2. up to 3MBits baudrate.
	3. 3x GPIOs per port to control transceiver.
	4. UART devices need enabled by GPIO device register.

Ji-Ze Hong (Peter Hong) (6):
  USB: serial: f81232: Add F81534A support
  USB: serial: f81232: Force F81534A with RS232 mode
  USB: serial: f81232: Add generator for F81534A
  USB: serial: f81232: Add tx_empty function
  USB: serial: f81232: Use devm_kzalloc
  USB: serial: f81232: Add gpiolib to GPIO device

 drivers/usb/serial/f81232.c | 760 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 741 insertions(+), 19 deletions(-)

-- 
2.7.4

