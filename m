Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CB4C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC29D20693
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562602494;
	bh=Qj6k0S1NNnHVBW6+5hhaH5MI5vaHdOUbXlJr2gF49e4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=irU/xo8fQtMwY65n+neFYWdelW7lLuMw+Nxy0zRj4/Y+FG0T55CwvNbNWyQAInEOt
	 yhuvTiosuz4+fShLN3Id3jQA6UrnVcWDBQK4hDmD4Ec/WPYgQH27fIknBI7N+6TH+K
	 Q1/QL3EcAz57VNhGPYoWaWA2VR/guFAX5VNEsI4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390376AbfGHQOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:14:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44298 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbfGHQOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:14:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id p17so6617687wrf.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 09:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vv5ALn53OORkWfiJdQXxTQ+F2C2+p379sh9eSgXfuFU=;
        b=aoBdlpc7ipgJLJfC43NigQcrk9CFm9Sj4GKQGeHU/B+HlfHGU1FzMfPn1IRfc0S0NY
         vOIlBmW4YO5UOKgj0SUV58Z991q8+TH+HNYTgkRcLYtFmmmfio1TCY8MfrJIMG+4Zb5t
         KqTTKY+KMFoUTjdfzgJdJdJ6AzjJnghP+dbt1G6C4V+tU6knQuQpCslr5Nx7yyGwUpeB
         kkyHjwbcXW0RYAHv6+wvjdJEFrPbt+86k4Vlh831VkY7J3FH42EbDXqeCCK2WHmAjAl0
         Q9lM1+Igab5RcE4UX0zeDVVZA+P6cOsJ4mHpGXvItm7SPSRMw2cJk4O/XManRsR4Yca6
         Xp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=vv5ALn53OORkWfiJdQXxTQ+F2C2+p379sh9eSgXfuFU=;
        b=rAwvqWAX+6bPvT8zhKxyPiHzlVFoCj9343icJbS3k7CgyUN2bR6UF3pu6Yak47CIqY
         /BYkD1R/oaAIFZYxSKDetJ25B9u6+0BI7ta3TJDrX6TiXQp8CWfxlENBdVUpKIon4WBL
         NXsyTXuu29AN/PLyLJeAEojk5Of3hl65z/9X5/s09BZFQ0QNWT1CGVG2j6hZ2LHsYL8I
         d6HEzEv4HyiE4jMVX41oYcuXpFPyZ12i3QvUxU9wbmR7k7UkGFTmtp+hUv8InCEm75h/
         p5NZc0Pk9OFTJleGBFE2eA2QRzHXLwvFDR+nE6XpYf/PbKNdrlombteNrQjRWb4fBk0X
         qAQQ==
X-Gm-Message-State: APjAAAVELOb8abGxYGycwdjRUZy5lMOwakThSdrGhLIPwEudi0I+kKug
        PfU8I1kdZUPz+H9pqU0ROQe9/1Cc
X-Google-Smtp-Source: APXvYqy/2xqx1vDZRJhyP8O3PQqLV9svh5LL2rpY5NXUoiIbxuVFvmmH/V1fSTFfxIAKAISeWUwzQQ==
X-Received: by 2002:adf:fdd2:: with SMTP id i18mr14888307wrs.125.1562602491207;
        Mon, 08 Jul 2019 09:14:51 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c9sm8220wml.41.2019.07.08.09.14.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:14:50 -0700 (PDT)
Date:   Mon, 8 Jul 2019 18:14:48 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/paravirt changes for v5.3
Message-ID: <20190708161448.GA115581@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-paravirt-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-paravirt-for-linus

   # HEAD: 46938cc8ab91354e6d751dc0790ddb4244b6703a x86/paravirt: Rename paravirt_patch_site::instrtype to paravirt_patch_site::type

A handful of paravirt patching code enhancements to make it more robust 
against patching failures, and related cleanups and not so related 
cleanups - by Thomas Gleixner and myself.

 Thanks,

	Ingo

------------------>
Ingo Molnar (5):
      x86/paravirt: Detect over-sized patching bugs in paravirt_patch_insns()
      x86/paravirt: Detect over-sized patching bugs in paravirt_patch_call()
      x86/paravirt: Match paravirt patchlet field definition ordering to initialization ordering
      x86/paravirt: Standardize 'insn_buff' variable names
      x86/paravirt: Rename paravirt_patch_site::instrtype to paravirt_patch_site::type

Thomas Gleixner (3):
      x86/paravirt: Remove bogus extern declarations
      x86/paravirt: Unify the 32/64 bit paravirt patching code
      x86/paravirt: Replace the paravirt patch asm magic


 arch/x86/events/intel/ds.c            |   8 +--
 arch/x86/include/asm/paravirt_types.h |  21 ++----
 arch/x86/kernel/Makefile              |   4 +-
 arch/x86/kernel/alternative.c         |  53 +++++++-------
 arch/x86/kernel/kprobes/opt.c         |  16 ++---
 arch/x86/kernel/paravirt.c            |  46 ++++++-------
 arch/x86/kernel/paravirt_patch.c      | 126 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/paravirt_patch_32.c   |  67 ------------------
 arch/x86/kernel/paravirt_patch_64.c   |  75 --------------------
 arch/x86/tools/insn_decoder_test.c    |   8 +--
 arch/x86/tools/insn_sanity.c          |  28 ++++----
 11 files changed, 214 insertions(+), 238 deletions(-)
 create mode 100644 arch/x86/kernel/paravirt_patch.c
 delete mode 100644 arch/x86/kernel/paravirt_patch_32.c
 delete mode 100644 arch/x86/kernel/paravirt_patch_64.c
