Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2679C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CA220665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uslUty3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbfGOVV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:21:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37058 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730076AbfGOVV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:21:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id g15so8323333pgi.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 14:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fmsNiLEERXvMNEkMF4DKaj6uDO68SFZu7uOSDCmxCzo=;
        b=uslUty3yGjg45QbsWNdTPjfTC4X9/T3RQMzsVcI+VFvMtueaB9HdsYsSP1gtUjjUtx
         te+oGYG2IrFlVrfgHC3FO6A5OFRxslrG+xNUgUexhcW4DvG3locEGsWA73tgfebT3w7p
         xW2apE1Uafk5uyPD0DTHKmGUupF1kxPNTuD9KGw8pPK2gCq22JXaTsPZAvjnIKB9nbJv
         VWhkJkFUYNhWFjuKvDAnvEcUSb4Ea8H21jTBZpc8pCFx0VSC3mHARGsmSg/36H5/tRDD
         +PLCVwdJw4VC8WRtuRURg3izngjSd0+Rl4iSRMJjjuFgNkGjR0VQO131hKumxddQf6XZ
         FlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fmsNiLEERXvMNEkMF4DKaj6uDO68SFZu7uOSDCmxCzo=;
        b=WlkbJkAqnmjYbAcKZE0hUyzP43Z4fZeUeVnQzHDH1ctO3t5OpaK840LHZUMw5e6foi
         l/mz9jULXqPeqHfNlOLL5eXb8EqAUvc1uE2NeamsOryX6Xu6IH359Drk0Vh2vegSNS/a
         cO9wrMzgjfML5/540iTPep7MZWpibi+TKxxeFApbm0Mw4dCjdMZhRo0F58LckdLVwEbi
         Ww5VfT3jvEayJVP3WkOjHedl2YWGlSbSZZELEgDNGeJjv0aydofN121KzwUad78Vblfc
         yaRJ31iha5uPwPFcGgSFLVb8N5I/7B+d+zbPRuhKoWpGndqokcNX8gS/yxsHDVICEch/
         Kj4A==
X-Gm-Message-State: APjAAAXvhXVizErMcK7Mp6G5PwzQ+dunRu8yRwj988M8YMFYBg+ZUbXt
        qX5di5h+ZTlKX1pHffk/5Og=
X-Google-Smtp-Source: APXvYqy3idPED1nlqnc1hI1fzbHolrg3a8piOv3LPqasFqJ8bSvq5eRyEJEK0+yeTa5iVonyKcU/Wg==
X-Received: by 2002:a65:6256:: with SMTP id q22mr28908488pgv.408.1563225687129;
        Mon, 15 Jul 2019 14:21:27 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id b6sm16820322pgq.26.2019.07.15.14.21.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 14:21:26 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>,
        Geordan Neukum <gneukum1@gmail.com>,
        Jeremy Sowden <jeremy@azazel.net>,
        Vandana BN <bnvandana@gmail.com>, devel@driverdev.osuosl.org,
        Bharath Vedartham <linux.bhar@gmail.com>
Subject: [PATCH 0/1] staging: kpc2000: whitespace and line length cleanup
Date:   Mon, 15 Jul 2019 14:21:22 -0700
Message-Id: <20190715212123.432-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Hi everyone,

This is an easy, drive-by cleanup that I did while reviewing Bharath's
changes to convert over to put_user_page(). It should make the code less
obviously non-conforming, and therefore help future reviews and cleanups.

This is on top of latest linux.git, commit fec88ab0af97 ("Merge tag
'for-linus-hmm' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma"),
and it does NOT have Bharath's patch applied, so it conflicts (but should
be trivial to resolve, regardless of which is applied first, as it's just
whitespace).

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Simon Sandström <simon@nikanor.nu>
Cc: Geordan Neukum <gneukum1@gmail.com>
Cc: Jeremy Sowden <jeremy@azazel.net>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Vandana BN <bnvandana@gmail.com>
Cc: devel@driverdev.osuosl.org
Cc: Bharath Vedartham <linux.bhar@gmail.com>

John Hubbard (1):
  staging: kpc2000: whitespace and line length cleanup

 drivers/staging/kpc2000/kpc2000_i2c.c         | 189 +++++++++++------
 drivers/staging/kpc2000/kpc2000_spi.c         | 116 +++++-----
 drivers/staging/kpc2000/kpc_dma/dma.c         | 109 ++++++----
 drivers/staging/kpc2000/kpc_dma/fileops.c     | 199 +++++++++++-------
 .../staging/kpc2000/kpc_dma/kpc_dma_driver.c  | 113 +++++-----
 .../staging/kpc2000/kpc_dma/kpc_dma_driver.h  | 154 +++++++-------
 6 files changed, 507 insertions(+), 373 deletions(-)

-- 
2.22.0

