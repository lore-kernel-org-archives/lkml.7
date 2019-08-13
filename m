Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDD5C32757
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA1120663
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbfHMP2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:28:33 -0400
Received: from 8bytes.org ([81.169.241.247]:48998 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbfHMP2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:28:18 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9A77446B; Tue, 13 Aug 2019 17:28:17 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 0/3 5.2-stable] Sync mappings in vmalloc/ioremap areas
Date:   Tue, 13 Aug 2019 17:28:11 +0200
Message-Id: <20190813152814.5354-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Backport commits from upstream to fix a data corruption
issue that gets exposed when using PTI on x86-32.

Please consider them for inclusion into stable-5.2.

Joerg Roedel (3):
  x86/mm: Check for pfn instead of page in vmalloc_sync_one()
  x86/mm: Sync also unmappings in vmalloc_sync_all()
  mm/vmalloc: Sync unmappings in __purge_vmap_area_lazy()

 arch/x86/mm/fault.c | 15 ++++++---------
 mm/vmalloc.c        |  9 +++++++++
 2 files changed, 15 insertions(+), 9 deletions(-)

-- 
2.16.4

