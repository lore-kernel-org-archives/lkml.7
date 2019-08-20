Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07358C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C430E22CE3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566305640;
	bh=El6gxGVQTI7lrwE2rbA4weHEK0dx+FjLVF6pha4hx+Q=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=BorRW6kep7U4d81QljEfP2iah7LR+smkCa6ZdTsGtrc4pYMevja6dI8H5EhukfelG
	 Amir/jw4/qileQzQWM40r2gSEvyGY26bIGFrA0W77LSX1Wh0ehNRqlKx4x1SXIGXFO
	 r6Cw2ohvDVNBg6JFsmL10lXVKKqHDHv6wYxjWO38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfHTMx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:53:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729137AbfHTMx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:53:59 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D45522CE3;
        Tue, 20 Aug 2019 12:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566305638;
        bh=El6gxGVQTI7lrwE2rbA4weHEK0dx+FjLVF6pha4hx+Q=;
        h=Date:From:To:cc:Subject:From;
        b=YYd8lOiYWRgc1Q6vH7tyuE3UiLAkc+kSIF7RzMrri/no+TAFFyuE7Tz3wi3k/9Hzh
         FN6p6/oe9iLzWV83c4yB+T8NQ9VO8qWNh92JrBkd3IWTLSuCdNZt1EKpnNWlAorBL4
         OwKCcsUI/t8rhO9XNQPqevaqhsykRVwDg0tEGqH0=
Date:   Tue, 20 Aug 2019 14:53:48 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.1908201449220.27147@cbobk.fhfr.pm>
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

to receive HID subsystem fixes:

=====
- a few regression fixes for wacom driver (including fix for my earlier 
  mismerge) from Aaron Armstrong Skomra and Jason Gerecke
- revert of a few Logitech device ID additions which turn out to not work 
  perfectly with the hidpp driver at the moment; proper support is now 
  scheduled for 5.4. Fixes from Benjamin Tissoires
- scheduling-in-atomic fix for cp2112 driver, from Benjamin Tissoires
- new device ID to intel-ish, from Even Xu
=====

Thanks.

----------------------------------------------------------------
Aaron Armstrong Skomra (2):
      HID: wacom: add back changes dropped in merge commit
      HID: wacom: correct misreported EKR ring values

Benjamin Tissoires (3):
      Revert "HID: logitech-hidpp: add USB PID for a few more supported mice"
      HID: logitech-hidpp: remove support for the G700 over USB
      HID: cp2112: prevent sleeping function called from invalid context

Even Xu (1):
      HID: intel-ish-hid: ipc: add EHL device id

Jason Gerecke (1):
      HID: wacom: Correct distance scale for 2nd-gen Intuos devices

 drivers/hid/hid-cp2112.c                |  8 ++++++--
 drivers/hid/hid-logitech-hidpp.c        | 22 ----------------------
 drivers/hid/intel-ish-hid/ipc/hw-ish.h  |  1 +
 drivers/hid/intel-ish-hid/ipc/pci-ish.c |  1 +
 drivers/hid/wacom_wac.c                 |  7 +++++--
 5 files changed, 13 insertions(+), 26 deletions(-)

-- 
Jiri Kosina
SUSE Labs

