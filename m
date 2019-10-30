Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A97CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EDC204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IgR3AvNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfJ3TJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 15:09:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43148 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfJ3TJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 15:09:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id l24so2087716pgh.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 12:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dufKW7ailST27XmBsRzEjUu5gldQC2+JQubS/xpnsTo=;
        b=IgR3AvNb/IW+SuaYisEPvGgQ1N2CpDUOZAYg3Bs1VILV+oQkm3mFZj1IcMwvtNGnDL
         yeG/doPiWKeFY3yEF0o2hjznX9oxZms0D8u3x06ENtLStfpt0E7OnXbnVS1h8Gnqe7Ln
         znKBLsdqnjwo/9KJQEFt73HS/yRu0B+AJ1Qpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dufKW7ailST27XmBsRzEjUu5gldQC2+JQubS/xpnsTo=;
        b=WkDWGlBZ99d/hhLNY1rjG2z6FNbTV45m3LjQr/84+6R0IF0PNu3G1EoHN1UogAx9Jq
         +FFaUHsPQhr+K0OpFWJ/fZ9/6my04np7yft7Uf1nbFuinlJe/RY6wGXDp7AOHA7WKNOd
         piI4kbCwPoUB63/+oF9UIrYSjFtSpyIf4ris8I33rpzcbfAA3HctAXnCv5S024OKUCBT
         oFAB2PTc9xfW6pZj2qq3k4D4hAYeALmT2xATQ4z47B7RKaxJCgbH10vAghfwhrreHjmU
         mO3PZyYFb/NJeLidxbBUne7+cC649DPFv/RAtTxpaN9wwKXhFvbgYUfKrt51Cs/eRxYw
         d3Gg==
X-Gm-Message-State: APjAAAXBPALMuKH2DWwdzpXv7skRQ4XJYA7OoKiFt6hIpj373AmKP+Mv
        AG2vgjxbA+jlfrfG27r5HW2XLQ==
X-Google-Smtp-Source: APXvYqyWkXi7dHZifGHol+L8h1naJvUA7vjOJyl4pJ9ePxkgrWj5xfjXri3x2IxsOUF4oLO2ZUTSBw==
X-Received: by 2002:a17:90a:9204:: with SMTP id m4mr1064291pjo.104.1572462581965;
        Wed, 30 Oct 2019 12:09:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m123sm699881pfb.133.2019.10.30.12.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 12:09:41 -0700 (PDT)
Date:   Wed, 30 Oct 2019 12:09:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Matthias Maennich <maennich@google.com>,
        shuah <shuah@kernel.org>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>, Theodore Ts'o <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Mike Salvatore <mike.salvatore@canonical.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
Message-ID: <201910301205.74EC2A226D@keescook>
References: <20191018001816.94460-1-brendanhiggins@google.com>
 <20191018122949.GD11244@42.do-not-panic.com>
 <alpine.LRH.2.20.1910191348280.11804@dhcp-10-175-221-34.vpn.oracle.com>
 <CAFd5g46aO4jwyo32DSz4L8GdhP6t38+Qb9NB+3fev3u4G6sg4w@mail.gmail.com>
 <20191024101529.GK11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024101529.GK11244@42.do-not-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 10:15:29AM +0000, Luis Chamberlain wrote:
> On Wed, Oct 23, 2019 at 05:42:18PM -0700, Brendan Higgins wrote:
> > With that, I think the best solution in this case will be the
> > "__visible_for_testing" route. It has no overhead when testing is
> > turned off (in fact it is no different in anyway when testing is
> > turned off). The downsides I see are:
> > 
> > 1) You may not be able to test non-module code not compiled for
> > testing later with the test modules that Alan is working on (But the
> > only way I think that will work is by preventing the symbol from being
> > inlined, right?).
> > 
> > 2) I think "__visible_for_testing" will be prone to abuse. Here, I
> > think there are reasons why we might want to expose these symbols for
> > testing, but not otherwise. Nevertheless, I think most symbols that
> > should be tested should probably be made visible by default. Since you
> > usually only want to test your public interfaces. I could very well
> > see this getting used as a kludge that gets used far too frequently.
> 
> There are two parts to your statement on 2):
> 
>   a) possible abuse of say __visible_for_testing

I really don't like the idea of littering the kernel with these. It'll
also require chunks in header files wrapped in #ifdefs. This is really
ugly.

>   b) you typically only want to test your public interfaces

True, but being able to test the little helper functions is a nice
starting point and a good building block.

Why can't unit tests live with the code they're testing? They're already
logically tied together; what's the harm there? This needn't be the case
for ALL tests, etc. The test driver could still live externally. The
test in the other .c would just have exported functions... ?

-- 
Kees Cook
