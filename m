Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FB2C7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 15:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B402085A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 15:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Imgq5Blo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387925AbfG0P7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 11:59:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38426 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbfG0P7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 11:59:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id y15so25919674pfn.5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 08:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=32Oo5zeZMCR/4GPgu9LoitrNmNJwBTLWmozUv/ip9xw=;
        b=Imgq5BloIugGW1ZH9+MsJDxCTH8XCH+z3gPrhHkkYxGfASbj7V4xdB8x615nk4tUIX
         skDt+wQWw6CpQOb5DKfzdVGyBM1h9Jj9RV9wvbQXj091Vf706VmYbcqNK0jUckQQRwx3
         nT2R5lVWO167LGB2XVRHRJYFTbiXTn+do1MHZlVeUEJp9ChzfVaSad2zBHHGq9JSKjD3
         kYWk21Ks3MTmr95ijadB/NNYTqip5mdq85JGZWL9Lm0KpPewuAuFONq7O/Sdf6+KLPLP
         DzM1SlqAUKeNLvueY3bYE91DEqzpglTLbff75AJZ9ZDJNWGf45Xk2LC/qs6PZCE0zHf+
         2EDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=32Oo5zeZMCR/4GPgu9LoitrNmNJwBTLWmozUv/ip9xw=;
        b=Ea6qHs4vki4yAkij7DlyQEnMXNTyiw1Hqovu64h76r5npjPzSMVfrdghW2JhClA/Ga
         e9wGX7eqwS3iESSvrIF4UQ41znQbRDn6Rauw/9mdteKmMyKAUa86MkoY4Hk5f/li3cck
         Q0urIyE7hNmAxjp5KgR+WeNaItjVwXXlcVcQC9FWsxDXmSCeyP73fCQ26R7v6MvC8MWR
         5SOAmdBaajio+Nb43Y5EpjLZiNBGOiIQpkgF+RBuHHKRgmBAyMb6h/TUIP4Pb19s8CVj
         UgOa1YDhtWt8MRqd8rki/JY5sWVLgB+Q2FMraQQT8NyzPDYD0xnHnC02Tj5MSeW71i4+
         SSLA==
X-Gm-Message-State: APjAAAWICHUGudUBMPk1NRWMyjLQK/G/M5DGuICPN5RWQSKafyByXWUP
        t01xb+aC1oT+ElgSKqRM6n4=
X-Google-Smtp-Source: APXvYqz5+5H4yCkogSVilBG5FuenbdFP1dtf3X+yVAbLjVT2pOTXNNHPEA+OPd0OZow/7yRg89l4RQ==
X-Received: by 2002:a17:90a:22aa:: with SMTP id s39mr102725349pjc.39.1564243176254;
        Sat, 27 Jul 2019 08:59:36 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:d1fb:8d6c:15fe:b4a])
        by smtp.gmail.com with ESMTPSA id c98sm54964994pje.1.2019.07.27.08.59.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Jul 2019 08:59:35 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 0/2] devcoredump: cleanup and typo fix
Date:   Sun, 28 Jul 2019 00:59:04 +0900
Message-Id: <1564243146-5681-1-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches are cleanup and typo fix for device coredump subsystem,
and these were originally a part of nvme device coredump series.  However
the series requires an overhaul because it makes nvme-pci driver
compilcated, so these two independent patches are extracted from the
series.

Akinobu Mita (2):
  devcoredump: use memory_read_from_buffer
  devcoredump: fix typo in comment

 drivers/base/devcoredump.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Kenneth Heitke <kenneth.heitke@intel.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
-- 
2.7.4

