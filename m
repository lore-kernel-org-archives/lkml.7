Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8045AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551FD2190F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570696996;
	bh=8kPvOYOGyf5PHsSw6p5NqUvH4fnQwYXOlNmS2bYD+iM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JHjWVD5bp8LG1V41x/QWdLvpMmhl5PaHiw7BMONVm0UNjU15tAh2nLp1V54JQgAKR
	 FZ5/Nbprp/eiVVDqLjiVuUmfn/rGXN+lz7YRF4Cjn4um44uHkh8slJD/ezdSRIpRb0
	 jkq7jrWviOuZaE+Nq59bg+/7WwMuMhAnvY1/egFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388053AbfJJInO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:43:14 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44904 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388682AbfJJInK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:43:10 -0400
Received: by mail-oi1-f195.google.com with SMTP id w6so4183917oie.11;
        Thu, 10 Oct 2019 01:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rTlYYOGkqgnD6Zh5iPOqbNdyFEWm7e54SIBJvDOHe+w=;
        b=L8cq/6MB/aSeowfUY/dL6sM10ZJ2U9Kyr3+4I8WVPA3rULP1tPA0g/uDb0Jscpma7Z
         zBC13ezJ8wkCa4VVy2yRofS/0APYkxnNJ9/1jCet67vDV7rQfLdZnpZwpihteON0O7bY
         zgqI2lsgo0ddSL0ydxRID8Y0k7j+zB+wsl1euM3WCreRQaIc8dVyxwURF7zGbKpXFwn4
         SbmH7cEUp1XWL1f7ddHdclcynO2ZVzt7bQ2YkMCNLh932fx6RHVdeModKDHv0oz82UbG
         3vBZPd9PCZ/+zwSDvTSsgQI7nD9AeGLjcBA3e39jQBl2psES5oK5OdGw5wxy9ZpMuwS0
         hbBg==
X-Gm-Message-State: APjAAAUD+32Px12lYnJvQp8QJW0qIvPhIZ0WHCypRfk6meJYkfAK7A4L
        6cTZxj9cezlSlPXjbEvl3uxkI1khlrfM5a7/wd8=
X-Google-Smtp-Source: APXvYqxZxVEkCcvoHeYoneF0Gm7l+ZPEmDyvwN/Ft4cT9xsNTutEE5bv0px9c0e97RY7vXWtCfWrgZJ27ep0hauNnZo=
X-Received: by 2002:aca:d706:: with SMTP id o6mr6702363oig.57.1570696989666;
 Thu, 10 Oct 2019 01:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <001601d57487$e1029ef0$a307dcd0$@net> <CAJZ5v0jvusVBcKECBueDHk5KQGda=GGuSGPO3F4wCvk3cro56A@mail.gmail.com>
 <1574317.FFykgJKpNH@kreacher> <3490479.2dnHFFeJIp@kreacher> <000b01d57f39$11868670$34939350$@net>
In-Reply-To: <000b01d57f39$11868670$34939350$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Oct 2019 10:42:58 +0200
Message-ID: <CAJZ5v0g+dQKTDMPPf-iP1oTCWhrLk7N2+PVbBZB5mKQN4Qb6zg@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH v8] cpuidle: New timer events oriented governor
 for tickless systems
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Chen, Hu" <hu1.chen@intel.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 9:05 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2019.10.09 06:37 Rafael J. Wysocki wrote:
> > On Wednesday, October 9, 2019 1:19:51 AM CEST Rafael J. Wysocki wrote:
> >> On Tuesday, October 8, 2019 12:49:01 PM CEST Rafael J. Wysocki wrote:
> >>> On Tue, Oct 8, 2019 at 11:51 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>>> On Tue, Oct 8, 2019 at 8:20 AM Doug Smythies <dsmythies@telus.net> wrote:
> >>>>> O.K. Thanks for your quick reply, and insight.
> >>>>>
> >>>>> I think long durations always need to be counted, but currently if
> >>>>> the deepest idle state is disabled, they are not.
> ...
> >>>> AFAICS, adding early_hits to count is not a mistake if there are still
> >>>> enabled states deeper than the current one.
> >>>
> >>> And the mistake appears to be that the "hits" and "misses" metrics
> >>> aren't handled in analogy with the "early_hits" one when the current
> >>> state is disabled.
>
> I only know how to exploit and test the "hits" and "misses" path
> that should use the deepest available idle state upon transition
> to an idle system. Even so, the test has a low probability of
> failing, and so needs to be run many times.
>
> I do not know how to demonstrate and/or test any "early_hits" path
> to confirm that an issue exists or that it is fixed.
>
> >>>
> >>> Let me try to cut a patch to address that.
> >>
> >> Appended below, not tested.
>
> Reference as: rjw1
>
> >>
> >> It is meant to address two problems, one of which is that the "hits" and
> >> "misses" metrics of disabled states need to be taken into account too in
> >> some cases, and the other is an issue with the handling of "early hits"
> >> which may lead to suboptimal state selection if some states are disabled.
> >
> > Well, it still misses a couple of points.
> >
> > First, disable states that are too deep should not be taken into consideration
> > at all.
> >
> > Second, the "hits" and "misses" metrics of disabled states need to be used for
> > idle duration ranges corresponding to them regardless of whether or not the
> > "hits" value is greater than the "misses" one.
> >
> > Updated patch is below (still not tested), but it tries to do too much in one
> > go, so I need to split it into a series of smaller changes.
>
> Thanks for your continued look at this.
>
> Reference as: rjw2
>
> Test 1, hack job statistical test (old tests re-stated):
>
> Kernel  tests            fail rate
> 5.4-rc1          6616           13.45%
> 5.3                      2376            4.50%
> 5.3-teov7               12136            0.00%  <<< teo.c reverted and teov7 put in its place.
> 5.4-rc1-ds              11168            0.00%  <<< [old] ds proposed patch (> 7 hours test time)
> 5.4-rc1-ds12     4224            0.00% <<< [old] new ds proposed patch
> 5.4-rc2-rjw1    11280            0.00%
> 5.4-rc2-rjw2      640            0.00%  <<< Will be run again, for longer.
>
> Test 2: I also looked at every possible enable/disable idle combination,
> and they all seemed O.K.
>
> No other tests have been run yet.
>
> System:
> Processor: i7-2600K
> Deepest idle state: 4 (C6)

Thanks a lot for sharing the results!

Cheers,
Rafael
