Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F846C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335FB20684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570458782;
	bh=HUl8R52T7cgkb8x/4TNM2OXj952tdm3KUZZ6WIxxfYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s945NTL9RE1h70K8kPaNVte/fA2V6iO0MpHhFzDlrtslN7wwG1fI8pZAbXNQBU1zg
	 +Y7C5PS/CIIIl1Gr0JEbuFWy8H2rJWOZq9tRbw50hkWfds0BIe0MP0PD/hKtZCkFsm
	 LlbAAUwjbdwx5snUyUBEee855XXvdIFJHpWJdbv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfJGOdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:33:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50277 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfJGOdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:33:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id 5so12967528wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 07:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RbUgSQOnWa53bBkdI6rRTzXWR2R4wDQN9/kHVcEwC6o=;
        b=tXsaEI8mGNFUVgDijftGUXCp9c+l3lZyuY6TZuXnrSpAAsWMxDIgcKqVIM7AnJZWsl
         i1Wkzo5xc9Bn2iJ3FJ7f3jFt5+jG6Of8RgIFXAyf1VZ9z7Yg4XbhNwnXIUEGIW2WqNl0
         TbmbFNe++4YCbA00Vky8ODQXR8HyHxBYCYOUuCRQaWZv8nJ2ktNPKDj0pH1QQj8MoM9/
         wJePRxTJ/K73cYez7cxv3UW2PxOvGh/TYuuWiz0xslatu/z47QAVDQhWPOZKgjnI7Tr5
         Rezksxxy1vJb2aJ/FoYwV0H4HMZn6VIjNaT6B0QF6GI5DCmTwH+fb024XXx3m6zALA++
         QIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RbUgSQOnWa53bBkdI6rRTzXWR2R4wDQN9/kHVcEwC6o=;
        b=QNbYX0Qx6bXQ8fTaE7YBKGuESab9v/YPZJnUgX9A/UIE3kQJ0HjoR0Pd6tg/TW5qHO
         Dvf/S/jc08EkhQhi+LZyDCmdD7xyM025Espbn8zc2Ng73Y5rk+UwpZqjYCMnOjjxkH8q
         V311OpCFLo8XP6A6GvtyNkh1YXYZqNaXbgw404tEZomJiSS0WMk+T8tMXjIoVRX2TDe8
         NuxwBjuMRvLiG1sUnsksK7FPpF+86bJvs4D/8Cfq4lp+aEV2i+ctu52LvdZ7JSZAptCP
         3nPKsOd5M3G9OkP3t157qCeAIB80FrBdUw/jzbuQoHADKWXzNBicA3Bbz5R4E1yF/YTn
         AJGQ==
X-Gm-Message-State: APjAAAUIVzdEY1yqSETWD3w4n3NgWM3T5vj3Zy7bXT9CW7WlPHS45p7h
        oIV54sFPdJVVR894TEv7tak=
X-Google-Smtp-Source: APXvYqzl+jzKWZLyIMNNqiv+oPhBzAl9hAq7FoY8g2PwWnK7jN84Tn2zwg2p7xEXWpdfUsU0vYn3FA==
X-Received: by 2002:a05:600c:2052:: with SMTP id p18mr20648347wmg.13.1570458778650;
        Mon, 07 Oct 2019 07:32:58 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e18sm18437044wrv.63.2019.10.07.07.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 07:32:57 -0700 (PDT)
Date:   Mon, 7 Oct 2019 16:32:55 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Changbin Du <changbin.du@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: determine whether the fault address is canonical
Message-ID: <20191007143255.GA59713@gmail.com>
References: <20191004134501.30651-1-changbin.du@gmail.com>
 <8b2c8164-d7ae-20b7-ff48-32eab9ec9760@intel.com>
 <20191004153115.GA19503@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004153115.GA19503@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Sean Christopherson <sean.j.christopherson@intel.com> wrote:

> On Fri, Oct 04, 2019 at 07:39:08AM -0700, Dave Hansen wrote:
> > On 10/4/19 6:45 AM, Changbin Du wrote:
> > > +static inline bool is_canonical_addr(u64 addr)
> > > +{
> > > +#ifdef CONFIG_X86_64
> > > +	int shift = 64 - boot_cpu_data.x86_phys_bits;
> > 
> > I think you mean to check the virtual bits member, not "phys_bits".
> > 
> > BTW, I also prefer the IS_ENABLED(CONFIG_) checks to explicit #ifdefs.
> > Would one of those work in this case?
> > 
> > As for the error message:
> > 
> > >  {
> > > -	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. Non-canonical address?");
> > > +	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault at %s address in user access.",
> > > +		  is_canonical_addr(fault_addr) ? "canonical" : "non-canonical");
> > 
> > I've always read that as "the GP might have been caused by a
> > non-canonical access".  The main nit I'd have with the change is that I
> > don't think all #GP's during user access functions which are given a
> > non-canonical address *necessarily* caused the #GP.
> > 
> > There are a billion ways you can get a #GP and I bet canonical
> > violations aren't the only way you can get one in a user copy function.
> 
> All the other reasons would require a fairly egregious kernel bug, hence
> the speculation that the #GP is due to a non-canonical address.  Something
> like the following would be more precise, though highly unlikely to ever
> be exercised, e.g. KVM had a fatal bug related to injecting a non-zero
> error code that went unnoticed for years.
> 
> 	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. %s?\n",
> 		  (IS_ENABLED(CONFIG_X86_64) && !error_code) ? "Non-canonical address" :
> 		  					       "Segmentation bug");

Instead of trying to guess the reason of the #GPF (which guess might be 
wrong), please just state it as the reason if we are sure that the cause 
is a non-canonical address - and provide a best-guess if it's not but 
clearly signal that it's a guess.

I.e. if I understood all the cases correctly we'd have three types of 
messages generated:

 !error_code:
	"General protection fault in user access, due to non-canonical address."

 error_code && !is_canonical_addr(fault_addr):
	"General protection fault in user access. Non-canonical address?"

 error_code && is_canonical_addr(fault_addr):
	"General protection fault in user access. Segmentation bug?"

Only the first one is declarative, because we know we got a #GP with a 
zero error code which should denote a non-canonical address access.

The second and third ones are guesses with question marks to communicate 
the uncertainty.

Assuming that !error_code always means non-canonical access?

And hopefully "!error_code && !is_canonical_addr(fault_addr)" is not 
possible?

Thanks,

	Ingo
