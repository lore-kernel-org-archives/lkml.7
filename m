Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEA7C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 16:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81ED42086A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 16:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574700550;
	bh=//Vk9skfhYpfLNzSjPMrouF0EQDfG8iC+SYwFumm9YI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QhIj2QawLfzya5NmnAlPgOK7w8x7b0q8uXZ97d2FFY6ginxxedsfnd0cK9219iznx
	 rqfcu+58MI4rPKVu6gzVzC3nkc3VzxdkRd4fZS+B1XNtn2fmDzt4KI7U5z66hRm4r8
	 6tvHoqJRSK4lpka8QCFxJ762sRHZLgeKqZPvj7jA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfKYQtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 11:49:09 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34492 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbfKYQtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 11:49:09 -0500
Received: by mail-lj1-f194.google.com with SMTP id m6so9331177ljc.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 08:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1E1EUN5Uc4Q2o2hi1DztWyCr1Ev456MpyPBq9OxAAVU=;
        b=fsY7s9faAco1KtisSTem5KxbOeCQZhC5Mw5Hg+wFjVdVR+bA3K6eyUFiMvwlvtXqWW
         9rV67R31ok1Ifi5dc6/RHSu7cS7VOt4vYCFiOFeihXxdn9s+02WGqBWzBKWIOfD/eu8S
         q9lOCb0CmvOZgbeSJoLcPC6hKot4CWxCBIj3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1E1EUN5Uc4Q2o2hi1DztWyCr1Ev456MpyPBq9OxAAVU=;
        b=Nc6FBkEcq1gFB0vuS5f3d/rBNcTjueik6iyLyaGWD1CcO7mgKqzxc86tLLxEsuFtrg
         jPZFy3P2f+DZLjXvpOAA/G6Y8k4D7OSKCv9/bmyE/kD8C+5Db2ojwC6vDWYExUlW0TU4
         EhKk29FHK/8MvbgKB6ZtZAuJ7tEORw/VTtdpmpYdShZH/vgeIhfrr2aCdE7E+6TkXkP5
         BqtdSy0fgd/qxB4kOolNYC3PkKKx8StpwOkYLD7EExcikpO1ELJk6H2u9Ha+9mdYTs+S
         XE0gU4+TlIU0eDweEFmG7N10/fLHYr+q0kvAZoMtGNAnECiQZ6OO8V7X/Q6LeSPFCBIR
         FaUw==
X-Gm-Message-State: APjAAAVCSNH2NTGjmRZEwYIdLXkD+2uj7OnMtqmfrl/5eo6VAzB/yCot
        +OOSNnDRVKoUa2kiUgB7w2MP3JLNVIc=
X-Google-Smtp-Source: APXvYqwn+IJ/raA1VPb20C85ts2bMf+ofKS2C9I/WNase2WgEuA14SK8wpOxPstJPYHCl4oeb44x1Q==
X-Received: by 2002:a2e:9904:: with SMTP id v4mr23038008lji.211.1574700546150;
        Mon, 25 Nov 2019 08:49:06 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id g14sm3943558lfj.17.2019.11.25.08.49.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 08:49:03 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id j6so7682356lja.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 08:49:03 -0800 (PST)
X-Received: by 2002:a2e:8809:: with SMTP id x9mr23297700ljh.82.1574700542740;
 Mon, 25 Nov 2019 08:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20191125125944.GA22218@gmail.com> <9af8a5eb-5104-ad0b-bf46-dedb65d66a07@arm.com>
In-Reply-To: <9af8a5eb-5104-ad0b-bf46-dedb65d66a07@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Nov 2019 08:48:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjV6CGaVXYoWvQER4_xmFdX2eTBSYf+6WhcgAx+K9M+Og@mail.gmail.com>
Message-ID: <CAHk-=wjV6CGaVXYoWvQER4_xmFdX2eTBSYf+6WhcgAx+K9M+Og@mail.gmail.com>
Subject: Re: [GIT PULL] scheduler changes for v5.5
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 5:49 AM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 25/11/2019 12:59, Ingo Molnar wrote:
>
> So I really don't want to be labeled as "that annoying scheduler PR guy",
> but some patches in Vincent's rework should be squashed to avoid being
> performance bisection honeypots.
>
> > Vincent Guittot (14):
> >       sched/fair: Remove meaningless imbalance calculation
> >       sched/fair: Rework load_balance()
>
> These two ^ (were split for ease of reviewing, [1])
>
> >       sched/fair: Rework find_idlest_group()
> >       sched/fair: Fix rework of find_idlest_group()
>
> And these two ^ (Mel voiced similar concerns at [2])

If they were split for ease of reviewing, then they should be split in
the history too.

I worry a lot less about some possible (temporary!) performance dip
than about a hard bug, and if the code is easier to review in two
steps then it's going to be easier to find the bug in two steps too.

                     Linus
