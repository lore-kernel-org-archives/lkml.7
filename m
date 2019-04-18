Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE26C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BBD2183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388435AbfDRJYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:24:02 -0400
Received: from thoth.sbs.de ([192.35.17.2]:50604 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbfDRJYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:24:02 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id x3I9NoSs005077
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Apr 2019 11:23:50 +0200
Received: from md1f2u6c.ad001.siemens.net (md1q0hnc.ad001.siemens.net [139.25.68.37] (may be forged))
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x3I9NoXc030948;
        Thu, 18 Apr 2019 11:23:50 +0200
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org
Subject: [PATCH 0/2] gpio: sch: Interrupt support
Date:   Thu, 18 Apr 2019 11:23:47 +0200
Message-Id: <cover.1555579429.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

See patches for details.

Two things I'm not 100% sure about:
 - Should we enable interrupts for all sch variants the driver support,
   or only the Quark where I was able to validate it (and where I found
   documentation for)?

 - Is there a better way to hook into the SCI? Yes, GPIO events will
   also set a bit in GPE0_STS, but there is no ACPI description for that
   event on our IOT2000 platform and, thus, also the original Galileo
   Gen2.

Jan

Jan Kiszka (2):
  gpio: sch: Remove write-only core_base
  gpio: sch: Add interrupt support

 drivers/gpio/gpio-sch.c | 147 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 135 insertions(+), 12 deletions(-)

-- 
2.16.4

