Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3EDC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABDA2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="gviqNG1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732633AbfDQOrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:47:16 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:44207 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbfDQOrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:47:16 -0400
Received: by mail-wr1-f49.google.com with SMTP id w18so2211468wrv.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 07:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ap5mFoaMo2tPo1FsQ32/BuCFfhQsUubSQirVoPHo5A8=;
        b=gviqNG1FKCBvLVos2UlZMicJH5v40N4P+78E9eA4VqxbVjoLhV7AFm6McLDORs5lIk
         dbyKxmbNyImDI09DxnVJniQGxN3zFYSMWrm3Q59ovL8iST96Pgq1YubUJ/iupTCiXdxF
         TYPD04I+yiamBpp0MLE1v5QikRbWm8eP3o9N9quF8bEPJBkdSDlvZbGAfGlHkJSF4la4
         uxbykwNTei+fRWGGY44vI121FOENDStOqQrBgVS0oeV5Lzbj4XBnWBP1/YDRNrz002wT
         kSnxF/RUSc35ZQN0DWlAHMH5Fy6cnbbtq2+CyurLf2T6HbQTZx2IIYAcZ/BmNbVfcBNO
         HLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ap5mFoaMo2tPo1FsQ32/BuCFfhQsUubSQirVoPHo5A8=;
        b=l5IW5Vtaulzyhf7/l+3PDdJneHLHLMSQyh4EQdUtJ5YYCSNQD6L+haAwDtUICFGGt+
         yk7X/NpELkTbqXeeBF1gfJy0uSbmQp4hL91EGg37ddIoFPmwAdp8E4uumXBdXvz31RDD
         8knd0RkrbxySKGkyUWahe2OoNqp2092gW50oxeGaeYazDKd1EM857KwScBTFxiTYUxh2
         7+vtLI+uCVxfzhNK5lZ6C5afIq3UizU2uuy8KoCSJAf0aR1L/7yV+UimtFb8BvFM9mak
         rnW4uimZ0uBxWDqnxWshV3hCNkIKNf5UAn13Anyax7sIoboP7v8nP3VWhv5zxDTPFtNT
         heRw==
X-Gm-Message-State: APjAAAUEzYkDP9uGsZ5JaLrHE2lce3QGXU7vIKEF136vtB2xqeeAKKrc
        pgxZSswz/3SOFDYlabwQFBx71w==
X-Google-Smtp-Source: APXvYqxL2lgRlHpFw+OzGQVAuHsPczWAB3MtT3I96JFcGMR9l5EachbZYY4y0Z6lwBGVTX6hSyyhgg==
X-Received: by 2002:adf:ea43:: with SMTP id j3mr33344502wrn.210.1555512434371;
        Wed, 17 Apr 2019 07:47:14 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-15-216.w90-86.abo.wanadoo.fr. [90.86.218.216])
        by smtp.gmail.com with ESMTPSA id u17sm5582862wmu.36.2019.04.17.07.47.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 07:47:13 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RFC 0/2] clocksource: davinci-timer: new driver
Date:   Wed, 17 Apr 2019 16:47:07 +0200
Message-Id: <20190417144709.19588-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Daniel,

as discussed - this is the davinci timer driver split into the clockevent
and clocksource parts.

Since it won't work without all the other (left out for now) changes, I'm
marking it as RFC.

The code has been simplified as requested, the duplicated enums and the
davinci_timer structure have been removed.

Please let me know if that's better. I retested it on da850-lcdk, da830-evm
and dm365-evm.

Bartosz Golaszewski (2):
  clocksource: davinci-timer: add support for clockevents
  clocksource: timer-davinci: add support for clocksource

 drivers/clocksource/Kconfig         |   5 +
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/timer-davinci.c | 342 ++++++++++++++++++++++++++++
 include/clocksource/timer-davinci.h |  44 ++++
 4 files changed, 392 insertions(+)
 create mode 100644 drivers/clocksource/timer-davinci.c
 create mode 100644 include/clocksource/timer-davinci.h

-- 
2.21.0

