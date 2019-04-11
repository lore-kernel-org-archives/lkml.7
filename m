Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDB9C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDEC2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="V/AOBYRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfDKJAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:00:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36809 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfDKJAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:00:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85so3215317pgc.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 02:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=frJX+t0qve0rvf3r8LM28APcFZPyTl1bsa5j7cIVrPw=;
        b=V/AOBYRDlQbzjRGJCoP0AO747lJxK1E0b6yBordaP73mSpH13q3xrnrhAo7zANOhKq
         /kc9soi71g+8qig/5AewWyq8bnGL+nWI8OMm6oV3nv/CAVOp4y2Ysr+jaifggz6iYR4X
         u1s/NkK2pvi4yorUXuQcc6i4Vo8NLsAcopOSZSSO9VU4m9kLz5zHlDO65iBEs8LZNo+E
         GJ9l6L4XHo6zJtu2ouKu3dxI+ZrveejgVIBT5tFmYRzrbwmCTYZ78HDWdwi0kgdWlIfK
         4WRYq/O4GXKfNAr9Qz9AAA6meGFpnzsxVDisACP6wMAWtoGmlCQ9kJkx1oKaxcuKh/fD
         twHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=frJX+t0qve0rvf3r8LM28APcFZPyTl1bsa5j7cIVrPw=;
        b=JRtMF0APaFKNTjLUrxf4ftZef1ck9wybZuiEpL/RrJHNJZkrkWeqCJBH3fno+5oaQg
         nrO83Ws7oZ8ZeAVsL5tJpzZl7sy1uXt2GgWAi92+m0zMS7w7GxNoMMlCzTMNXcEk1dY6
         Rmo3SEVaHcDNit9EVqaZzj5I0FN4C2c08+frrWG3xyu0hbSB4YwVaZDJMUVN+leP8SmB
         hVf/+lWcaTf0F6gTBhDiSNg94zX4IhD0K0850GKtbdblQ/1ygwY8H6Oaxaui2VFnUOtx
         JqznZbxyGeJczj8VHKX4d6PC+th5pIsGsR2W/xFZ4WyvrC3sbM/+QoUu202ulCgHuGKu
         izMw==
X-Gm-Message-State: APjAAAV6lalTSiREyI09vbzePx2ygUQzWuD3T/3rdDgYbm29h9hx8kSS
        L76XT+wOp6OVAbA99RDrqOzd+u61gjw=
X-Google-Smtp-Source: APXvYqwnwryDuYaJoeuBpmKcv+V+hzo4KNfAncAHXRXUeIU/yiGJDhxdzCOlWP+yC+Do3J51O4H8Pw==
X-Received: by 2002:a62:70c6:: with SMTP id l189mr49304294pfc.139.1554973242222;
        Thu, 11 Apr 2019 02:00:42 -0700 (PDT)
Received: from viisi.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id m2sm64317272pgr.74.2019.04.11.02.00.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 02:00:41 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v4 0/2] tty: serial: add DT bindings and serial driver for the SiFive FU540 UART
Date:   Thu, 11 Apr 2019 02:00:26 -0700
Message-Id: <20190411090027.8670-1-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a serial driver, with console support, for the
UART IP block present on the SiFive FU540 SoC.  The programming
model is straightforward, but unique.

Boot-tested on a SiFive FU540 HiFive-U board, using BBL and the
open-source FSBL (with appropriate patches to the DT data).

This fourth version incorporates a few more comments from the lists.

The patches in this series can also be found, with the PRCI patches,
DT patches, and DT prerequisite patch, at:

https://github.com/sifive/riscv-linux/tree/dev/paulw/serial-v5.1-rc4


- Paul


Paul Walmsley (2):
  dt-bindings: serial: add documentation for the SiFive UART driver
  tty: serial: add driver for the SiFive UART

 .../bindings/serial/sifive-serial.txt         |   33 +
 drivers/tty/serial/Kconfig                    |   24 +
 drivers/tty/serial/Makefile                   |    1 +
 drivers/tty/serial/sifive.c                   | 1067 +++++++++++++++++
 include/uapi/linux/serial_core.h              |    3 +
 5 files changed, 1128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
 create mode 100644 drivers/tty/serial/sifive.c

-- 
2.20.1

