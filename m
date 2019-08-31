Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85188C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 08:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A8A23431
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 08:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfHaI0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 04:26:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:52486 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726143AbfHaI0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 04:26:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF3F3AAB2;
        Sat, 31 Aug 2019 08:26:31 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] W1 drivers for devices used in SGI systems
Date:   Sat, 31 Aug 2019 10:26:20 +0200
Message-Id: <20190831082623.15627-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add two W1 drivers. One is a driver for the W1 master in
SGI ASICs, which is used in various machine starting with SGI Origin systems. 
The other is a W1 slave driver for Dallas/Maxim EPROM devices used
in the same type of SGI machines.

Changes in v3:
- dropped include of asm/sn/types.h which isn't needed at all

Changes in v2:
- added documentation about dev_id field in include/linux/w1.h
- use PTR_ERR_OR_ZERO

Thomas Bogendoerfer (2):
  w1: add 1-wire master driver for IP block found in SGI ASICs
  w1: add DS2501, DS2502, DS2505 EPROM device driver

 drivers/w1/masters/Kconfig           |   9 ++
 drivers/w1/masters/Makefile          |   1 +
 drivers/w1/masters/sgi_w1.c          | 130 ++++++++++++++++
 drivers/w1/slaves/Kconfig            |   6 +
 drivers/w1/slaves/Makefile           |   1 +
 drivers/w1/slaves/w1_ds250x.c        | 290 +++++++++++++++++++++++++++++++++++
 include/linux/platform_data/sgi-w1.h |  13 ++
 include/linux/w1.h                   |   5 +
 8 files changed, 455 insertions(+)
 create mode 100644 drivers/w1/masters/sgi_w1.c
 create mode 100644 drivers/w1/slaves/w1_ds250x.c
 create mode 100644 include/linux/platform_data/sgi-w1.h

-- 
2.13.7

