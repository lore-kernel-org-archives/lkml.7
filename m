Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40400C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013D42075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554298764;
	bh=LM8rm/6DR75PeaE3f4EJR+ywSgqlgBvMry0dFyBJsH8=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=gFSTrx79K7WpJROLQ08ytZjysAJyB/Yba/rKsQiR7ox0qfzm1mIlgYqiDM9UswQbU
	 gU13v3ZpzecKH3XfEHClkMf3seNc+fJv76Cd30fWpiRGp/Q2BzJzFalPeyBrYlYMaF
	 /pUZoDZIcTzCX1qltaS20sluBZs7sfQsHbgTfOXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfDCNjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:39:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfDCNjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:39:22 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 739C02075E;
        Wed,  3 Apr 2019 13:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554298761;
        bh=LM8rm/6DR75PeaE3f4EJR+ywSgqlgBvMry0dFyBJsH8=;
        h=Date:From:To:cc:Subject:From;
        b=s9CYtrMSKwnpAaIF43zgcLCZ3DMubltsC9oT9hhXpVQ9jSw49I8havfrQbAw0Q4Zr
         7HcSDfGexsoELPTnxvghjjeegMtFlXsQL6Ztp4GQ7wqnjbWLbNV7HMmUjZodofBX8J
         +PS/cx7dOMsranYLVq3Fue9XAnB97D27o+ignhns=
Date:   Wed, 3 Apr 2019 15:39:18 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.1904031532431.9803@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive HID fixes:

=====
- build dependency fix for hid-asus from Arnd Bergmann
- addition of omitted mapping of _ASSISTANT key from Dmitry Torokhov
- race condition fix in hid-debug inftastructure from He, Bo
- fixed support for devices with big maximum report size from Kai-Heng 
  Feng
- deadlock fix in hid-steam from Rodrigo Rivas Costa
- quite a few device-specific quirks
=====

Thanks.

----------------------------------------------------------------
Andy Shevchenko (1):
      HID: quirks: Drop misused kernel-doc annotation

Arnd Bergmann (1):
      HID: hid-asus: select CONFIG_POWER_SUPPLY

Colin Ian King (1):
      HID: uclogic: remove redudant duplicated null check on ver_ptr

Dmitry Torokhov (1):
      HID: input: add mapping for Assistant key

He, Bo (1):
      HID: debug: fix race condition with between rdesc_show() and device removal

Hui Wang (1):
      HID: i2c-hid: Disable runtime PM on Synaptics touchpad

Jeffrey Hugo (1):
      HID: quirks: Fix keyboard + touchpad on Lenovo Miix 630

Kai-Heng Feng (1):
      HID: Increase maximum report size allowed by hid_field_extract()

Kangjie Lu (1):
      HID: logitech: check the return value of create_singlethread_workqueue

Louis Taylor (1):
      HID: quirks: use correct format chars in dbg_hid

Peter Hutterer (1):
      HID: logitech: Handle 0 scroll events for the m560

Rodrigo Rivas Costa (1):
      HID: steam: fix deadlock with input devices.

 drivers/hid/Kconfig                |  1 +
 drivers/hid/hid-core.c             |  6 +++---
 drivers/hid/hid-debug.c            |  5 +++++
 drivers/hid/hid-ids.h              |  1 +
 drivers/hid/hid-input.c            |  1 +
 drivers/hid/hid-logitech-hidpp.c   | 13 ++++++++++---
 drivers/hid/hid-quirks.c           | 11 +++++++----
 drivers/hid/hid-steam.c            | 26 +++++++++++++++++++-------
 drivers/hid/hid-uclogic-params.c   |  4 ----
 drivers/hid/i2c-hid/i2c-hid-core.c |  2 ++
 10 files changed, 49 insertions(+), 21 deletions(-)

-- 
Jiri Kosina
SUSE Labs

