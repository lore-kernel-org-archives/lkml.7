Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D512FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA176218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1D255We"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbfC3Sju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 14:39:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38651 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730606AbfC3Sjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 14:39:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id w15so6480981wmc.3;
        Sat, 30 Mar 2019 11:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yof/6QpkEjSPGURPb0MHdoL2Eb7OTCYbhXCafvEKtdQ=;
        b=i1D255WegenXaD+JgLgPxdX4G2ZCCx92/qs3rWMMmE/WlxCOHnv3JrmaN8NCC7C0R/
         vl5UTQMXaFeepuXXXejO8nLtIt7ZX3sDdI5bZtMWj9Y51OnMJXHkYNJzTVePBOYBOZfT
         i+osZRO3RP9zAgPuSOh8y8/9sCl2vrUouJI21m2zy1b5b+KmopiaQvUKC32X3qKI+6GR
         4onQnWMfTWvEZsu1fYlWKCA4NWGanYd+8jKWvqaCIfvBNFL/Gei1YZmvW3QobHJtRIPR
         iiSGK0pD/LCM5xvGZoPDoNn2tDd6xItybfRQkAv5zFPy6n0ackABYmLCpk7nEntZ+TmY
         gplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yof/6QpkEjSPGURPb0MHdoL2Eb7OTCYbhXCafvEKtdQ=;
        b=JrVwX9JvM9bnoF6JqRpsmhgS5UPZ3+xt0Zk7IHnF1SmgBhPPc4V7LvTPQi1Phlabt7
         uQ3lD9HYBW+pgAEIe3EnEd14pFXCB8IXcdlovYPecbHlsnuadyA9Vv86bsp3EnBsqVav
         RiGyrkfpObRkrNgu1h9zVwIHMAXHx/0kcyqAS5+5ZkpZX5ijn0Jgwhieb9weXglsOJQJ
         IoART9unFUV9Dk1zqj6nRvthuwrp2xCOG+j8i22HyeQgSzVoFoGSE5LcqKnPLw8ri63p
         pmiOEUxmZaeMJp25GmMaoW/eTkm8+JMXrasgE6wz7nCQE+6bg8GJHW+7zFVE4fjFWCWm
         WZug==
X-Gm-Message-State: APjAAAVGs0+dNGBWDb04y4fJUuOty4ACjCBJ/88ik41PO2+d8XVx2ktu
        LKXca98vNXP7BNiPaacA68E=
X-Google-Smtp-Source: APXvYqxakJEQVswCmorgMp0JqUYKc8kzsqDNtwfSyqXDJJ8pybRHifbuNZEUOJA4Y+JCMASfzYBC3Q==
X-Received: by 2002:a1c:e143:: with SMTP id y64mr7182710wmg.141.1553971188020;
        Sat, 30 Mar 2019 11:39:48 -0700 (PDT)
Received: from myhost.home (ckm59.neoplus.adsl.tpnet.pl. [83.31.88.59])
        by smtp.gmail.com with ESMTPSA id b134sm13139920wmd.26.2019.03.30.11.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 11:39:47 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, kjlu@umn.edu, linux@rasmusvillemoes.dk,
        rafal@milecki.pl
Subject: [GIT PULL] LED fixes for 5.1-rc3
Date:   Sat, 30 Mar 2019 19:39:42 +0100
Message-Id: <20190330183942.6589-1-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull LED fixes for 5.1-rc3.

ledtrig-netdev fixes:
	- fix refcnt leak on interface rename
	- use memcpy in device_name_store() to avoid including garbage from
          a previous, longer value in the device_name

leds-pca9532:
	- fix a potential NULL pointer dereference in case of_match_device()
          cannot find a match

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git tags/led-fixes-for-5.1-rc3

for you to fetch changes up to 909346433064b8d840dc82af26161926b8d37558:

  leds: trigger: netdev: use memcpy in device_name_store (2019-03-30 19:09:32 +0100)

Thanks,
Jacek Anaszewski

----------------------------------------------------------------
LED fixes for 5.1-rc3
----------------------------------------------------------------
Kangjie Lu (1):
      leds: pca9532: fix a potential NULL pointer dereference

Rafał Miłecki (1):
      leds: trigger: netdev: fix refcnt leak on interface rename

Rasmus Villemoes (1):
      leds: trigger: netdev: use memcpy in device_name_store

 drivers/leds/leds-pca9532.c           |  8 ++++++--
 drivers/leds/trigger/ledtrig-netdev.c | 16 +++++++---------
 2 files changed, 13 insertions(+), 11 deletions(-)
