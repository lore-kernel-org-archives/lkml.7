Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E8AC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BA92081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551978725;
	bh=ZzdNpRYF6oNfPhiBSTEinTIwoUoJLIIJx0oiXuL8tDk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=FKZsbSUhjLQ3vnnIfpE1sx1Z9ms9SfNoI5hqJ6HI2SbJWPu32Ci245849ajgCWali
	 UraSGTfk6GLC6qdfCo9WPKhZWlc/XRg9zvOzdCH8ry2Rpky9/4GZyRARh7qriPsRRN
	 yNyQrBVATWzwhnb72sYEPB5yi5oOTPRZQLMP9PdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfCGRME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:12:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41707 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfCGRME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:12:04 -0500
Received: by mail-wr1-f67.google.com with SMTP id n2so18334128wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 09:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=0WAtjo+vTCf6z35z0XuTNZ8EWfXsSdk8g5iKTtXwuSU=;
        b=PA/bw2DF+ortDAjPdohKyXCObRuTVf1F1wbuE7GWGYejZbHsOCT3m71JWHynEYDhWD
         m20iqLsYYJIDneqpbkLeDnOSAtGUI9vBrTtxMlwotBzeWK0NVV3IFBSvQu9ijaF5Rku6
         vFKZ3SDndEwv+zMLOBmajxvEVLHyIOs3qyLdxMQH0s8lW5+iphQx8PewV+45vbNGG1DG
         +ZJmokeq5gqZ5nWkDweujsS534/ZDqZ3rHULlXgUivn77JGczhmE0MEBwQK0+GbXZj4F
         7n32bGLrvCPJoX0VN9LX3JA+PFCCeIfQIIFRVwNbU9LFv4xadT/spCkLG+/l+elOhmCB
         NGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding
         :user-agent;
        bh=0WAtjo+vTCf6z35z0XuTNZ8EWfXsSdk8g5iKTtXwuSU=;
        b=Ibkmz2LlKbU7iZu0yTWOKr0Go/HkXcNKY91c2JRju8RqwefBuv8nFmLcDpUhwocLja
         KO1d8myKb3Lj5U5VmblGgp72SHYDmD8cYEBKs9t23hpe6vCmsDmMT/sbGMvHZ8AR85+q
         RBFPezmZUeNdqV+6613oizASmV2+WxBWGz3Zs1HLUzI8U7zbziugH0ganpphl60h+jeV
         NYOZ2aNeMVQGhkf1HRBoZnEQWgVFT1PTXa88T9Tmv6TbsltQbbS4p++MPDdnEjLYu1Yd
         pVTtfR9YmmTlu+eEDE7/3DXDVsVFI4LboaWYQOzMKlWPq9xYBHEb9bYtq/HHeTC5P+kb
         kxzw==
X-Gm-Message-State: APjAAAV9YloO3frWM0DnI2WbIVAuYfOfxwD2fA7JkfEDeWfzaB3riZaw
        35V7izuxfKZbGQB7OqDnBhA=
X-Google-Smtp-Source: APXvYqz9ecqDDvEAt6D/j9OMn5AdwoJJgC520UtxU9M5cAMRsU1PPsiUS9HUP2xeacQC/V3oUZP2mQ==
X-Received: by 2002:a5d:6542:: with SMTP id z2mr7560041wrv.237.1551978722115;
        Thu, 07 Mar 2019 09:12:02 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a2sm6662446wrr.60.2019.03.07.09.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 09:12:01 -0800 (PST)
Date:   Thu, 7 Mar 2019 18:11:59 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [GIT PULL] x86/build changes for v5.1
Message-ID: <20190307171159.GA46548@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-build-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-for-linus

   # HEAD: ce02ef06fcf7a399a6276adb83f37373d10cbbe1 x86, retpolines: Raise limit for generating indirect calls from switch-case

Misc cleanups and a retpoline code generation optimization.

 Thanks,

	Ingo

------------------>
Borislav Petkov (1):
      x86/build: Use the single-argument OUTPUT_FORMAT() linker script command

Daniel Borkmann (1):
      x86, retpolines: Raise limit for generating indirect calls from switch-case

George Rimar (1):
      x86/build: Specify elf_i386 linker emulation explicitly for i386 objects

Rafael Ávila de Espíndola (1):
      x86/build: Mark per-CPU symbols as absolute explicitly for LLD


 arch/x86/Makefile                      | 5 +++++
 arch/x86/boot/Makefile                 | 2 +-
 arch/x86/boot/compressed/vmlinux.lds.S | 2 +-
 arch/x86/boot/setup.ld                 | 2 +-
 arch/x86/kernel/vmlinux.lds.S          | 4 ++--
 arch/x86/realmode/rm/Makefile          | 2 +-
 arch/x86/realmode/rm/realmode.lds.S    | 2 +-
 7 files changed, 12 insertions(+), 7 deletions(-)
