Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F17BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202FF2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+rwx8XC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404143AbfG2UAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:00:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42554 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390586AbfG2Twq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:52:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so28763504pgb.9;
        Mon, 29 Jul 2019 12:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BisbOojm1L0chpN6FgWkwkJa3SL7jxklJpQDnyixEqU=;
        b=f+rwx8XC7zkZr/aTm1JcdENObmj3+KH0SoKNOkobp+pzzdBULNYK6xgsuFty9Y77RQ
         A8lLAIjK1g19EohWEKzNxTIf15wAVexuwRpclK+dPJqPEeyEEq+/Mg7JN5pb09HYnVFQ
         1XXlznRn3qF5LoVg8/32Bbfiq8TY2XOig5TdnCAt3RmD79dwk82BacqNSBUJ4LmM7qEQ
         HbcTzUzqSCIZLp1HR760haA2wDyixxnE/GoHDquH/h+0F8sy2HmyFcL2H1pBy6OSN85W
         f4R+K62/V0H//xJPAWAL0nmkt/8lAfgrnKMtQtzEUYd5zbCoaw4wQ60D1RNxCFfQyZL+
         6+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BisbOojm1L0chpN6FgWkwkJa3SL7jxklJpQDnyixEqU=;
        b=jpiYTanBmiQgZTN6Qe0xI8d+OvH8KqFZR9NduyR0f+u9VESDsv6amKCvW8xIIq+a+d
         5jvkMLf3guCZCYkp1D2tf42e3dhpVGph9ItHStyL35dEoreOY2MhQTHi+hsNcUhkBVQp
         g9KeSh997qnI7ZWnA+l5hDaNgMIPzTpUSdcudNCxiA8tTf0IzP5WA6PvOrH+w4zT8wpA
         mw0YniwqRkCiPcfKOfgm7fgydUenx2Ujp8XF3B8uTtpf1WePjbkkWJYAmhRNRMuREEYs
         O6Jtt98/EeDqTE443J3w1lKNKTvlsbggeV5CpTnGraM4u2v/daBIdupDTGH8PrOQOf+Z
         lgTg==
X-Gm-Message-State: APjAAAWF2YPa7FzJbyiwr7uzNRayKhZODarx2d8l4HZHewIDJuzfc9mM
        p60xmsQfQnboI+a5QF6keaN7PK+t
X-Google-Smtp-Source: APXvYqwa8Ei33RrNsx5dj7nvc/Lp68l06u/Bs/qK2sj3O+Zom8jIey/fEY2K+AP7tGUuQjiXOZS0Zw==
X-Received: by 2002:a63:1908:: with SMTP id z8mr103078604pgl.433.1564429964812;
        Mon, 29 Jul 2019 12:52:44 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z12sm43983750pfn.29.2019.07.29.12.52.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:52:44 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/24] LPUART fixes and improvements
Date:   Mon, 29 Jul 2019 12:52:02 -0700
Message-Id: <20190729195226.8862-1-andrew.smirnov@gmail.com>
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

Thanks,
Andrey Smirnov

Andrey Smirnov (22):
  tty: serial: fsl_lpuart: Flush HW FIFOs in .flush_buffer
  tty: serial: fsl_lpuart: Simplify RX/TX IRQ handlers
  tty: serial: fsl_lpuart: Fix bogus indentation
  tty: serial: fsl_lpuart: Drop unnecessary sg_set_buf() call
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

 drivers/tty/serial/fsl_lpuart.c | 495 +++++++++++++++++---------------
 1 file changed, 261 insertions(+), 234 deletions(-)

-- 
2.21.0

