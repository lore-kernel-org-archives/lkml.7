Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64354C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C443206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shVjfj4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfDXMea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:34:30 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33962 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729853AbfDXMe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:34:29 -0400
Received: by mail-lj1-f195.google.com with SMTP id y16so5899702ljg.1;
        Wed, 24 Apr 2019 05:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0owTF1taWfix8lSIDzrSbqFDN03B9sQPaWwvJtZD0Fs=;
        b=shVjfj4bF+aS56w2el2dQQxnXUYKKIkmU2/ICVNue+NU9j7RFWrUGDXTGnUxNpyWCv
         uakMr3DFj3xocUY27wqbF5mwa9YjTUmnACPRv5ZTXsDgTZ0+0sTmjDripLf3xVWaQ8lt
         XUHVuIcfsW/wjVrpTs1gTw7hEm7/6G5XlTPtYQhZ4y8HhGWaIfkMmZbujApKxYfHrU99
         J+Y0RpIV+LGjw7B2gTBcfkGffHfL6lsc2ErE+JtY2X5yuhY9m38Dlri5WBOoMDVKb67+
         eKCIraJLqjMEHcF60XX200+rgIu88EC6wBtNAwt9dSVJPoly9RDpuAvn8OuX7ZFlUA5i
         JY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0owTF1taWfix8lSIDzrSbqFDN03B9sQPaWwvJtZD0Fs=;
        b=SpCjCcZbWDFigwxZHluygZYTd+hu+TCwXRTGIStGc+yBuB8IJ0JWEbHaUEv9lPejHt
         m1Gb4xue06ZWEk/vSpdzZMFlwcX2isjBdANe/6DTF+ppmtduippGLPjqfWHkyd9eEJDu
         4j5H5+bOty3i4mrCrpEo4XSbqY8kC8SxbkdeoZ8y2RS7XVryCzs359msJEM6VUuNseGR
         T1nmEfpXxqwT/ucGru+Sog7aNwtzp8Gy7DJJ7h+3L3Hktf4miYwlyQQxYfSLw1k9Ek/T
         vzVTpRauwNE3anlWTPa4wuq7QdKv8wHrde7WVszwqLLVrTKaVXzvkSGv94h+zz6x2FAr
         7Njw==
X-Gm-Message-State: APjAAAUqdEdWnBNKk+b0iXaBzL3V9wX+frATR7TH9tKX7YI+Vs8rmYXq
        xXslYA45M+PbtLcLa/lEDVJuDcFHru4=
X-Google-Smtp-Source: APXvYqzTR3akqwANPWPXwaitPDXB6ywMPEdKBWi3pKGFJAyUGMM2b1PgmqNv23ExBhZQA4uPnULvRw==
X-Received: by 2002:a2e:7114:: with SMTP id m20mr17449840ljc.120.1556109266736;
        Wed, 24 Apr 2019 05:34:26 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id t14sm3765962lji.33.2019.04.24.05.34.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 05:34:25 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] i2c-mux-gpio: Split plat- and dt-specific code up
Date:   Wed, 24 Apr 2019 15:34:09 +0300
Message-Id: <20190424123414.25311-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main idea of this patchset was to add the dt-based GPIOs support
in i2c-mux-gpio driver. In particular we needed to have the full GPIOs
specifier being handled including the dt-flags like GPIO_ACTIVE_HIGH,
GPIO_ACTIVE_LOW, etc. Due to using a legacy GPIO interface the former
driver implementation didn't provide this ability.

On the way of adding the full dt-GPIO flags support a small set of
refactorings has been done in order to keep the platform_data-based
systems support, make the code more readable and the alterations - clearer.
In general the whole changes might be considered as the plat- and dt-
specific code split up. In first patch we unpinned the platform-specific
method of GPIO-chip probing. The second patch makes the driver to return
an error if of-based (last resort path) failed to retrieve the driver
private data. The next three patches is the sequence of initial channel
info retrieval, platform_data-specific code isolation and finally full
dt-based GPIOs request method introduction. The last patch does what
we inteded this patchset for in the first place - adds the full dt-GPIO
specifiers support.


Serge Semin (5):
  i2c-mux-gpio: Unpin a platform-based device initialization
  i2c-mux-gpio: Return an error if no config data found
  i2c-mux-gpio: Save initial channel number to the idle data field
  i2c-mux-gpio: Unpin the platform-specific GPIOs request code
  i2c-mux-gpio: Create of-based GPIOs request method

 drivers/i2c/muxes/i2c-mux-gpio.c | 224 ++++++++++++++++++++-----------
 1 file changed, 146 insertions(+), 78 deletions(-)

-- 
2.21.0

