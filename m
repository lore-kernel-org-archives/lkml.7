Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CFEECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBB920869
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ON5RjH0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408513AbfJQJaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:30:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46050 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393479AbfJQJa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 05:30:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1so988037pgj.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 02:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BhmzWijDe5yao7vgl7kT7tSRmrdD456yMAPTwvVZ6aE=;
        b=ON5RjH0pSpZU2Cd7Fz0YbphH0L/Em2TGlv7YnZJBvpgopaCB/FKNcHBXq8HKwYUg7P
         9zkm0CUSDi8v7DL/pyzSsR88zRdT+gXAfP2h3/W5kvOKlunjpsrKxnUOTDwT80UUeo50
         4D6r0R0NHfCVid/eMA8W/jEIqrs+6PGfUdVEPeKkuRyFGFdx81pc41weawhWqG27vqEO
         ueMpeFIhp2mICDuxVZfklOTuQxnr12o48mmafzWwEBS3QILVhVMTtY6n5DI3On4w/GId
         e3zbFJ3f17wCZh5HFUOnvhEslPT7wGccw26PeqA8E36a8zrcusugKBnVc2c7y91AH2U3
         ZCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BhmzWijDe5yao7vgl7kT7tSRmrdD456yMAPTwvVZ6aE=;
        b=V0qKQkjt5mQHhFLu03fkHv9QaK47ykILW7sBtLmC1QZ3B2CrENK1B+5jxHk+dZp67P
         JKa2zVFQFARYKufehWxevivuDmbjD4ZPNTn0FipTGsjGUpPDiHkGdAu+K7Et2z3U7i5M
         uMuXdneErd7H/i5z47Ll3QP49VSUzZDcIZjWS3nOaVwtYdOX2exceY54R/AIuDs4vZTO
         5VKK0s0IghSasi2h9rpDyMj/oBdfYILcUhP9iAM7imImEdMM0BnRwf1T3g7E0Ic91Qo7
         uxkrxC90fnrW+Kx/qoRt/UNDqwTX0yNvOB9yDYr84G5FGRVQeiQ2fCw9xzdQZ+E/16Ja
         plmQ==
X-Gm-Message-State: APjAAAVNGy/A6ft54vTgQj/qDvR2K5i7x7CgwhsuDFih4ygsW5SaTGgN
        IwWRfISnbkdWS6fS7PtY3RTGZw==
X-Google-Smtp-Source: APXvYqzE6ySNtpyo3AA5URWU3jKLTzHmlb++gJiGHbo4eEfHZNF4YHTd0p39zwIlMfLoeZpK1XK1eg==
X-Received: by 2002:a63:1c47:: with SMTP id c7mr2994536pgm.265.1571304627200;
        Thu, 17 Oct 2019 02:30:27 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id a17sm1897804pfi.178.2019.10.17.02.30.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 02:30:26 -0700 (PDT)
Date:   Thu, 17 Oct 2019 15:00:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] cpufreq: merge arm_big_little and vexpress-spc
Message-ID: <20191017093022.du76n64kwzqibqhs@vireshk-i7>
References: <20191016110344.15259-1-sudeep.holla@arm.com>
 <20191016110344.15259-3-sudeep.holla@arm.com>
 <20191017023936.vgkdfnyaz3r4k74z@vireshk-i7>
 <20191017092628.GD8978@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017092628.GD8978@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-10-19, 10:26, Sudeep Holla wrote:
> On Thu, Oct 17, 2019 at 08:09:36AM +0530, Viresh Kumar wrote:
> > On 16-10-19, 12:03, Sudeep Holla wrote:
> > > arm_big_little cpufreq driver was designed as a generic big little
> > > driver that could be used by any platform and make use of bL switcher.
> > > Over years alternate solutions have be designed and merged to deal with
> > > bL/HMP systems like EAS.
> > >
> > > Also since no other driver made use of generic arm_big_little cpufreq
> > > driver except Vexpress SPC, we can merge them together as vexpress-spc
> > > driver used only on Vexpress TC2(CA15_CA7) platform.
> > >
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >  MAINTAINERS                            |   5 +-
> > >  drivers/cpufreq/Kconfig.arm            |  12 +-
> > >  drivers/cpufreq/Makefile               |   2 -
> > >  drivers/cpufreq/arm_big_little.c       | 658 ------------------------
> > >  drivers/cpufreq/arm_big_little.h       |  43 --
> > >  drivers/cpufreq/vexpress-spc-cpufreq.c | 661 ++++++++++++++++++++++++-
> > >  6 files changed, 652 insertions(+), 729 deletions(-)
> > >  delete mode 100644 drivers/cpufreq/arm_big_little.c
> > >  delete mode 100644 drivers/cpufreq/arm_big_little.h
> >
> > The delta produced here is enormous probably because you copy/pasted things. I
> > am wondering if using git mv to rename arm_big_little.c and then move spc bits
> > into it will make this delta smaller to review ?
> >
> 
> Yes, I did a quick try but slightly different order. As I need the final
> driver to be vexpress-spc-cpufreq.c, I am thinking of first merging
> vexpress-spc-cpufreq.c into arm_big_little.c and then renaming it back
> later. Does that sound good ?

Maybe git can produce short diff even if you do this in a single patch. But two
would be fine if that makes me review lesss stuff :)

> 
> drivers/cpufreq/arm_big_little.c       | 78 ++++++++++++++++++++------
> drivers/cpufreq/arm_big_little.h       | 43 --------------
> drivers/cpufreq/vexpress-spc-cpufreq.c | 71 -----------------------
> 6 files changed, 68 insertions(+), 145 deletions(-)
> delete mode 100644 drivers/cpufreq/arm_big_little.h
> delete mode 100644 drivers/cpufreq/vexpress-spc-cpufreq.c
> 
> If we first rename arm_big_little.c, then we need change the final name
> otherwise we end up with same delta as the new name file will be merged
> into vexpress-spc-cpufreq.c



-- 
viresh
