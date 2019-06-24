Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBE7C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4D820674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="kr2YtGPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfFXJvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:51:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45968 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfFXJvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:51:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so13124462wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 02:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XVmGEJyQPDHoch+b6BWewi3xs9P5Dw405kJdnxVdR0M=;
        b=kr2YtGPzC3J6vReJFFvpNeYI8P2G7TzBXWRjt4IONsx8qu/O5IbzGWf4XfDBgQEdVB
         OwcMNpoUNmMJWeLUNXPP9RmyA8+ow5fiKS5O/1jIm0BZr6BbA0EvFB+4mT7v0ztYwMX/
         N1BYBfnqqNwFImvTUwOhPYiMutavibtxd1AUXNdcmN5cM50gQ0Jdo3v7ruGeYi0tKgee
         mil9VPdAstj2a8xGFV6b7ob4WfIOp47KtVIJd2xlUotkrVJgjVS/RGTD5yX7mAEh4/WY
         Zf6frsWL+i+43vZE9v7Rv2BgOQjZ5Cyxa7uHWUslfyYBpAfOOdsMnbOR4kXeM1vy27WW
         oUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XVmGEJyQPDHoch+b6BWewi3xs9P5Dw405kJdnxVdR0M=;
        b=Gr0q57dR6tZQ/gy7BoD/kpa3tDMPzbqYad3Y4dPSTN52kEyN771S++dRYOjCYRTMgh
         zmtbJJSBMkj37FBlVH4fNSDkc1X7MH+pN50UK4J0dUbFk4G6lE6oUhGz5JSnB2bRiE9G
         WToj7/LflOmhGmqdXtaMfI+qoI+WqPTqgH36RSD3DTcgzQ/bMLNufFrCYkr5ihZMTwuB
         z3Rs1wsmz8iRYpOp7g12QQ4gHxD/GZYqpYNFvWxvyrRbYU4Qk40dqRyqDs0KbYPnYd47
         S639A1tO1oq7+PtAMMmdY3PGv4Ou9SRZ7Me+ij3amVGQXfSrxVNN1J6MdpSc/Cqwn0dg
         V2MQ==
X-Gm-Message-State: APjAAAWTu2D0INeIxVhEG4DclLMUS+oip22iq8x7/mxLB8Sicb0OdoOD
        7VlSjpC3AN9F7hIn8PePjRBQ5A==
X-Google-Smtp-Source: APXvYqwOYNWFj4G2lFccqRsQzHMY3FxP9ZPFXZjzlJFp4+nV2YP4HV6nLizVMISKYY8c9e+bP8227A==
X-Received: by 2002:adf:df0b:: with SMTP id y11mr47776110wrl.176.1561369859479;
        Mon, 24 Jun 2019 02:50:59 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id y17sm17364483wrg.18.2019.06.24.02.50.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 02:50:58 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v8 0/2] clocksource: davinci-timer: new driver
Date:   Mon, 24 Jun 2019 11:50:54 +0200
Message-Id: <20190624095056.21296-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Now that we have an agreement on the driver and only minor issues are left
to fix, I'm dropping the RFC tag and continuing the numbering from before
RFCs.

This is the davinci clocksource driver but it with a sparse warning fixed
and with a small tweak to kzalloc() call.

RFC history:

v1 -> v2:
- changed the format of the copyright notice
- removed all mentiones of the periodic timer setting
- added caching of the TCR register value so that its updating doesn't
  require a read
- split the timer configuration for clock events into the
  set_state_oneshot() and set_state_shutdown() callbacks

v2 -> v3:
- tim34, if used, should run in periodic mode for clocksource, now fixed
- dropped all the configuration variables from struct davinci_clockevent
  as clockevent always uses tim12
- dropped caching of the TCR register with the following reasoning: on
  systems using tim34 for clocksource, the TCR register is only touched
  by the clock driver and we know that we need to keep tim34 in periodic
  mode; on da830 the RTOS running on the DSP may modify the TCR register
  but we on the other hand never change its settings when only using tim12
- subsequently the whole routine for TCR updating was dropped
- dropped the shift variable from most places
- added separate routines for initializing clocksource for da830 and all
  other systems
- sprinkled a bunch of comments all over the driver to explain things
  that caused confusion before

Changes since last RFC:

- fixed the following sparse warning:

>> drivers/clocksource/timer-davinci.c:198:14: sparse: sparse: incorrect type in assignment (different address spaces) @@    expected void [noderef] <asn:2> *base @@    got oderef] <asn:2> *base @@
>> drivers/clocksource/timer-davinci.c:198:14: sparse:    expected void [noderef] <asn:2> *base
>> drivers/clocksource/timer-davinci.c:198:14: sparse:    got struct resource *

- added the __GFP_NOFAIL flag to kzalloc() call so that we don't get warnings
  about not freeing the memory later

Bartosz Golaszewski (2):
  clocksource: davinci-timer: add support for clockevents
  clocksource: timer-davinci: add support for clocksource

 drivers/clocksource/Kconfig         |   5 +
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/timer-davinci.c | 369 ++++++++++++++++++++++++++++
 include/clocksource/timer-davinci.h |  44 ++++
 4 files changed, 419 insertions(+)
 create mode 100644 drivers/clocksource/timer-davinci.c
 create mode 100644 include/clocksource/timer-davinci.h

-- 
2.21.0

