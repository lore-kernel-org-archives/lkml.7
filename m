Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1E8C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 05:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D3020661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 05:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f65Jht7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfCGFKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 00:10:07 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37935 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbfCGFKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 00:10:06 -0500
Received: by mail-pf1-f194.google.com with SMTP id n125so10481377pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 21:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1xLq0mXH8E/9KmncM/lk6Pz3t5zTQb4hBseR0b9hg6Q=;
        b=f65Jht7pxLoXPy7xu8kOmJ8UALdo7vSY86UyDWOAI0AIGGGxXqmQYjLyFbxjx+N5Aq
         cxwVRo52aRCIr+zzuDElW/+n3eHlcgi4+uZZ+tMe1IypNOAJiS07LZfweX9kWzHeAnNq
         SECoCtKBH/741HKdt53Wi/aPyQZO5z6AB7s4Axu+sb7/S4ngqAdqFbV2s0PlJEI/3+Er
         c3Xbl6Kd32qbz4xTkAeLJJo62ZlaPTprVeUcR1ZyqyECUeG9QWoApmj4xZJF8qRmjESS
         y9svyg9P8lFx3t9yKgzUuPs/hOOFJEufWUeoagPHqj+IKm8lSIArfLsXkpVNUBwtjdzF
         hpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1xLq0mXH8E/9KmncM/lk6Pz3t5zTQb4hBseR0b9hg6Q=;
        b=ZSCfJtXi8hXtTor6e+HGfOQITbBA3yldtpJKWWmH4+wCWM5VhWCm3YraZ09QCqCm/f
         Bb9C/r2iGRgsiNAueRtCLXH3X+0G/so0NalpOjDAN8AX1CuitAVDIO7uq/whtBlGeiti
         ag5byVKRLI/fQoqJBb9bVR1tpuPoB8ss4nzPd7fvceQ4jbjOIHR027yM2q3nB4TU7boi
         cMIxtJa9RnCxTklrrAgL1oiX6Q2lqlt/DSZjSqvpEkVEuTqmy09CY3j4HcYBWX9lMCPV
         fA++ABWNNph9Zh+np/Tfd6CT9Fbpapt4t3Cj3fUO/z0HIcCmC2fEbK3chPaa2llvCxf7
         XsYw==
X-Gm-Message-State: APjAAAXxUYLuZYnKRi76X3glM0o8eD4BzAFCqqiQGyRRaSqNL93Klvuh
        nxinqcriI5JZ0yR8yvoctBg=
X-Google-Smtp-Source: APXvYqyjb5KFM0IYBVNsozI/2nQGN0o28kUP0aWJon457JVYj0zuL901ggfRc8gfle+XmtJyqYuh9Q==
X-Received: by 2002:a63:5d48:: with SMTP id o8mr9797986pgm.297.1551935406038;
        Wed, 06 Mar 2019 21:10:06 -0800 (PST)
Received: from localhost (c-71-198-144-65.hsd1.ca.comcast.net. [71.198.144.65])
        by smtp.gmail.com with ESMTPSA id q62sm9111473pfi.183.2019.03.06.21.10.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 21:10:05 -0800 (PST)
Date:   Wed, 6 Mar 2019 21:10:03 -0800
From:   Richard Cochran <richardcochran@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] ntp: Avoid undefined behaviour in second_overflow()
Message-ID: <20190307051003.scr4us4gktenthyn@localhost>
References: <1551835710-53773-1-git-send-email-wangxiongfeng2@huawei.com>
 <CALAqxLXFGKDzxT-S9DDnjRRYvDB1Qq3T-tHYYGQXg3c47HtTbQ@mail.gmail.com>
 <20190306095442.GM21520@localhost>
 <alpine.DEB.2.21.1903061327350.1646@nanos.tec.linutronix.de>
 <CAK8P3a09XrQWSBJh5-t2WhUtMGvGQRE6coGyxjNDpX2k0bAyUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a09XrQWSBJh5-t2WhUtMGvGQRE6coGyxjNDpX2k0bAyUg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 02:37:21PM +0100, Arnd Bergmann wrote:
> 
> There is also y2070 (many RTCs), y2100 (some other RTCs, especially
> those that assume it's a leap year), and y2106.

That's okay, Arnd.  When the time comes you can come out of retirement
and cash in, doing Y2.07, Y2.1, and Y2.106K consulting  ;^}

Cheers,
Richard

