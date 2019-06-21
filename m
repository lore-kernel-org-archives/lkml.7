Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F6EC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6B2208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjRYDV0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfFULP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:15:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39792 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfFULP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:15:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id j2so3442214pfe.6;
        Fri, 21 Jun 2019 04:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6Dz4Z+dmuRUi0NOnymZGvWj/MoeH9WQhV7Y+qJ24/00=;
        b=SjRYDV0MkGpoVQrf6DKrSzISHxIt8y/kiuPlX5j3sK09B6aAzHi5CxPUXhs3+l4edL
         BXNIVe4XRBry5jx6zib7eLlg495Ku11/2Hskk6W0FNs+JksUHNUK782wGrQ/3urknmHC
         wMh0GL+DxFVt0sHutVHNzW2V6lh8jlsyy43fKe5AyJZWk4y8Y9yTwGofLgX2vFVMVPft
         TCBCdfDB6Bk8vUj/wDkAdzUj7R9o4pSVAvPu/io/VJfSskVoM78a+4dDBDTgTIQ7cRTg
         DCbnw/3wcDwcgI6cvTsXs5JKQaYOnPI9wEWrC9pO9roSEnnPHpqfy9F+f+XVVNamCae+
         wT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6Dz4Z+dmuRUi0NOnymZGvWj/MoeH9WQhV7Y+qJ24/00=;
        b=i1ThiM0ubki/IwY9D6v/U69EqJ2Xy3ERJ94hShG7vF2ScQx0GeExzl27WkWkSkxZYB
         OT3F4F8/k988GumEr2lgJ8l5AGvBBtvMQ8YyuHWQZtgJYfM+AdV6KrwucMYRVIwWpx9E
         1STqbvXpkwDC8jFKPRgYNfQcSoJo1DKBTh/RBqhpdeUf+5WoGhSu8yxGC6PkBKhRY3IQ
         i0Rmd4iXK81eDUwUBtIkC7l1p8VBV/BpqBZGa9iM9+LTu9xEAwtA94OI8i4TQ5mcjf1X
         vIn8fCf/iRy0WTcfndcpj8NeQySlkM07fJJnI4w/sUmP4Gl5viKfJdyo/NEodOunrAjL
         tW8g==
X-Gm-Message-State: APjAAAV3X06MAulBthhoz8fk+aOQGz2SVhXg6twubC6nuAmXxGaVZVBd
        +CuCNeI0AcMWQCVXcwaCHgk=
X-Google-Smtp-Source: APXvYqxb6mOFj/WG4GMZNsDDWZmPushL+3w5hnh8g2Y4/W0ZvCeDMNUmpcLN/zUJCAeyvoIW3mmUFQ==
X-Received: by 2002:a65:4383:: with SMTP id m3mr17452043pgp.435.1561115755503;
        Fri, 21 Jun 2019 04:15:55 -0700 (PDT)
Received: from Pilot130.192.168.0.22 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.googlemail.com with ESMTPSA id w4sm2405737pfw.97.2019.06.21.04.15.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Jun 2019 04:15:54 -0700 (PDT)
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, joel@jms.id.au,
        andrew@aj.id.au, benh@kernel.crashing.org, robh+dt@kernel.org,
        mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        shivahshankar@gmail.com, sudheer.veliseti@aspeedtech.com
Cc:     sudheer veliseti <sudheer.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [patch 0/5] *** DMA based UART driver for AST2500 ***
Date:   Fri, 21 Jun 2019 16:47:30 +0530
Message-Id: <1561115855-4186-1-git-send-email-open.sudheer@gmail.com>
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


