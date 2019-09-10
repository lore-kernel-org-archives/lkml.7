Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBC2C4740C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 01:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD9120872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 01:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjqU11GQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392563AbfIJBqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 21:46:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38483 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfIJBqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 21:46:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id d10so8915508pgo.5;
        Mon, 09 Sep 2019 18:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zkdf5X2lRCKs9gBjpc2Indy7Hflqkj3t7UL+8Fw1O/U=;
        b=JjqU11GQxNlZ/ydHiMzp8Ds0MFlcktmhNsa7NcdjZwotsdFgsQT2fH7xJIK9kKYNiH
         fIxkgglma41jV7Qwly40LOaLjqyk9GZZfJ3ofgQQcz1ynq2syRgwgeV6k9zGtY7NELH8
         5UVdGxMpDoOC6gWZlt53VB/IqZ4yWTsVlU6YDbZSLQ3uDQ1iz0eNJLYM8fsqvlcAJPYP
         3bS2fWjQl5xyNWgj3HmZOcYKF1ygTx7IN4QykstA8Q1Hslu/DpTjo2S+acNM/uET4DHN
         yCE3RWv3mB0fGGfU499Rabdxdusrr7jWg647Sg0bPkE4AeXib4/n8rbOn+HGnyKhE6Zx
         tCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zkdf5X2lRCKs9gBjpc2Indy7Hflqkj3t7UL+8Fw1O/U=;
        b=inuZwLQjHM0SNuvKxwvK18EZc3/3h+DO0kVhpQ8E/LUiIbCOs2V6O5lU+fj4azMjiE
         6Im/1YaKPFlsDoaMr2BCCwAGwQdu0k16mr8gsuSpH5vYqXytF5YdGg9/zNKB6CkAwCgt
         x5ZTEDTRELmbTv5RGQqvZ3dbzWlyuY7wMfZsksQcekaGcdInCPz2bMZUh6DjHtA7LY3j
         xcr/1bnYeaRYdhVE+MbAnF/Jr79KSHW59z2LxPWA4oGu6gM+KUzdzAobFccNAHDE4a2c
         fWNSNxK+c7LIOyw+98xEmJtmdhc/GlPiBBCOUe1pMW/U7NmsptcJkRCYji/nZ2xMhUcQ
         CxYg==
X-Gm-Message-State: APjAAAXssewfU1NSkgTOojFQFmntS30127R9rLsOLu1es5DY7hUOtxPn
        kea/wTvbkcjzlbH2KIM/3SxV41Zu
X-Google-Smtp-Source: APXvYqz9vXVZO1tG0buTLRAB6TCrRLPER7D34+ianfe+j40eaPSqPcyxKO/vYqLBHrNsoRmGTfg/vw==
X-Received: by 2002:a63:eb56:: with SMTP id b22mr25411159pgk.355.1568080011465;
        Mon, 09 Sep 2019 18:46:51 -0700 (PDT)
Received: from localhost.localdomain (S0106d80d17472dbd.wp.shawcable.net. [24.79.253.190])
        by smtp.gmail.com with ESMTPSA id p189sm13204189pga.2.2019.09.09.18.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 18:46:51 -0700 (PDT)
From:   jassisinghbrar@gmail.com
To:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     vkoul@kernel.org, robh+dt@kernel.org, masami.hiramatsu@linaro.org,
        orito.takao@socionext.com, Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH v3 0/2] Add support for AHB DMA controller on Milbeaut series
Date:   Mon,  9 Sep 2019 20:46:47 -0500
Message-Id: <20190910014647.5782-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jassi Brar <jaswinder.singh@linaro.org>

The following series adds AHB DMA (HDMAC) controller support on Milbeaut series.
This controller is capable of Mem<->MEM and DEV<->MEM transfer. But only DEV<->MEM
is currently supported.

Changes since v2:
 # Spelling mistake fix
 # Bug fix prep_slave - made local copy of sgl 

Jassi Brar (2):
  dt-bindings: milbeaut-m10v-hdmac: Add Socionext Milbeaut HDMAC
    bindings
  dmaengine: milbeaut-hdmac: Add HDMAC driver for Milbeaut platforms

 .../bindings/dma/milbeaut-m10v-hdmac.txt      |  32 +
 drivers/dma/Kconfig                           |  10 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/milbeaut-hdmac.c                  | 583 ++++++++++++++++++
 4 files changed, 626 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
 create mode 100644 drivers/dma/milbeaut-hdmac.c

-- 
2.17.1

