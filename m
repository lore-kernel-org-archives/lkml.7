Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59927C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F45B21955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DOsklcpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbfGVSjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:39:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32911 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbfGVSjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:39:05 -0400
Received: by mail-pl1-f195.google.com with SMTP id c14so19495568plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 11:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=afjBQ4g1IUXo6zFCrmEJVVK94nPsD5XPtVTs3wYkEsM=;
        b=DOsklcpWWHEHgtX/MFkcdhA/HFtRclgtibfG0Vnq7ElGVc6PXgFuMrUR8UodNp0eck
         nfP+9FM6zeCJsAOiGLJxakLADdLMFsgc0wVFFrw1ETS7mdTgZ2wjqBG8KEydbQ3WjQXb
         1APpm7tVwnUvMpOCHUdjCzgsUquGBBVdW5iPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=afjBQ4g1IUXo6zFCrmEJVVK94nPsD5XPtVTs3wYkEsM=;
        b=WEs7QnmnnsSjrDoaXYx8MOD0oqe3ve6DbFCxH5/gKzoJQhoHuREl9aFY+fLAocqq7Z
         gs0vMNTdGVvi2dZxSFTuyb13xKIw/bDQ0Os3qgL1bkai5ffyM4h91m4irU6XdQ8E8F/f
         i4tG11IjBXM0DaIH6s0pnorjBrhmsZ8+UlNjEOQ1a/4J2Nx3nGyFc6uKawsxPAq6Ag2p
         6GY7CqhaWH2eU9aDKBoMxof3ZGEQefdOhlB19dAo3dt0uQg57Jnfd4OEIva+MQuLsoBA
         4oChs1atM4paT1QCKE1l3ZslCHOZI+syuGGsUqZAXqNwOagc+G0nzZpJI11a9wfRIFKm
         nUuQ==
X-Gm-Message-State: APjAAAXWj14rsKPwp8P1x6sYvT1zLZVKLAVAt9h1YjuMABhBEOO6SI4Q
        Dv1/Jk75uPfGXCfnUp6KAMriLQ==
X-Google-Smtp-Source: APXvYqxOYw+6ay19uiXshqpTfMuapAEG62UyetZAjMPrfJmQVvNv5uMBQqK4dT6PpTS0Barpxj2BQw==
X-Received: by 2002:a17:902:20e9:: with SMTP id v38mr77533322plg.62.1563820745282;
        Mon, 22 Jul 2019 11:39:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u70sm4087577pgb.20.2019.07.22.11.39.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 11:39:04 -0700 (PDT)
Date:   Mon, 22 Jul 2019 11:39:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [5.2 REGRESSION] Generic vDSO breaks seccomp-enabled userspace
 on i386
Message-ID: <201907221135.2C2D262D8@keescook>
References: <20190719170343.GA13680@linux.intel.com>
 <19EF7AC8-609A-4E86-B45E-98DFE965DAAB@amacapital.net>
 <201907221012.41504DCD@keescook>
 <alpine.DEB.2.21.1907222027090.1659@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907222027090.1659@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 08:31:32PM +0200, Thomas Gleixner wrote:
> On Mon, 22 Jul 2019, Kees Cook wrote:
> > Just so I'm understanding: the vDSO change introduced code to make an
> > actual syscall on i386, which for most seccomp filters would be rejected?
> 
> No. The old x86 specific VDSO implementation had a fallback syscall as
> well, i.e. clock_gettime(). On 32bit clock_gettime() uses the y2038
> endangered timespec.
> 
> So when the VDSO was made generic we changed the internal data structures
> to be 2038 safe right away. As a consequence the fallback syscall is not
> clock_gettime(), it's clock_gettime64(). which seems to surprise seccomp.

Okay, it's didn't add a syscall, it just changed it. Results are the
same: conservative filters suddenly start breaking due to the different
call. (And now I see why Andy's alias suggestion would help...)

I'm not sure which direction to do with this. It seems like an alias
list is a large hammer for this case, and a "seccomp-bypass when calling
from vDSO" solution seems too fragile?

-- 
Kees Cook
