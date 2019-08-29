Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4724AC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 04:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F002173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 04:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Uh5zy1yM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfH2Ewm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 00:52:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35578 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfH2Ewl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 00:52:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id n4so923474pgv.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 21:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=9BP8IKO9876WFktChuLK9za6HwiWbIKNndRGikQ4ROo=;
        b=Uh5zy1yMA01siESv2fEqBla8M/nR0OowkWsBwqqE82PoMyHAPnWOnDb3djdGkZkH7r
         VqAi0Kn4O3nnSsLBRQ3nyJw34XDQXVqU1OfCVdFcVsJEdvISc2fcK3MswoeEdiZrxEWa
         HNuHqQARuq142x31v+ris4wa93EeQ/7bbif3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9BP8IKO9876WFktChuLK9za6HwiWbIKNndRGikQ4ROo=;
        b=lafaLqtTQdASyw0KUoXF+5c3sS/0yS9bYkO6EPrqPhAQX15GaTkr33gF5fMeoC7nKI
         tgA1WKfPTW6TBqnOwv2ViGiRsqNq/HMFpcc+XFPVMYUA4z9pvQdjX89ATuK+EjbnDAq3
         vNuaAf5SA3YLOHPymVEmeS3Olis9jJOk8XlakuEvaoB35u4QME8etJjgR8iVGhu5tZkL
         MlCdUytGLNPByPE7udbDoN/QAJ20Ub93zFBjQYOSiszBE1bpQB55DJ/V4FPX7WbXYNHw
         mGYOu2Zvc/baS3noLAQeIDa0mvGvrlve6piwHIzCOLWqRlljCurIkHduGvLxnUVc1EFB
         yBVQ==
X-Gm-Message-State: APjAAAXIT/ccoHWWfbxbFRVv4jrcmEXvgJwi4R+O6rLvE1PTzubm9fhb
        4H/aBnEGm6Cd0yPvee6PYVNkXA==
X-Google-Smtp-Source: APXvYqzMjw2uesiactM9pV9vgKy+02kV2TdNBike0XLPF3rAF5krhaPNeJZWfvdb3HUuUDwJHxI5ww==
X-Received: by 2002:aa7:9a81:: with SMTP id w1mr9019225pfi.24.1567054360720;
        Wed, 28 Aug 2019 21:52:40 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id j1sm1131440pfh.174.2019.08.28.21.52.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 21:52:39 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH 0/2] Add fixes to iProc GPIO driver
Date:   Thu, 29 Aug 2019 10:22:26 +0530
Message-Id: <1567054348-19685-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the following fixes to the iProc GPIO driver
 - Fix Warning message given for shared irqchip data structure
 - Fix pinconfig of pull-up/down and drive strength for AON/CRMU GPIOs

This patch set is based on Linux-5.2-rc4.

Changes from v1:
  - Add Fixes tags in both patches

Li Jin (1):
  gpio: iproc-gpio: Fix incorrect pinconf configurations

Rayagonda Kokatanur (1):
  gpio: iproc-gpio: Handle interrupts for multiple instances

 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c | 117 +++++++++++++++++++++++--------
 1 file changed, 88 insertions(+), 29 deletions(-)

-- 
2.7.4

