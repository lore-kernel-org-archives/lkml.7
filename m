Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBFDC3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A5422CEA
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567127506;
	bh=cxG/Csv0dO0dzHh0hw8hEJaJviptwRvJ+VuvpnA+zQ4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=iN2NBT5LltB3xM45z6RHKhKdaAlEx9xdZjZbOdA8RMyYCObSV6udHVTVTQTFG9tqh
	 e4PbHSqzVtFRYkLAqEet+n653xM+AaqGPRfb0yD4qL2NY0jFeAsArNdeAbuPDDD7wi
	 W3K2Npaynmg3tQgJTD3/0shKBlBUL7sKzszKvlXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfH3BLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 21:11:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbfH3BLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 21:11:45 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15A1021726;
        Fri, 30 Aug 2019 01:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567127504;
        bh=cxG/Csv0dO0dzHh0hw8hEJaJviptwRvJ+VuvpnA+zQ4=;
        h=From:To:Cc:Subject:Date:From;
        b=l/e54Qwqc4S7T7xLPRTF6aL4Jp+Ft+XfOURSQfTJJcFanYajZm4eXqJvTB/OWotdG
         e/Z4n40q+Lpn5mGyt7s9me5IKpUekh65VHkFqGcCsx0O7PwtDupXtBV+/1hsbyShOO
         lxQPHtbVUafs469dKHT7RY8OanI7Fq4cbzJy4+hM=
From:   Andy Lutomirski <luto@kernel.org>
To:     Theodore Tso <tytso@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/7] Rework random blocking
Date:   Thu, 29 Aug 2019 18:11:35 -0700
Message-Id: <cover.1567126741.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes two major semantic changes to Linux's random APIs:

It adds getentropy(..., GRND_INSECURE).  This causes getentropy to
always return *something*.  There is no guarantee whatsoever that
the result will be cryptographically random or even unique, but the
kernel will give the best quality random output it can.  The name is
a big hint: the resulting output is INSECURE.

The purpose of this is to allow programs that genuinely want
best-effort entropy to get it without resorting to /dev/urandom.
Plenty of programs do this because they need to do *something*
during boot and they can't afford to wait.  Calling it "INSECURE" is
probably the best we can do to discourage using this API for things
that need security.

This series also removes the blocking pool and makes /dev/random
work just like getentropy(..., 0) and makes GRND_RANDOM a no-op.  I
believe that Linux's blocking pool has outlived its usefulness.
Linux's CRNG generates output that is good enough to use even for
key generation.  The blocking pool is not stronger in any material
way, and keeping it around requires a lot of infrastructure of
dubious value.

This series should not break any existing programs.  /dev/urandom is
unchanged.  /dev/random will still block just after booting, but it
will block less than it used to.  getentropy() with existing flags
will return output that is, for practical purposes, just as strong
as before.

Andy Lutomirski (7):
  random: Don't wake crng_init_wait when crng_init == 1
  random: Add GRND_INSECURE to return best-effort non-cryptographic
    bytes
  random: Ignore GRND_RANDOM in getentropy(2)
  random: Make /dev/random be almost like /dev/urandom
  random: Remove the blocking pool
  random: Delete code to pull data into pools
  random: Remove kernel.random.read_wakeup_threshold

 drivers/char/random.c       | 234 ++++--------------------------------
 include/uapi/linux/random.h |   4 +-
 2 files changed, 27 insertions(+), 211 deletions(-)

-- 
2.21.0

