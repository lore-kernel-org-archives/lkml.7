Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33706C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026272089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568096304;
	bh=8QubJZfJaeGmmoiRCuuX0FsldVc+ePkWKtEyLgcSuLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TYHpgYE+gTOUin1+0UNESOzheJbfC1iHvq+bnuTgIw98Gqq/ju9QMTQhHAe+WXeiv
	 S/FVti7pmjs29/abg3ulWlm7dmEx/mpFMslZ6Tkap0WbrrYf4rTK0Kb+G0PKP4cwT3
	 GlDbg/QHxxYYbg/KQqLlJvN9NCQgoy1bIzQFOG0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393382AbfIJGSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 02:18:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41145 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730336AbfIJGSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:18:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id h7so16519202wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 23:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lcRZ+gmqkRI/8wjYYIRGOzRppQSTNB6wSfg2biqLEWM=;
        b=uYfxvbHG4hrOBB2ocromyu9I9NtZXbvsfyVPCGC4CwdZbuEJsGP2WnFSTWzItCgtjc
         2bMYfEmuXS0jDGFyXcHq8SUFs50EUkX0/xae84/Fmm0f3X4mRQIlvFbbBIuwIL1hbKQW
         EJSEDgJTohSuijRirnp0IYaaogOEe5sVvTw31L/Q/5G4TcsnxQVI2PKQZV5X6+sIwVi+
         RilmfzXpaoTc+M8k43GUxIIXnXoUhiMyCLroMRtTprHdTvICXqP2qiVuyWoszmbmCG1b
         bxH9Mq0S8V9PcpN7x+zjMYUF32EB4l6hDxKb4egP3t4bRVEt2zOE8jmca51GXIGQl14Z
         zeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lcRZ+gmqkRI/8wjYYIRGOzRppQSTNB6wSfg2biqLEWM=;
        b=bfEetsnBdYbWPTI/3ILOzvCcPiq+xsTUei8NFvVqwsfs+/ZV8EOrA80MvInNhAl5fF
         EbGkxrkVLIDNYKIDMQxuQ5lJdo3RkPVAC6PNzKockY8j5u2YQE/k22x2nF8XiFsl5pq8
         RfkuC07tIkUbUi0vfICeL/3a81wTJUEWZkOSw0Hre5qu2/t8ePPXblqdVmTB6ys5IRya
         25lE0ay5UR/wjbah65h3G15dJ5p/5MCGSKCYIuVP8o+BkMtvDLmXUCgC6pc9ivopQrI0
         pYEi/ArcjCllUnH1xKKlH3IRsq+tFawXy/VtPpuT7xVFzcJ5ccCwTAyBM4ERRjWg1Ebp
         hhOA==
X-Gm-Message-State: APjAAAWmEAiiRr7WmS3lqiO9SiSjsP/ZEZWV5lPk9mmwOCJCvoT/KJ0e
        gtQ3Wuh+MUbLRTeGP6/WATs=
X-Google-Smtp-Source: APXvYqxAgwnlMWHqpbd9xwOGL0fLsNoflWayYi73oiBA8hJJEZ58rPZiJBLknOdEg9CKZtd6AgkIMw==
X-Received: by 2002:adf:f303:: with SMTP id i3mr5465116wro.242.1568096299298;
        Mon, 09 Sep 2019 23:18:19 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b184sm3773148wmg.47.2019.09.09.23.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 23:18:18 -0700 (PDT)
Date:   Tue, 10 Sep 2019 08:18:15 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Jordan Borgner <mail@jordan-borgner.de>,
        Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org,
        Baoquan He <bhe@redhat.com>, russ.anderson@hpe.com,
        dimitri.sivanich@hpe.com, mike.travis@hpe.com
Subject: Re: [PATCH] x86/boot/64: Make level2_kernel_pgt pages invalid
 outside kernel area.
Message-ID: <20190910061815.GA40059@gmail.com>
References: <20190906212950.GA7792@swahl-linux>
 <20190909081414.5e3q47fzzruesscx@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909081414.5e3q47fzzruesscx@box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kirill A. Shutemov <kirill@shutemov.name> wrote:

> On Fri, Sep 06, 2019 at 04:29:50PM -0500, Steve Wahl wrote:
> > Our hardware (UV aka Superdome Flex) has address ranges marked
> > reserved by the BIOS. These ranges can cause the system to halt if
> > accessed.
> > 
> > During kernel initialization, the processor was speculating into
> > reserved memory causing system halts.  The processor speculation is
> > enabled because the reserved memory is being mapped by the kernel.
> > 
> > The page table level2_kernel_pgt is 1 GiB in size, and had all pages
> > initially marked as valid, and the kernel is placed anywhere in this
> > range depending on the virtual address selected by KASLR.  Later on in
> > the boot process, the valid area gets trimmed back to the space
> > occupied by the kernel.
> > 
> > But during the interval of time when the full 1 GiB space was marked
> > as valid, if the kernel physical address chosen by KASLR was close
> > enough to our reserved memory regions, the valid pages outside the
> > actual kernel space were allowing the processor to issue speculative
> > accesses to the reserved space, causing the system to halt.
> > 
> > This was encountered somewhat rarely on a normal system boot, and
> > somewhat more often when starting the crash kernel if
> > "crashkernel=512M,high" was specified on the command line (because
> > this heavily restricts the physical address of the crash kernel,
> > usually to within 1 GiB of our reserved space).
> > 
> > The answer is to invalidate the pages of this table outside the
> > address range occupied by the kernel before the page table is
> > activated.  This patch has been validated to fix this problem on our
> > hardware.
> 
> If the goal is to avoid *any* mapping of the reserved region to stop
> speculation, I don't think this patch will do the job. We still (likely)
> have the same memory mapped as part of the identity mapping. And it
> happens at least in two places: here and before on decompression stage.

Yeah, this really needs a fix at the KASLR level: it should only ever map 
into regions that are fully RAM backed.

Is the problem that the 1 GiB mapping is a direct mapping, which can be 
speculated into? I presume KASLR won't accidentally map the kernel into 
the reserved region, right?

Thanks,

	Ingo
