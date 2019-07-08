Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C355C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021D2216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562601655;
	bh=4+nUPSUPPBUqM7g0oEfIbTl7e4jDJxR2coI+1h5sTyE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=PBzqnP25sCEBIxJHRlSlyOY3kDEWOp6ecD4zCXyWORi0kTk3Gi6c4TGfMVIviARhH
	 2c3wDspfSOkJMy2qtp8XYIvwj4A843AQVjRoIn5b9ddfSh7oEJUg1+R773Yv6+0ULY
	 RvEiM6AMflsJk7T8Spl67VSM4we+3ZrmahHt0hcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390460AbfGHQAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:00:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40169 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbfGHQAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:00:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so11398931wrl.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 09:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=AmYPt+E4TRsks482BwVamsAcsHm6mV5jPDB/+CpZ9xI=;
        b=VfzOwlrcl1g5HNPNVNipgh+BJOA0A1Ke9whminXJI8/+aODvJMt91RV0m3aOjylZjt
         0NY+84y7NAX7LFUCvf1uljKZwldWKR6TX1KSy55YhE46H4kdzD9qNDb12ALR+87taRJ6
         8qBnkwrarGRVuqRiuMWbfxnlAqFa3UmSZoQ6jpJYyV3rHEoltNcg9xk2FJ1OA3x11S4h
         lIAWrv1S+J8nDcbSjJrc3dCJyOuPNtsY9P/ujfhxbEaLMEsh9HfOwVNQ0SGSPWQizWrH
         GKxCVZ6ZpB5Q1ezkaAnsfLIs8QWAjDtt/lURxP4oKwDjLFkIXtqPrtXvMKeA8UlM9oHn
         Ixng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=AmYPt+E4TRsks482BwVamsAcsHm6mV5jPDB/+CpZ9xI=;
        b=nKst9fiBJSQuveK6deWPM485hOW0oN1ZgKkLQCQZBfKK53gQTN25pk6sCbLy/e33TK
         JZUfoLE7EeR+SK/4axS9BbT1x6bnvWaABNmTlCuKbDNqVadQJmKmshhchLA6rY4MLAuK
         PjsJR7qtBjNnFlo/XyLZaBaZ3Ezcv+xgHNmeYpu6fQvO9k5Jt1mN4GOnXZgFc5et2B/b
         7OeYmAPaYHI5Pxjr/n0RYGwk8AxMZC4mTx2841FOLZTvSY/4XE++JqsZKzVRggKmI5i1
         /P64omSeLocEEW7tsHGgQXTWkR4El7GedBozdzFO4gbLgjwlaCtbYUwuXQ/i0/c0dcqS
         7i4w==
X-Gm-Message-State: APjAAAV4Nm0NZK5sc5Tu8zg1UOC1a6jnlQLkNEbU4tOYNHljPJHP5Zvq
        LLffY5nGEYbqjhcwkZT5ulE=
X-Google-Smtp-Source: APXvYqybFpk6zwtQG2V/vBLKLLYrMWkYA1f5sOKAXKMH98nBsP1VCwEMKU41RGmoEoFe4FrBmCVkHw==
X-Received: by 2002:adf:d08e:: with SMTP id y14mr657690wrh.309.1562601651145;
        Mon, 08 Jul 2019 09:00:51 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id p12sm8014658wrt.13.2019.07.08.09.00.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:00:50 -0700 (PDT)
Date:   Mon, 8 Jul 2019 18:00:48 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/cache changes for v5.3
Message-ID: <20190708160048.GA33834@gmail.com>
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

   # HEAD: 2ef085bd110c5723ca08a522608ac3468dc304bd x86/resctrl: Cleanup cbm_ensure_valid()

Two cleanup patches.

 Thanks,

	Ingo

------------------>
Reinette Chatre (1):
      x86/resctrl: Cleanup cbm_ensure_valid()

Thomas Gleixner (1):
      Merge branch 'x86/urgent' into x86/cache

Uros Bizjak (1):
      x86/resctrl: Use _ASM_BX to avoid ifdeffery

 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  6 +-----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 12 ++++++------
 2 files changed, 7 insertions(+), 11 deletions(-)

