Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB3FC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629D320B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bo3LX1z+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbfHES51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 14:57:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46931 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730222AbfHES50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 14:57:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so36792132plz.13;
        Mon, 05 Aug 2019 11:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cnQ6cgNtIaI+0LNE/I4I7al7W7oYkecPwVLfFtCA+eQ=;
        b=Bo3LX1z+8ICC8BSWstNpcx1mu3CkcjEdX445gLNwG9yTHyhTNKY/+/nhx7dUOdHjs7
         5d1h8wezEZ9R0r5e9Rt2lNwvNuVaOqwr3TPU+6PiwFOIGW0VWKgH8te9YGWwwAHfgaBD
         q4O3HH0gOWpnz94lSbtF5wkEfu2EKfD9hrFrTvB0Ahg782leok1stx5U9LjCqKedqAFJ
         Dyepc5JdslwTB8h1otTKpCtEV/Nhbak+mEKltPkI9mBlOoHeS7ONytl5To9L7wgy6qcc
         x6EIv4VAZU3ZQLGdu1U5W3K6jYbscy+Ye2OBomxWV8hW8GmfEKYx8Uekok1G8GlaMuDV
         HGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cnQ6cgNtIaI+0LNE/I4I7al7W7oYkecPwVLfFtCA+eQ=;
        b=gSnxgl7rvI40u3Ns9iKUZJHsp7Jabu71eYJq5tV3nCpEHgjojtP805kIn5q3PTcZgi
         n5pp6b4wT5Jwyi3qGnsUS3IkzpKGwKyy8Hc0Kx8rcF1n62gPW1uyN/0l+O2t+2LJdjwq
         j1o7srSDVHwgGZZwsHOrVWa1RQV2cF2kpD/w5KDwkbHeEIk+fuzOEg4P2BfxUOGUtXtb
         JRWqrSf7565/xL67BzhlEwWYvOU1hMyQ+yZSoTpiQkG89lhGowNFmhF3BOE8JAL6YZU/
         BDfb2aChTaaKbP0LxiGqEe5dfuw4ids5SUwjl+9oQT5GD+J/bvmmr1mYBnJSzIVpRzy5
         t21A==
X-Gm-Message-State: APjAAAU1y4IHASSUM741lLiYKVNscdaEOb7hfpSt/SONy7y2B0yo50uw
        8D/df/J/zNl7kZU+PYQxGE9TXNCt
X-Google-Smtp-Source: APXvYqw+nHsVIxmaF9zejqrnhLn77hw3t4858ifFHn0wW30q2SfFwXdbqRT2jIayzJLLeBmK/jVI0A==
X-Received: by 2002:a17:902:1e9:: with SMTP id b96mr14848028plb.277.1565031445444;
        Mon, 05 Aug 2019 11:57:25 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id k64sm16037959pgk.74.2019.08.05.11.57.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 11:57:24 -0700 (PDT)
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
Subject: [PATCH v3 0/6] LPUART fixes and improvements
Date:   Mon,  5 Aug 2019 11:56:55 -0700
Message-Id: <20190805185701.22863-1-andrew.smirnov@gmail.com>
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

Changes since [v2]:

 - Series rebased on Greg's tty-testing branch

Changes since [v1]:

 - Dropped "tty: serial: fsl_lpuart: Drop unnecessary sg_set_buf()
   call" due to being a duplicate of "tty: serial: fsl_lpuart: remove
   sg_set_buf() for sport->rx_sgl"
   
 - Fixed build break in "tty: serial: fsl_lpuart: Introduce
   lpuart_tx_dma_startup()"

Thanks,
Andrey Smirnov

[v2] lore.kernel.org/r/20190731173045.11718-1-andrew.smirnov@gmail.com
[v1] lore.kernel.org/r/20190729195226.8862-1-andrew.smirnov@gmail.com

Andrey Smirnov (6):
  tty: serial: fsl_lpuart: Introduce lpuart_tx_dma_startup()
  tty: serial: fsl_lpuart: Introduce lpuart_rx_dma_startup()
  tty: serial: fsl_lpuart: Introduce lpuart32_configure()
  tty: serial: fsl_lpuart: Introduce lpuart*_setup_watermark_enable()
  tty: serial: fsl_lpuart: Don't enable TIE in .startup() or .resume()
  tty: serial: fsl_lpuart: Ignore TX/RX interrupts if DMA is enabled

 drivers/tty/serial/fsl_lpuart.c | 195 +++++++++++++++-----------------
 1 file changed, 91 insertions(+), 104 deletions(-)

-- 
2.21.0

