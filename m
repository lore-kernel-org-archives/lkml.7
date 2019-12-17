Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD20CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869162176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576592518;
	bh=ueGS3iFnbRD2iFw8cOWQhfJY1+W3N8aPfHC9xXQTM3k=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=170IUDaUnBGLr8igsujMEr3t4r8ZQxZLyaLz2BrConkETwXBJQlKzjEALCjno21s8
	 MZ8yhprw+YWdtQE2oGzshGMp5Qvv6eQw1RkbFGtjk71HeZxDBieuwYqm59hQKkno7B
	 eo/z7GwS3CD50pZZFmSDr+v8NhDfijcbRKiejl6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfLQOV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:21:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:57072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbfLQOV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:21:57 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A21DE21739;
        Tue, 17 Dec 2019 14:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576592516;
        bh=ueGS3iFnbRD2iFw8cOWQhfJY1+W3N8aPfHC9xXQTM3k=;
        h=From:To:Cc:Subject:Date:From;
        b=vXqu8GIYA+hYaUmgXRVbbmFskLdI7UcMHOrLuCJ5+ZIGvhrrT78TzXFmu5Kg6KEHz
         l6TeEGPx+2TBBo90EMku8XRyTGbrcQ6ftVeaW8AmwU+osMK7PklMv4u8UxQmD8Inir
         rvo0iiYhHA6uC+5q19TNAd9ZGKG71sh+gBkKD53k=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 0/2] sh: get rid of __ARCH_USE_5LEVEL_HACK
Date:   Tue, 17 Dec 2019 16:21:48 +0200
Message-Id: <20191217142150.10392-1-rppt@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

These patches update the SuperH page table folding/unfolding to take into
account the 5th level.

Mike Rapoport (2):
  sh: drop __pXd_offset() macros that duplicate pXd_index() ones
  sh: add support for folded p4d page tables

 arch/sh/include/asm/pgtable-2level.h |  1 -
 arch/sh/include/asm/pgtable-3level.h |  1 -
 arch/sh/include/asm/pgtable_32.h     |  5 ++---
 arch/sh/include/asm/pgtable_64.h     |  5 ++---
 arch/sh/kernel/io_trapped.c          |  7 ++++++-
 arch/sh/mm/cache-sh4.c               |  4 +++-
 arch/sh/mm/cache-sh5.c               |  7 ++++++-
 arch/sh/mm/fault.c                   | 26 +++++++++++++++++++++++---
 arch/sh/mm/hugetlbpage.c             | 28 ++++++++++++++++++----------
 arch/sh/mm/init.c                    | 15 +++++++++++----
 arch/sh/mm/kmap.c                    |  2 +-
 arch/sh/mm/tlbex_32.c                |  6 +++++-
 arch/sh/mm/tlbex_64.c                |  7 ++++++-
 13 files changed, 83 insertions(+), 31 deletions(-)

-- 
2.24.0

