Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34604C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069F72189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567004638;
	bh=UdcxP8PvW8h4h3ltsMgYpEi3ypmTFhsT6eT1HrV6HXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ONcVWdbj4auDLhsaayQEMJRgLlivZ2ZcHuXSQMpo/0GpggkAccYoa4XGHGpeHfJWk
	 4cw9oquVk9PiAeWSIbXm+exxqNFPwo/g8t24e4COdrPUATrncHvuyDez/3NNKw9t7P
	 iiSCRFOCi3tF65KzfOY+3qwrJxPacfDWb+7zFFmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfH1PD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:03:57 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:35855 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfH1PD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:03:56 -0400
Received: by mail-wm1-f42.google.com with SMTP id p13so423755wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 08:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ev+eyec33mKCmlxne5PpZs8ItbnOEVrmXSsAxEwGuYk=;
        b=bPg83++Fji41iN7cKuEycpbpRKjFtc0Z7u/+iLVCFSA4JPpulgWXQwNFe1Et2g0t6d
         duQwf9o8hPaLKm7pAv0ITd0OAiYzOXBHU5P6t5ysU+4b9140Tg3ObV9PVFYYKvZPPexB
         Zf7TTjoMm3Xpsc+CYXwZVtWQ4qUJ7+skM72kUyAgyJ1hc/oSh6q6QJCDwe+G4BHKoGau
         IcaKJXhU1DmgKXwJMxPsQZUCd06lQi9GrHobmWzSLPxt1gZtFqPz2ougvgMJZcMtc/Yh
         kmNh73j913rPrOWnQXf1Tw4hOfm6Q5Ig93+MySZIMgjIuijgX+W8MO6t5GdmTg09eApq
         fyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ev+eyec33mKCmlxne5PpZs8ItbnOEVrmXSsAxEwGuYk=;
        b=Chj1gvKgMQMyUaoDcAijF9RjapoObj7aIiAp2BjCUJy8T5Pu5MyQrvvWTn4iF05C1W
         5CNDzRN0LK/5evWtv5t3ul6tFce+DBiKP3HnCXR89KouigO41TZVsln5D5atIe0c93ii
         FiChMREv0Mu6JMJbpkmsKgflXLnA5RNN2pQFhlEOa1LE0G6bxMecl+6njZTl8yxUUwM0
         GiZPEstztljummF8U0SYvDvmXAFWfQRqfHXQZfv/i/gU+WINkTof1h/dTwox0rWfkTxH
         ArDaohQN0uk4VU50phPIAGXtAmmbnokVG/RzquhrB0RfqYVNr2mIc6MmZJt8xN623JQu
         wCdQ==
X-Gm-Message-State: APjAAAWEWhfx6GkNEGy2mscf4iAqlBUGHU1awIIGm82QZKi944XPQ7Rd
        9Qfz9XhX1qJF2pRvxO+2APbICTyv
X-Google-Smtp-Source: APXvYqxZtunqdyf/S38Gt3Uc2V14Czl2S4pOvLDuxLxuW0Y2j6Jd+0zMp/FvL4Lbh803TjMwVTa3SA==
X-Received: by 2002:a7b:cf2d:: with SMTP id m13mr5467420wmg.120.1567004634967;
        Wed, 28 Aug 2019 08:03:54 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s19sm4665558wrb.94.2019.08.28.08.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 08:03:54 -0700 (PDT)
Date:   Wed, 28 Aug 2019 17:03:52 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH -v2 0/5] Further sanitize INTEL_FAM6 naming
Message-ID: <20190828150352.GA14545@gmail.com>
References: <20190827194820.378516765@infradead.org>
 <3908561D78D1C84285E8C5FCA982C28F7F43EC93@ORSMSX115.amr.corp.intel.com>
 <20190827215135.GI2332@hirez.programming.kicks-ass.net>
 <20190828093301.GE2369@hirez.programming.kicks-ass.net>
 <20190828125902.GP2386@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828125902.GP2386@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Aug 28, 2019 at 11:33:01AM +0200, Peter Zijlstra wrote:
> > On Tue, Aug 27, 2019 at 11:51:35PM +0200, Peter Zijlstra wrote:
> > > On Tue, Aug 27, 2019 at 08:44:23PM +0000, Luck, Tony wrote:
> > > > > I'm reposting because the version Ingo applied and partially fixed up still
> > > > > generates build bot failure.
> > > > 
> > > > Looks like this version gets them all. I built my standard config, allmodconfig and allyesconfig.
> > > > 
> > > > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > > > 
> > > > What happens next? Will Ingo back out the previous set & his partial fixup and replace
> > > > with this series?  Or just slap one extra patch on top of what is already in tip?

There was no extra patch needed:

> > > > First option changes a TIP branch
> > > 
> > > This is uncommon, but not unheard of. I'll talk to Ingo and Thomas
> > > tomorrow to see what would be the best way forward.
> > 
> > OK, I talked to Thomas and we're going to force update that branch. I've
> > pushed it out to my queue.git thing and I'll push it to -tip later
> > (hoping the 0day gets a chance to have a go at it, but that thing's been
> > soooooo slow recently I'm loath to rely/wait on it).
> 
> Done now. tip/x86/cpu should have the shiny new patches in.

Note that it's the exact same patches:

  old:  tip/x86/cpu 26ee9ccc117b: x86/cpu/intel: Fix rename fallout
  new:  tip/x86/cpu a3d8c0d13bde: x86/intel: Add common OPTDIFFs

  dagon:~/tip> git diff 26ee9ccc117b..a3d8c0d13bde
  dagon:~/tip> 

What you did was to backmerge my fix, but haven't changed anything else, 
right?

Thanks,

	Ingo
