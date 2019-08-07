Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A60C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89419217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbfHGWvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:51:49 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:58566 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730038AbfHGWvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 18:51:49 -0400
Received: from mr5.cc.vt.edu (smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x77MplsN028635
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 18:51:47 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x77MpgjN023266
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 18:51:47 -0400
Received: by mail-qt1-f197.google.com with SMTP id p34so83760688qtp.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 15:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=VVqj1RHavfLwN3oDC8GBFJV2upV3A569CWoZr0FMSAI=;
        b=ZxM215VZ0n5i0MqLjhUxS4gApqz6aIyu3h7uUfcJg4N4WApItKBFJ+ZZxMYqYu8W6T
         jZbQFLWannQtotMcrWr8gP1CJzrXNRoPRsVxsxgv/ACiwKghK4lz511sm9rgemzq3RgS
         YQrTVzQLVh6KiXP0x+/D6IlD1RRNArFx8pEGt253pEFFZWrUdfhBQbuhvYLOBD0lS0ca
         ZiSxSn7663DN5ocxxAizAnxuqfp/+r0T5TiDHl1dsR8kA1Pm4S/4oO4GQfm+XyReCxUr
         BcCbuaNTiN763Ey631aCzGxhjrDgZU/kX102IIFcyw7GYYK0BRw4ScgxaO62NFBX0iEx
         fD3A==
X-Gm-Message-State: APjAAAVzOQsYEJ+WkLFVkfG1BT6jV/3CfdzkuOObGfYmThXfgmaxBbSc
        OWthhKLGR1/ur+bPo9lP5MpPvFH0Haais+6PLu98eRZKEjt3pUKO9A5ZYtuhbZa2OCquYh3iWp3
        SwGXTNx53y+BL0VXa0azqGutkMXnRerBbTFU=
X-Received: by 2002:ac8:194f:: with SMTP id g15mr10459996qtk.113.1565218302720;
        Wed, 07 Aug 2019 15:51:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxFVSty23dhumB7bRuWQr1litmwZOB8e2hPR6QLdBsmY9Fdo6u3y1IL1k670uNq+n9spIELcg==
X-Received: by 2002:ac8:194f:: with SMTP id g15mr10459984qtk.113.1565218302520;
        Wed, 07 Aug 2019 15:51:42 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id u15sm1920864qtq.76.2019.08.07.15.51.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 15:51:41 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] drivers/ras cleanups
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 07 Aug 2019 18:51:40 -0400
Message-ID: <6559.1565218300@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two patches in this series.

1) There's no need to even build drivers/ras/debugfs.o if config doesn't
include debugfs

2) Add proper includes to silence warnings building debugfs.o 

Changes since first version: deal with error when building without debugfs.

 Makefile  |    5 ++++-
 debugfs.c |    2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
