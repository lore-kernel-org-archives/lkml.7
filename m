Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9514BCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690E1217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSAe87In"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbfKAMmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:42:40 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35967 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730672AbfKAMmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:42:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id x9so5303186lji.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 05:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ORSG/8+Jf2L5RMvQ4AjOGFaJ9bOqkKCEFFwwyd0kGjE=;
        b=nSAe87InRfmCTxLXQ00TpN4EtpSTbEO59EV/aV9m9dIlP7IoFHOsoulVE3HMxD9yye
         Yu1QaPiNS0hzbjPATA6WBbUjnoSKDQjjgCQQudPwo90TzKbxps3fUMhLaqYEEb69Tabm
         cr7uNE8YkLchliafWdcJd3aFHPWkmXsRh7Hr65ifq2JepQu929ognh/5y1qWHC2uFgUu
         JGCMVigtL32UHNBKAP+xCHw+Gr8dvPFcC9iMCOcBdX+D2Zk2AZzn2hCl7Szz+nJno3H5
         Fyh0mIvjvaEaqPWHve4BQAtuU6qFGjmekWi4SSsff+/y7X/eKDp850BR5WUHDAMLj63f
         +UJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ORSG/8+Jf2L5RMvQ4AjOGFaJ9bOqkKCEFFwwyd0kGjE=;
        b=p+DSZvoqGOSsH+q/cHS2qKF4rcp52kuZkbp2Rk5yAD/BNBtYk8oEDQOL8OJzQ94Xys
         5MPg+zFK48ZonQa+0aAldV/LDOKbTHyTR97TuOUxtqPcotLQxsZM1NcJeu//DgnYs6fQ
         4csmnSa0dK5lB1PmgUB84Xu0KdI1qMAcXXheF3rIvWEiKZgUz/RXM/RY291vYlyNP1Hv
         awEDaNudXGf7QFCwmfI7xDvtanAaeAYkD6AChRk+iw9O1pQYWCrBPCUVDf+6Fr5OuxIJ
         4iYVDMeKPFrR8yAPcAtaWjZmPMbn/npAA791iwA/dCCE3mHKoTV1GPcpJG91j+e4k39/
         wfgg==
X-Gm-Message-State: APjAAAV/VnpcOxJtLvRhoeSYrOp6jC87AGt4JwyEmKOfccIjhyvP5fKF
        ZtjJpcU3wAg5FE5M5EoMY6oWoDeH
X-Google-Smtp-Source: APXvYqwHjXTvJ7GIHhklGQ/Kh98y0lw4h30skEYzsW4y8IFB/OZfGqRQVsbdbVjoofQ6DoHfJvD1gA==
X-Received: by 2002:a2e:9dd5:: with SMTP id x21mr1980951ljj.232.1572612150184;
        Fri, 01 Nov 2019 05:42:30 -0700 (PDT)
Received: from uranus.localdomain ([5.18.199.94])
        by smtp.gmail.com with ESMTPSA id x1sm5052545lff.90.2019.11.01.05.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:29 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 7760146123B; Fri,  1 Nov 2019 15:42:28 +0300 (MSK)
Date:   Fri, 1 Nov 2019 15:42:28 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, X86-ML <x86@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip] x86/fpu: Shrink space allocated for xstate_comp_offsets
Message-ID: <20191101124228.GF1615@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the commit 8ff925e10f2c72680918b95173ef4f8bb982d59e up to 64 entries
are allocated for xstate_comp_offsets while we only handle XFEATURE_MAX
entries. For this reason xstate_offsets and xstate_sizes already defined
with the explicit limit. Lets do the same for compressed format for
consistency sake.

Actually I guess the main idea was to cover all possible bits in
xfeatures_mask but this doesn't explain why other members such as
standart offsets and sizes were not using the same. So I think better
to use known XFEATURE_MAX limit everywhere and extend it on demand
when new features get implemented on hardware level.

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
CC: Ingo Molnar <mingo@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: H. Peter Anvin <hpa@zytor.com>
---
 arch/x86/kernel/fpu/xstate.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-tip.git/arch/x86/kernel/fpu/xstate.c
===================================================================
--- linux-tip.git.orig/arch/x86/kernel/fpu/xstate.c
+++ linux-tip.git/arch/x86/kernel/fpu/xstate.c
@@ -60,7 +60,7 @@ u64 xfeatures_mask __read_mostly;
 
 static unsigned int xstate_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_sizes[XFEATURE_MAX]   = { [ 0 ... XFEATURE_MAX - 1] = -1};
-static unsigned int xstate_comp_offsets[sizeof(xfeatures_mask)*8];
+static unsigned int xstate_comp_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
 
 /*
  * The XSAVE area of kernel can be in standard or compacted format;
@@ -342,7 +342,7 @@ static int xfeature_is_aligned(int xfeat
  */
 static void __init setup_xstate_comp(void)
 {
-	unsigned int xstate_comp_sizes[sizeof(xfeatures_mask)*8];
+	unsigned int xstate_comp_sizes[XFEATURE_MAX];
 	int i;
 
 	/*
