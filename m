Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0458FC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86AB217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfH3SuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 14:50:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:40430 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727940AbfH3SuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 14:50:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 611B6AD35;
        Fri, 30 Aug 2019 18:50:17 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] W1 drivers for devices used in SGI systems
Date:   Fri, 30 Aug 2019 20:50:05 +0200
Message-Id: <20190830185008.3177-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add two W1 drivers. One is a driver for the W1 master in
SGI ASICs, which is used in various machine starting with SGI Origin systems. 
The other is a W1 slave driver for Dallas/Maxim EPROM devices used
in the same type of SGI machines.

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
 include/linux/platform_data/sgi-w1.h |  15 ++
 include/linux/w1.h                   |   5 +
 8 files changed, 457 insertions(+)
 create mode 100644 drivers/w1/masters/sgi_w1.c
 create mode 100644 drivers/w1/slaves/w1_ds250x.c
 create mode 100644 include/linux/platform_data/sgi-w1.h

-- 
2.13.7

