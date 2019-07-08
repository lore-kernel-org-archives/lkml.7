Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021D4C606A7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C762320656
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562579468;
	bh=qRCxKkIY0GPpQ2ZT/W3B8z1ggZX8dFatDQO798K+K+E=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=UUD/+4FFfjsM89CQTxyoWrjZ0cKj6Nt88qEzudIXd41J0VBJnNAbpgWEaRfRDRrgW
	 PvNturl+gHE5tcwjoG4LiqXQVISk48vMRuFlzinqv2M8KeHK3XoZTfZYU8XPM98hgT
	 W7ghlcPhwP3hs8EY2wfGxjp4IMfYND4FtIh1mj04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbfGHJvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 05:51:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35305 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbfGHJvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 05:51:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id y4so7692343wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 02:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XC+MCenEOTbiEZaPU4ZpNhdfgGfWHfTIq6+TiHkM7NU=;
        b=ZYqnUAQqlSDGhAPfPpBsqqtk/N5hnycFGScWzud4u27GZVoN7HOq4dnBcBTnr+nLw/
         p+JQcy03Y8UlGofWg4aJFjrQsBG9E9g49AlTziJ6WuItj8pXJNWDa6FVAJQBNFBfakmY
         RlJb/yEyw9c0Yicd1rtDNoi6gfG07B6LsZ/SzqoTycLeSn6a4O1nhx7FoNRKP2hlWRZ2
         mniDzJxBFZLwX/dfifuag8h+5C26vvDq9PlPEFFkBQdvSE3uTigxcVPasXstqn7YsGRh
         a0tzCNd8zOkwEJ7BSw+f/jpnmqgqgRB7qbqIFSbI16H1w9lTzlqNH2yWnTDI/TEIyClm
         92nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=XC+MCenEOTbiEZaPU4ZpNhdfgGfWHfTIq6+TiHkM7NU=;
        b=JZuhKjz0/86ICe3JSDE9s8p/6cci27LompkFVFpPiMCznuYqRQ4HCxuiALm2r1A0MM
         ZIrVMBP8kUoZ2z18sTAnpWnz5GS/X4pm+b94P5jQP48pYcrtiL05hZn2Veh8tUKSBJCY
         p9dIsbIgm3WFsjuNrqXfztJTJ9X028Je1UU6b4GevgNfAzYb+D/FV+kdNmAoyQcc6udu
         Jdv8lLb/jIgU1H/8CI92qG9Jh6vCsyN1YUErQoAeVp6keBIgw453lQipm7cbi4kP8tzp
         dU1owWzY1Ls8hO9iP5jDh+pHA0bs9Q8/ZpbBxH3MXE2INUe7prgLfffTc4bHgrDrNVmC
         KZAg==
X-Gm-Message-State: APjAAAXc+ibc3dgXz/LXYBCLJbKq6H+rBwWpMmlCbILPu957cra19vxm
        +IDg74FsRpIyKAoaFUyqbYA=
X-Google-Smtp-Source: APXvYqxDh4IthAZGfY5V5LAa7y4sh/8lal5dCeVm6w2KW5gWXtd16+sSzz19IRwApsglBcY2sC/KHw==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr18746021wrm.235.1562579464969;
        Mon, 08 Jul 2019 02:51:04 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h9sm12818994wrw.85.2019.07.08.02.51.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 02:51:04 -0700 (PDT)
Date:   Mon, 8 Jul 2019 11:51:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] RAS changes for v5.3
Message-ID: <20190708095102.GA59026@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest ras-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus

   # HEAD: 6e4f929ea8b2097b0052f6674de839a3c9d477e9 x86/mce: Do not check return value of debugfs_create functions

Boris is on vacation so I'm sending the RAS bits this time. The main 
changes were:

 - Various RAS/CEC improvements and fixes by Borislav Petkov:
    - error insertion fixes
    - offlining latency fix
    - memory leak fix
    - additional sanity checks
    - cleanups
    - debug output improvements

 - More SMCA enhancements by Yazen Ghannam:
 
    - make banks truly per-CPU which they are in the hardware,
    - don't over-cache certain registers, 
    - make the number of MCA banks per-CPU variable.

   The long term goal with these changes is to support future 
   heterogenous SMCA extensions.

 - Misc fixes and improvements.

 Thanks,

	Ingo

------------------>
Borislav Petkov (8):
      RAS/CEC: Fix pfn insertion
      RAS/CEC: Check count_threshold unconditionally
      RAS/CEC: Do not set decay value on error
      RAS/CEC: Fix potential memory leak
      RAS/CEC: Sanity-check array on every insertion
      RAS/CEC: Rename count_threshold to action_threshold
      RAS/CEC: Dump the different array element sections
      RAS/CEC: Add copyright

Greg Kroah-Hartman (1):
      x86/mce: Do not check return value of debugfs_create functions

Tony Luck (1):
      RAS/CEC: Add CONFIG_RAS_CEC_DEBUG and move CEC debug features there

Yazen Ghannam (5):
      x86/MCE: Make struct mce_banks[] static
      x86/MCE: Make mce_banks a per-CPU array
      x86/MCE/AMD: Don't cache block addresses on SMCA systems
      x86/MCE: Make the number of MCA banks a per-CPU variable
      x86/MCE: Determine MCA banks' init state properly


 arch/x86/kernel/cpu/mce/amd.c      |  92 +++++++++----------
 arch/x86/kernel/cpu/mce/core.c     | 177 +++++++++++++++++++++++++------------
 arch/x86/kernel/cpu/mce/inject.c   |  37 ++------
 arch/x86/kernel/cpu/mce/internal.h |  12 +--
 arch/x86/kernel/cpu/mce/severity.c |  14 +--
 arch/x86/ras/Kconfig               |  10 +++
 drivers/ras/cec.c                  | 132 ++++++++++++++++-----------
 7 files changed, 269 insertions(+), 205 deletions(-)
