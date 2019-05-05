Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B006C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 12:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A5C20675
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 12:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XP/vtf0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfEEMiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 08:38:09 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42173 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbfEEMiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 08:38:08 -0400
Received: by mail-io1-f65.google.com with SMTP id c24so8852116iom.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 05:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Env16Kjh/S/tPnSWgndkg5+56faTqmTyePlsgJmP09M=;
        b=XP/vtf0Dlv9BGu3OP4nffNiWlGm7z/cvckO4+kX5ZKF4IJtf+OZcnEP/FUYEcmRX7d
         4s3WoTpZ011CUs78Bw4H3hVnCYaN0cMqIK9GUKJiXQ/NCIOn1j7q7xPAVm9WKhUPWYoH
         8+z2CKe5dnlhNvHn4iO6OBRIBwbllA68q8mtBqbBNcL6t+bO1AP0caZ6crIyMDhV2kgI
         /Dnor3a6Ey3sJUb6EDWUYZIODSn/OLUcRAq0FXP3hPqLL8FMkk7QQuix7RMbYRkl55nC
         md0Bwh3jJkaWpJ5N6+AqprdXmeRBgrDdmJTRtHGxUDQKN4oBFx2lLk4fMm2TxLJYG2H5
         YIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Env16Kjh/S/tPnSWgndkg5+56faTqmTyePlsgJmP09M=;
        b=pG+TDvK4rrxlUH7ZA/qMAk97I9kIHR6/br/4yAqEKSH7upoGBMG3KdlIsVCM9rWqjt
         KDHqFR4GfKgtCXKtPx6p31iI4NaAvHLGjHOYNQGPNkeTj5QtH1ZHyhcMuPF8TfgJ7dVm
         IqDIQ+YbYQOGTPTTkw7js0zH26i/LUSx5104GKhMO/P6aNVtwHK2G7GofbDhUgTJeIMA
         TMu72UF/WbSX4Is6xfFuN348nD4Q5uouDRykSBvzC5kRE4xG7KPeKXMwggkDwYpBA8IO
         NpiRdwjfg9pck2xPPOc7bEnA4UJ/pB8ttwVR6d1d1fhmQibKabIHmheW2QoGjFxSx4JB
         XDVw==
X-Gm-Message-State: APjAAAUjOFj8lmD48AKIW8GS+TK6kht7g7kdi2yhGmlPF4jebaPaLJVG
        JFOt297BJrjCziIEKfmtGgacrw==
X-Google-Smtp-Source: APXvYqyNcDuss+Z4/v3Efpyj8txBV/fjSy5ttytvA5R44fIHq2k5zf1CuBdHu8UAkV3gXrzTIMKDXA==
X-Received: by 2002:a6b:b745:: with SMTP id h66mr8530702iof.107.1557059887916;
        Sun, 05 May 2019 05:38:07 -0700 (PDT)
Received: from localhost (c-75-72-120-115.hsd1.mn.comcast.net. [75.72.120.115])
        by smtp.gmail.com with ESMTPSA id n138sm3480757itb.32.2019.05.05.05.38.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 May 2019 05:38:06 -0700 (PDT)
Date:   Sun, 5 May 2019 07:38:05 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.19 00/23] 4.19.40-stable review
Message-ID: <20190505123805.u7ivqoof777b6uqb@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, Shuah Khan <shuah@kernel.org>,
        patches@kernelci.org, Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
References: <20190504102451.512405835@linuxfoundation.org>
 <20190505030044.q3dlgd5bhfx5txmf@xps.therub.org>
 <20190505070854.GA3895@kroah.com>
 <CA+G9fYv668HB5nZSn_drMd5cLhfH7GP0NxDsF88wtp3MUAMimA@mail.gmail.com>
 <20190505090236.GA24937@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190505090236.GA24937@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 05, 2019 at 11:02:36AM +0200, Greg Kroah-Hartman wrote:
> On Sun, May 05, 2019 at 02:23:22PM +0530, Naresh Kamboju wrote:
> > On Sun, 5 May 2019 at 12:38, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sat, May 04, 2019 at 10:00:44PM -0500, Dan Rue wrote:
> > > > On Sat, May 04, 2019 at 12:25:02PM +0200, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 4.19.40 release.
> > > > > There are 23 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > >
> > > > > Responses should be made by Mon 06 May 2019 10:24:19 AM UTC.
> > > > > Anything received after that time might be too late.
> > > >
> > > >
> > > > Results from Linaro’s test farm.
> > > > Regressions detected.
> > >
> > > Really?  Where?
> > 
> > Not really.
> > selftest: net: msg_zerocopy.sh is an intermittent failure on qemu_i386 device.
> 
> Is that a test problem, or a qemu problem?
> 
> > We could ignore this failure as known issues.
> 
> It wasn't listed in the report, or did I miss it?

It needs further investigation, but it's unrelated to this RC. It's an
intermittent failure that we see sometimes but only ever on qemu. With
the amount of tests that we run, this is common - our process is to
investigate the failure and determine if the failure is a regression or
not. In this case, I determined that it was not a real regression, but I
did not run the right command to generate the report accordingly.

No regressions on arm64, arm, x86_64, and i386.

Dan

