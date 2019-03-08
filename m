Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37114C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 07:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0568720684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 07:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552029256;
	bh=xYhb1cdR3ZJAAB+Ijsz5Q1NHJjnv2WcA1wYT+540d/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dx5yDchbyeKcLaZNXpf+hmrIVF/QH179M/vY9gYVPxnDVrLvaMVOWJgWRv3+sKGuN
	 Ay8y/9uHCsbNDJLCAeS8LOxYEWhkPKAgJQ7aCgJ3tgC8q6ZRLFIcfx4ie5OFDWFOC9
	 oGiDQko6YWBIY5xKbnS8cd3/DUO+94MP9ijYzEe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfCHHOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 02:14:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38513 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfCHHON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 02:14:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id a188so11386155wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 23:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SXmhCOLQJaBMjwNsSAxvQYu70xaYzs+3ImE+e3tHovI=;
        b=W/DE562R5Pja3Qtbz6qImzNR1i4RdkaH5sj/JCpSLrxzlsM478V9/e4Q7mTRosOZMS
         xa/JEPQBFoZ/r9zcLTv5o9gatreBBq42onasMVMKbZdvMyS+pMjLxQPFHfI7BBfRupBd
         4F1WPqNQzhM4e1nVjwK3imuvlItqN200040p1e+hDK0msAeEp6EEzh9Ksr/Px0DCECHQ
         Ew3fu5kEA86oOhjtXsLy6UE06KUB0ghqTK4KWDA5eBA5ZSJo2tYhszoRCRevVdcMoXQd
         MhxaRAgKy32OBeSc0P/kuM68ffALJohZiPHjTZ/2naixHBu/OTBoX5SD69oBsNTtzqyP
         kfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SXmhCOLQJaBMjwNsSAxvQYu70xaYzs+3ImE+e3tHovI=;
        b=hRpyDoocSWLo0f70LCXUuHpzVo3XIulIkpvifnAAkOlO7cW1cyXxZM8vOEJtIonTwv
         R0LSBuBNHioRBbM3VX3+71A5M1HY7nFyAw5C6j2tfj5MVKavhd6cJLix1SLquZs1JejF
         DR0awS8wUnRLYKShu1VHe84u4GhoMTChyWyn6WTnq/dPLVqs6afk8sVfyuXivC8VJ8rr
         93rkpy1O/hSiX4mXlPgYYzSE5atKIpAW/uXbTQcCMCzc3MVXhLKYN5r4wGN5tUmMEWUH
         zyM58E0Cz1scmlwCYWFoUTIry6Z2g2kuw1dy0bzZbGeN1fb5ZY+/GHDl7RHWE8f8/3Gf
         agJA==
X-Gm-Message-State: APjAAAWfOl7uLvju8YNfRkZbsBHOrosGu2CpgyBjOp1OXgxLtiqx80B6
        ecPTgcqlRRLFYAe488txsGM=
X-Google-Smtp-Source: APXvYqw7WJtbRPXUCqcKA+/Qmqb7Qr4ED1yJ8/nzlh/SpRqV02XHY2DgIxKggDlV6oQuhnObnAcmYw==
X-Received: by 2002:a1c:c404:: with SMTP id u4mr8551340wmf.87.1552029252247;
        Thu, 07 Mar 2019 23:14:12 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o12sm11608632wrx.53.2019.03.07.23.14.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 23:14:11 -0800 (PST)
Date:   Fri, 8 Mar 2019 08:14:09 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/kdump changes for v5.1
Message-ID: <20190308071409.GA122442@gmail.com>
References: <20190307192305.GA33711@gmail.com>
 <CAHk-=wih-jHhN6LHb_EyBEw-iP8kXpDYd56jKLKzOa0u8fOiww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wih-jHhN6LHb_EyBEw-iP8kXpDYd56jKLKzOa0u8fOiww@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Mar 7, 2019 at 11:23 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Please pull the latest x86-kdump-for-linus git tree from:
> 
> Hmm. No diffstat?
> 
> The branch is simple enough that I'll pull anyway, but I would have
> wanted to see that up front..

Sorry, I must have fat fingered that, here's the proper shortlog and the 
diffstat for the record.

Plus the SHA1 safeguard in my pull request:

> > # HEAD: f263245a0ce2c4e23b89a58fa5f7dfc048e11929 kdump: Document kernel data exported in the vmcoreinfo note

matches what you pulled:

| commit d2cb698f6896d4b3fc6794142a902d2647f7dbae
| Merge: 35a738fb5fd0 f263245a0ce2
| Author:     Linus Torvalds <torvalds@linux-foundation.org>
| AuthorDate: Thu Mar 7 17:42:13 2019 -0800
| Commit:     Linus Torvalds <torvalds@linux-foundation.org>
| CommitDate: Thu Mar 7 17:42:13 2019 -0800
|
|    Merge branch 'x86-kdump-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
|    
|    Pull x86 kdump update from Ingo Molnar:
|     "Add the AMD SME mask to the vmcoreinfo, and also document our
|      vmcoreinfo fields"
|
| dagon:~/tip> git diff -M --stat 
| 35a738fb5fd0..d2cb698f6896d4b3fc6794142a902d2647f7dbae
|  Documentation/kdump/vmcoreinfo.txt | 495 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
|  arch/x86/kernel/machine_kexec_64.c |   3 +
|  2 files changed, 498 insertions(+)

Thanks!

	Ingo

------------------>
Lianbo Jiang (2):
      x86/kdump: Export the SME mask to vmcoreinfo
      kdump: Document kernel data exported in the vmcoreinfo note


 Documentation/kdump/vmcoreinfo.txt | 495 +++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/machine_kexec_64.c |   3 +
 2 files changed, 498 insertions(+)
 create mode 100644 Documentation/kdump/vmcoreinfo.txt
