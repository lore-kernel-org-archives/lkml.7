Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579B0C04AB2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EA220896
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDIk566m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfEJQay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 12:30:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46804 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbfEJQax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 12:30:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id y11so3483062pfm.13;
        Fri, 10 May 2019 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eEVKOIIrcwgLiz75VXyJHjrPtlirWbYchuQYHF7nzwg=;
        b=sDIk566mYKdY5TWoNulkhL0ehkTLSRVaU6dzltMBKp3KqT0tSYTd/uxvNe4qxQBGmL
         RuwGrHw4K6FgG7vlb3nfOQedw9Cin714XEG+Wdg1DL40ukTPwxOETGQvOojepHt5vxZM
         aj3vAPSaa8/rxnaZMjiRnV1SlwNbfbTlKyFHW9ryvdi0SJi1PFyGC6VU3nbRVql3XHam
         Zwl1F9SjVAkBhwjyEm8aI35tHSZe6hPF7F3nzo8295knK/Nh8AFwEBX8TxklNPIfCLGF
         JGWRN9RFop2WgT/v6Q+FLZ/EJO1xqZ0WunjojdEoNr66Xjy3CwD2za9c0tAbJEn+ifs0
         cDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=eEVKOIIrcwgLiz75VXyJHjrPtlirWbYchuQYHF7nzwg=;
        b=MW3YqmyRIdIfItRfl9bC58FrqBbc206auJmtmrNz6eWurCoIo+vsvLS0IpSyrBnyOF
         y9etuYK0cZ6xlNeArkgWrhgwpPKepbQiaN8xvA1HsCu9WxWoJHiR15TYivl7ypit+7O3
         Lxl1omq6ek6yi9x0BmnnYPtFaJYiIbWWhpdv/yylp+MWorPaffHba7dTjbljmmPLuVyb
         WwlmgbHkWTGWq4HJ7sVKg6avwRM0+hpsup14QyiAeJJTkWNHS4sQ3BoOALcYFDCq58d8
         zLtVibegDwVOqkVF1e/YN6DoaYUNJMcYXMdQnpb/OAkCRlyWATrCLwT2mCk6AyD1zFmw
         tcpA==
X-Gm-Message-State: APjAAAWnk5P5VNZFYIikjdbTpBPxpFhASE3Jjnxook1GWBn051qT1LFK
        sSZqJy3nlZVwf+y91JzgHmg=
X-Google-Smtp-Source: APXvYqwp8fIdmlUt/KS0Hn4zY7hzE708Vhjk1wSNlMpD3SQQX0y06mBmoEAxRGsfnwy+ZutcIbkcjg==
X-Received: by 2002:a63:6196:: with SMTP id v144mr15060449pgb.235.1557505852982;
        Fri, 10 May 2019 09:30:52 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f64sm10074621pfc.62.2019.05.10.09.30.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 09:30:51 -0700 (PDT)
Date:   Fri, 10 May 2019 09:30:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 5.0 00/95] 5.0.15-stable review
Message-ID: <20190510163050.GA21034@roeck-us.net>
References: <20190509181309.180685671@linuxfoundation.org>
 <CA+G9fYvKNb-WD+0govE2NWzjHisdJXiRRioTQGZKHP0gvO9WKw@mail.gmail.com>
 <20190510155051.GC2209@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190510155051.GC2209@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 05:50:51PM +0200, Greg Kroah-Hartman wrote:
> On Fri, May 10, 2019 at 12:06:07PM +0530, Naresh Kamboju wrote:
> > On Fri, 10 May 2019 at 00:21, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 5.0.15 release.
> > > There are 95 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Sat 11 May 2019 06:11:22 PM UTC.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.15-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> > >
> > 
> > Results from Linaro’s test farm.
> > No regressions on arm64, arm, x86_64, and i386.
> 
> Thanks for testing 4 of these (no 5.1?) and letting me know.
> 
5.1 results coming shortly. I had to fix a bug in my builder setup.

Guenter
