Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B645C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E2C20881
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557842963;
	bh=09ry7hopdOyfDPB78COiiBUivUpXqZK1H6ToYb6NQCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MsLAj4OjFFMLXjYgnz3ASd3ju+wNdUb/zT86Kf1tS6YtiHVyV2qnCqksHQwcHd5Xr
	 tQb9WnPhbx0Qfq44+shat7Fs6r0zELGeOaGhGkD2TpWNIQebBmJeor3fQkrUwIgRXa
	 1Zi/mIbTpAPTtEXK6UNCmCiR3Rbrgw/F1oJPeoJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfENOJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:09:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42851 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENOJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:09:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id l2so19377971wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 07:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NXD/cBlZtm4F6T0USEyOTof/8ULd1e59bS2+Zc/i//M=;
        b=j7XvgZ1MBiwUbby/RgTbwI4G6OYSavWSoDyW36gZkcPUTvA/uxze+gJOGwnnRANapP
         hXJa9sgTaA0ksfb1QGtuoUM8T09iYK4XonJ6nh6eLbA5PapFgZOmV53B9jHj3UUwZ4AM
         V9YtFT383FPZmH6V8Bp743uk90bKYNeuHAh6jb5ODHhpA7OOyIv2aB2G6MOPQD7uA6cb
         AZr7Y1z6dIK+a4sDLOJcMi8NFstBq56S8aevFCsMtA75eoVjIxJG4SN+gHzBCyAUVVck
         oot7ereDKHv+X0vD63Qbv8A8sJELvbkgSufmqieV4Wx0FIXlQdNoZ/NMiu+7ve7WN+wj
         jFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NXD/cBlZtm4F6T0USEyOTof/8ULd1e59bS2+Zc/i//M=;
        b=Tun7Yq8P4UEi4+Tbb+4xpLHbILWi6XEqp+i5DWbSnuO89wJ45EyDoMssG7BdM1fD6B
         3WDg2WddzVhEf3B0M/9fx4keLnvaT5H28DtBjHMqxhqhlOhbBzzlqt+w+CsF2BWLOmTx
         SMd/WPSiTUA97CKOT0NrwMgvMpN0lrRYGZkTqnXtbhLpiI6kaqtXwPNpZOzCstn5l6rR
         2Fqs4poy7MC0XfkQsQ7QZd29pqk9RQYR9cT4bB+Yr3PziakMEVz3zFYnUC2cqJoLAYpc
         8xNIn1lQe+Fiix+sPI1/580ljISzHoB0cZaWdKE2AAsMT4ykjy5xRfr1pcpiAikPLk33
         mn0w==
X-Gm-Message-State: APjAAAWfgr4Y1KejHGYXWazN9nv33MHvmCZGJAREkPr7X5Y8H2T5IfEJ
        ok5ScSo+s6o4qf+cQ/mkqRs=
X-Google-Smtp-Source: APXvYqwFMlk0bgh8bQLjL8tM7gJ767gnOGmmfMGPs6nQ93NdWQFpENrzv/CBnmMfF1MC7e6pRRx+7w==
X-Received: by 2002:a5d:4945:: with SMTP id r5mr20913809wrs.328.1557842960054;
        Tue, 14 May 2019 07:09:20 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id n1sm2833483wmc.19.2019.05.14.07.09.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 07:09:18 -0700 (PDT)
Date:   Tue, 14 May 2019 16:09:16 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Dave Young <dyoung@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, Baoquan He <bhe@redhat.com>,
        Borislav Petkov <bp@alien8.de>, j-nomura@ce.jp.nec.com,
        kasong@redhat.com, fanc.fnst@cn.fujitsu.com, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Message-ID: <20190514140916.GA90245@gmail.com>
References: <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv>
 <20190513070725.GA20105@zn.tnic>
 <20190513073254.GB16774@MiWiFi-R3L-srv>
 <20190513075006.GB20105@zn.tnic>
 <20190513080653.GD16774@MiWiFi-R3L-srv>
 <20190514032208.GA25875@dhcp-128-65.nay.redhat.com>
 <20190514084841.GA27876@dhcp-128-65.nay.redhat.com>
 <20190514113826.GM2589@hirez.programming.kicks-ass.net>
 <20190514125835.GA29045@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514125835.GA29045@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dave Young <dyoung@redhat.com> wrote:

> On 05/14/19 at 01:38pm, Peter Zijlstra wrote:
> > On Tue, May 14, 2019 at 04:48:41PM +0800, Dave Young wrote:
> > 
> > > > I did some tests on the laptop,  thing is:
> > > > 1. apply the 3 patches (two you posted + Boris's revert commit 52b922c3d49c)
> > > >    on latest Linus master branch, everything works fine.
> > > > 
> > > > 2. build and test the tip/next-merge-window branch, kernel hangs early
> > > > without output, (both 1st boot and kexec boot)
> > > 
> > > Update about 2.  It should be not early rsdp related, I got the boot log
> > > Since can not reproduce with Linus master branch it may have been fixed.
> > 
> > Nothing was changed here since PTI.
> > 
> > > [    0.685374][    T1] rcu: Hierarchical SRCU implementation.
> > > [    0.686414][    T1] general protection fault: 0000 [#1] SMP PTI
> > > [    0.687328][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.1.0-rc6+ #877
> > > [    0.687328][    T1] Hardware name: LENOVO 4236NUC/4236NUC, BIOS 83ET82WW (1.52 ) 06/04/2018
> > > [    0.687328][    T1] RIP: 0010:reserve_ds_buffers+0x34e/0x450
> > 
> > > [    0.687328][    T1] Call Trace:
> > > [    0.687328][    T1]  ? hardlockup_detector_event_create+0x50/0x50
> > > [    0.687328][    T1]  x86_reserve_hardware+0x173/0x180
> > > [    0.687328][    T1]  x86_pmu_event_init+0x39/0x220
> > 
> > The DS buffers are special in that they're part of cpu_entrt_area. If
> > this comes apart it might mean your pagetables are dodgy.
> 
> Hmm, it seems caused by some WIP branch patches, I suspect below:
> commit 124d6af5a5f559e516ed2c6ea857e889ed293b43
> x86/paravirt: Standardize 'insn_buff' variable names

This commit had a bug which I fixed - could you try the latest -tip?

Thanks,

	Ingo
