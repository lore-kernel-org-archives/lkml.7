Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0C8C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9EC20842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="OaK1uWNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfHLMxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:53:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38005 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfHLMxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:53:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id m125so7610259wmm.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 05:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UbDB6JFS0IFPkYF4fl0nqbXR16d37yVxlPN08CwT4oU=;
        b=OaK1uWNkYBTnkyqRDeDUdTQBsgC23gwVtMC4iKGuof8O4PZDBlaeLwIJOJnKurvNE1
         AuawtYfXVgsuH5DeSPIDr7kNWi/+MFbtigLkgi2oKVwkL5v43Oa9DKRfDMHBLhGstPyT
         fZWqmyN5Ch6WyXEinLQCAOmpmrn6uHVWRyFjt/YDaphpuCigkkZPQxDd4D/9ArRtqqzm
         u/D7S6h+fPtrio3kd99RVEaVeKdz7BBXC3Ga3gnw1qQZ4i2jasMyELTS/LlpZL+/nsjO
         MhllbK3/tAgqeoEJob1N4HV+YGndyEo3ciPkLDDDkqPUJIUkXjDzknRuGL5/V30+bCpZ
         9HHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UbDB6JFS0IFPkYF4fl0nqbXR16d37yVxlPN08CwT4oU=;
        b=ATIN9cMgLgPiBpLN1hip6dVqqmU+H12K9pc+CZ0UY91iQBu5/nCDe6EQv1wxvyiGSD
         nLYM76JB0HZ4wkxDGgx3tb/vk+AZjFFcdzhAW2z7y1uDz7iNE6PFbGX1pmT8+WKQp6Ze
         /PTRUn1Ct9P1x0xoewlklIFcSBj+skVoLOLuBUqstwAqyR4Blul765YQLhMAuYTVuVIB
         a5sy/JGgmdFR+UrKaY9K0IBfRPpE/KsNJfv/C6PX6G5gYDIWsvpRsV7J6Rbo4SYALL0m
         EE7WQoKJRoriTwrX//2Dlw51cdbxIDHuo+eZ4Ng7jyMCB5XY7G86f9q1IN02/aVYuFop
         tn1A==
X-Gm-Message-State: APjAAAX2i4jLW3q/4vlVG9xH6XQPJSPKtgFw5mQBnFUwK+jPTBm4rpj3
        sQDS4a4/R6GOqXVp6XJokHL74g==
X-Google-Smtp-Source: APXvYqxUJYUKGKzgKcM/WXnrMlZ63SVZ1QErY6mY/juBb/K5JySfVxSAQz2izQo9zbIX9xm5e1uQlg==
X-Received: by 2002:a1c:238e:: with SMTP id j136mr27057657wmj.144.1565614382150;
        Mon, 12 Aug 2019 05:53:02 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id r16sm28288431wrc.81.2019.08.12.05.53.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 05:53:01 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/2] irq/irq_sim: try to improve the API
Date:   Mon, 12 Aug 2019 14:52:54 +0200
Message-Id: <20190812125256.9690-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently the interrupt simulator exposes structures that don't need
to be public and has a helper that manually maps the simulator's irq
offsets to the global interrupt numberspace - something that should
be preferably handles by an irq_domain.

The first patch addresses the public structures: it moves them into
the relevant .c file and makes the init function return an opaque
pointer.

The second patch adds a linear irq_domain to the simulator and removes
the irq_sim_irqnum() routine. Users should now use the standard
irq_domain functions.

Both users of the irq_sim are converted at the same time as it's much
easier than trying to transition them step by step.

Tested both the gpio-mockup module as well as the iio_dummy_evgen.

Bartosz Golaszewski (2):
  irq/irq_sim: make the irq_sim structure opaque
  irq/irq_sim: use irq domain

 drivers/gpio/gpio-mockup.c          |  21 ++--
 drivers/iio/dummy/iio_dummy_evgen.c |  34 +++---
 include/linux/irq_sim.h             |  29 ++---
 kernel/irq/Kconfig                  |   1 +
 kernel/irq/irq_sim.c                | 177 ++++++++++++++++++----------
 5 files changed, 152 insertions(+), 110 deletions(-)

-- 
2.21.0

