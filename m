Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258F5C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE1F21841
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IYWLDzj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391020AbfEXLZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:25:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51117 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390654AbfEXLZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:25:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id f204so9002905wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZKAVSuVxSyjVxFHG79LiXe1L/1C8AwBPO3T5bevrATs=;
        b=IYWLDzj2SRGGv7nshR8CopxsYB3ZcTrqo3SNNKmp0qjTAgBJ+MJSJhMGxFlIePfT5T
         M5zyhAts08d2/In7mGc90k1D1ePGN4RUK3gyhkHIIrkzljYbsZPV38qEj5ktXAZA24tH
         VCZ+VVh9uC1+wA+oPQ7KKBbt/+vis8x37zZx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZKAVSuVxSyjVxFHG79LiXe1L/1C8AwBPO3T5bevrATs=;
        b=Cfg8kOT1es2gH1PbXgb5peoE4qCPh3YQWl7Mp9UBNkyl7NDtQQTLc6e5A7Q68cCLVS
         duHBNXOq87KGIz5TRGVBXvjTh9Qk6VX4vSoaRqwh2+gxgEm75FztJ0lemLkfyCgteHNa
         4n5RllHcuHvXm6+3E6O4Wt1Ip7iGm9HWlWbHUzluyd47T8BQYg0fYePlxE4azYCPyPYk
         FU+kzrhBkqjkZLcBxcc2I/aUBw3dINRA/bmgDLEXM0sCabk+D9czNtvnAp82AQBretLm
         DlMZjsTo2ljsk3oQNG6yJ/3oqTUfEFZxhim3E3xZPXUpRONEKO5YOFxfnR4WLVaLz4AH
         u5qg==
X-Gm-Message-State: APjAAAWr8aGHiF61ytL0+VGnp0cfu2TdWC3Yn8dVWi+l5QhxZseR48gU
        iCsJ5StBTLOC6q+z60n4nMzWiwnUEJqx8A==
X-Google-Smtp-Source: APXvYqx6gVep88Wtaj48QXoLN+bNvGAXEPpmV9oU8kakR7+AxMFAcwzlBNIVQsu59TGtmSyavcDj5g==
X-Received: by 2002:a05:600c:2116:: with SMTP id u22mr15347421wml.58.1558697103821;
        Fri, 24 May 2019 04:25:03 -0700 (PDT)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id v5sm4180337wra.83.2019.05.24.04.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:25:03 -0700 (PDT)
Date:   Fri, 24 May 2019 13:24:57 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH 2/2] compiler: Prevent evaluation of WRITE_ONCE()
Message-ID: <20190524112457.GA20149@andrea>
References: <1558694136-19226-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1558694136-19226-3-git-send-email-andrea.parri@amarulasolutions.com>
 <20190524105339.GC12796@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524105339.GC12796@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 11:53:40AM +0100, Mark Rutland wrote:
> 
> This would be better titled as:
> 
>   compiler: don't return a value from WRITE_ONCE()

No strong opinion here: I'll adopt your suggestion in v2 if there are
no objections.  And similarly for the rcu_assign_pointer() patch.


> 
> ... since we do want the WRITE_ONCE() itself to be evaluated.
> 
> On Fri, May 24, 2019 at 12:35:36PM +0200, Andrea Parri wrote:
> > Now that there's no single use of the value of WRITE_ONCE(), change
> > the implementation to eliminate it.
> 
> I hope that's the case, but it's possible that some macros might be
> relying on this, so it's probably worth waiting to see if the kbuild
> test robot screams.

Absolutely!  Does kbuild process your tree?  I might be worth to apply
the patch to just see what kbuild 'think' about it...


> 
> Otherwise, I agree that WRITE_ONCE() returning a value is surprising,
> and unnecessary. IIRC you said that trying to suport that in other
> implementations was painful, so aligning on a non-returning version
> sounds reasonable to me.

And I should probably also modify the few #define-s under tools/ (that
I missed in this iteration...)

Thanks,
  Andrea
