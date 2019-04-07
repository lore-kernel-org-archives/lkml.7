Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5061C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 18:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B6E213F2
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 18:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpa9LRuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfDGSZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 14:25:25 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38999 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfDGSZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 14:25:25 -0400
Received: by mail-lf1-f66.google.com with SMTP id m13so7785911lfb.6;
        Sun, 07 Apr 2019 11:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wDIsYYOrvxhZ9kzb7SJ7T2luie5cJmB0gvybJw+O/2s=;
        b=jpa9LRujzVBLOut5d1ZVrKKllZZ75U0cz5q2XphqKoupK7hgI7+Jy94xxu/SvOb19P
         guB/HMOhAks6AGxSbB/3fixaMYsolAzI90OJC1JKRXWRM049JMjznb8cSQizNwYTkele
         USmeu2gcvq7rwED/Tb3lgB5QLTMBCyWDZ6j7dSdtNKlkwd3e1035OalhXi2ADqQP+TXc
         Dy41sSga0hzU01fHEIUmmRqXxe+nJtl6ylyuasaiLoFCqjfhsVFauO9Vpj54cZeFFn6I
         TSfWnBCqPZvoFnh9ByYNmoL2jS9vJGxQPVEZkE+qzfN6c0dY2COixMQeGRJujwc/ix7V
         We/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wDIsYYOrvxhZ9kzb7SJ7T2luie5cJmB0gvybJw+O/2s=;
        b=GQPKNHBc5nYKS5rX2cHMNf/gGbOd/3ScJWrMK+ow82MZLrgCTrJbMV+NT1PpuQhr/I
         hc3iniRQGEZrkst8Rwu1B04vUATfl8YV799Ejqr6r26yaN95YwmKSocuIN8sJKbmQ+zR
         pA0yzTh8xTHCynxbXF2HbzRU6gVyGuvWupHbim/NA8X6xK8cSwuNqR5Do4Rq6yRlvtaU
         JGyWJVtiJtxakOL1I139aMGGveWYeME9iuYww+xnP6CBq34e0U4Pm4Pj86hsKBdooStL
         u4gsBpQYyJfcAGqpQXqhPomMSgaEZ0bOJTBrxT1P8CTehDd4llTrDpvGSEtTBdDgd1X3
         i/bA==
X-Gm-Message-State: APjAAAUw1LqMXlaqhSnkaA2is//bQqRjX/h2miJmI+0tcTzFybDNdhQH
        hstr6V8hejmK1AeO9vb4jQk=
X-Google-Smtp-Source: APXvYqza5brr3Ko2Re4d8WD03r0O0u7fSZwx4HLMqQ90Q63De4ZJ7cA4tZXISWt41c092v7GDnyegQ==
X-Received: by 2002:ac2:4839:: with SMTP id 25mr4359256lft.85.1554661523353;
        Sun, 07 Apr 2019 11:25:23 -0700 (PDT)
Received: from myhost.home (bkw193.neoplus.adsl.tpnet.pl. [83.28.190.193])
        by smtp.gmail.com with ESMTPSA id x6sm5636706lfe.67.2019.04.07.11.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 11:25:22 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     lee.jones@linaro.org, tony@atomide.com
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        jacek.anaszewski@gmail.com
Subject: [GIT PULL] LM3532 backlight support improvements and relocation
Date:   Sun,  7 Apr 2019 20:25:14 +0200
Message-Id: <20190407182514.15427-2-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190407182514.15427-1-jacek.anaszewski@gmail.com>
References: <20190407182514.15427-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git tags/lm3532-driver-improvements

for you to fetch changes up to b3e9d18dc4a5e4d329dea32b59bdde5e012ae64a:

  leds: lm3532: Introduce the lm3532 LED driver (2019-04-06 21:06:07 +0200)

Thanks,
Jacek Anaszewski

----------------------------------------------------------------
LM3532 backlight driver improvements and relocation.
----------------------------------------------------------------
Dan Murphy (4):
      dt: lm3532: Add lm3532 dt doc and update ti_lmu doc
      ARM: dts: omap4-droid4: Update backlight dt properties
      mfd: ti-lmu: Remove LM3532 backlight driver references
      leds: lm3532: Introduce the lm3532 LED driver

 .../devicetree/bindings/leds/leds-lm3532.txt       | 101 +++
 Documentation/devicetree/bindings/mfd/ti-lmu.txt   |  20 -
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |  27 +-
 drivers/leds/Kconfig                               |  10 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-lm3532.c                         | 683 +++++++++++++++++++++
 drivers/mfd/ti-lmu.c                               |  11 -
 include/linux/mfd/ti-lmu-register.h                |  44 --
 include/linux/mfd/ti-lmu.h                         |   1 -
 9 files changed, 813 insertions(+), 85 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3532.txt
 create mode 100644 drivers/leds/leds-lm3532.c
