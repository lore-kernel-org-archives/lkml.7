Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7075C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7903D22C7E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOU3G58i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfGZNZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:25:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42275 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfGZNZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:25:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id t132so24788004pgb.9;
        Fri, 26 Jul 2019 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ouOMj6cpN1ep3ajODfqH/x6C/iWcdYxWbD9mvS45xHg=;
        b=jOU3G58iAy4awdh8qWndAXBO2fOOApa5MMp6QlU+ldAXdH4LL2P+HvGVeh3GHywN12
         zMONN3mo8xUwLuP1Zlxhh2HI8eza6Volc1KIK+eFJIKPtMbE8surYZAPx8r8xkbWfY3m
         39z4iXzwzyHP0nzfLQwSZZtZiMuLoS3K9CfemqBaNroo/M4U6B32eMZaDp9L3s0TUcZ1
         vDz7k0LZAn8U8G15ayoGp5ObNQgH2zSG/REXT0qvF/exAuzmORZf9f8wYS/OwiCw998d
         jxyiciXSgbFPwggylGS2TJQkFXgd2tMLlSdMxZl+U1hhuRNlQ/7CYE+nN8Yy4r0Bzu0b
         uDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ouOMj6cpN1ep3ajODfqH/x6C/iWcdYxWbD9mvS45xHg=;
        b=guiwlBDQVS10MvtgP6b9lGxYVJKsLZh0XFSjPVekX8efuvLbgMC0tbrAX4S25Htfki
         0pa/9jpWaMNAGWx3jHVC+GvDCcQfjA1YunQZKy/xoobWlCokwUvR/Q+/EeSan0s3YkpS
         B34jdwjjh66RU6n5DIqOA+E1nY80xD9AEeH6+e+4+E/dtL/SdsxGfH1Znb9BQiu+MCDA
         DJY0dPx+2T/oVphiXnnWLAQPkxshWTaENe5PSpiVi1dGC3WCtzAmtNPFsug7O+nZXsVU
         LVwi5cX9ToFg3EUYjEuHcCuCQX2sV8LFVeWtBMePCZZZeXW8zCB61xPg5Dvp+DF20rF0
         49aQ==
X-Gm-Message-State: APjAAAWUz2KBFDt9XqOj9XV7X0USvYAzmJfYadrXhwsduRqdm3Wu8bDV
        EWjUm5+Jvj1vaLVB24FckEY=
X-Google-Smtp-Source: APXvYqzpni+ucvhEzBbxxIJYKppf0r5REEqwhVm66NXtYWNRygBcWFNpTWkvy9T6iLcmDoXZq8DoWA==
X-Received: by 2002:a63:ee04:: with SMTP id e4mr66521651pgi.53.1564147520023;
        Fri, 26 Jul 2019 06:25:20 -0700 (PDT)
Received: from Pilot130.192.168.0.22 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.googlemail.com with ESMTPSA id k36sm54544603pgl.42.2019.07.26.06.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 06:25:18 -0700 (PDT)
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, joel@jms.id.au,
        andrew@aj.id.au, benh@kernel.crashing.org, robh+dt@kernel.org,
        mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        sudheer.veliseti@aspeedtech.com
Cc:     sudheer veliseti <sudheer.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [patch v4 0/5] *** AST2500 DMA UART driver ***
Date:   Fri, 26 Jul 2019 18:57:15 +0530
Message-Id: <1564147640-30753-1-git-send-email-open.sudheer@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sudheer veliseti <sudheer.open@gmail.com>

Hi,

In this patchset v4,all the comments provided for patchset v3
are addressed.Also there is considerable
change in the code related to how the per port
uart structure is registerd with uart core.
so the patch [patch v4 1/5] considerably differs from [patch v3 1/5]

Thanks and Regards
Sudheer.V

changes in v4:
- since TX uart interrupt is being invoked by 8250 framework
  instead of expected TX DMA interrupt,registration of uart port is changed.
  per port uart structure registration is done directly now
  instead of going throgh 8250 framework.
  so there is considerable change in code against v3 patch
changes in v3:
- custom debugs replaced with pr_debug in 8250_ast2500_uart_dma.c
- change logs added in patches

sudheer veliseti (5):
  AST2500 DMA UART driver
  build configuration for AST2500 DMA UART driver
  DT nodes for AST2500 DMA UART driver
  defconfig and MAINTAINERS updated for AST2500 DMA UART driver
  Documentation: DT bindings AST2500 DMA UART driver

 .../bindings/serial/ast2500-dma-uart.txt      |   43 +
 MAINTAINERS                                   |   12 +
 arch/arm/boot/dts/aspeed-ast2500-evb.dts      |   21 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |   71 +-
 arch/arm/configs/aspeed_g5_defconfig          |    1 +
 .../tty/serial/8250/8250_ast2500_uart_dma.c   | 1901 +++++++++++++++++
 drivers/tty/serial/8250/Kconfig               |   45 +-
 drivers/tty/serial/8250/Makefile              |    1 +
 8 files changed, 2090 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/ast2500-dma-uart.txt
 create mode 100644 drivers/tty/serial/8250/8250_ast2500_uart_dma.c

-- 
2.17.1

