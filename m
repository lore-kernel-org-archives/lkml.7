Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E19AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0E820868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQe2cW6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbfDPUTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:19:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37925 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfDPUTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:19:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so10956786pfo.5;
        Tue, 16 Apr 2019 13:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6PEnLK/BsL4UPQ/Z4GyQ9Ocfr+UTl9n4Ij9wkAIKQj8=;
        b=FQe2cW6Tb220WlfuCFNyIJXuey2LXFONTUCTEeMZQQt8ZR2KaGM56adW+oZYuE0qo2
         WcDSGmGy9w0gYjg+Kepbs8KnpyNSrhWkIjWYuz6VUGTiwjyJWhVSCd6E7fJbMyEVLqiu
         znH+In39WuDy2XE6895XVjWnzgQdoTH0QacbJkNXFFJVOP3hrihH+XHXZRWOZ3FTc/o9
         68cqRF2Zhm3QlxEC8f24bsQfmtFmyIqHbS6pXZEcT5rjg91ufQb0q2WElJQdOaYC3CNG
         Avmd1MpbTU2aNS0fJrBBii9F2Cmmf+hxZmRyuz/7U8fU4nBCdL4C/ggy+ZoULUgNkquq
         k6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6PEnLK/BsL4UPQ/Z4GyQ9Ocfr+UTl9n4Ij9wkAIKQj8=;
        b=L0HL8j/aVefABCLcDlCtiGFnufNrwuEVWZLbAlSRAUKWEGQQrqhZJ5tb8eLmKINjNU
         QXHWucv7Uotcn5p02MWTdtNLHtyZI/pgn3Daym4ZI3JxY20XzHRss44aVdlWeydqE3VP
         +mwdeuHG6Cy6Zldu8k5DZS7bOSmq5iHtD2JPgnIJeLVQ6QLAHnWYlutl/CHD5Mehuds3
         gCCQekzRi/I1CDr04xcEt8I6Uz6NSWFU9ZUGL6FMn++wqV0nLEbUcaDTvAz1QOawo0QK
         cPkK+pp1ZQLrFx7mFjQR9YBphFo7h9wmddRgLu0B2Dq0YuoGmeL3fLBU+yPBcne2wsuu
         7lSg==
X-Gm-Message-State: APjAAAXm/GxS5Br+E8Hck/ZpSj9ATyjr3R0pBw0Ci6XqKHSmtrOWKiu6
        1TR6VVjrQzIE/hQjpOGYGdQ=
X-Google-Smtp-Source: APXvYqw0jl+ajxhO7EPVgSnIwkf65zT+vj0kMWO/tOSEyL7W0AyM5qStHADg30RiYpBG4sr05j29nQ==
X-Received: by 2002:aa7:8e55:: with SMTP id d21mr43513536pfr.62.1555445954705;
        Tue, 16 Apr 2019 13:19:14 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q10sm64766245pgh.93.2019.04.16.13.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 13:19:14 -0700 (PDT)
Date:   Tue, 16 Apr 2019 13:19:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/76] 4.9.169-stable review
Message-ID: <20190416201913.GA25517@roeck-us.net>
References: <20190415183707.712011689@linuxfoundation.org>
 <20190416162935.GA22656@roeck-us.net>
 <20190416184600.GB6253@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416184600.GB6253@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 08:46:00PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 16, 2019 at 09:29:35AM -0700, Guenter Roeck wrote:
> > On Mon, Apr 15, 2019 at 08:43:24PM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.9.169 release.
> > > There are 76 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Wed Apr 17 18:36:37 UTC 2019.
> > > Anything received after that time might be too late.
> > > 
> > 
> > Build results:
> > 	total: 172 pass: 165 fail: 7
> > Failed builds: 
> > 	<all parisc>
> > Qemu test results:
> > 	total: 320 pass: 304 fail: 16
> > Failed tests: 
> > 	<all parisc>
> > 
> > Build failures as already reported.
> 
> I should have those build failures fixed.
> 

I didn't rebuild the other images, but parisc build and boot tests
are now fine (with v4.9.168-78-g6ecae2ce7b5a).

Guenter
