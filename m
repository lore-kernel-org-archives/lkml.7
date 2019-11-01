Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244ACCA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9B521734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DGeGBbSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbfKAHpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:45:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39659 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfKAHpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:45:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id a11so8795160wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 00:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=to/Y/QniUKkmMiWX6pjQcsRGKsnCzLq5ufaQQdqWZaY=;
        b=DGeGBbSBF3XBgQkPzpHmCQeFeB+An6cAw2pADw8jObNdktR2wAJYZyaNvNypUUSyzt
         3RbLP0F6s/LWdjQ2cyscdEqHYHFEUtbMNkOfeQfvJhKU/DXlesWfI62+9UIsQ2tccQn9
         OWp/fMADkVTtJjkM8ktM5ey74wSv2owi1hbyy8xdt5E9ap2yunxrhdcyTLVaC6Skea2U
         vT8pEVhFT39RWjnZ7upwYsYng+82rk1hWMZxGOLjhx3483Anr/FcD9Z5pienGvAx8/i9
         l6gVFD1OFIVMLPnKxE1mvr0oy4Wb86BHYaxly8EacH/EQKrFNXyCqimqN6uL+JyEcqmv
         hvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=to/Y/QniUKkmMiWX6pjQcsRGKsnCzLq5ufaQQdqWZaY=;
        b=mrK0D7vbGrTwpeD3uCWl5cKjU0aa+nXbEGZTutAl2FaRcBWNhYV08rujaXVuZGkZDx
         aYTPGlHiYoG/Zt8B5cm7V9Q9EqXzkRwjJyoqjySyi+rJwyN4BrXp/bMuJAXP7skHXOai
         nZeU38c12nguQugjQ2OkGYqRl4fcK5DGa2ywPBmU33m8HS3SCFsEPi0rJ+iI3HnMWEHi
         hZouD1opI3J8hWcHuHEETXx9LTK3lgHHkJjF/3a+pARjCK6IG3ZNh26v1fzOzzV4+nZI
         jH7ERj+VnKC0N650Gv9YIdDy1xnezuVqXmlA3Es8rpSARLreW1hV+fl/qRQR7mruHJXr
         plYw==
X-Gm-Message-State: APjAAAXKNd6+OBy7LSvKl4pHW28FRCSeERXQddxf0IXyzxGrpsNjA34z
        63tJYGs0pn82Gk+Ux1cGAqIbOg==
X-Google-Smtp-Source: APXvYqyxjoV/SqOqmBnZZX6r+ePMAOXdffQ7T9WX/+gdTSuCsEL054iIAv0sY38n9RTh2JKXTN0IVg==
X-Received: by 2002:a5d:5288:: with SMTP id c8mr2412711wrv.1.1572594321520;
        Fri, 01 Nov 2019 00:45:21 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.64])
        by smtp.gmail.com with ESMTPSA id b1sm576215wrw.77.2019.11.01.00.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 00:45:20 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, linus.walleij@linaro.org, baohua@kernel.org,
        stephan@gerhold.net, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 00/10] Simplify MFD Core
Date:   Fri,  1 Nov 2019 07:45:08 +0000
Message-Id: <20191101074518.26228-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MFD currently has one over-complicated user. CS5535 uses a mixture of
cell cloning, reference counting and subsystem-level call-backs to
achieve its goal of requesting an IO memory region only once across 3
consumers. The same can be achieved by handling the region centrally
during the parent device's .probe() sequence. Releasing can be handed
in a similar way during .remove().
 
While we're here, take the opportunity to provide some clean-ups and
error checking to issues noticed along the way.
 
This also paves the way for clean cell disabling via Device Tree being
discussed at [0].
 
[0] https://lkml.org/lkml/2019/10/18/612.

Lee Jones (10):
  mfd: cs5535-mfd: Use PLATFORM_DEVID_* defines and tidy error message
  mfd: cs5535-mfd: Remove mfd_cell->id hack
  mfd: cs5535-mfd: Request shared IO regions centrally
  mfd: cs5535-mfd: Register clients using their own dedicated MFD cell
    entries
  mfd: mfd-core: Protect against NULL call-back function pointer
  mfd: mfd-core: Remove mfd_clone_cell()
  x86: olpc-xo1-pm: Remove invocation of MFD's .enable()/.disable()
    call-backs
  x86: olpc-xo1-sci: Remove invocation of MFD's .enable()/.disable()
    call-backs
  mfd: mfd-core: Remove usage counting for .{en,dis}able() call-backs
  mfd: mfd-core: Move pdev->mfd_cell creation back into mfd_add_device()

 arch/x86/platform/olpc/olpc-xo1-pm.c  |   8 --
 arch/x86/platform/olpc/olpc-xo1-sci.c |   6 --
 drivers/mfd/cs5535-mfd.c              | 108 +++++++++++-------------
 drivers/mfd/mfd-core.c                | 113 +++++---------------------
 include/linux/mfd/core.h              |  20 -----
 5 files changed, 68 insertions(+), 187 deletions(-)

-- 
2.17.1

