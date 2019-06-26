Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E254C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D915221726
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561584139;
	bh=yykw67F77XueBsIeF3ez6SwvtPQd4XMEZBFc8zoShBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d/zfplWW5DanA6IfEEKe/0mLgdRWq6LmTkjJgyaOfttX9ld4VmoVNL8t69tT6b6e3
	 RsjqOU8hBkXISRiO62B9RjE7iHvLNGP0x3IO3TLH6HbH00mSw+ihPl/a1u21dRA1hs
	 Vq0lS0rHmtkbD6A9cTZKmTnJ1YmZZ5FZjVGL/Omc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfFZVWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 17:22:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44775 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfFZVWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:22:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16so4353619wrl.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 14:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b/ZlpRZVxFBwECu4aPl39vi2j5gPrwixI4d7m3sK/64=;
        b=IC7h4DL0Jd8xxHf5DsPhE5L2PgLW6Tpq6Gk9wxuYxlcfy4cnNsylK3DTbTAX1L/gnV
         maHWEI7Gn2AD713Ct0iDg47H00Nq6l8JUac2t+YzbaOzSfrCmzKErpxAgbPv0Eq/w87j
         /INvpSE1XyRHxJuqJ67GjagRoZsQvw2whv2oTsFD6vqfAGrhA9YdY7hpAbgOjKPg57of
         PxalFtPIjnMSua5LUebXeBmMprVjkcxOniJsOGu0NNX/VDeVjPuIh7nfSjpnbBOP12+L
         8T4kLg1xfMrk4jdNiB/pe6ulDWsX+pTtMcNu5NeSCCUpqwiM+wa5fFV3uhzy8y14Ima1
         +uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=b/ZlpRZVxFBwECu4aPl39vi2j5gPrwixI4d7m3sK/64=;
        b=D00LSgE8sN/3wFvT2/hvjQIfxXR6NisQb3/wpmJNJ/+R8rUSEMGPIWnF6mS9F6IEBm
         YYwP6hPs1/290qAdT+4bo6mBiCAQe2C7zs2HIt6BWj0fQ2doAu3cMxy1M74rJ7JBlxMg
         tfoml3fDYPLCawjbqMILvQNYcxwS9P31XRrSonGvwm/GgOeJijMoHwPa9v5yYmoGwm9V
         iUbIY4bLdrgYFh+DEPi1EFH1dzGMC8GdEliTGb+vzWk4yW2GfVIhOVbkGSiXQ4UsJUt9
         Crt4DBQktY3FSw12lhp8F5xEl3aiiMrxrqvfJz97F0DI+bQ9qnuIMw5WDI35HBHi4fL+
         WL8g==
X-Gm-Message-State: APjAAAWSjLkXiU9FvM43YsukAJLkAkey9kYP9hMJIHGvUZliBM7dK9P1
        BdeGes7gGachpSdy/OLmJwI=
X-Google-Smtp-Source: APXvYqxY0zFVQVu47q977LPp6zqO/6lKRMOHFJ8gXnJ9bSiIHrW4EZtI/GhxKpTnltyOueqSMSL0wA==
X-Received: by 2002:a5d:4810:: with SMTP id l16mr4748749wrq.48.1561584136184;
        Wed, 26 Jun 2019 14:22:16 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s10sm41398wrt.49.2019.06.26.14.22.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 14:22:15 -0700 (PDT)
Date:   Wed, 26 Jun 2019 23:22:13 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: Re: [patch 00/29] x86/hpet: Cleanup the channel management
Message-ID: <20190626212213.GD101255@gmail.com>
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190623132340.463097504@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> When reviewing the HPET NMI watchdog series, I stared into the HPET code
> and the proposed changes. The latter try to add yet another layer of duct
> tape and ifdeffery to the existing maze. No, thanks.
> 
> The following series cleans up the channel management and consolidates all
> state storage into a single place instead of 3 different ad hoc allocated
> places which carry redundant information and make the code hard to follow.
> 
> The reservation of a HPET channel for a NMI watchdog becomes a few lines of
> code after that series and just fits naturaly into that scheme without glue
> and more extra storage and ifdeffery.
> 
> For your conveniance the series is also available from git:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/hpet
> 
> Thanks,
> 
> 	tglx
> 
> 8<---------------------
>  include/asm/hpet.h |    7 
>  kernel/apic/msi.c  |    4 
>  kernel/hpet.c      |  937 +++++++++++++++++++++++------------------------------
>  3 files changed, 428 insertions(+), 520 deletions(-)

Modulo the minor nits I just posted, all the other patches (not written 
by me) are looking good:

  Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
