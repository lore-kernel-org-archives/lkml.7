Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2482BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 02:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A7E20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 02:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6ZVsVKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391572AbfIWCY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 22:24:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37468 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389942AbfIWCYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 22:24:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id y5so8184910pfo.4;
        Sun, 22 Sep 2019 19:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jl6nStrj8n1KdRcUctb22FcHDz6z46Ab7ioA1mr+peM=;
        b=J6ZVsVKjKAbYuB7+uWgC6QXykq5twUFH/96mbBz2Ovd8H9w+TKnUMRsh2s5IgUGkwX
         EWPCtkvs9wipVFIsLyztIFilOBtVVC4DYIzPzpEbnYiff+1fHVnv3VABUSPcgg2JWndM
         Gf3d5923BCtoj2BBf8pjyg4BaTZkrXgV4YTbNsdegxaMq4kOBOJniwlUfP1LzCoVyMJU
         JDpKkTKvOO7Dh+zEAR90aF77p/77H+n9lYbWS5T7SCTmNyySk4+0tK0PyGjkAbJh8MdF
         ZSDHzghDqDJVgD0KFFBZX6pPWGoSfqioUUfGKDvzAgC2YJKG/xZPtogl/Gq6kJfZW/lk
         tlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jl6nStrj8n1KdRcUctb22FcHDz6z46Ab7ioA1mr+peM=;
        b=dMj+VDeruRb1BJSxbF+qoTrwxe1gs3QUhdbkGbrjy59xTjZzS1WVgkOYqSzYY7YxxO
         DJoQEOVy5/6Oyb99IedXQCV+hGDarcq78AKVzbH5c9H7RelmO4TJmMaK81C1yJHH05gH
         dgKsNJcn3T75OLnkDcwmJYDRYgaoJMfcisBAzYIVkxDhy6jzajeS3QvbFCQr+HF/ef3n
         Cns5ZFoKXWR1E54DrWLkdsaFyLIrNj6EG4NyOtaDYN/yAiHxCsS0SMz43DG+gHlsvpJF
         3JXh5c6AMResVz7c1eiSGr6OME1ix57iW5GTRFMq9pAHn3ia1KikaamrAjur4lyw0aTo
         Ayew==
X-Gm-Message-State: APjAAAVUCXotZWTWODhXACFfC/yGL4UnOctwEkpfZbOI9TsLlpZdZAcl
        8qeKdMGGJQGPrQlY+WVi7MOTmJCJ
X-Google-Smtp-Source: APXvYqxaHBRrQtOH8qvqEa4S0igLP5Ed+A34G12nHMCnZ8ZKxEiwAdp33qBGsDin1ezJ9/ZoxJKoGg==
X-Received: by 2002:a17:90a:fb85:: with SMTP id cp5mr18596193pjb.42.1569205494746;
        Sun, 22 Sep 2019 19:24:54 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id h70sm10204523pgc.48.2019.09.22.19.24.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Sep 2019 19:24:54 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V2 0/7] Add Fintek F81534A series usb-to-serial driver
Date:   Mon, 23 Sep 2019 10:24:42 +0800
Message-Id: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Fintek F81532A/534A/535/536 is USB-to-2/4/8/12 serial ports device
and the serial port is default disabled when plugin computer.

The part number is a bit same with F81532/534, but F81534A series UART
core is enhanced from F81232, not F81532/534.  

The IC is contains devices as following:
	1. HUB (all devices is connected with this hub)
	2. GPIO/Control device. (enable serial port and control all GPIOs)
	3. serial port 1 to x (2/4/8/12)

It's most same with F81232, the UART device is difference as follow:
	1. TX/RX bulk size is 128/512bytes
	2. RX bulk layout change:
		F81232: [LSR(1Byte)+DATA(1Byte)][LSR(1Byte)+DATA(1Byte)]...
		F81534A:[LEN][Data.....][LSR]

We'll try to do some code refacting before add F81534A series.

Ji-Ze Hong (Peter Hong) (7):
  USB: serial: f81232: Extract LSR handler
  USB: serial: f81232: Add tx_empty function
  USB: serial: f81232: Use devm_kzalloc
  USB: serial: f81232: Add F81534A support
  USB: serial: f81232: Set F81534A serial port with RS232 mode
  USB: serial: f81232: Add generator for F81534A
  USB: serial: f81232: Add gpiolib to GPIO device

 drivers/usb/serial/f81232.c | 604 ++++++++++++++++++++++++++++++++++--
 1 file changed, 570 insertions(+), 34 deletions(-)

-- 
2.17.1

