Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEC1C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32823206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bE8Cvb50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfLJPhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:37:42 -0500
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:53730 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727411AbfLJPhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:37:40 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 21414405E0;
        Tue, 10 Dec 2019 15:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1575992259; bh=fYuY0lyYqVPq+/KbacWe8P4uzxJ1IsIgZmjZKUwsUeo=;
        h=From:To:Cc:Subject:Date:From;
        b=bE8Cvb50ctNvJTv8ONaR0ziSsoWGdFlr4d0SeLDUx/4mQ3Ilmc5iXrEYAVNHQweog
         p0ntUaFjRp3ft9wkJBVkxMzPvKz1pqYRgkufGMWCbwkZ9NXYahiIGpJUYSEa3MsLx5
         dXAhg+bRyviaj8e27S+X92G+9Q3jKys2PYiITdTiX0HQ63AicK680Y+8jUXtxAFKul
         oacBoagqV0+wbwg8wsOdPqTzbe5npiUcD5GcOqmPRsHc2Ac9zunPWnadZFIzVBlCQQ
         tmG3QQSpw2xQzKKbchFJCgFdqQjK6/qaSkL3MQ5S2K0ZlawvtAmMx+VBOOHguMzItY
         UcK9HmM5/MldA==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9AAA5A005D;
        Tue, 10 Dec 2019 15:37:36 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 691303E2CC;
        Tue, 10 Dec 2019 16:37:36 +0100 (CET)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org
Cc:     Joao.Pinto@synopsys.com, bbrezillon@kernel.org,
        gregkh@linuxfoundation.org, wsa@the-dreams.de, arnd@arndb.de,
        broonie@kernel.org, Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [RFC 0/5] Introduce i3c device userspace interface
Date:   Tue, 10 Dec 2019 16:37:28 +0100
Message-Id: <cover.1575977795.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For today there is no way to use i3c devices from user space and
the introduction of such API will help developers during the i3c device
or i3c host controllers development.

The i3cdev module is highly based on i2c-dev and yet I tried to address
the concerns raised in [1].

NOTES:
- The i3cdev dynamically request an unused major number.

- The i3c devices are dynamically exposed/removed from dev/ folder based
  on if they have a device driver bound to it.

- For now, the module exposes i3c devices without device driver on
  dev/i3c-<bus>-<pid>, but we can change the path to
  dev/bus/i3c/<bus>-<pid> or dev/i3c/<bus>-<pid>.

- As in the i2c subsystem, here it is exposed the i3c_priv_xfer to
  userspace. I tried to use a dedicated structure as in spidev but I don't
  see any obvious advantage.

- Since the i3c API only exposes i3c_priv_xfer to devices, for now, the
  module just makes use of one ioctl(). This can change in the future with
  the introduction hdr commands or by the need of exposing some CCC
  commands to the device API (private contract between master-slave).
  Regarding the i3c device info, some information is already available
  through sysfs. We can add more device attributes to expose more
  information or add a dedicated ioctl() request for that purpose or both.

- Similar to i2c, I have also created a tool that you can find in [2]
  for testing purposes. If you have some time available I would appreciate
  your feedback about it as well.

[1] https://lkml.org/lkml/2018/11/15/853
[2] https://github.com/vitor-soares-snps/i3c-tools.git

Vitor Soares (5):
  i3c: master: export i3c_masterdev_type
  i3c: master: export i3c_bus_type symbol
  i3c: device: expose transfer strutures to uapi
  i3c: master: add i3c_for_each_dev helper
  i3c: add i3cdev module to expose i3c dev in /dev

 drivers/i3c/Kconfig             |  15 ++
 drivers/i3c/Makefile            |   1 +
 drivers/i3c/i3cdev.c            | 438 ++++++++++++++++++++++++++++++++++++++++
 drivers/i3c/internals.h         |   2 +
 drivers/i3c/master.c            |  16 +-
 include/linux/i3c/device.h      |  54 +----
 include/uapi/linux/i3c/device.h |  66 ++++++
 include/uapi/linux/i3c/i3cdev.h |  27 +++
 8 files changed, 565 insertions(+), 54 deletions(-)
 create mode 100644 drivers/i3c/i3cdev.c
 create mode 100644 include/uapi/linux/i3c/device.h
 create mode 100644 include/uapi/linux/i3c/i3cdev.h

-- 
2.7.4

