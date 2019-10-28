Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E546BCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B846620717
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572268678;
	bh=NbPrpNWukhwArDUUIISrsPsSj3KaIzOulncG5+Yab5Y=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=ekyUK2hQto7lnc1g5Xe6ufT9HSt/DZ/ArN2OCxWuzs3yd1JpffkPhHcokGicoxeP0
	 wg1BQMvjZtIpI8XlCIbWZi1USab7USFIH2kI32l/40Bw4FnaEZE04m1jjPF8owZVch
	 TriZbRrh8C5ebQaFKU5ZNpC04XU0UzOSxocsCymg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388808AbfJ1NR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 09:17:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfJ1NR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 09:17:57 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 711D720650;
        Mon, 28 Oct 2019 13:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572268676;
        bh=NbPrpNWukhwArDUUIISrsPsSj3KaIzOulncG5+Yab5Y=;
        h=Date:From:To:cc:Subject:From;
        b=T/dfpVBxamwNNfI4CiEuzohQg0Ls7AmReY0dj1VhXk3sB6CbXaBqsbGOUnqU7Nrja
         5dTD5JfMPtb95SMUV7ICp2YAidW5TnkkS87v7UYrwl35PgdtC9KJOELfOvIMfL2tPo
         qZ6exzIxGYPxCp2GCCMfs4SwESEGcY6/NDkQCoAs=
Date:   Mon, 28 Oct 2019 14:17:53 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes for 5.4
Message-ID: <nycvar.YFH.7.76.1910281411130.13160@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive fixes for HID subsystem:

=====
- HID++ device support regression fixes (race condition during cleanup, 
  device detection fix, opps fix) from Andrey Smirnov
- disable PM on i2c-hid, as it's causing problems with a lot of devices;
  other OSes apparently don't implement/enable it either; from Kai-Heng 
  Feng
- error handling fix in intel-ish driver, from Zhang Lixu
- syzbot fuzzer fix for HID core code from Alan Stern
- a few other tiny fixups (printk message cleanup, new device ID)
=====

Thanks.

----------------------------------------------------------------
Alan Stern (1):
      HID: Fix assumption that devices have inputs

Andrey Smirnov (3):
      HID: logitech-hidpp: split g920_get_config()
      HID: logitech-hidpp: rework device validation
      HID: logitech-hidpp: do all FF cleanup in hidpp_ff_destroy()

Colin Ian King (1):
      HID: prodikeys: make array keys static const, makes object smaller

Hans de Goede (1):
      HID: i2c-hid: add Trekstor Primebook C11B to descriptor override

Kai-Heng Feng (1):
      HID: i2c-hid: Remove runtime power management

Micha³ Miros³aw (1):
      HID: fix error message in hid_open_report()

Nicolas Boichat (1):
      HID: google: add magnemite/masterball USB ids

Zhang Lixu (1):
      HID: intel-ish-hid: fix wrong error handling in ishtp_cl_alloc_tx_ring()

 drivers/hid/hid-axff.c                           |  11 +-
 drivers/hid/hid-core.c                           |   7 +-
 drivers/hid/hid-dr.c                             |  12 +-
 drivers/hid/hid-emsff.c                          |  12 +-
 drivers/hid/hid-gaff.c                           |  12 +-
 drivers/hid/hid-google-hammer.c                  |   4 +
 drivers/hid/hid-holtekff.c                       |  12 +-
 drivers/hid/hid-ids.h                            |   2 +
 drivers/hid/hid-lg2ff.c                          |  12 +-
 drivers/hid/hid-lg3ff.c                          |  11 +-
 drivers/hid/hid-lg4ff.c                          |  11 +-
 drivers/hid/hid-lgff.c                           |  11 +-
 drivers/hid/hid-logitech-hidpp.c                 | 248 +++++++++++++----------
 drivers/hid/hid-microsoft.c                      |  12 +-
 drivers/hid/hid-prodikeys.c                      |   4 +-
 drivers/hid/hid-sony.c                           |  12 +-
 drivers/hid/hid-tmff.c                           |  12 +-
 drivers/hid/hid-zpff.c                           |  12 +-
 drivers/hid/i2c-hid/i2c-hid-core.c               | 118 +----------
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c         |  19 ++
 drivers/hid/intel-ish-hid/ishtp/client-buffers.c |   2 +-
 21 files changed, 297 insertions(+), 259 deletions(-)

-- 
Jiri Kosina
SUSE Labs

