Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B830C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568A6214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556015441;
	bh=0Wi65UInynQj74PRFkUlFc3EMGDs8aqLkUyBIKtcu7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lE4HDjivXANL9alvrqJkixgz/K2pCINepibGWkv9Ef1w6Vu7dO0y7rbm00QtWkjE4
	 G8/OneqOT0R98i66slHEy6h9IaVpxFhT3IgQtGezColIvLEm/bSmTNb1Ol5fek3G9x
	 0fKYbNAOKA3s7KfKmSrb1vVwv20djrouGXfOY6mE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfDWKak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:30:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41737 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDWKaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:30:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id c12so13344002wrt.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 03:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RkYx4VVXuM+AQksPd61bD8N8/jg5mPWg3jCHNvjS0zg=;
        b=JbOJ36g5HrEYz1hpICE1KVLKHclv3MCpr8FHTQilDMksA7XYQBfIoQkS/yarKhGK0F
         ShOJbv6Bv74yOCvyDng+iMVJqf/lrroHfBAvXRAcic+PW8tGmugeowAt5llXdRsBRx0Y
         IAr0ZCRiAxl4mHE3tI/xooMJqz/ggJseIRRh+gzzjufA3zESJIpPsAymAs5G6IcJq9lz
         L4DaGQTSJZcTLpPp+DT8Z7r33OrNOQ89q+v597A+AwmmDIMcSGAJ6eGF7k/s4VJQGp7h
         eCKin8lXPXwtFQ8/JUQ/WY3qVh2cE2x7FpKemmvbJHNvT6yFHWSp/1S0vIpGw3J/SbF5
         EKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RkYx4VVXuM+AQksPd61bD8N8/jg5mPWg3jCHNvjS0zg=;
        b=Cml/E6d0E15FnixgDYrLYko0FNmAIJ1R7hp3pmTbjWB9OCoNIvYTZy4CVlY/QIE1oj
         5u1OyUuTr9ihKH1/0X0f2o1/C52biQCVSCCXNz3VS1hn0DDTLG9a4A4H5ZXNjBa/H0fI
         L/ygBACLNOth6oPvRFZzflBxRATYSSAsB3+Za/9SzWZFEWDzhaezK06IbJZ3qC9Yq/35
         EItnl0xJFnyNo+9+lzs6CcWPhnWgIlh+58h9DjRCp6tS0Q1YOcFc3UzwadlRrXhfgKBr
         5Semuc7YSRmr/d9tbo688cQBb9bdWq7qICHcEHZiWG0IwgLhuIyRz4HylgXNqZyLTJwo
         ZeeA==
X-Gm-Message-State: APjAAAVpAsoXX0JI0BhZLCl0sMkm3Ygc/JL+6oDbpUly8YMf/Lpp+NGC
        Ku+tzjUJoxilLYWJpO3xFdM=
X-Google-Smtp-Source: APXvYqzDIjlx/x4Gvat1wMnogikn6fpVGMs/hlQ01RsoqmF1Iap71YNyV9KFAsRoajeX0dm2dEmnGQ==
X-Received: by 2002:adf:ebd0:: with SMTP id v16mr7041309wrn.175.1556015438048;
        Tue, 23 Apr 2019 03:30:38 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l1sm4272943wrh.58.2019.04.23.03.30.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 03:30:37 -0700 (PDT)
Date:   Tue, 23 Apr 2019 12:30:34 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Daniel Drake <drake@endlessm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: [PATCH 2/2] x86/tsc: set LAPIC timer frequency to crystal clock
 frequency
Message-ID: <20190423103034.GA8216@gmail.com>
References: <20190422101526.28415-1-drake@endlessm.com>
 <20190422101526.28415-2-drake@endlessm.com>
 <20190422120451.GA9499@gmail.com>
 <CAD8Lp44ZaifPf+809BzbLg=9ijsRsE=7JMVpXkqRenY9radpZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD8Lp44ZaifPf+809BzbLg=9ijsRsE=7JMVpXkqRenY9radpZA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Drake <drake@endlessm.com> wrote:

> On Mon, Apr 22, 2019 at 8:04 PM Ingo Molnar <mingo@kernel.org> wrote:
> > Minor style nit: the parentheses are unnecessary, integer expressions
> > like this are evaluated left to right and multiplication and division has
> > the same precedence.
> 
> Fair point, although the same could be said for cpu_khz_from_msr().

Yes, this standardization on mhz, if it makes sense, might have to be 
propagated a bit to function names and any other variables.

Another naming quirk: what unit is 'lapic_timer_frequency' in? AFAICS 
it's a "period" unit (number of clock cycles per jiffy), not a frequency 
(which is number of cycles per second) - so the better name might be 
lapic_timer_period?

> > But it might also make sense to actually store crystal_mhz instead of
> > crystal_khz, because both CPUID 15H and 16H provides MHz values.
> >
> > That way the above expression would simplify to:
> >
> >         lapic_timer_frequency = crystal_mhz / HZ;
> 
> Wouldn't it be
>         lapic_timer_frequency = crystal_mhz * 1000000 / HZ;
> ?

Sorry, what I wanted to suggest is crystal_hz, not crystal_mhz.

I.e. store the raw unit that comes out of the CPUID, which appears to be 
HZ, right?

That would change the calculation to:

         lapic_timer_period = crystal_hz / HZ;

Note how clearly it's visible in that calculation that what we calculate 
there is a 'period', not a frequency.

Thanks,

	Ingo
