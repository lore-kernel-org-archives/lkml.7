Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECECC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C55F20851
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BxxRly/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391340AbfEXL4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:56:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46981 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391289AbfEXL4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:56:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id r7so9702477wrr.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fIH1V2TkOLOizahELZLm8HyLwy2aaFtFRBz9J0PeBqw=;
        b=BxxRly/ajvZLSzLtmSK61bITxGipmBwL2OJdeWQO3mNyXxtVS8CEil/Hq9l4iMDC/B
         VEFZDVNkjxzqX0zbqaeHVXVNhpOn9cAJzdlqNPCzBx+7o6QywsG/hAWe603Bqw6bhPEs
         LDmeY9vGcEAOtfqf3dCRVdOkTV+JzURsWeF6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fIH1V2TkOLOizahELZLm8HyLwy2aaFtFRBz9J0PeBqw=;
        b=Apo+cTe17mtEokulMXob54Jr52rXAwkAS2ICmQ6S+YJqEunNXI+3Noisb+rt2bhVZ/
         bsduH2d5KDFKeZpCvTuGzxm1oB/ZWgHA9qHuFijsbCztpslvfdS37q0BqLA0JtRJ3Gry
         XGoEd4YqveK1/QzbUrAbwtUufHnZD8LQXWCxY8m0wlFGVSE5oKK9vYilKIllLtFDNPZX
         oQ8+y/rqtLeqTbs+gDr3HhPcAN6fmcnc0HQcUKiskhEOk5WH5DZt38Wlmr0oByNmU575
         oKBB3FIoGZGFL+KLGmAaHPUeiieHLg7o3lUma4yDGJGga6LoU8Hd7bRVHDrr9TWtYTKK
         +Prw==
X-Gm-Message-State: APjAAAUsqcKvhF2lx0gYcOkgWbuz/6xekw3Oh+t5bLYvYuOCABy8v41B
        XpnOK+Ch12O/TfuAz/pRo5CBMA==
X-Google-Smtp-Source: APXvYqxaUJk406M1CG/mbR9qjOGcTakZkRCyBja4St7JWs72rRudUYM+FwM44E6UaY6tFnqje5PA6A==
X-Received: by 2002:adf:e90b:: with SMTP id f11mr7526503wrm.291.1558698978195;
        Fri, 24 May 2019 04:56:18 -0700 (PDT)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id 91sm2540053wrs.43.2019.05.24.04.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:56:17 -0700 (PDT)
Date:   Fri, 24 May 2019 13:56:12 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH 1/2] vmw_vmci: Clean up uses of atomic*_set()
Message-ID: <20190524115612.GA21365@andrea>
References: <1558694136-19226-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1558694136-19226-2-git-send-email-andrea.parri@amarulasolutions.com>
 <20190524103934.GO2606@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524103934.GO2606@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 12:39:34PM +0200, Peter Zijlstra wrote:
> On Fri, May 24, 2019 at 12:35:35PM +0200, Andrea Parri wrote:
> > The primitive vmci_q_set_pointer() relies on atomic*_set() being of
> > type 'void', but this is a non-portable implementation detail.
> > 
> > Reported-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jorgen Hansen <jhansen@vmware.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> > ---
> >  include/linux/vmw_vmci_defs.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
> > index 0c06178e4985b..eb593868e2e9e 100644
> > --- a/include/linux/vmw_vmci_defs.h
> > +++ b/include/linux/vmw_vmci_defs.h
> > @@ -759,9 +759,9 @@ static inline void vmci_q_set_pointer(atomic64_t *var,
> >  				      u64 new_val)
> >  {
> >  #if defined(CONFIG_X86_32)
> > -	return atomic_set((atomic_t *)var, (u32)new_val);
> > +	atomic_set((atomic_t *)var, (u32)new_val);
> >  #else
> > -	return atomic64_set(var, new_val);
> > +	atomic64_set(var, new_val);
> >  #endif
> >  }
> 
> All that should just die a horrible death. That code is crap.
> 
> See:
> 
>   lkml.kernel.org/r/20190524103731.GN2606@hirez.programming.kicks-ass.net

I see, that was indeed 'racy' with my patch!  ;-)  Thank you!

  Andrea
