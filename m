Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AB6C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B592084B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B2tUetSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732306AbfFYRk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 13:40:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46776 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfFYRk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 13:40:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id v9so9279871pgr.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 10:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ux77FZ9CHBjOrnDI3EGePYwTHmJ+z3DID4gfNoVBXXI=;
        b=B2tUetSMchtGW/+SGYLyVgEoxEsQnGMalqfzkjRhSWLa2CAkg9rIOWI2GrJouCvBmJ
         8SSoFbzPRXkulByCc5u2YTkbxzk3N/RPcIhBo+OM3Jz9vXdGLPi+TvGlOLoAMx10+WlV
         P/0Y1ECcoF74A7rb/2nxql5xDRiDJ7zW4eJ5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ux77FZ9CHBjOrnDI3EGePYwTHmJ+z3DID4gfNoVBXXI=;
        b=KJepflNa4AUSobWWZbDVvFetkdedWB0umkRs3leoBbNBZ3z9lpgZ3ralJqqfVs6S7s
         4w3/CUEJFUQbcmO2FYjeB67CSQ+vHJgErz1SidDmnxS6QH+PfvzGEvUtjIdZ5JkMTG3N
         cBZuDhY3dFW7j/68Olp1zunzpIXrC097BYof/cyBJXFrG2zeGpZR/OHgWpPA+ZXkGvOX
         g5MnnwgooVC+FgqeFCFf+BJ9LtmslOC3TTM79FjBaPM1hbECn8olrl4INvDykwzda9/C
         fBgsZ42cSyMscvbS9aaCZJy+owAXyUh0weU7rVKjVaEfqM3bBU5kUUVC6QJy/EqwO3x5
         vX1Q==
X-Gm-Message-State: APjAAAVws/gvacSNylbTZRD13Jlx4tDISY7VgEItJc3BUGMl7jOL28Qs
        Oui5PLvA1V5h65cZj51Od36waQ==
X-Google-Smtp-Source: APXvYqzNDPcrCGfOG+yL1j11DnH5kFJPaIn1I4HvlZNFyLHQ4xt+OBlk/zX50Hgr1Nyc9Lq0MQAuSw==
X-Received: by 2002:a63:d60c:: with SMTP id q12mr39461181pgg.176.1561484456705;
        Tue, 25 Jun 2019 10:40:56 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id 85sm20872129pfv.130.2019.06.25.10.40.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 10:40:55 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ganapathi Bhat <gbhat@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 0/2] mwifiex: spinlock usage improvements
Date:   Tue, 25 Jun 2019 10:40:43 -0700
Message-Id: <20190625174045.125223-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series follows up on some notes from this thread:

  http://lkml.kernel.org/linux-wireless/20181130175957.167031-1-briannorris@chromium.org
  Subject: [4.20 PATCH] Revert "mwifiex: restructure rx_reorder_tbl_lock usage"

where Ganapathi suggested I send out my work.

In particular, patch 1 is a step toward helping apply Ganapathi's
original "mwifiex: restructure rx_reorder_tbl_lock usage" solution
without regression, by logically separating the two operations (and
therefore, the locking patterns) involved in that deadlock. It doesn't
re-apply that change, nor does it 100% unblock such a solution, but at
least it's a step in the right direction, as I understand it.

Patch 2 is a change I noticed should be possible along the way. There
are a number of reasons we probably shouldn't be disabling hardirqs when
it's not necessary, but one funny side effect: bugs noticed in the above
"revert" patch would no longer happen. This is because
mwifiex_recv_packet() bases softirq decisions on in_interrupt() (see
description in include/linux/preempt.h), so it will automatically skip
softirq processing if we have BH disabled, but not if we only have hard
IRQs disabled. In other words, if we have such an incorrect nesting bug
in the future (this time with BH disabled), we will now skip softirq
processing and therefore sidestep this sort of bug. [1]

[Related note: softirq masking is weird:
https://lwn.net/Articles/779738/]

It's also possible we can improve system responsiveness and
debuggability by keeping (hard) IRQs enabled more often, although I
didn't measure any particular effect here, and most of these contexts
should be rather quick.

I've done a variety of performance and stress tests for this series, on
both 8897/SDIO and 8997/PCIe, and I haven't seen any decrease in
performance or stability. Or, any change in performance appears to be
within the range of "noise".

Regards,
Brian

[1] Side note: the usage of 'in_interrupt()' in mwifiex_recv_packet() is
probably not really a good idea. But it does have a helpful side effect
for this particular sort of bug.

Changelog:

v2:
 * fix warnings about using uninitialized "flags" variables


Brian Norris (2):
  mwifiex: dispatch/rotate from reorder table atomically
  mwifiex: don't disable hardirqs; just softirqs

 drivers/net/wireless/marvell/mwifiex/11n.c    |  53 +++-----
 drivers/net/wireless/marvell/mwifiex/11n.h    |   5 +-
 .../net/wireless/marvell/mwifiex/11n_aggr.c   |  26 ++--
 .../net/wireless/marvell/mwifiex/11n_aggr.h   |   2 +-
 .../wireless/marvell/mwifiex/11n_rxreorder.c  | 125 ++++++++----------
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  35 +++--
 drivers/net/wireless/marvell/mwifiex/cmdevt.c |  76 +++++------
 drivers/net/wireless/marvell/mwifiex/init.c   |  32 ++---
 drivers/net/wireless/marvell/mwifiex/main.c   |  29 ++--
 drivers/net/wireless/marvell/mwifiex/scan.c   |  58 ++++----
 .../wireless/marvell/mwifiex/sta_cmdresp.c    |   5 +-
 .../net/wireless/marvell/mwifiex/sta_event.c  |  10 +-
 drivers/net/wireless/marvell/mwifiex/tdls.c   |  68 ++++------
 drivers/net/wireless/marvell/mwifiex/txrx.c   |   5 +-
 .../net/wireless/marvell/mwifiex/uap_txrx.c   |  10 +-
 drivers/net/wireless/marvell/mwifiex/usb.c    |  10 +-
 drivers/net/wireless/marvell/mwifiex/util.c   |  15 +--
 drivers/net/wireless/marvell/mwifiex/wmm.c    | 109 ++++++---------
 18 files changed, 278 insertions(+), 395 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

