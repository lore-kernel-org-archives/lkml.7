Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BB5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6363821902
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xv0uOkzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbfCUSlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:41:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33531 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbfCUSls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:41:48 -0400
Received: by mail-qt1-f194.google.com with SMTP id k14so7839112qtb.0;
        Thu, 21 Mar 2019 11:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tY6+2yg5kBlO2MGtS1RdpL8kEichnYOMAH7b32Qy3RY=;
        b=Xv0uOkzqllGXScY4vjGguqYLVr5w6YlrdB12LeF9KMC5TSmugoacp9q+r7J3azEZXQ
         UTTiGiL2kliydJyEwoKoALs64KgEUWxCNM5/Xq7c/Qxq4O7xRnVZMQOLSwMPnSfhgG+q
         xQ/Dw46vuInaXcf7VczZBqAydm68JBj6FCn+mtcuqoOIeo98jPA/wnCsCCCHuLKwgFEq
         U0bH+q2WWiAS53V5pmN1zAuxR3yMJF5SgWUtBvbKcFKQH0yLzhKUtyczVnhQrjC/3WZJ
         Rd5gVpLXjDWP2Yy2Domhu4BjGNV2232f2xrnHUKS+IzzfrzQCeSIHhQWpS7+98cxATGg
         VGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tY6+2yg5kBlO2MGtS1RdpL8kEichnYOMAH7b32Qy3RY=;
        b=pBhtkfznCoFS1AEcSQo4luLq5sNbiW+M7d/Obk7wXrBL+weJHjMEjOUore1PwA5Wof
         GKaZLkBUgrXQ5lLeHMMa1MoS/7iMRhFFzUDX6GeUnkm739qOTR86MGAEUR+F/Ux3KGCg
         9DcJcLMM5xHbk/UFPgb1NU2voQ+4aNV2L+wFPzDLgqzFNEJ1kNJk46R3ALzRCUsKKMP+
         Tb4KotYMFPjAquhKVXpBQx3lgi/J0FjwpkFWAF7TuJVQbnWNvASaO+XK6AaUZdFquqti
         YIAAeZK8B2+KrdS+65UoToPbWAI+JE8pJctUkE7eQunst0gs2zzQadu4l5B4HfBYe6Ii
         rgMA==
X-Gm-Message-State: APjAAAUmp9OKIxV+6+VSJONVjhO6/iHF07Xotgv9rDt6mWCF3BaHQ45s
        kPy/BYbJjLB4X1V2l4E+pmE=
X-Google-Smtp-Source: APXvYqxzjhFVm4s99YLvolN5QUmAWmBn9FwIuD2PdRLvvn2QaMVXC7jV7TsTUGsU9Hp9a8eAB1prBQ==
X-Received: by 2002:ac8:1489:: with SMTP id l9mr4264423qtj.267.1553193707492;
        Thu, 21 Mar 2019 11:41:47 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id a10sm3648694qti.32.2019.03.21.11.41.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Mar 2019 11:41:46 -0700 (PDT)
Date:   Thu, 21 Mar 2019 15:41:42 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        michael.hennerich@analog.com, stefan.popa@analog.com,
        alexandru.Ardelean@analog.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v5 0/2] staging: iio: ad5933: move out of staging
Message-ID: <cover.1553192834.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches makes device attributes' names equal to ABI
documentation and move ad5933 driver out of staging. More precisely:
It changes device attributes' names to match or be similar to existing
ABI.
It moves the ad5933 driver from staging directory to iio main drivers
directory.

Marcelo Schmitt (2):
  staging: iio: ad5933: change attributes to match ABI
  staging: iio: ad5933: move out of staging

 drivers/iio/Kconfig                           |   1 +
 drivers/iio/Makefile                          |   1 +
 drivers/iio/impedance-analyzer/Kconfig        |  18 +
 drivers/iio/impedance-analyzer/Makefile       |   5 +
 drivers/iio/impedance-analyzer/ad5933.c       | 811 ++++++++++++++++++
 drivers/staging/iio/Kconfig                   |   1 -
 drivers/staging/iio/Makefile                  |   1 -
 .../staging/iio/impedance-analyzer/Kconfig    |  18 -
 .../staging/iio/impedance-analyzer/Makefile   |   5 -
 .../staging/iio/impedance-analyzer/ad5933.c   | 811 ------------------
 10 files changed, 836 insertions(+), 836 deletions(-)
 create mode 100644 drivers/iio/impedance-analyzer/Kconfig
 create mode 100644 drivers/iio/impedance-analyzer/Makefile
 create mode 100644 drivers/iio/impedance-analyzer/ad5933.c
 delete mode 100644 drivers/staging/iio/impedance-analyzer/Kconfig
 delete mode 100644 drivers/staging/iio/impedance-analyzer/Makefile
 delete mode 100644 drivers/staging/iio/impedance-analyzer/ad5933.c

-- 
2.20.1

