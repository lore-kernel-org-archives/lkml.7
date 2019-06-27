Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56D9C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807EE2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561628272;
	bh=KmiOKWu+8QexJ8lPQPqypYPtnrqM0EvVEE0r/tGHZuk=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=PZ5xGncLzkB796kzzuLLbRA2/Xe1R08ncAZcx0xu/+c3C39AvttG4bWwxH6SpnruG
	 nsL18SYkSzf7CNjh1EepUlARc+FST6IGi0aC26lQJfIzYV0da5LLlzv2fIDjLkuTj0
	 LV9HtE/StQ4k17h7+7WWRymNgs8v/1LTg6qBw1qA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfF0Jhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 05:37:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfF0Jhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 05:37:51 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CF922080C;
        Thu, 27 Jun 2019 09:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561628269;
        bh=KmiOKWu+8QexJ8lPQPqypYPtnrqM0EvVEE0r/tGHZuk=;
        h=Date:From:To:cc:Subject:From;
        b=ifQLNdv7IH5Y/95hr6IZtn197cWgaG5bPsuTzxQhfdOUfUB01ktJz4v60ppxSMKTH
         /BSB4yKT11hKgMvjC+wB2f+PsRijJthwbdeQjiSfh59ZQ2WKMl8xsoqszkwjhSijpy
         HI5QvankQ9gLq/j2cZkoAq9qqhk7k4e1li6Z6cEg=
Date:   Thu, 27 Jun 2019 11:37:47 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.1906271134320.27227@cbobk.fhfr.pm>
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

to receive the following fixes for HID subsystem:

=====
- fix for one corner case in HID++ protocol with respect to handling very 
  long reports, from Hans de Goede
- power management fix in Intel-ISH driver, from Hyungwoo Yang
- use-after-free fix in Intel-ISH driver, from Dan Carpenter
- a couple of new device IDs/quirks from Kai-Heng Feng, Kyle Godbey and 
  Oleksandr Natalenko
=====

Thanks.

----------------------------------------------------------------
Dan Carpenter (1):
      HID: intel-ish-hid: Fix a use after free in load_fw_from_host()

Hans de Goede (1):
      HID: logitech-dj: Fix forwarding of very long HID++ reports

Hyungwoo Yang (1):
      HID: intel-ish-hid: fix wrong driver_data usage

Kai-Heng Feng (1):
      HID: multitouch: Add pointstick support for ALPS Touchpad

Kyle Godbey (1):
      HID: uclogic: Add support for Huion HS64 tablet

Oleksandr Natalenko (1):
      HID: chicony: add another quirk for PixArt mouse

 drivers/hid/hid-ids.h                        |  3 +++
 drivers/hid/hid-logitech-dj.c                |  4 +++-
 drivers/hid/hid-multitouch.c                 |  4 ++++
 drivers/hid/hid-quirks.c                     |  1 +
 drivers/hid/hid-uclogic-core.c               |  2 ++
 drivers/hid/hid-uclogic-params.c             |  2 ++
 drivers/hid/intel-ish-hid/ishtp-fw-loader.c  |  2 +-
 drivers/hid/intel-ish-hid/ishtp-hid-client.c |  4 ++--
 drivers/hid/intel-ish-hid/ishtp/bus.c        | 15 ++++++++++++++-
 include/linux/intel-ish-client-if.h          |  1 +
 10 files changed, 33 insertions(+), 5 deletions(-)

-- 
Jiri Kosina
SUSE Labs

