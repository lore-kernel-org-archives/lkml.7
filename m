Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D1AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 08:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2DB20645
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 08:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+zgUrq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbfC3IS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 04:18:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42042 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730384AbfC3IS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 04:18:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so2292498pgh.9;
        Sat, 30 Mar 2019 01:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lQFPduuRrvcX+gZuXfvtig2m2Ju7MKCjCFT91ywMWWw=;
        b=d+zgUrq4m5Sd097CG9C3c42l6xmoLtR6USTocGxSFbJazASzU7HS32c57fWFZTrigS
         Z2hygPI+JHb4eiikHmAwY+37o0Z7Kke0d7IgrC4o00jD297HvIz50ZSKBFom4JUA5dkS
         ng0faIKHaIBrOlWYuBlLwf7T2utjEX2Io1np6fCQwUq0o467iqdBT84XcuxE3SDzmgOW
         lZE71DiGJsrIduAr9p7uEpaUoPma2/lfh7l42g9wf1SF98vlqs4KfEOnWITcI03QNo2w
         JE/kwEyNZxzhNb/NqOcc2zeihtaTfhIQ6U+e2+XPr9ecZN9HMckiRUSIG8FPsciQupb4
         nB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lQFPduuRrvcX+gZuXfvtig2m2Ju7MKCjCFT91ywMWWw=;
        b=fH6DhcgIlh5hr4MVxOCRIYlsQSsrce0j/8qTVsAcuglAAsiPueRepsg2kXn0KxcZHx
         kufqVqbpx08j5lre5sKI02w6vYa0H0PjDcNiK6LOgW2zVzO/08DUEKEYmHoTabqD6pUA
         FEXU7Av1CU++f09vEY/U44ZTijsT92RY6TLQ7nu9jMgG+t12/CFI7gRmT6XEm+Ehb/45
         hIwABy2zpkovF+BXJiFuQBrSmLJ0tMyi2FbElF/bbOP8SAJUXcI4YHIqZt32RyHx8PAT
         ZYBW81HrDpnOycaGEAWbIgo/outFCDsgx/clmd2g8fmfLL+na3lUURryLEnrrC8BiMm6
         iePw==
X-Gm-Message-State: APjAAAVeVNtzBqzn2OOzu9gDb8mHpKmdSMkvZae2F7XWqkiO02/WKHgV
        qHQAp1gaYfxKi/fqxCTGYn4=
X-Google-Smtp-Source: APXvYqxl0qmF88noEbF2jDL6qHdi9WKyyh2eApvDspI9S9Oa4OhtAeDwY57q8m18R6+jO7NSibhwzw==
X-Received: by 2002:a63:550d:: with SMTP id j13mr4639837pgb.18.1553933936044;
        Sat, 30 Mar 2019 01:18:56 -0700 (PDT)
Received: from localhost.lan (nitrohorse.emeraldonion.org. [2620:18c:0:1001::106])
        by smtp.gmail.com with ESMTPSA id e2sm6724006pfa.64.2019.03.30.01.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 01:18:55 -0700 (PDT)
From:   Tom Li <biergaizi2009@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-mips@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org, Tom Li <biergaizi2009@gmail.com>
Subject: [PATCH 0/1] KB3310B MFD Driver for Lemote Yeeloong laptops.
Date:   Sat, 30 Mar 2019 16:18:35 +0800
Message-Id: <20190330081836.26942-1-biergaizi2009@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend of the first patch ("[PATCH v3 1/7]") in the patchset
"[PATCH v3 0/7] Preliminary Platform Driver Support for Lemote Yeeloong
Laptops" [0], which introduced a new MFD driver.

The original patchset never arrived to Lee's inbox. so I resend the
patch to facilitate review.

It features the following...

* Create a MFD driver for KB3310B controller, and move the original
KB3310B controller code from mips/loongson64 to our new MFD driver.
This needs to be reviewed by the MFD subsystem maintainer before the
following can proceed.

* Subdrivers - hwmon, battery, backlight, lcd and hotkey are registered
as MFD cells in the MFD driver. It means onlf the MFD driver is resposible
to register the upcoming subdrivers, the core board files mips/loongson64/
will not contain unrelated code.

[0] https://lore.kernel.org/linux-mips/20190306120113.648-1-tomli@tomli.me/T/#m2a6e18afbb62ceb535a859181d8485916b30a63f

Thanks,

Yifeng Li (1):
  mfd: yeeloong_kb3310b: support KB3310B EC for Lemote Yeeloong laptops.

 MAINTAINERS                          |   7 +
 drivers/mfd/Kconfig                  |  10 ++
 drivers/mfd/Makefile                 |   1 +
 drivers/mfd/yeeloong_kb3310b.c       | 200 +++++++++++++++++++++++++
 include/linux/mfd/yeeloong_kb3310b.h | 211 +++++++++++++++++++++++++++
 5 files changed, 429 insertions(+)
 create mode 100644 drivers/mfd/yeeloong_kb3310b.c
 create mode 100644 include/linux/mfd/yeeloong_kb3310b.h

-- 
2.20.1

