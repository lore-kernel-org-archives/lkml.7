Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD27C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629942087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557136796;
	bh=591Lr/4v81Bp73W6qlSlD5kNyyLpUiRLug4Fv5pIAIQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=KQTO3cFvb4XKMTEwLDuNDwLrbSsgzZJZWiHVw49BWythVWmKPR1ozqvMkoJDhoNGw
	 Psitfz0Z3IrtGWS0/HhqYDBx8tfKUdavCM6wokG2AT3lHUzdkjZxJwPdf3Krdvs4Go
	 aSqpNokTxwlAGv2heWx0Xy36zMJ3hkKmtxYjFEYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfEFJ7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:59:55 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:34979 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfEFJ7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:59:54 -0400
Received: by mail-wm1-f52.google.com with SMTP id y197so14387183wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 02:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xsRZTNrxM31jcmcUbhCJiA0tQjBMnjfUKzxPuk+mYUU=;
        b=fcdbCjGABC8mPQlYwZ/HYLYhAxMxrTqD63dMmwJc2RJ1h6flSUiK4VZxKFEpAP+Xxu
         z0ZlM22Ri0BNhOP74lRGlM6YziiKoONl+BX0MRROTp9YGt7mKDr9xV9Rl09Y9VwRFZSy
         EvKsCmWn2xUR+pujaA2HPlM3iHqvjJbNXQF/6PWgXnKOKKtL4GJoey5wyBn1e33eMvyI
         9bpKLs7sgEX/Xl0mmFdfzC6buwc0pS4FLCCQaP8E0ugH/DL25KZKc+IlVOuFRPBnWEaJ
         h3eHlugJ/TQtkBv7zOTH4Mv7eVCexuqUFEdhcnI4IKJRrwGrmiFGOTabqHx662psSH3D
         rCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=xsRZTNrxM31jcmcUbhCJiA0tQjBMnjfUKzxPuk+mYUU=;
        b=cpk2+4mpq4R3TQrpcFoAtIXSaRZ/dZEBXdpkIJq0DQIxzMXuyTiad3cuuOH8MbpvFL
         3JT53CaUyIeLWd1qO0f8FJJHQua6CbtDmZkcVxd/wKj1vC9uiUW89Z9Jc73Vx3xRVDgk
         /ar3oYF7N2jLpc1Cz1YBMbggUmQkRE5WuHXcH8ETfPH1bixX6BttR9uqv7HtQkspfoj7
         vATu9lgTRnd9f0GeYyXy2O1hf7OHOlW4mmUGZDruCUyxSaoSbRTZNooIfAUq8PJp19gM
         ZPZfpCZj8Umbl6A4P/vWsX4idQ3cMp9OL29yXtsY9+YVu6+JyIlEBUKSE3UIjtJmVgFQ
         KdOg==
X-Gm-Message-State: APjAAAW0QWpnnIvuIxpaVCxZUMNlK/ht2s65Acc5sxA7qwYptLzv+Qw+
        B/BLc3N3Ko6wtgy3PBOJB3E=
X-Google-Smtp-Source: APXvYqyauk3N5tR9uvj1pw2NgwgbAiIiWK0uN/NhvuWYqxmtDmpavVQ6q6q8HTlgj7LJi32JiO8mCg==
X-Received: by 2002:a1c:2c04:: with SMTP id s4mr1294462wms.123.1557136793607;
        Mon, 06 May 2019 02:59:53 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j3sm8685970wrg.72.2019.05.06.02.59.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 02:59:52 -0700 (PDT)
Date:   Mon, 6 May 2019 11:59:50 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/cache updates for v5.2
Message-ID: <20190506095950.GA15822@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-cache-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cache-for-linus

   # HEAD: 47820e73f5b3a1fdb8ebd1219191edc96e0c85c1 x86/resctrl: Initialize a new resource group with default MBA values

An RDT cleanup and a fix for RDT initialization of new resource groups.

Thanks,

	Ingo

----
Borislav Petkov (1):
      Merge x86/urgent into x86/cache

Xiaochen Shen (2):
      x86/resctrl: Move per RDT domain initialization to a separate function
      x86/resctrl: Initialize a new resource group with default MBA values

 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |   4 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 173 +++++++++++++++++-------------
 2 files changed, 102 insertions(+), 75 deletions(-)
