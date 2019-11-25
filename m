Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0740C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8674F20740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574691418;
	bh=FcsYHZTdJycVz6Nd/BJ4X38DCFU4dqeZf1izyPeHsvU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=gDsPE5x4SlSkUUmzc7daXsbyPzrrECVk/G4zJdjzk0hluY6ACe4LxxZoGX6wvPFyP
	 d3BKptKZP5h1H5Q+Hfo8hXLTfplHpnnFdYw2HmTuT8wqqP8PUT6t272dMx29SqODO/
	 BtEkBaSNfzf7YAElzeyHPC9puxBoI+E+r+L2e7WY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfKYOQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:16:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32930 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbfKYOQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:16:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id w9so18315159wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 06:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=iugLU0eTHDYBed47rvsz7OukNp7tc48GbQNHELuwgzM=;
        b=vSOfs0q6FWUJ5RS8oZsDJfNIZEp4TFf98iqAXSAK/uatMsrDHlNctZ3j2woujk8f/+
         l+WQ1sN9kSN8cXDvdFHWQ7TqTvcJDJARL6iRPbGUGoKSCZYMLEar/IQT1EoMakemxr6l
         9+zMHcz8nXsX95Ex3qC+X3zXokDNH8YM5wuasz00uklDMpAAYzAoLINzsXAdFcM/F6Y5
         fwfUqQBlj+vvq2t9Z375sF613X38hXoJ5gcymTd86N4D2DdvHx7vimuCGUySzbBKR4z1
         HShPlacgU54E1qm3K4ywJFCsO/iqDH6DARNpuPNrzS2wRYFSkifcywiC1KYTFqoaBiBI
         kpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=iugLU0eTHDYBed47rvsz7OukNp7tc48GbQNHELuwgzM=;
        b=NeSbeggRdMLjc2yqQ8V8TNRqK0r7v8vBmBlJTeHlApHCPf+a04RJY2HxZhVAlGIK1k
         X1TyOyqXhCtcI4oOb1C8RA4oumHingHklhryxv+RO8tG1HXpc9hT6Kbw2cVfvQgaMncW
         CyY2lRwfr0Mg/oX1QnRSlh24kwGOMynj5OUuwgtd9b0/P8WmqJ/nsN4plJSpXGXaNEa7
         3G3ycAtl5cOL96l9sU0px4C/atnUxL0f+fdybVQQY/iWgFBsJFwZNwyqvdoxqC1GMTRs
         R43v4bi+zxf9TKPNtZjQ5X/THFoKwwb8ULwavqCxVNTrA8fpEoOTNu1HKxHWHU0JbbZD
         n8+g==
X-Gm-Message-State: APjAAAUSiUEi2qSGazX6pPOATqHaOisPj0mhCHnzch8PBJbpGfsOpTwA
        jvgSi0shfdksmMWLIlVFdGncEF+J
X-Google-Smtp-Source: APXvYqyIqSLjR9IC+Q07oYqh8VljIc4Tevai+QHk2pg/FhBPNOgbSgzYduKPT8FdS5CRlvgL8Us07w==
X-Received: by 2002:a5d:50c3:: with SMTP id f3mr30921343wrt.14.1574691414126;
        Mon, 25 Nov 2019 06:16:54 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id u18sm10781974wrp.14.2019.11.25.06.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 06:16:53 -0800 (PST)
Date:   Mon, 25 Nov 2019 15:16:51 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/kdump changes for v5.5
Message-ID: <20191125141651.GA21990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-kdump-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-kdump-for-linus

   # HEAD: 9eff303725da6530b615e9258f696149baa51df6 x86/crash: Align function arguments on opening braces

This tree solves a kdump artifact where encrypted memory contents are 
dumped, instead of unencrypted ones. The solution also happens to 
simplify the kdump code, to everyone's delight.

 Thanks,

	Ingo

------------------>
Borislav Petkov (1):
      x86/crash: Align function arguments on opening braces

Lianbo Jiang (3):
      x86/crash: Add a forward declaration of struct kimage
      x86/kdump: Always reserve the low 1M when the crashkernel option is specified
      x86/kdump: Remove the backup region handling


 arch/x86/include/asm/crash.h       |   8 +++
 arch/x86/include/asm/kexec.h       |  10 ---
 arch/x86/include/asm/purgatory.h   |  10 ---
 arch/x86/kernel/crash.c            | 128 +++++++++++--------------------------
 arch/x86/kernel/machine_kexec_64.c |  47 --------------
 arch/x86/purgatory/purgatory.c     |  19 ------
 arch/x86/realmode/init.c           |   2 +
 7 files changed, 46 insertions(+), 178 deletions(-)
