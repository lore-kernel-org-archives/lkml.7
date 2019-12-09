Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00848C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C782720637
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575919998;
	bh=WvB6y6a/PlnU6VTvcvNynAcuEUjynaIwZgYnlQb28R8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=CEq/IbJu3fqCDAsOfV/Qp0konUBF/Jhx5MtJTSYqUgPP1ajlFcEQTviNG4r3Oyk4m
	 CT9HDz34qHfHRqMmKwChQ6pLELrXeKZZj0d6onh+HS/bqUGW4Wy2dRHgJLYUusTnNv
	 3K/FhEDGBQdhMGMqT+tadx8jSqWeQPvEZJroqb2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfLITdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:33:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfLITdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 14:33:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AA5620637;
        Mon,  9 Dec 2019 19:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575919995;
        bh=WvB6y6a/PlnU6VTvcvNynAcuEUjynaIwZgYnlQb28R8=;
        h=From:To:Cc:Subject:Date:From;
        b=qPTBQlQEZsVbQ3NKx1F1mgmCk57b4sCu5+fN/qsh3dGz8skDfoJem2PSbSJsaEfcR
         KaB+3pEOj0MMjyxVolHEBPrVEfkDLWk6ou7l5DyPdz0LrqTPx+t3uhD90Bn3BIZBEH
         WXhViwqUXXh4sJHDBU/HBoV8Y6nMzmANOoEkb75g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 0/6] device.h: split up into smaller pieces
Date:   Mon,  9 Dec 2019 20:32:57 +0100
Message-Id: <20191209193303.1694546-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the 5.4-rc merge Linus complained about the size of device.h and
how it can be a pain to merge things into at times.  It's also become
kind of a "kitchen sink" for anything related to drivers / devices /
busses / classes and is the 10th largest include/linux/*.h file by size.

So let's split it up into smaller pieces, moving things out by logical
parts where it can be.

Greg Kroah-Hartman (6):
  drivers/base: base.h: add proper copyright and header info
  device.h: move devtmpfs prototypes out of the file
  device.h: move dev_printk()-like functions to dev_printk.h
  device.h: move 'struct bus' stuff out to device/bus.h
  device.h: move 'struct class' stuff out to device/class.h
  device.h: move 'struct driver' stuff out to device/driver.h

 drivers/base/base.h           |  19 +
 drivers/base/bus.c            |   1 +
 drivers/base/class.c          |   1 +
 drivers/base/driver.c         |   1 +
 include/linux/dev_printk.h    | 235 ++++++++
 include/linux/device.h        | 999 +---------------------------------
 include/linux/device/bus.h    | 288 ++++++++++
 include/linux/device/class.h  | 266 +++++++++
 include/linux/device/driver.h | 292 ++++++++++
 init/main.c                   |   2 +-
 10 files changed, 1108 insertions(+), 996 deletions(-)
 create mode 100644 include/linux/dev_printk.h
 create mode 100644 include/linux/device/bus.h
 create mode 100644 include/linux/device/class.h
 create mode 100644 include/linux/device/driver.h

-- 
2.24.0

