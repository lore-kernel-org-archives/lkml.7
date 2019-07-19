Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23DFC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717982173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="YA6Eggnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfGSMVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 08:21:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44883 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbfGSMVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 08:21:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so32032302wrf.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 05:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZSNxINB1eoSUuwzdj5DoTcqLmEl60Bp0Y1Hgn40sFfw=;
        b=YA6EggnrFQ6Rx4knXWvUwz2U9x+1SCXFlO09KhemP39oSM5WYZgQ2m/kFVHmUdPaiL
         Bm1Ggw6zh2v63WBxSukl1wDC7kjbGrKz1ZXMbEgZLoli/r4F13x+dHAZ6rE4Pz2qeley
         9tPCOG2cMyDnw62NpBr9grkI92uWPyMgpht0Uw2SLvd9Dz2mAO6avNTIp3+tem/noeAR
         V4om6zfHYpQNS87JMPrVvHsV4E1J0XeN9bBskUB2432vKBEvTC8+7q2OQdTGZ93iZIvI
         ohhk/qhXg1mByYO2x65TDsZB/H0HOt+SpMEznQE/4/KLLVO6NYvQR0/hZMhvkRJlJ94I
         XwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZSNxINB1eoSUuwzdj5DoTcqLmEl60Bp0Y1Hgn40sFfw=;
        b=P0h0ZIwuh7xidp/8FMTEwosR0n8vPsJgJTdz/7IofR4Kh5bOIj1eqei+sIxKxdp4eF
         d09G86fpetJsmRlytJ00yaIIqNrKdDDg1+KxcAJ9VG7TtRQlY6ekQDIu6z2DdRLBeHLv
         W1GCF0EvHsJIwAECXX6gWQzfE/W9GgrVN2tqltAVZqDeNivze20CChuMkdhva5aaZSQ/
         tFOuh9tPu8DxUoq7eluryhzfYua403FX7HCJerVHEFm4t5F+S6KuZfIMhXOMc0o8pMWr
         nzkEM59MW1DBdFIaVCnc5sEQreVE6QKe47vlVOLyB5cAOazNF1B1CEp4wui7pCmJZfKS
         e/7Q==
X-Gm-Message-State: APjAAAVlrVyZyhLWrsVPkBFlIbJC9g15zJfMSjs0UuHXs71YHrdxMOB7
        qneXObDpQzFvHuItdPGba5Dsr87wpA4=
X-Google-Smtp-Source: APXvYqx9gGrYkCwplFu6XW/mRH357ZdxOoELb3Z3UiLqCzSiDwFdDoevEVdtgUgUKpbiqm5tozaFNg==
X-Received: by 2002:adf:f851:: with SMTP id d17mr56545224wrq.77.1563538868448;
        Fri, 19 Jul 2019 05:21:08 -0700 (PDT)
Received: from brauner.io (p5097b50e.dip0.t-ipconnect.de. [80.151.181.14])
        by smtp.gmail.com with ESMTPSA id r12sm38324623wrt.95.2019.07.19.05.21.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 05:21:07 -0700 (PDT)
Date:   Fri, 19 Jul 2019 14:20:59 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 1/2] arch: mark syscall number 435 reserved for clone3
Message-ID: <20190719122058.njbtwy2fbd6xrp2d@brauner.io>
References: <20190714192205.27190-1-christian@brauner.io>
 <20190714192205.27190-2-christian@brauner.io>
 <e14eb2f9-43cb-0b9d-dec4-b7e7dcd62091@de.ibm.com>
 <20190716130631.tohj4ub54md25dys@brauner.io>
 <874l3i8h0l.fsf@concordia.ellerman.id.au>
 <20190719102503.tm3ahvkh4rwykmws@brauner.io>
 <871rym8egj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871rym8egj.fsf@concordia.ellerman.id.au>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 09:13:16PM +1000, Michael Ellerman wrote:
> Christian Brauner <christian@brauner.io> writes:
> > On Fri, Jul 19, 2019 at 08:18:02PM +1000, Michael Ellerman wrote:
> >> Christian Brauner <christian@brauner.io> writes:
> >> > On Mon, Jul 15, 2019 at 03:56:04PM +0200, Christian Borntraeger wrote:
> >> >> I think Vasily already has a clone3 patch for s390x with 435. 
> >> >
> >> > A quick follow-up on this. Helge and Michael have asked whether there
> >> > are any tests for clone3. Yes, there will be and I try to have them
> >> > ready by the end of the this or next week for review. In the meantime I
> >> > hope the following minimalistic test program that just verifies very
> >> > very basic functionality (It's not pretty.) will help you test:
> >> 
> >> Hi Christian,
> >> 
> >> Thanks for the test.
> >> 
> >> This actually oopses on powerpc, it hits the BUG_ON in CHECK_FULL_REGS
> >> in process.c around line 1633:
> >> 
> >> 	} else {
> >> 		/* user thread */
> >> 		struct pt_regs *regs = current_pt_regs();
> >> 		CHECK_FULL_REGS(regs);
> >> 		*childregs = *regs;
> >> 		if (usp)
> >> 
> >> 
> >> So I'll have to dig into how we fix that before we wire up clone3.
> >> 
> >> Turns out testing is good! :)
> >
> > Indeed. I have a test-suite for clone3 in mind and I hope to have it
> > ready by the end of next week. It's just always the finding the time
> > part that is annoying. :)
> 
> I know the feeling!
> 
> > Thanks for digging into this, Michael!
> 
> No worries, happy to help where I can.
> 
> In the intervening five minutes I remembered how we handle this, we just
> need a little wrapper to save the non-volatile regs:
> 
> _GLOBAL(ppc_clone3)
> 	bl	save_nvgprs
> 	bl	sys_clone3
> 	b	.Lsyscall_exit

Sounds good.

> 
> 
> A while back I meant to make it generate those automatically based on a
> flag in the syscall.tbl but of course haven't got around to it :)
> 
> So with the above it seems all good:
> 
> $ ./clone3 ; echo $?
> Parent process received child's pid 4204 as return value
> Parent process received child's pidfd 3
> Parent process received child's pid 4204 as return argument
> Child process with pid 4204
> 0
> 
> I'll send a patch to wire it up on Monday.

Excellent! Thank you!
Christian
