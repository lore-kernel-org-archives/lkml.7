Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBECBC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0C0207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="gXLc5ArD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388464AbfFJIov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 04:44:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32970 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387992AbfFJIou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:44:50 -0400
Received: by mail-lf1-f67.google.com with SMTP id y17so6041494lfe.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 01:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xiOomN8ncLqLA/h78gWk8goAIoMFhfSzrcxxROAHNlw=;
        b=gXLc5ArDB8RPgrEk/Jd8N+pjJHoSUH2PJMybar0YONDntHf2WpIAijMyMLo5MFX4gL
         PA/1RzIkFGq8pLfKnJYQcshyTaHhVOK3hdVaIPM1zaLNGQFS73MdqWXX2u/bf03UcQkT
         AU25UQWm8a2jX6LidJDvR5EPSvgdLA7i/eadYH5nhrQD4mFbh9H95UQnyKufzAOGHIrK
         auJZxRoDMfkaM5TidlbFxYMosAuuB6NXw4wW1gwT2hqm5SMkwm79bPwIIadykKigbHIi
         nOsQAc/9PG348frP4jY2BWB9sf+g0LU1x/cHfqH49ydNRvjeS3JGPyfsyatEPc3qcY9z
         gy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xiOomN8ncLqLA/h78gWk8goAIoMFhfSzrcxxROAHNlw=;
        b=uHMFQfJC5tDIaUSbQAm4BofsItZEYMuD/buzuJbz+AeK0ZHRF6JL+b1Y+GDIkpKz6l
         4WIV5BV0Y/LMxBY8m50otZe6B4cU3uWSMP7nfFwYVf6GenwcYUJSVfKIXG3sR17gQ4pg
         NawRCeMmk/rLhTmowgivyOjeqxPOBisLB/NurZwIsYOnBO2FWenRD3tafzr+gU1geXoJ
         ncEVJZIZrB7ZwAg0/nltrwFiteOzdzo0+SYl+KevKL72JGDab97EdV2eAVJLPTC47Scd
         ZZ74b2DaOB1wyINTjHlLRu/Bzy+o8Y4Haw4osD11Y+8qkEorlE7CGaU9p6q+HfMaVYLG
         amhw==
X-Gm-Message-State: APjAAAVTIfJ9B6vEdCxDMzCDRW103Hov2PaTFOJHxYOsRmbd/O5JU23j
        r0wE/ATJpVbAnW6ZwDt0UVbkGQ==
X-Google-Smtp-Source: APXvYqyZSlbnytSQkmm6Jlms/NI1ecWIJrJDLKJPGWFjX1SaV4FKH8IfBTurzQbygYJ8SAHg1k3dyA==
X-Received: by 2002:a19:c142:: with SMTP id r63mr36601429lff.49.1560156288925;
        Mon, 10 Jun 2019 01:44:48 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id e26sm1826486ljl.33.2019.06.10.01.44.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 01:44:48 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     =simon@nikanor.nu, jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH 0/5] staging: kpc2000: remove unnecessary debug prints
Date:   Mon, 10 Jun 2019 10:44:27 +0200
Message-Id: <20190610084432.12597-1-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches removes unnecessary debug prints in staging/kpc2000.
Debug prints that just informs about function entry or exit can be
removed as ftrace can be used to get this information.

Simon Sandström (5):
  staging: kpc2000: remove unnecessary debug prints in cell_probe.c
  staging: kpc2000: remove unnecessary debug prints in core.c
  staging: kpc2000: remove unnecessary debug prints in dma.c
  staging: kpc2000: remove unnecessary debug prints in fileops.c
  staging: kpc2000: remove unnecessary debug prints in kpc_dma_driver.c

 drivers/staging/kpc2000/kpc2000/cell_probe.c    |  5 -----
 drivers/staging/kpc2000/kpc2000/core.c          |  6 ------
 drivers/staging/kpc2000/kpc_dma/dma.c           |  4 ----
 drivers/staging/kpc2000/kpc_dma/fileops.c       | 17 -----------------
 .../staging/kpc2000/kpc_dma/kpc_dma_driver.c    |  4 ----
 5 files changed, 36 deletions(-)

-- 
2.20.1

