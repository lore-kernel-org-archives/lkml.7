Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4178C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89EB20679
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4I+L0DY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbfGaRbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:31:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47003 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729993AbfGaRbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:31:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id c3so9116723pfa.13;
        Wed, 31 Jul 2019 10:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x4Cxze/2AoCEdIVtmKyfx00YEVCCPhrKcLTbzIqdhqs=;
        b=h4I+L0DYy2DtXITuV4j3M6QG+NIg4/sM96sMojAb8xJYFOiJLYhM8arvGI0ZWx0+F9
         ZGFCGIzgtK3eqQmjMsovU1l3AH/9W6E554sH/v1+R1eqVMW8Rgjfvk8UbinxKYidrkp+
         HV0IbotKA1woVHxfz2YNxZ6ZiOSjvyp9AjnEsAx/TrkYr6KI3K0c+tadlFjfUsYNIIB+
         t47st0/8J4MfgnREQjFp7NXq9yuLrAKANjQXLM0/MPbUNzo4JUZ0UyLsq3VOt9vNon70
         Jl88CNeADc+XT1rK6+HRwp8qLBWk63MY7GVnvoDVI4X0ucFXnQfBkYaK/t3OF0MzZgk6
         n7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x4Cxze/2AoCEdIVtmKyfx00YEVCCPhrKcLTbzIqdhqs=;
        b=JH0UNa/5ixL8rppvBKvloNX2HCp9T2EYr0ezlkzrgciu2OijDJumNjDZrXPhqVymir
         sMxMRW2LsgsEXI8Y+Si/nLhHKgyWCuVce/g5vuF+5JLjX5O7hrtPn2zyTWJr1aFN+H64
         t0vd7JWClJ+2XgogipYdmFLCxWfyh4ok7+rBtpBvqjmv3JVSB4hOd4i6ns35WUyVIamu
         Y8cKb68Q/OL+iEUKXqTxR1yucECLrI/cUewrqz+8aTk+jCmyCiMHjKtzRVbuCtr5UCNk
         3oaNUyrrA+h23UDSvsusZvN76INjp9BNUU6kK5M8LGDFqhaey8rxIGdmCd3v+mA+LvWp
         N3Cg==
X-Gm-Message-State: APjAAAUgYTu+lKihR1Zl6uJScWNqmp3fFZBbhzdKLt5XFpyy2QPFAUZr
        RE6G44pq1PtDM1F8TPMJTSTGhdeh
X-Google-Smtp-Source: APXvYqyP29U2AOQQ2Y/jna+STO7GT5Is/2e234+zYo0pCApeM36vEyWB+q5P5mIMy+/eroOMQKgenA==
X-Received: by 2002:a63:6eca:: with SMTP id j193mr39128359pgc.74.1564594266330;
        Wed, 31 Jul 2019 10:31:06 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id bo20sm2089617pjb.23.2019.07.31.10.31.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:31:05 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/23] LPUART fixes and improvements
Date:   Wed, 31 Jul 2019 10:30:22 -0700
Message-Id: <20190731173045.11718-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This series contains fixes/improvements to LPUART dirver I came up
with recently as well as fixes picked up from Toradex and NXP Vybrid
repos.

Feedback is welcome!

Changes since [v1]:

 - Dropped "tty: serial: fsl_lpuart: Drop unnecessary sg_set_buf()
   call" due to being a duplicate of "tty: serial: fsl_lpuart: remove
   sg_set_buf() for sport->rx_sgl"
   
 - Fixed build break in "tty: serial: fsl_lpuart: Introduce
   lpuart_tx_dma_startup()"

Thanks,
Andrey Smirnov


Andrey Smirnov (21):
  tty: serial: fsl_lpuart: Flush HW FIFOs in .flush_buffer
  tty: serial: fsl_lpuart: Simplify RX/TX IRQ handlers
  tty: serial: fsl_lpuart: Fix bogus indentation
  tty: serial: fsl_lpuart: Drop unnecessary uart_write_wakeup()
  tty: serial: fsl_lpuart: Fix issue in software flow control
  tty: serial: fls_lpuart: Split shared TX IRQ handler into two
  tty: serial: fsl_lpuart: Drop no-op bit opearation
  tty: serial: fsl_lpuart: Drop unnecessary extra parenthesis
  tty: serial: fsl_lpuart: Clear CSTOPB unconditionally
  tty: serial: fsl_lpuart: Use appropriate lpuart32_* I/O funcs
  tty: serial: fsl_lpuart: Introduce lpuart_wait_bit_set()
  tty: serial: fsl_lpuart: Use cpu_relax() instead of barrier()
  tty: serial: fsl_lpuart: Introduce lpuart_stopped_or_empty()
  tty: serial: fsl_lpuart: Drop unnecessary lpuart*_stop_tx()
  tty: serial: fsl_lpuart: Introduce lpuart_dma_shutdown()
  tty: serial: fsl_lpuart: Introduce lpuart_tx_dma_startup()
  tty: serial: fsl_lpuart: Introduce lpuart_rx_dma_startup()
  tty: serial: fsl_lpuart: Introduce lpuart32_configure()
  tty: serial: fsl_lpuart: Introduce lpuart*_setup_watermark_enable()
  tty: serial: fsl_lpuart: Don't enable TIE in .startup() or .resume()
  tty: serial: fsl_lpuart: Ignore TX/RX interrupts if DMA is enabled

Stefan Agner (2):
  tty: serial: fsl_lpuart: fix framing error handling when using DMA
  tty: serial: fsl_lpuart: flush receive FIFO after overruns

 drivers/tty/serial/fsl_lpuart.c | 493 +++++++++++++++++---------------
 1 file changed, 261 insertions(+), 232 deletions(-)

-- 
2.21.0

