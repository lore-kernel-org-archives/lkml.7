Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B97C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E844420679
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574690729;
	bh=quDAB8Uqc62gFhkuNE1HgClrJykpO2XRGzk20cFddAI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Ije/aeDYny6iOY2w/hjXnQRKVcWmjuMIeBMoqyCO2Ei3RfkkKoF4p6+P6MlI4hNjE
	 07NmQF4LtQolqSyuD+t7Ta0h/PRvW1cahni73LP0UowkG5DNskoidB1z7i6daEG4jq
	 0v5r3Kr6UqLrldQoPHlqDrTd3dRtajuHvE3Inj0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfKYOF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:05:28 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35929 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbfKYOF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:05:27 -0500
Received: by mail-wm1-f67.google.com with SMTP id n188so14139635wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 06:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7rCB0kiz7ZepRbN1hyx+ha0Z1lkJ2TbjF61aPlOcchQ=;
        b=GW8IW63bOPy0pINRpdzaIdR94v7RxljBm8pb8EIqRsWRE+6M233zgxFk27O/RE2D3G
         RYcSHhhMrCZvCQGWU2Xqh6WHds3ZI0sQQLZrXucoNfp2c+7bWOAa6WNqYELC9gyjMmYr
         b0OV+ZJqUHZlZTzZPrHAbR6XU0lVzVXQrRKQa8sGdl6jNA2CRDOJpFAsONkaOovgyBmM
         Bo4CgaHXirUp6qwh6xgFSlw0uijZze5mCJ/eyfNrb24f2f8mPwn5PGtspcJ73eXJU+ZC
         Z0zjw6eGyVrRPqk5Ty/cG8qeHylj2eHaehwxS1sd4MGgjPvWOz2A9Bral4BK3182dOqZ
         2ucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=7rCB0kiz7ZepRbN1hyx+ha0Z1lkJ2TbjF61aPlOcchQ=;
        b=sz2NNsxl/dDGP1++XXAoJUMGqJXbGuFbyeKMwacPU6t/WEGcKzAFnyL8d5H42Injef
         Pn1lurTqk6oWnHlqbrJVD7yGPUyQMelkZrAQQUKTY1226zcfiX2EG7mRouwWPtiL8oGu
         stbE6/jCQC157unMLW30riEYmulQesSiPfdW2L6S+hUuw21hw20NCPCcL9fXC8yabcHt
         NEW1Ys5CZmBFRzTW5NUHaDIgEDbYSMeJQfAJgjWToSBN/Shkme+VM9yzFwxWUTBVKaqJ
         geVFpDk48eTmqhkRBE4GFjEAeKcxWASST4fXOQz/N3QBMnxPsCI2A/qsSCZr4XBTVlVe
         jG5g==
X-Gm-Message-State: APjAAAWEjhVzV32ucZ4nW1tOlT1LNBEMME4HuGaUkLgbKCb0ye3b7V/S
        snw/G2cpqrklzWJoDwSEEVDqZOMy
X-Google-Smtp-Source: APXvYqwnTc2p2Mq06B4TWMY4yzzk+BNAZakTujy9EduzfTdP7nYPswGA59ECMxC4PA9AK/f7LZk6ZA==
X-Received: by 2002:a1c:9ccd:: with SMTP id f196mr29337513wme.152.1574690724731;
        Mon, 25 Nov 2019 06:05:24 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id v19sm11146777wrg.38.2019.11.25.06.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 06:05:24 -0800 (PST)
Date:   Mon, 25 Nov 2019 15:05:22 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/hyperv changes for v5.5
Message-ID: <20191125140522.GA56668@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-hyperv-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-hyperv-for-linus

   # HEAD: 4df4cb9e99f83b70d54bc0e25081ac23cceafcbc x86/hyperv: Initialize clockevents earlier in CPU onlining

Misc updates to the hyperv guest code:

 - Rework clockevents initialization to better support hibernation.
 - Allow guests to enable InvariantTSC
 - Micro-optimize send_ipi_one

 Thanks,

	Ingo

------------------>
Andrea Parri (1):
      x86/hyperv: Allow guests to enable InvariantTSC

Michael Kelley (1):
      x86/hyperv: Initialize clockevents earlier in CPU onlining

Vitaly Kuznetsov (1):
      x86/hyperv: Micro-optimize send_ipi_one()


 arch/x86/hyperv/hv_apic.c           |  16 +++-
 arch/x86/hyperv/hv_init.c           |   6 ++
 arch/x86/include/asm/hyperv-tlfs.h  |   5 ++
 arch/x86/include/asm/trace/hyperv.h |  15 ++++
 arch/x86/kernel/cpu/mshyperv.c      |   7 +-
 drivers/clocksource/hyperv_timer.c  | 154 +++++++++++++++++++++++++++++-------
 drivers/hv/hv.c                     |   4 +-
 drivers/hv/vmbus_drv.c              |  30 ++++---
 include/clocksource/hyperv_timer.h  |   7 +-
 include/linux/cpuhotplug.h          |   1 +
 10 files changed, 190 insertions(+), 55 deletions(-)

