Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DC1C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76ED021537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562602308;
	bh=deIYNiJGWk8xhKz5u1IiZV8tnnAGyzHTlwwSpvh0Nog=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ZjDaJ09zPounXjuF2ePIhg8BBwXADK0wMEA26BLRFviqbjqQzX6VN+VQ0JNpubjc+
	 UqCjCpe9QsL4VgBk4MGWyffUnwQr1wAtCDyk/ujwvY6hy10j+xZIp4B+0aH62jIHqu
	 Dn9Fge46ZZ72xkf7BPcADFE9cSwEBwE6wLiYLo/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389578AbfGHQLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:11:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52059 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbfGHQLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:11:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so97808wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 09:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0YfI9ulneYjIAaJNmJ8mTywngdZ+lHgD4fcT0tv/HX4=;
        b=KuJxlfGSU5CrH+UyUj3RrfYszPQdIS+qFBc/8q4LZQFsF8gr3fI1k06KNU/flDpO0Y
         OaPUT7gkE+8A837BzZzqiJNoo/JaocYLjTEQmysD6qqRuASRcarZ8/YncjTdzagwHM3F
         rBYcovuoG3gyfSMlmk7Onz3hc4rRxg7/waa1sXtgkaIhE42q6UAZJDyCi1Y9wrk5r/JF
         mGTncNPvrZJMVePCOUOMNGhOnqMQUPg5dzC6Nm/tU2Qobl6p8cSYGeJfKucToh43Ng3U
         pcCzYYa1FfV+ouprsLMvwi0tK+bQQkxFFbyghY2AJkmBS6IwtOMLYacVYUB4cNhqcrVa
         EesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=0YfI9ulneYjIAaJNmJ8mTywngdZ+lHgD4fcT0tv/HX4=;
        b=nAT5aCdF315had+XT3ADLZQl2zal9dSN1zpjy97Ioiv8DQ9DdSAxRsByU+KFZSofOL
         qLHL3Tyc9yKTLjvlXV0zRavvD8NCmH/LAGHWmFDZIKNR/0bjVNdwDyV6azqS5SG3qQv0
         pX60Ux5iBxSCc/AjFMqRfr5w2dh1V5zMZDSoJRQYpFgvq3AWjo67o7Cb09Nf7YKVoe06
         DAmbhP+rvi1m09y0jJG3cADydWzA/ZxT7AXeAAk0HE4LSaJcVFxLOcBgYJZvOTNrHojl
         EW7iAk4RfbS+otuqGFGcXp9EwoS+zSTLTEsmHvTSZ0xj3fiVES0oJk24JM5p9BcYBD6v
         bO0g==
X-Gm-Message-State: APjAAAUcsrIoE85GlKcc3nYv3jTJ1++sTJ5Ls6M8t6qN5C7b1Dsm5Jer
        Yu+nDiLsGg92ULPeiIPK03M=
X-Google-Smtp-Source: APXvYqzPSP9SkpEHuug5qKqst+jRHha9sIk0sCJ3FTpsskyruj5gpiRwAlffmfG+JrPW6rJ8PPST1w==
X-Received: by 2002:a7b:c398:: with SMTP id s24mr17777923wmj.53.1562602304553;
        Mon, 08 Jul 2019 09:11:44 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id f204sm28747wme.18.2019.07.08.09.11.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:11:44 -0700 (PDT)
Date:   Mon, 8 Jul 2019 18:11:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/core changes for v5.3
Message-ID: <20190708161142.GA107326@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-for-linus

   # HEAD: 711486fd18596315d42cebaac3dba8c408f60a3d Documentation/filesystems/proc.txt: Add arch_status file

This adds a new ABI that the main scheduler probably doesn't want to deal 
with but HPC job schedulers might want to use, the AVX512_elapsed_ms 
field in the new /proc/<pid>/arch_status task status file, which allows 
the user-space job scheduler to cluster such tasks, to avoid turbo 
frequency drops.


  out-of-topic modifications in x86-core-for-linus:
  ---------------------------------------------------
  fs/proc/Kconfig                    # 68bc30bb9f33: proc: Add /proc/<pid>/arch_s
  fs/proc/base.c                     # 68bc30bb9f33: proc: Add /proc/<pid>/arch_s
  include/linux/proc_fs.h            # 68bc30bb9f33: proc: Add /proc/<pid>/arch_s

 Thanks,

	Ingo

------------------>
Aubrey Li (3):
      proc: Add /proc/<pid>/arch_status
      x86/process: Add AVX-512 usage elapsed time to /proc/pid/arch_status
      Documentation/filesystems/proc.txt: Add arch_status file


 Documentation/filesystems/proc.txt | 40 ++++++++++++++++++++++++++++++++
 arch/x86/Kconfig                   |  1 +
 arch/x86/kernel/fpu/xstate.c       | 47 ++++++++++++++++++++++++++++++++++++++
 fs/proc/Kconfig                    |  4 ++++
 fs/proc/base.c                     |  6 +++++
 include/linux/proc_fs.h            |  9 ++++++++
 6 files changed, 107 insertions(+)

