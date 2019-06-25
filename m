Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC72C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C8F21743
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0R/j+8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbfFYKmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:42:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45084 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfFYKmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:42:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id z19so5815406pgl.12;
        Tue, 25 Jun 2019 03:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1uMFvdA9zD0TW36wu1ROblZoYCBPkNlkO2ia2DlAOOo=;
        b=f0R/j+8cwVS5csLWk6p5Ykg9xNZW0+umrEPAJ3HxBV4gG9Bw2yhyhB9sn49qE5Zrv+
         AGFN3ejYP8YtKwR7g8vgMWS3lRP/dY6SmujIakxV4B/gwq2fepV15w/4waWXzPY1qZfJ
         Vk51rxlvmoCKoFn6zALdPIwIj24YqqeCKjywnR6ottpAP7NU1ndYJ4+kHvZkZTf1iL9+
         /ElGY1TjxP0hHokScFuCqeW4Gvl+8Xxp2d/iwMKwIKu5VY0uaSoLu3ctv8IgDqoHP887
         unK7l0vZ0ltcYjo+Rg86TIpmX6Wgn5rAYY2vujaTRmhqba2E5tRU01mGmHyNL31LZxxt
         /DBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1uMFvdA9zD0TW36wu1ROblZoYCBPkNlkO2ia2DlAOOo=;
        b=ThvHToR614SQdLTIVzuDENyr7potFUGv5ryZbtf1/5w3ZmIoMDbof4HS3Z+SJTR8H6
         9TbX9Nrr5pIkAQN6hMZMeNm+LyaQ8s49rzrprAy53Dh9xA3JbyskxKmrjQgFCskJ70uF
         q/rVtbrCqqZg9pArznLSUx/VLZhHw8mZ2eE/xXhBWcnrpqol7JqaU04HmwA3SL+Mt76J
         cYvFFjZAGwO7m6dABCSwfRWFyp4rL6Ui3XAIbn3HeINqWp3NMwQb5u8Z+bAvVC1ul7eE
         fPH0XrixFqhbbWtdyf9hw/O/ltTsgG+TqSKcLU6AdF+om7QranpoL3i829s/qRB+WPs+
         VQ1w==
X-Gm-Message-State: APjAAAUaRQtf8Xln+7MzVamCB04PTYxLkWF35lSl7+A3EQlPFb/Xn52k
        WZIXH3o2k8+leHK9MzDgHzU=
X-Google-Smtp-Source: APXvYqz07ytF5AwY9QhulPVIkFTT7bio8bpxCxvXzud/mQQUQXGy0FbUpYnn5JsBdLZntdfuj+fjHg==
X-Received: by 2002:a63:f342:: with SMTP id t2mr35787408pgj.83.1561459362300;
        Tue, 25 Jun 2019 03:42:42 -0700 (PDT)
Received: from Pilot130.192.168.0.22 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.googlemail.com with ESMTPSA id 14sm22026759pfj.36.2019.06.25.03.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jun 2019 03:42:41 -0700 (PDT)
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, joel@jms.id.au,
        andrew@aj.id.au, benh@kernel.crashing.org, robh+dt@kernel.org,
        mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        shivahshankar@gmail.com, sudheer.veliseti@aspeedtech.com
Cc:     sudheer veliseti <sudheer.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [patch v3 0/5] *** DMA based UART driver for AST2500 ***
Date:   Tue, 25 Jun 2019 16:14:31 +0530
Message-Id: <1561459476-14268-1-git-send-email-open.sudheer@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sudheer veliseti <sudheer.open@gmail.com>

Hi,
AST2500 has dedicated Uart DMA controller which has 12 sets of
Tx and RX channels connected to UART controller directly.
Since the DMA controller have dedicated buffers and registers,
there would be little benifit in adding DMA framework overhead.
So the software for DMA controller is included within the UART driver itself.

Thanks and Regards
Sudheer.V

changes in v3:
- custom debugs replaced with pr_debug in 8250_ast2500_uart_dma.c
- change logs added in patches

sudheer veliseti (5):
  AST2500 DMA UART driver
  build configuration for AST2500 DMA UART driver
  DT nodes for AST2500 DMA UART driver
  defconfig and MAINTAINERS updated for AST2500 DMA UART driver
  Documentation: DT bindings AST2500 DMA UART driver

 .../bindings/serial/ast2500-dma-uart.txt      |   40 +
 MAINTAINERS                                   |   13 +
 arch/arm/boot/dts/aspeed-ast2500-evb.dts      |   21 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |   71 +-
 arch/arm/configs/aspeed_g5_defconfig          |    1 +
 .../tty/serial/8250/8250_ast2500_uart_dma.c   | 1879 +++++++++++++++++
 drivers/tty/serial/8250/Kconfig               |   35 +-
 drivers/tty/serial/8250/Makefile              |    1 +
 8 files changed, 2056 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/ast2500-dma-uart.txt
 create mode 100644 drivers/tty/serial/8250/8250_ast2500_uart_dma.c

-- 
2.17.1


