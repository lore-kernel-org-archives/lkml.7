Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E41C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C262084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="IlrVYrAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfDKJtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:49:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45445 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfDKJtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:49:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so6405958wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 02:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zA+XgUyd+ivldt3lYQcNAv56jtVYhNuq0PR2criQX3U=;
        b=IlrVYrAHqOKEYrtE32ZBL53AdLhCj7VOcbq9a/e3hiATg/Xs3BXLuP3DCXs824YRe/
         6cHYLUcNf+roj1xYIP4DNcFCI/KeMBZ2lBk8PuRRsyDzNWTMn7afJ8gizurBdhJMS3o7
         +r77p5M00jfpWFkRK7bgDBxdq0jWtAQMFr7atIC21wbiBBx8plId5Xd/Di0IEBtA9s5T
         rmp3Y448r+jr+B/3F81m8/1OW2Miel7eoOezrRzQU4s8qd2BPK3k7PCWrrU3T+ds/o96
         94BkG97Hg3v8PtTrvPN04H3Ax4QRp2EGX21qcMxx0VqfUJeO8ORz3i2ec+CUHUxBH7lW
         2IQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zA+XgUyd+ivldt3lYQcNAv56jtVYhNuq0PR2criQX3U=;
        b=TICL7EMTCGwrkJ+EBKE189uobnKnBybwkh9TmOoPQnMwFCfeL/dKPGRYLnodRP9Osf
         QJH5GTeuO+Y1S8KcNERD+imhHN6boy35cCU3iC0kTvXOinCXstQR2PzZAgcUpiJ6bONe
         97IocMxPdaHGxf9UHXSDmBTkgW70top2JiWkxaoulABLThcQhkYVjFdL09yc94dxPZNZ
         SWufXAGc/BvYVmF1Y+i1ZJ20ncj55bm4K7LzymfBjMr+DGYkqnSjX21G4HwViqHzLBjK
         JmqrIBn3QRGUe/9QB/DKgre0DI8Pb3K4ScObShpxmIYMfDpQryYx0pqXDvPTa0AWOo8k
         oFQw==
X-Gm-Message-State: APjAAAXEay1BH3s7yRhL2fYdH0AjNaKLZ+bL81Xzxm3j1Fi8M+spdK5E
        BMJFonEeEyAHf5w4WILcIdjr8NcGHIE=
X-Google-Smtp-Source: APXvYqzbYmYsnR0vgsFHVoLeauR5YpqEZ+CZBoT2sTbL5o0z/O/3MHb4bNSInXaOu669ksJ73ml7lw==
X-Received: by 2002:a5d:6b02:: with SMTP id v2mr8050057wrw.84.1554976187309;
        Thu, 11 Apr 2019 02:49:47 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id s10sm6434066wmh.0.2019.04.11.02.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 02:49:46 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 0/4] um: build and irq fixes
Date:   Thu, 11 Apr 2019 11:49:40 +0200
Message-Id: <20190411094944.12245-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Resending again - this time with tags collected.

===

I've previously sent these patches separately. I still don't see them
in next and I don't know what the policy is for picking up uml patches
but I thought I'd resend them rebased together on top of v5.1-rc4.

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

