Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1549FC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1C2206E1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6qUKjy+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfKMRWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:22:07 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41460 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfKMRWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:22:07 -0500
Received: by mail-lf1-f68.google.com with SMTP id j14so2600846lfb.8;
        Wed, 13 Nov 2019 09:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kV1Wcdoyb3tKkjtZ6TiX+SctpfjtVlKeBG+DTOA7wco=;
        b=H6qUKjy+MIZ5DBe9pQIP/fOIsyk7X/1ym72XQuXiEOFm3FEysa6i8nj1wu//7qFbuN
         Rt1waOKtzNR0HNdxhROvzLzeMN2l0gzpdLkzNF3a2end5ARGrKaJ/pJ/8cEw4zCmE1iY
         74prm7mtFRNkAezXqAix5mcfLBByncIoMniVRKM6pcPGzcKF3HGWN3xWZTVzr+0l6N3C
         H2RyOI8wIbUTZ5GtNFDfRzVUXBbYccS1wknug0zQw1ZHxbc8LAmXMLTLY9TnwbXYLj5k
         xKosD5SBYYXJofqwIJhaO7SvfZUSYpQqGLKF20qyempqJ0DGfwmOZIU+w8SMlwyz8H7L
         DLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kV1Wcdoyb3tKkjtZ6TiX+SctpfjtVlKeBG+DTOA7wco=;
        b=PHmJXhjIUzcxL7lu8/+PHZNxuqR/Acxk9Qb2OjMG+AyN9HitWM4yVPXq/M33tBQyXJ
         w6Ysb/gDVzAOeLgLFCaZZ1xJbk/LTa3KBpUTe7tDwKXO5TBzgqf+UUUFKZwVY6iJ82A0
         4tuWCkKnhi6SmT4uyiA8+WrvbqQ6WbImQ0S8LTuRXOk8kQPjuo0pFpYcPNuFh8IgTzdV
         GFEGDIQ4ug5XfQzcA6/K92mhgusfncrY/X3jLWqHgweFjZ1A2MwqDIx5h4y2gvgNwK6y
         DJup4qwPQ9s2gFwY1b5ppwqTOo9s8ycD14Wez0OrKZ8HiMhOxNR9xe8ZlHIJK5llwl45
         u3dw==
X-Gm-Message-State: APjAAAVM+itPPBT+U0P4dvmcPoC9n/FpXXAx2+6YAaadXF0eJXG1DZch
        Lo4Hqy2/oNVL1i0jcpOLpa8=
X-Google-Smtp-Source: APXvYqwkFdruCHuBviiwuej3RfXe8TmCFvDSnosIsvIFb+Byv8brgs/Rc+dEjF/7zAtPTKiEK+lr2Q==
X-Received: by 2002:a19:494d:: with SMTP id l13mr3657711lfj.66.1573665725268;
        Wed, 13 Nov 2019 09:22:05 -0800 (PST)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id f14sm1122510ljn.105.2019.11.13.09.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 09:22:03 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 4CB514613FE; Wed, 13 Nov 2019 20:22:03 +0300 (MSK)
Date:   Wed, 13 Nov 2019 20:22:03 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        alpha <linux-alpha@vger.kernel.org>
Subject: Re: [PATCH 11/23] y2038: rusage: use __kernel_old_timeval
Message-ID: <20191113172203.GE5130@uranus>
References: <20191108210236.1296047-1-arnd@arndb.de>
 <20191108211323.1806194-2-arnd@arndb.de>
 <20191112210915.GD5130@uranus>
 <CAK8P3a03FRfTsXADH+xfLsWxCu54JXvXbb-OdyGXXf88RNP34w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a03FRfTsXADH+xfLsWxCu54JXvXbb-OdyGXXf88RNP34w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 11:02:12AM +0100, Arnd Bergmann wrote:
...
> 
> There are clearly too many time types at the moment, but I'm in the
> process of throwing out the ones we no longer need now.

Cool!

> I do have a number patches implementing other variants for the syscall,
> and I suppose that if we end up adding __kernel_rusage, that would
> have to go with a set of syscalls using 64-bit seconds/nanoseconds
> rather than the old 32/64 microseconds. I don't know what other
> changes remain that anyone would want from sys_waitid() now that
> it does support pidfd.
> 
> If there is still a need for a new waitid() replacement, that should take
> that new __kernel_rusage I think, but until then I hope we are fine
> with today's getrusage+waitid based on the current struct rusage.

Definitely.

> 
> BSD has wait6() to return separate rusage structures for 'self' and
> 'children', but I could not find any application (using the freebsd
> sources and debian code search) that actually uses that information,
> so there might not be any demand for that.

Thanks for detailed info Arnd!
