Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3F2C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53FD20862
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482280;
	bh=lwTjIpHsoKK4AkJCfv0JG8JTPqDiQmIFGWOvm6Ie5A4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1NRVvdd1kp5n7J+hadTX2104Jq6YZkGDfSvGwh1HzwLI9UtyVqYq3VhvKzzGWhz48
	 KUAOHJqQIXRtlUVsBMZgFYoR5OYQgYIYS4UjjBhzkyx8KGtWKdAPNkMSLeXPrYRYH5
	 u1gvF14QMlE/IToizUxurKt18zXRtQL6BhjernH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfLDR57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:57:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:59506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728462AbfLDR5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:57:55 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6565820675
        for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2019 17:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482274;
        bh=lwTjIpHsoKK4AkJCfv0JG8JTPqDiQmIFGWOvm6Ie5A4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gYmZOMghZ2/1+Z+h5VzicyK1eoUgr2cM2d8ZCLyRB+HxzgngVCXPd4s3s40CFHHAG
         lbP1gBy02paOIcR75H/qIr+CLzND8CmmRwNljl1+kVFq4+shM6n56RXnBxl/ytHWfY
         9IVTnNwz3KL3puW7fQp8siGNBNJgT0P2N48zKrpQ=
Received: by mail-wm1-f43.google.com with SMTP id p17so730707wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 09:57:54 -0800 (PST)
X-Gm-Message-State: APjAAAW7CXc95WaPlIPpcEI/i4Izit7FvvYnUUOHpBFTJQGIx1AqL16c
        2Vt1gyEylQuVhlivEoJxmkJPxP8LW7ydYPSLrTQBFg==
X-Google-Smtp-Source: APXvYqzPryvm0hCNXTDUMuNgMnD2Rzqe+4Isv8hkhbwF8x5RjfAeDu7SsGRSqqQdQzS3W4CfCRA6W/cEKqT50QnQCDU=
X-Received: by 2002:a1c:20d6:: with SMTP id g205mr840527wmg.38.1575482272930;
 Wed, 04 Dec 2019 09:57:52 -0800 (PST)
MIME-Version: 1.0
References: <8eeee0695c664305ba6a56bce42a995f@AcuMS.aculab.com>
In-Reply-To: <8eeee0695c664305ba6a56bce42a995f@AcuMS.aculab.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 4 Dec 2019 09:57:41 -0800
X-Gmail-Original-Message-ID: <CALCETrXB=qqFttN2WS3dEWJ+9YAtOOFcZ_8A9=m+RL1E3Si5Hw@mail.gmail.com>
Message-ID: <CALCETrXB=qqFttN2WS3dEWJ+9YAtOOFcZ_8A9=m+RL1E3Si5Hw@mail.gmail.com>
Subject: Re: Running an Ivy Bridge cpu at fixed frequency
To:     David Laight <David.Laight@aculab.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 9:01 AM David Laight <David.Laight@aculab.com> wrote:
>
> Is there any way to persuade the intel_pstate driver to make an Ivy bridge (i7-3770)
> cpu run at a fixed frequency?
> It is really difficult to compare code execution times when the cpu clock speed
> keeps changing.
> I thought I'd managed by setting the 'scaling_max_freq' to 1.7GHz, but even that
> doesn't seem to be working now.
> It would also be nice to run a little faster than that - but without it 'randomly'
> going to 'turbo' frequencies (which it is doing even after I've set no_turbo to 1).
>

I don't remember.  I'm sure I could figure out what MSR to write, but
that's not the answer you're looking for.  Someone else will know :)

> An alternative would be a variable frequency TSC - might give more consistent values.

You can quite easily use perf to count cycles.  I never really
finished it, but this is a tiny little library that should do exactly
what you need.  It's a bit messy.

https://git.kernel.org/pub/scm/linux/kernel/git/luto/misc-tests.git/tree/tight_loop/perf_self_monitor.c
