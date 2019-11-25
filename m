Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0660BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1D4207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574691696;
	bh=NE33tX2qJSpGxxufTErRCgkY/RZ1dxsE1foTjtF8tts=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=2LmcxWaYRG9coDEkqVrP4hF1u6nCzc9G6aajSEYc+WmOyefQzUvUF4MotrTEKqPhm
	 Mwu1uMCo4jlMKJTCfilVOQ4tjitAd2jnR7YIYLAQxN00Eh7ddqlqC5mhoReUf3s+pR
	 VXLN8sEoZtw8ImBefgA+lrhCrhsvNblr5htfDvH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfKYOVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:21:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34428 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbfKYOVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:21:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so18269206wrr.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 06:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=az3sebe4g6Usvkn3Ey27KQsyFcxxMl/3gUmN1MHpvsg=;
        b=MzwLiZRrOAKZBpAI/7mU6ABv2rrby6VLC9vdT3YtW1POdWseIAy/hLLmNbvJV/2riO
         Xckvru7gbkL69zZd62FTKz4g6JqZt88nDg5SZYfutdBzi+WoWyv4kgsV1cM78lNGkPP/
         Uhpr7SbeIrst5YPBqRiYZxqnejPx1idNPv2m46/Rjktvw2QzEhhuwL353cznVGkGvlhX
         B/mT/nU6WQ0D2O0Qd3GcBKe8ksWvr/zClFerzSXFV7278X3jbJ7ZXwKMxe7IMeGjOd9b
         IApR0DR7fnfNXWIjQeLvcnTla2ISO/l3JNZLKt00aQjuBYeGF7iY4vn/jPZ719yp2Xfh
         x7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=az3sebe4g6Usvkn3Ey27KQsyFcxxMl/3gUmN1MHpvsg=;
        b=hN6e3bg1qQFcEeNJvAUVpFPfletyx8cTi6+iOalfLsfKADuKXi91YAxymn3GSBWRpy
         +VDAeHTxKHM4oNBiwP4Qho5ysRvPM+YGpItHo9B1VWp2jYNEBy41e1LoYoFUt0w6COWV
         tj7EUCy6elNP9wcmDvjRizaUtyhG1y7QCzsWVyxMlLxlUjHdUnukyrOf7DDD/wykWeCX
         ezaezD3+m0ivOTLIgLowlv7UUKGA25uiTYw9lefvbGLVkd2gRUZ7XiPW/dN1ppor4Q7h
         CkvjvJFPUeCQbjb3f1IpZQux7jdBZlswyZOzGB/IB1qxhz4a4rxAWcSzNnxum8cDtEwd
         1mbg==
X-Gm-Message-State: APjAAAX/de+gyeCTeqSKQT84q/WwHs59oQtJIdibgmhrzH4TPSUWq4oA
        sZeDOflUOrCwjCC9Xph4VfVn8e3F
X-Google-Smtp-Source: APXvYqzyGpj/0E+0PCaR9cPrIm+3wxJMCzY1vtjNHOPe6Va09gYWiP+9BjGVJqGwUHihdfpOYrUkAQ==
X-Received: by 2002:adf:ba4f:: with SMTP id t15mr29962673wrg.24.1574691693451;
        Mon, 25 Nov 2019 06:21:33 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id x10sm10698497wrp.58.2019.11.25.06.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 06:21:32 -0800 (PST)
Date:   Mon, 25 Nov 2019 15:21:30 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [GIT PULL] x86/mm changes for v5.5
Message-ID: <20191125142130.GA25523@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-mm-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-for-linus

   # HEAD: 7f264dab5b60343358e788d4c939c166c22ea4a2 x86/mm/pat: Rename pat_rbtree.c to pat_interval.c

The main changes in this cycle were:

 - A PAT series from Davidlohr Bueso, which simplifies the memtype rbtree 
   by using the interval tree helpers. (There's more cleanups in this 
   area queued up, but they didn't make the merge window.)

 - Also flip over CONFIG_X86_5LEVEL to default-y. This might draw in a 
   few more testers, as all the major distros are going to have 5-level 
   paging enabled by default in their next iterations.

 - Misc cleanups.


 Thanks,

	Ingo

------------------>
Davidlohr Bueso (4):
      x86/mm/pat: Convert the PAT tree to a generic interval tree
      x86/mm/pat: Do not pass 'rb_root' down the memtype tree helper functions
      x86/mm/pat: Drop the rbt_ prefix from external memtype calls
      x86/mm/pat: Rename pat_rbtree.c to pat_interval.c

Ingo Molnar (1):
      x86/mm: Clean up the pmd_read_atomic() comments

Kirill A. Shutemov (1):
      x86/mm: Enable 5-level paging support by default

Sylvain 'ythier' Hitier (1):
      x86/cpu: Clean up intel_tlb_table[]

Wei Yang (1):
      x86/mm: Fix function name typo in pmd_read_atomic() comment


 arch/x86/Kconfig                      |   1 +
 arch/x86/include/asm/pgtable-3level.h |  46 +++---
 arch/x86/kernel/cpu/intel.c           |   8 +-
 arch/x86/mm/Makefile                  |   2 +-
 arch/x86/mm/pat.c                     |   8 +-
 arch/x86/mm/pat_internal.h            |  20 +--
 arch/x86/mm/pat_interval.c            | 185 +++++++++++++++++++++++
 arch/x86/mm/pat_rbtree.c              | 268 ----------------------------------
 8 files changed, 229 insertions(+), 309 deletions(-)
 create mode 100644 arch/x86/mm/pat_interval.c
 delete mode 100644 arch/x86/mm/pat_rbtree.c

