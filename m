Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5371C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EB6206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="cyHmttOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbfDCIjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:39:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33104 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfDCIjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:39:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id z6so4269797wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 01:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OE9kvuQABo+Xh1cKw3S624QNJBKsiiBfWEGL0hJqlvE=;
        b=cyHmttOdjwIYlQ2XnmH9lLCA6j3ZfsvfNFh2wrMEUsd2kFJEsFX/mNia9es9DswBfJ
         AOR9zbhl/rXv9tJTgXKH5NZNMl6rHm48iLbb0JpfNiJ1T4oNzM9ism0PIdkGr4XhnMYJ
         wmqJzMcOhTFt71KRHF9/XnA5hy/ElWyQgxMtoWRVs5uVo0aJOsSB4let61ZS8hDb8O0G
         Z/LAkHnJSpRAMR3sOGeykfTNDLmAPdkN6nIMUaLNoTxAcm7nEdxEhNwpaG3qrRJ2jmj4
         F22+1JI8tLQk8/HJta63IOk5YXsHmYo1qJrbwhIye5joDnsxfGzlVwPTq3uNKSvAF1Mj
         ppaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OE9kvuQABo+Xh1cKw3S624QNJBKsiiBfWEGL0hJqlvE=;
        b=bVwKvLaouLmC2ClvKvagQ6ZC+zPng0xTxxBYVG+QAx+yGbztB5DFI79senMxRZ6Q8Y
         d8O6itSN9g7LZTzNpGK2SPHcUw2DybnQBbeXwO3fhYDNMvEE0bsizFnH4o+uHhTvKEmp
         GBtjeCZXZuOXpcU0SkyzS8o5xz2ze0dIPUljr2S+EqevjnANkRvXIeFthUIOzZHOxzqC
         0kJUCnt1svSb+wwLZa0fQRrOUBbPGRB6+fynNfF1ztswRfHzmHZgO89fFSJGiBH06yb8
         87bg18zP+pPp/cZZASN/9QZwSkAhIPi9h4UuyRhdvoEmZf6L93ZKR5FiXpxKYfU3Ok9C
         zrrA==
X-Gm-Message-State: APjAAAXcYhJWepDww35jpm4FGhUeWiQnU9Gt/u6NUAsh1QdKBXN25yIu
        ZscQi35gJ0hWLe6NwCuj3+ptuw==
X-Google-Smtp-Source: APXvYqzM0neknGGeh7/l3IU8cRd+G10v1tGZRRCEUycxnarn1/X6HpBhGVG0sIGpU3ghcLhae+dlXw==
X-Received: by 2002:a1c:b646:: with SMTP id g67mr1215020wmf.125.1554280747665;
        Wed, 03 Apr 2019 01:39:07 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-29-77.w90-86.abo.wanadoo.fr. [90.86.254.77])
        by smtp.gmail.com with ESMTPSA id v192sm23655771wme.24.2019.04.03.01.39.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 01:39:07 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 0/4] um: build and irq fixes
Date:   Wed,  3 Apr 2019 10:38:58 +0200
Message-Id: <20190403083902.3975-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I've previously sent these patches separately. I still don't see them
in next and I don't know what the policy is for picking up uml patches
but I thought I'd resend them rebased together on top of v5.1-rc3.

Bartosz Golaszewski (4):
  um: remove unused variable
  um: remove uses of variable length arrays
  um: define set_pte_at() as a static inline function, not a macro
  um: irq: don't set the chip for all irqs

 arch/um/include/asm/pgtable.h |  7 ++++++-
 arch/um/kernel/irq.c          |  2 +-
 arch/um/kernel/skas/uaccess.c |  1 -
 arch/um/os-Linux/umid.c       | 36 ++++++++++++++++++++++++++---------
 4 files changed, 34 insertions(+), 12 deletions(-)

-- 
2.21.0

