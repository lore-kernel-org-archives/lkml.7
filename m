Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B56EC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDF5214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbK2DVn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfIQS7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 14:59:22 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46916 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfIQS7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 14:59:22 -0400
Received: by mail-lf1-f67.google.com with SMTP id t8so3687386lfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 11:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dyuKhmzoMsbtM5H85infDrEkbEV6Ixbxarte1ObFGk0=;
        b=NbK2DVn9q0mEgbm8RATY4iFGicQZh6cH/8s2X7tkuc9lJBv9VJ0pNcIRn0IkEkJRJx
         ZGIOyg97bX+/DzoRKZvT2QMMqdrOG4/Dwp9QdWL2YAP2UfU6GnbVurqn50CEW01rYQKg
         ycaYqsUJHN8A733YK0OfgV5gaVv1YgjcEgqKyHT333ouFyXPVfP+/WGuENSz49XA/JXw
         Vy14qr3QQzmXdu+ZStFOzbL2rvhVHqU2vqTAZ6+8Eg8iZ0mqonaycTybwtgNxY3znHrv
         GMTpqwvLB2JfKZGCNFakt7kIMZbamj2RmQisIfEsgL/zmCAwz2tBraCyCWoaR096eFIC
         PzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dyuKhmzoMsbtM5H85infDrEkbEV6Ixbxarte1ObFGk0=;
        b=NQSr5/K0Xkel3WeN7WCrUjovweb3RWLXl3G7hptc+B55KduCcux2nIeL636syz3/pG
         q6krH/Cn2YBfQU3p0rS+Q98HKbgjSuQskw/V8OvnC6SPyfjCBkyjw69Qx5n0GiJfbVR/
         pep5OjMZ6RmPhWWsQPldli75FOQh9V30c/E9uiefc2OhBe9jbcXSKrwMBPjZTjiFSBmZ
         VWTNBva7seCO/ciaojZoztRzy/Etzs76o7lXPQUTlVjIZYsk4+pn3wjx8cPmuNomMo5p
         FSjnYvZQplI848q3Zl0xjS8fH/6F9a8YE2ucEnDWKiBjrvP5AnYMXoOiTtBla+vZ609R
         phew==
X-Gm-Message-State: APjAAAWxJlx9y/XY+Rf5/KZ3vpMYE5yt+y7+Hb9aVgWk5Qso7kQt2OS4
        FmU6QoOOK+GYJ0C2RBNDGl4=
X-Google-Smtp-Source: APXvYqxnNzrUX1SZAZFrr7uID+PtmazTg1aQvfYAbQBTc0mmMkg6V3GJEaMkr20MOcTljLg9GIOjvg==
X-Received: by 2002:ac2:491a:: with SMTP id n26mr2937567lfi.182.1568746760346;
        Tue, 17 Sep 2019 11:59:20 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net. (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id 6sm573038lfa.24.2019.09.17.11.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 11:59:19 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/4] xtensa updates for v5.4
Date:   Tue, 17 Sep 2019 11:59:05 -0700
Message-Id: <20190917185905.2761-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following batch of updates for the Xtensa architecture:

The following changes since commit a55aa89aab90fae7c815b0551b07be37db359d76:

  Linux 5.3-rc6 (2019-08-25 12:01:23 -0700)

are available in the git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20190917

for you to fetch changes up to 982792f45894878b9ec13df81e6e02209b34cb11:

  xtensa: virt: move PCI root complex to KIO range (2019-09-02 00:09:30 -0700)

----------------------------------------------------------------
Xtensa updates for v5.4:

- add support for xtensa call0 ABI in userspace;
- update xtensa virt board DTS for PCI root complex in KIO range;
- remove free_initrd_mem.

----------------------------------------------------------------
Max Filippov (3):
      xtensa: clean up PS_WOE_BIT usage
      xtensa: add support for call0 ABI in userspace
      xtensa: virt: move PCI root complex to KIO range

Mike Rapoport (1):
      xtensa: remove free_initrd_mem

 arch/xtensa/Kconfig                 | 48 +++++++++++++++++++++++++++++++++++++
 arch/xtensa/boot/dts/virt.dts       |  8 +++----
 arch/xtensa/include/asm/io.h        |  1 +
 arch/xtensa/include/asm/processor.h | 11 +++++++--
 arch/xtensa/include/asm/regs.h      |  1 +
 arch/xtensa/kernel/entry.S          | 42 ++++++++++++++++++++++++++++----
 arch/xtensa/kernel/head.S           |  2 +-
 arch/xtensa/kernel/setup.c          |  9 +++----
 arch/xtensa/kernel/signal.c         | 26 +++++++++++++-------
 arch/xtensa/kernel/stacktrace.c     |  5 ++++
 arch/xtensa/kernel/traps.c          |  4 ++++
 arch/xtensa/mm/init.c               | 10 --------
 12 files changed, 132 insertions(+), 35 deletions(-)

-- 
Thanks.
-- Max
