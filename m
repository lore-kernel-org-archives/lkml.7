Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBDCC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5087320811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbfDWD2d convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 23:28:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46417 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729097AbfDWD2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 23:28:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id 9so6689629pfj.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 20:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=D7x2hfvF8OYrm3/iMsirn8coi5z0CjuR9MVDpzeUWlI=;
        b=R57nsfJhJSNRlLYF8fQkgqHEPP3rLO+rUn9BVpTc6UGXWZAiSolFZAiIUazzT8uKNr
         la6xY+I/hu9gFHgGkxg874/XzyH4Uy4C0blPckkoq5VhS7062N8s2PuyMmXHohbYis4X
         Ft3fp3GQNIyqaee9OPwFOePYYlF5jHCM4EvD6+CNzZndyPxXJggeIWP+aDet0kbKlWOW
         12/uu006qVBRW8LNR6N2LcXaNIh3sLr2zBUSu6Dw/goscyfpwJjM5tdXtm7UF1+xvNfR
         zgNqzrOdr00N7ci2d3vAmyLT0z9aB9tnm+cBMV+jBDr7UQOnTN5pqrkwzzc2dRMmzQ0J
         f7Jw==
X-Gm-Message-State: APjAAAWav9rcpnsmmVHEbD5P0LkjhClK7Z8JcTly+WbaDdZyxMa9Ey85
        dkWn5MGMf84vAGNkObmTVawrgQ==
X-Google-Smtp-Source: APXvYqw1Taxi3WQUrRSLsfDPZRfBizy9nvkDShxpS9wsCyYolZwSA786fkHUQWvDQM9lmc010I3rqg==
X-Received: by 2002:a62:e418:: with SMTP id r24mr24731573pfh.52.1555990112093;
        Mon, 22 Apr 2019 20:28:32 -0700 (PDT)
Received: from ?IPv6:2001:240:240e:4025:456d:3cd:582e:ae26? ([2001:240:240e:4025:456d:3cd:582e:ae26])
        by smtp.gmail.com with ESMTPSA id y3sm17410608pge.7.2019.04.22.20.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 20:28:31 -0700 (PDT)
Date:   Tue, 23 Apr 2019 12:28:16 +0900
User-Agent: K-9 Mail for Android
In-Reply-To: <20190419010714.GH7751@bombadil.infradead.org>
References: <20190417131531.9525-1-mcroce@redhat.com> <20190418154045.2ad0bd50e73a6e71c0fac768@linux-foundation.org> <1109DAD2-E25B-47A3-8381-E02260FE51B9@redhat.com> <20190419010714.GH7751@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v3] proc/sysctl: add shared variables for range check
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Kees Cook <keescook@chromium.org>
From:   Matteo Croce <mcroce@redhat.com>
Message-ID: <5C263FB9-DC10-4D51-B6E4-776ED03C0E9E@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 19, 2019 10:07:14 AM GMT+09:00, Matthew Wilcox <willy@infradead.org> wrote:
> On Fri, Apr 19, 2019 at 09:17:17AM +0900, Matteo Croce wrote:
> > > extern const int sysctl_zero;
> > > /* comment goes here */
> > > #define SYSCTL_ZERO ((void *)&sysctl_zero)
> > > 
> > > and then use SYSCTL_ZERO everywhere.  That centralizes the
> ugliness
> > > and
> > > makes it easier to switch over if/when extra1&2 are constified.
> > > 
> > > But it's all a bit sad and lame :( 
> > 
> > No, we didn't decide yet. I need to check for all extra1,2
> assignment. Not an impossible task, anyway.
> > 
> > I agree that the casts are ugly. Your suggested macro moves the
> ugliness in a single point, which is good. Or maybe we can do a single
> macro like:
> > 
> > #define SYSCTL_VAL(x) ((void *)&sysctl_##x)
> > 
> > to avoid defining one for every value. And when we decide that
> everything can be const, we just update the macro.
> 
> If we're going to do that, we can save two EXPORTs and do:
> 
> const int sysctl_vals[] = { 0, 1, -1 };
> EXPORT_SYMBOL(sysctl_vals);
> 
> #define SYSCTL_ZERO	((void *)&sysctl_vals[0])

Hi Matthew,

I like this approach, regardless of the const or not const extra1.

I'll be AFK for a few days, then I will investigate if extra1,2 can be made const and then prepare a v4 with the single export.

Thanks,
-- 
Matteo Croce
per aspera ad upstream
