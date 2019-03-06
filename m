Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD20C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC11E20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="pboDIV7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfCFUiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:38:20 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37695 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFUiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:38:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id x10so7140332wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 12:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dIOGep87u/oC04hHwu3SiS9hdcVziplp0CYZLZVIS/o=;
        b=pboDIV7VPb+RW/jlE7PLTwqEsOQ3iz6UvFDXOfy8oK73oWzGhBUKYR3LOBDMbth9X0
         nbMXc9Y/F65Kpzf2KxxAKwXZXK61orfiUHt5nRqs67u04DNISgKoTnZ+NIYneIeISH03
         SLfjFjeOiAFwDA+/2UAz0AD/T/kY3fkxMipSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dIOGep87u/oC04hHwu3SiS9hdcVziplp0CYZLZVIS/o=;
        b=lpzhbws/q/GHRV467wMmohebyahyG/gnW7WPsFv1J56Qfwqu/WodoZp3MEuTtxjCvP
         F69zq++3bQ7jyHgRtVmkpLVuT5rbqQxd0Fhx7xjggfUhmCoyPYHWBjFW3flSxQKGR50j
         CGHuO3xr3xkLI9ysXcOMo729KEVAyoYA+MX6e7Fchv2htNeVl/loIzqDmKa6AAfN5WHJ
         2KJAQTVXbpHod8tNQ5lpibpmWkOPEs88LkrKD0Wrb3CMsX3u3cqghCvkBpQzx07mWk8m
         1gnVMqxtHejOS/LXyHi19fYW80MS5YXHbvxjzK0nIrkOCoXn6dGK4UjEq8kjQUHWFMB2
         jElg==
X-Gm-Message-State: APjAAAW/j5ETOF6DPJxrswTvLYyH+tvM9M7b3XzFnBoueSvkF19nmFd/
        b9/Ss7nx3/VhaSq084pZDkrAHQ==
X-Google-Smtp-Source: APXvYqxGJKqXxVfaxwmD3t697ka/RWeSL6lHFg9sbwusujJrWnJbEuWGtEWlh6RFpaEisWOsrbZkiw==
X-Received: by 2002:a7b:c08b:: with SMTP id r11mr3216656wmh.133.1551904698150;
        Wed, 06 Mar 2019 12:38:18 -0800 (PST)
Received: from gmail.com ([95.149.160.82])
        by smtp.gmail.com with ESMTPSA id 12sm5535744wme.25.2019.03.06.12.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 12:38:17 -0800 (PST)
Date:   Wed, 6 Mar 2019 20:37:26 +0000
From:   Louis Taylor <louis@kragniz.eu>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        fanc.fnst@cn.fujitsu.com, bhe@redhat.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, ndesaulniers@google.com,
        jflat@chromium.org
Subject: Re: [PATCH] x86/KASLR: always return a value from process_mem_region
Message-ID: <20190306203725.GA23373@gmail.com>
References: <20190302184929.28971-1-louis@kragniz.eu>
 <alpine.DEB.2.21.1903062059570.1646@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903062059570.1646@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 09:02:47PM +0100, Thomas Gleixner wrote:
> On Sat, 2 Mar 2019, Louis Taylor wrote:
> 
> > When compiling with -Wreturn-type, clang warns:
> > 
> > arch/x86/boot/compressed/kaslr.c:704:1: warning: control may reach end of
> >       non-void function [-Wreturn-type]
> > 
> > This function's return statement should probably have been placed
> > outside the #endif, so move it there
> > 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/360
> > Signed-off-by: Louis Taylor <louis@kragniz.eu>
> 
> This lacks a
> 
> Fixes: commitsha1 (".....")

Fixes: 690eaa532057 ("x86/boot/KASLR: Limit KASLR to extract the kernel in immovable memory only")

Would you like me to resend with that tag?

Cheers,
Louis
