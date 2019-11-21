Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8767AC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59704206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574356340;
	bh=t5EJIwzjFzCnr3/y0RJFvBrWWW7vhvmNant8gnymADk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UUAX47PDq4MZykITES7s9r+FVf56NVHZEVBTB74D+YOcj2UjFRta5v2dZV2HHwZ0a
	 szI++89Dn/A8gKn+jME76GkmGxJzDjnnoadgKOSBSfwrVnqr8MH0UPCMCDRhaOxxhk
	 xRpAP2ebai+hg9OUb4e4Hr888LW+lRbnsVOS5QM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKURMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:12:19 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54396 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKURMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:12:19 -0500
Received: by mail-wm1-f67.google.com with SMTP id x26so4304928wmk.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 09:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pPzRgueH6uK6hH7ELmOl/FDIt7jH/wVnT8D620s5zbk=;
        b=AWCVXUrVCN0HA/bb8T86XVYsIPVAUeWrZD+f4QO/5wVjBD1yz9POeB9MSatZaFw1sC
         IituSCzT5sfZRbVE7j6CNSJNV0uItHyBgM4YXVHbsQZl/sUWJElT5k0isIeXRfai0FCR
         Xl3AqVnTpJV2MC8IiEP8Ebkog5cle1d97FE/ZXyutUxgRBBXkaC89DEqILZZCeQjq1+B
         X41Z3agG2CeIOWB9dQd7oXaa9ga3zGbMm2OkGpXCgCdFWQ/oQaQWzSpEy73Wyp+dAo2f
         OTaYM86aMfnA2hyUSuwFuc7ChKIe/0mLWtKXYybs0wdacx2zCDPRs0n0mCxktFsK2NnA
         FGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pPzRgueH6uK6hH7ELmOl/FDIt7jH/wVnT8D620s5zbk=;
        b=m+1h2VOGObLxFzw89iE7BwICeWgFg/hcVh69aMAoAaTrFhbS4bJkF3ZlujeUN6oss2
         dNF6FCCzM120yDJdQ7tSP8tcVbP+FF7W3YDZ3ndzAKSm2E14mzoVV8FWs+GZprmgrSI3
         Yb9lSKTFmAt03YJ7aEczoblA49whz2RWaXtzi+ghkRAZ3hlABxKDuoPwiP7CFGXUbWo0
         7OtIDk4127BPruPXwjtWZZqY7494/WGcZ4tq6f1/UL3SZaWkfiP/Wvr0t8kMJ8BJZXmp
         SMBxp2gE3zpWevJcwfOS9c8sBtbyWjrYZQmXyktjvDuFxrkOn8kN7pd+NqoXzZEP9bNX
         SesQ==
X-Gm-Message-State: APjAAAUtnstNdlvVExF0+KMMznUy7/kndgJd3UPTOY2uk5aPvaIeIcsu
        lg08JAINMGrkyfYljsOa0OA=
X-Google-Smtp-Source: APXvYqxcKF4Xn6UdfH6D3G90ypAQUDxpxkVVkJpuFB3DtIC1LVkspUWfOM6+eip0DCK+WKs9HRFzVg==
X-Received: by 2002:a7b:cb89:: with SMTP id m9mr4097199wmi.66.1574356336999;
        Thu, 21 Nov 2019 09:12:16 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 189sm330432wmc.7.2019.11.21.09.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 09:12:16 -0800 (PST)
Date:   Thu, 21 Nov 2019 18:12:14 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191121171214.GD12042@gmail.com>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
 <1574297603-198156-7-git-send-email-fenghua.yu@intel.com>
 <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121130153.GS4097@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Nov 21, 2019 at 07:04:44AM +0100, Ingo Molnar wrote:
> > * Fenghua Yu <fenghua.yu@intel.com> wrote:
> 
> > > +	split_lock_detect
> > > +			[X86] Enable split lock detection
> > > +			This is a real time or debugging feature. When enabled
> > > +			(and if hardware support is present), atomic
> > > +			instructions that access data across cache line
> > > +			boundaries will result in an alignment check exception.
> > > +			When triggered in applications the kernel will send
> > > +			SIGBUS. The kernel will panic for a split lock in
> > > +			OS code.
> > 
> > It would be really nice to be able to enable/disable this runtime as 
> > well, has this been raised before, and what was the conclusion?
> 
> It has, previous versions had that. Somehow a lot of things went missing
> and we're back to a broken neutered useless mess.
> 
> The problem appears to be that due to hardware design the feature cannot
> be virtualized, and instead of then disabling it when a VM runs/exists
> they just threw in the towel and went back to useless mode.. :-(
> 
> This feature MUST be default enabled, otherwise everything will
> be/remain broken and we'll end up in the situation where you can't use
> it even if you wanted to.

Agreed.

> And I can't be arsed to look it up, but we've been making this very 
> same argument since very early (possible the very first) version.

Yeah, I now have a distinct deja vu...

Thanks,

	Ingo
