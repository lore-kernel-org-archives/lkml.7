Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACEAC31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 21:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2186D20665
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 21:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NaOJcl+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfFPVb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 17:31:27 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:43467 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfFPVb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 17:31:27 -0400
Received: by mail-pf1-f182.google.com with SMTP id i189so4509687pfg.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 14:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7VduBeQKV5QqdjaRJMGgAlmp2IHtPHNsUVn3EFkQ16A=;
        b=NaOJcl+yzjhCeEuveWJCk+ztsn2feghCQVbaTu/DJt/zO+DaY4tFj/CMCQsela+8h+
         EKmmF2vvjDrJU6JhpZFROJhfuBdfMvQrtx3BxSU/UtzB8jNzHBhvW5ji713pacfpK+ur
         T/RCfrXIOu2euKG9FHWvlH0SOhLRvANMeGHsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7VduBeQKV5QqdjaRJMGgAlmp2IHtPHNsUVn3EFkQ16A=;
        b=ZfFSf5qe5atXd9tmNFgoxwqDCbXHCfuUiQKbMNHzC8+C77lKDXxk3017l85JRskanb
         bLT3bw/paT25YhQPSnbV/FFZ4WkdSoA24PY2ZMpidoa8XbrA3f0Zf2olioUYMc3a2VAz
         Sxjfdq0Mv3zppTDIQ3LckpqUncsZ8YF9I2kC7EN+0mZuXUU+oZZ30ioyFeMIFdlbSdK9
         3gsMsPZGXQrpRawrRlzh7Drs1Rs4NZVML6RozJFwDqCUlypiiI06EaYJn5Jdc9ZUHBfR
         k9AiG7txuDulOgnpDs+wGx5bfnDMEwMRdv0DPs2BiWdI75FiJA5Xp4vynYA6GsbPvvgg
         mCMA==
X-Gm-Message-State: APjAAAXsM2Bg5XsKQm4t0XRjBALdM/2gyDrXtZjk3Umt7otAR382DRhm
        /FjzHtWOpUKmDNjGgvQJFj+CHA==
X-Google-Smtp-Source: APXvYqy5woxSa9sXUW5owSCTm3+vlDqFe+0XmxF8JtpZmxIUt7qyTuJKjIzBbbHvBsWgxujujdFMaA==
X-Received: by 2002:a65:64d6:: with SMTP id t22mr43708172pgv.406.1560720686430;
        Sun, 16 Jun 2019 14:31:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f11sm4268923pjg.1.2019.06.16.14.31.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Jun 2019 14:31:25 -0700 (PDT)
Date:   Sun, 16 Jun 2019 14:31:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Jan Glauber <jglauber@marvell.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC] Disable lockref on arm64
Message-ID: <201906161429.BCE1083@keescook>
References: <20190612040933.GA18848@dc5-eodlnx05.marvell.com>
 <20190612093151.GA11554@brain-police>
 <20190614070914.GA21961@dc5-eodlnx05.marvell.com>
 <20190614095846.GC10506@fuggles.cambridge.arm.com>
 <CAKv+Gu_Kdq=UPijjA84FpmO=ZsdEO9EyyF7GeOQ+WmfqtO_hMg@mail.gmail.com>
 <20190614103850.GG10659@fuggles.cambridge.arm.com>
 <201906142026.1BC27EDB1E@keescook>
 <CAKv+Gu_XuhgUCYOeykrbaxJz-wL1HFrc_O+HeZHqaGkMHd2J9Q@mail.gmail.com>
 <201906150654.FF4400F7C8@keescook>
 <CAKv+Gu9-rZ16Nb9t3=knzW0BHu0eNxQoPwWS4c8UMMm=2iqiuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9-rZ16Nb9t3=knzW0BHu0eNxQoPwWS4c8UMMm=2iqiuw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2019 at 04:18:21PM +0200, Ard Biesheuvel wrote:
> Yes, I am using the same saturation point as x86. In this example, I
> am not entirely sure I understand why it matters, though: the atomics
> guarantee that the write by CPU2 fails if CPU1 changed the value in
> the mean time, regardless of which value it wrote.
> 
> I think the concern is more related to the likelihood of another CPU
> doing something nasty between the moment that the refcount overflows
> and the moment that the handler pins it at INT_MIN/2, e.g.,
> 
> > CPU 1                   CPU 2
> > inc()
> >   load INT_MAX
> >   about to overflow?
> >   yes
> >
> >   set to 0
> >                          <insert exploit here>
> >   set to INT_MIN/2

Ah, gotcha, but the "set to 0" is really "set to INT_MAX+1" (not zero)
if you're using the same saturation.

-- 
Kees Cook
