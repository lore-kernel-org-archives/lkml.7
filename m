Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4ACC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C5326A54
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JBsBQDHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfEaOS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 10:18:28 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39748 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfEaOS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 10:18:27 -0400
Received: by mail-it1-f195.google.com with SMTP id j204so10165858ite.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 07:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MqKLt/WpCLzDnR6KC2LbU71uyrGieaHBnTcbdQaj2rs=;
        b=JBsBQDHM/x967z4xbhmkenpWqpse6l3Q82blssloI9kSJK9dVwLAqu7PPCul+RhDyD
         XCkwXdEkas3GwDPLsyKEE4dHF/keiU6eTfjONXxlrD179eh6yFmVt8bXqZQAENkBnZdp
         BNSSd5YtOLA9E9A3mpDcECYFCyBuW8AyJKaA9xFyTXykloNvfzpi3CVFaKTzm59dVVpr
         Oe6J4W0opsoup05QbikGRDhvr61zpO9qlg2OLoFtAbPh4FFQvjWgD9RBeQ5gmYDZx8SX
         zT+kdy/omDe1r6fB7EaVpeDiXJLd1ZfZeTcNH/CxLnnPJed/cgYSsPwEh+WIUNIXfOqh
         rW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MqKLt/WpCLzDnR6KC2LbU71uyrGieaHBnTcbdQaj2rs=;
        b=h9PQz4ufFi9OnaK9vKV+remWVHOaSfHerSFh2Dy6w61UjeHhAmDerVcfgH7Dp7dZAN
         AW/OXg2uQ/8rGYhd4Dpn6Wp969QWFw9YEUI+D3acRVpZmtUaHKVmcIBjcvMmAHd0fRIp
         OGkCW8fgq7d5MUIGhHKCmsOkRp7Zl/Ux12sZDRe8seOOATKZHlMrEAlNEN5bfQaqIrNg
         Om6lOGVTQ+DQ8JLAzH8EYB9j6PC7x6q0rMLK+BTAHtuKr7sFAdUCwKi5U7Si+dYtbp4c
         HG2V5I8Dp6ihqF0jQiV/gS2eBPyrFUn3nnyg5wAZHmMRVJrbv7GDOtDszETdRRSuNsvm
         SXsQ==
X-Gm-Message-State: APjAAAWlOoZocRTZ0yKyzbsEwU6sGVSFmfq4aeFsdtrZSGAjQ37ISA+C
        UPDSR7YuHN7EWUH+x3ycyINKyQ==
X-Google-Smtp-Source: APXvYqzEQm57Jjt+GxYIloa90ycsvWyHobiGaLJGaDMP/qZ0HuWYZoFbPIjUNoe1PwRHtYrgxpB3aA==
X-Received: by 2002:a05:660c:191:: with SMTP id v17mr7282964itj.6.1559312306623;
        Fri, 31 May 2019 07:18:26 -0700 (PDT)
Received: from localhost (c-75-72-120-115.hsd1.mn.comcast.net. [75.72.120.115])
        by smtp.gmail.com with ESMTPSA id r6sm1892523iog.38.2019.05.31.07.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 07:18:25 -0700 (PDT)
Date:   Fri, 31 May 2019 09:18:25 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 5.0 000/346] 5.0.20-stable review
Message-ID: <20190531141825.vv4ii22am7i2p5pg@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <20190530030540.363386121@linuxfoundation.org>
 <CA+G9fYtW1E+jOKaU3qnhdwa63r1t7i04uMAcigWAUjVmDss6Pg@mail.gmail.com>
 <20190531132043.GA5211@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190531132043.GA5211@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 06:20:43AM -0700, Greg Kroah-Hartman wrote:
> On Thu, May 30, 2019 at 09:53:33PM +0530, Naresh Kamboju wrote:
> > On Thu, 30 May 2019 at 08:48, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 5.0.20 release.
> > > There are 346 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Sat 01 Jun 2019 03:02:10 AM UTC.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.20-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> > 
> > Results from Linaro’s test farm.
> > No regressions on arm64, arm, x86_64, and i386.
> 
> Thanks for testing 4 of these and letting me know.

5.1 sent out now. We were just waiting for the remaining test jobs to
finish before sending it.

Dan

> 
> greg k-h

-- 
Linaro - Kernel Validation
