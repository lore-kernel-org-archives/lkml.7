Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5F2C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9799821D7F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfKLVNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 16:13:04 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:37390 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726978AbfKLVNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:13:04 -0500
Received: from mr5.cc.vt.edu (inbound.smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xACLD2ep029397
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 16:13:02 -0500
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xACLCvht025274
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 16:13:02 -0500
Received: by mail-qt1-f198.google.com with SMTP id u23so21183395qtb.22
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 13:13:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=WJCGNCQuaefXamcTcKNT2rb/G1MBbPGc68q4Yzm/TOg=;
        b=XdyB5ItLRdj28quzJsVMqo/zNsyk9ionP2a82J7zbdgPFHZ8VFWqQahT5G/xya+ov4
         gOW4ka3CZFELpDktH9oLvSA3s8XNlqYqEu4meWbFRluMe3mDi3n4SXfGCMDzaqpKvA3W
         T1IOdNWwh35mn5riUb1fMmfVRHyw5GkbjkK+pyW4lstIPTEaow77xmxFNlILmuD8EpYE
         ulj8PErtD3vkT4ATSsmzBzNCA4taAHB2fM+MJabpp42GTK+pRuLQU/j82T7X/68C5CMJ
         Fl9M/lxydMQH2+9dJyZ5ur7cVy8GhwNyDk1xx2QcCH0SXMVSp1olIjhMuoNE1OzLpi0S
         2wHw==
X-Gm-Message-State: APjAAAVTJGrIE0CqpSz4/OVBIMeUHDy0CyWdfeylhV8Qh2UE9NTRd4sQ
        7d4htFt64Cg/559chvn+Rod/CqXEovqllUKyRXjqmKUq4AXO2d/0gQ6/9qoaAr0cKJ9nzQru1mA
        HAXEIe0uRXKN4C1QupYTaNL60Jrbw0hpIXAo=
X-Received: by 2002:a05:6214:852:: with SMTP id dg18mr31121806qvb.8.1573593177300;
        Tue, 12 Nov 2019 13:12:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqxsliWtv6xDWsmrevBQ5GtlwQfk6b3uvCdFIZKa5oLiD2vzGoyheoUDQPh5rXVBdDUZpoLpDA==
X-Received: by 2002:a05:6214:852:: with SMTP id dg18mr31121782qvb.8.1573593176974;
        Tue, 12 Nov 2019 13:12:56 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 130sm9674214qkd.33.2019.11.12.13.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 13:12:55 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] staging: exfat: Heave FAT/VFAT over the side
Date:   Tue, 12 Nov 2019 16:12:26 -0500
Message-Id: <20191112211238.156490-1-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first 4 patches iteratively remove more and more of the
FAT/VFAT code.

The second 8 patches make a lot of functions static, and
renames many of the rest to avoid namespace pollution.

Valdis Kletnieks (12):
  staging: exfat: Remove FAT/VFAT mount support, part 1
  staging: exfat: Remove FAT/VFAT mount support, part 2
  staging: exfat: Remove FAT/VFAT mount support, part 3
  staging: exfat: Remove FAT/VFAT mount support, part 4
  staging: exfat: Clean up the namespace pollution part 1
  staging: exfat: Clean up the namespace pollution part 2
  staging: exfat: Clean up the namespace pollution part 3
  staging: exfat: Clean up the namespace pollution part 4
  staging: exfat: Clean up the namespace pollution part 5
  staging: exfat: Clean up the namespace pollution part 6
  staging: exfat: Clean up the namespace pollution part 7
  staging: exfat: Clean up the namespace pollution part 8

 drivers/staging/exfat/Kconfig        |    9 -
 drivers/staging/exfat/exfat.h        |  160 +--
 drivers/staging/exfat/exfat_blkdev.c |   10 +-
 drivers/staging/exfat/exfat_cache.c  |  251 +---
 drivers/staging/exfat/exfat_core.c   | 1896 ++++++--------------------
 drivers/staging/exfat/exfat_nls.c    |  192 ---
 drivers/staging/exfat/exfat_super.c  |  359 ++---
 7 files changed, 595 insertions(+), 2282 deletions(-)

-- 
2.24.0

