Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FE4C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A542171F
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbfHGW4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:56:04 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:58910 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729976AbfHGW4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 18:56:04 -0400
Received: from mr5.cc.vt.edu (inbound.smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x77Mu3N0029242
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 18:56:03 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x77MtwIH026219
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 18:56:03 -0400
Received: by mail-qt1-f200.google.com with SMTP id y19so83798926qtm.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 15:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=mY0KIEoA+H50LCkSAaCYNb72lFtyJPKWzTHzZKe658s=;
        b=LQp75C00FqB46DE+VAS5qIa/xiHBqhGN8vap+51BI0z5EBNsBhCkerhmcBuAcAmlMw
         qjlAubhjQC3YrAU7YNXr2kO4zNGtuVyPWDY8zGZE1Z+LB1UuYllkHSEJuHQIfoBDh+mv
         9IcyQ5a3tXH9II/IpYuHy+eMvyNvyYSUDg1owqnOx2UjkAc2NWn08kceNW6Tqqs09YC1
         f/ZK8r8U6JGZndRbv8wh2onyEpEvVSM3sKwjPjtNwHxyXmB4YpFhGdzDbur7eBjvnkpM
         hO5D/bi5LiLpSawN1PeSJ38j82g3a0LRwAFLXhMHHV7KJSwJ/IlguajsXNT2CP3BFw/6
         E4HQ==
X-Gm-Message-State: APjAAAUpqVPl/ZM3PTNWmGTC9hpPTRNh3itSBYl1Mh7Ha2cLVupJ40Qp
        1vHnDbTSR4wRk6g3gaLmWf31PPi0oZOQwb4x5pw4u0fSXribmlyO0K2mj21plh0BJBUOniJikep
        +nF+VtBtQU4KY651gqzfNVUJ6FZwRQgWoJVI=
X-Received: by 2002:a05:620a:14ab:: with SMTP id x11mr10762400qkj.186.1565218558224;
        Wed, 07 Aug 2019 15:55:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxo+wivpeIKtcorCbZv7bt2gnfdh9d45AId0kEQ3TBxvHsC4lJ0Y1WuyHd7gVVWtPTSaoxsPQ==
X-Received: by 2002:a05:620a:14ab:: with SMTP id x11mr10762390qkj.186.1565218558020;
        Wed, 07 Aug 2019 15:55:58 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id p23sm36395103qkm.55.2019.08.07.15.55.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 15:55:57 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drivers/ras: Don't build debugfs.o if no debugfs in config
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 07 Aug 2019 18:55:56 -0400
Message-ID: <7053.1565218556@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason to build the debugfs.o if the kernel config doesn't
even include CONFIG_DEBUG_FS

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
index ef6777e14d3d..07a5c391cc23 100644
--- a/drivers/ras/Makefile
+++ b/drivers/ras/Makefile
@@ -1,3 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_RAS)	+= ras.o debugfs.o
+obj-$(CONFIG_RAS)	+= ras.o
+ifeq ($(CONFIG_DEBUG_FS),y)
+obj-$(CONFIG_RAS)	+= debugfs.o
+endif
 obj-$(CONFIG_RAS_CEC)	+= cec.o

