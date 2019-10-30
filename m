Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23B4CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED7720717
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mKFvbx8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfJ3Ttx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 15:49:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45628 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfJ3Ttw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 15:49:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1so2152641pgj.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 12:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GsUe1Wv0asWvlULQIAeQdfJEV8oOIy0jm7AS7PH13QM=;
        b=mKFvbx8+Ur0VWbOawosp16f0+2DVQV0YaMiBp0a8ffMylctSLmNfnbktb4IDkGSSlm
         t2J8LGUIH7gRdDdCm0Pd1JHAGE7mCjissmr1rgOixyJFxYFFV2Kpvvse8G+TGH/vXgSP
         VZY4lEF/rHr1YmnbKyBkgRa7/S7xOdPtJDkNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GsUe1Wv0asWvlULQIAeQdfJEV8oOIy0jm7AS7PH13QM=;
        b=W0kArBbLPVAgVzkLCieJWXhY0VZMgpKTHx7SXzn954ztPkRtKRC4FFLV62LVRMu5AR
         eMRhbCeiavxp5bDqwLXht+/R7BHV2R+0f9GD9+pISMSnYrG+XYLaPxM1mm0A/4dCQD9e
         xCXx882gmc+s3HxScILtI9q1zskznbeGi0u1T1OU2M89lyrlX/dF8o6B9/buty39EcS2
         5YApel4I2ZJes1pBtIUsz8aL0O8N81H0qIwGE3bABtVEF/TO+Xh3t32i+tyR+OZmFQGf
         o0WIHEHX5YtfZcMEaQr5gHVdAT2AnRa+PCr7LTPhu0ks9cr2WtVRTn3B2dMxD9mYM7tt
         hoIA==
X-Gm-Message-State: APjAAAVF1r9RsxTJVOOcvvrcz5XX1Q87zn9O9i6O4itBVu8beFWEwYRW
        iDmCSawh2rNNVHR/vLxAw8NLBg==
X-Google-Smtp-Source: APXvYqy0g3+VIM9woycIWCMOi9IxwLtAjVmxPGoyweq4MW4CXE5MTpM0ucYqlARWuMq4vSQhUGI6dg==
X-Received: by 2002:a63:3205:: with SMTP id y5mr1346198pgy.42.1572464990725;
        Wed, 30 Oct 2019 12:49:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d5sm2917654pjw.31.2019.10.30.12.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 12:49:49 -0700 (PDT)
Date:   Wed, 30 Oct 2019 12:49:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Miller <davem@davemloft.net>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] tty: n_hdlc: fix build on SPARC
Message-ID: <201910301249.9070A9889E@keescook>
References: <675e7bd9-955b-3ff3-1101-a973b58b5b75@infradead.org>
 <201910301131.2739AA83@keescook>
 <9ef8c2a5-8510-c509-4c31-b8684b6e1c67@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ef8c2a5-8510-c509-4c31-b8684b6e1c67@physik.fu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 08:29:40PM +0100, John Paul Adrian Glaubitz wrote:
> On 10/30/19 7:34 PM, Kees Cook wrote:
> > On Mon, Sep 30, 2019 at 07:15:12PM -0700, Randy Dunlap wrote:
> >> From: Randy Dunlap <rdunlap@infradead.org>
> >>
> >> Fix tty driver build on SPARC by not using __exitdata.
> >> It appears that SPARC does not support section .exit.data.
> >>
> >> Fixes these build errors:
> >>
> >> `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
> >> `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
> >> `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
> >> `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
> >>
> >> Reported-by: kbuild test robot <lkp@intel.com>
> >> Fixes: 063246641d4a ("format-security: move static strings to const")
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > 
> > Wow. That commit is from 2.5 years ago. Is the SPARC port still alive?
> Yes, it is. No idea why we didn't run into this. I assume it affects certain
> configurations only. On Debian, we are always compiling and running the
> latest kernel versions on sparc64.

Yeah, that's what I thought. I also didn't hit it 2.5 years ago when I
did multi-architecture build validation of these changes. :P

Randy you've found a nice corner case! :)

-- 
Kees Cook
