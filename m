Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B057BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7598220866
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="xlN+qgnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731483AbfCZP5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:57:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39697 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfCZP5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:57:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id j9so14984559wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 08:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U8XK9bJtLmBc8wuc/2NLzJPbbmbeGYQnogz6Wqi9Jds=;
        b=xlN+qgnkumGFZWVlsUI40paOXtXmV92SMhVj75rKaKHLl1WkXc6/3P86wZaU+N2hXA
         FF9xoHbrpD9UpT9pB4jZ5hEchFEh7gyhVBs6uYYui/Vz7GAI2Fmmpc6n1R396dN/04yS
         hXOMUXehWMp6Gw3KeXgTD5mCtxzvdN1iTMNCPkkvaDCNzyfoGKFL41ByeZUbuF2QP3EF
         htp64+szjgesZB+Y4kt85SxvjU9jBn7GPgpQqiqi15KjUXfTQj3TdBkjTyP7My4BlsQD
         4AjF09lzfhCzgBq0LCLFb5Zyz30cVQx7ugB6iGqscXglPZavF0IsRmzC7gRe5tJbkP2W
         hUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U8XK9bJtLmBc8wuc/2NLzJPbbmbeGYQnogz6Wqi9Jds=;
        b=i/gRZ60u/WxKUQTOxK5xY+Y8f1sGPdRyEBpunjaS333B5MDFqspDuk/brxRYqJzjrn
         iz+SKntkcGScw+bzJGtB4rrSZSMWxrBvbCvSwH/APFlndUmtZChdMzyDxdvAb/PoZjdh
         seDkDrguhTBZwg0Thp6vkEM7Q/IB86VXkI/dyO5wWv4xregtxv8syC0qGaI0ELE5URHx
         E8UEhUI4pTMp32SENovPUNOax8uhvSR3PG1SL1W8De5atY2BUiydsoSM6wuUcUl1JqdY
         HAisNUieRnUI5rYYiAQQBgXCKdlKrJ/Kz2+WHCV2eGgaoRO75wDzKahPtNfX4BHvIun+
         QNvg==
X-Gm-Message-State: APjAAAXmcO8p9ur9CQ63aXqkPcWp2y4O2IQIOPQ76AbCDOhqU8IMP5jy
        vteA3PBFUbS3DALtyZ5/naPLUw==
X-Google-Smtp-Source: APXvYqzssCJBB6F0S0Yl5ixsYuNZdS0wJg1e+EU4uSb3K2caVHnM7Y25UJvxYpUrkFFu6pWDD7FjDA==
X-Received: by 2002:adf:fec3:: with SMTP id q3mr21172620wrs.173.1553615855558;
        Tue, 26 Mar 2019 08:57:35 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id 204sm28522999wmc.1.2019.03.26.08.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 08:57:34 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/3] ARM: davinci: ohci-da8xx: model the vbus GPIO as a fixed regulator
Date:   Tue, 26 Mar 2019 16:57:25 +0100
Message-Id: <20190326155728.5432-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Adding the vbus GPIO support to the ohci-da8xx driver isn't really the
optimal solution. Rather: it should be modeled as a fixed regulator
in which case the driver already has support.

This series adds necessary fixups to the board files and removes the
vbus GPIO from the ohci driver.

Bartosz Golaszewski (3):
  ARM: davinci: omapl138-hawk: add a fixed regulator for ohci-da8xx
  ARM: davinci: da830-evm: add a fixed regulator for ohci-da8xx
  usb: ohci-da8xx: drop the vbus GPIO

 arch/arm/mach-davinci/board-da830-evm.c     | 48 +++++++++++++++++++--
 arch/arm/mach-davinci/board-omapl138-hawk.c | 48 +++++++++++++++++++--
 drivers/usb/host/ohci-da8xx.c               | 39 ++++++++---------
 3 files changed, 108 insertions(+), 27 deletions(-)

-- 
2.20.1

