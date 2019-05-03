Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88C6C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7951B2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UuHPz4he"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfECIvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:51:22 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43925 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfECIvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:51:21 -0400
Received: by mail-ed1-f66.google.com with SMTP id w33so2794337edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 01:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WtAh09ggDNk8Bg++boVrbk2pv8k5do2kf68uyPp426k=;
        b=UuHPz4heyl9PST1AnoCUmNlIrCU3I/eX0BuK2lNEqV9TLMa+5i8HJ/b6P8DTmS9Xg4
         kypmMouBYyFwsvJYuuCMjddDZojQ3IDeyLuuZyQ3EeOrMLwg/b5DFEaF6oMSzuovIvn4
         sEpUULXNnExPVs+2ENkZGa2RNVk4LYVjxlRkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=WtAh09ggDNk8Bg++boVrbk2pv8k5do2kf68uyPp426k=;
        b=Uf+1e2bvTzTWtABqevVO1AtCk5TuR+MAYb62lBQAANIa0JfkoANxZiqvawCjCNg/cO
         r/erulUFznTa6lLnSjA7Rd83u7cFfikVn41xFBVKWv1CgFHUuUsVOi6DMO12ecBPL0up
         Tl3PG/4EDhAVxIuoUO9Hb+/xPKRPjhFL69BCTTvNcBCdVDnzzDpNBTo+osxaydKwVSFg
         wZN3ZZja8r/06hBRHLz9MVfX6zEcYqY8DcieEzH9TnAlFR23Y1NoKNGUr7AwQExiutee
         qxgRfjmQjUlfv189ZDlSiaOU6jsHM7Y5kD3xaucV7gy2zadmTQlERgRFWgi2peFhMEH0
         dTRw==
X-Gm-Message-State: APjAAAVjPK46kj/y9NS4u67D0SKv9ea/K/GQs9kim0dPMcHeoXJiaEU8
        N3F9mQqIQHfyxC8/JV5D3Ct9RQ==
X-Google-Smtp-Source: APXvYqy1wRJDhuB7iuPdZsd4cRVVrUoPRO8I33eqnmgpGcrzQHL8UvjkGgbrvWI0m2hzJnHKYa3YBQ==
X-Received: by 2002:a17:906:a458:: with SMTP id cb24mr3128785ejb.158.1556873479738;
        Fri, 03 May 2019 01:51:19 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x18sm254555ejd.66.2019.05.03.01.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 01:51:18 -0700 (PDT)
Date:   Fri, 3 May 2019 10:51:16 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Liu, Chuansheng" <chuansheng.liu@intel.com>
Subject: Re: [PATCH] RFC: hung_task: taint kernel
Message-ID: <20190503085116.GK3271@phenom.ffwll.local>
Mail-Followup-To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Liu, Chuansheng" <chuansheng.liu@intel.com>
References: <20190502194208.3535-1-daniel.vetter@ffwll.ch>
 <20190502204648.5537-1-daniel.vetter@ffwll.ch>
 <7e4ef8c8-2def-5af9-f80e-b276fea8696a@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e4ef8c8-2def-5af9-f80e-b276fea8696a@i-love.sakura.ne.jp>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 09:47:03AM +0900, Tetsuo Handa wrote:
> On 2019/05/03 5:46, Daniel Vetter wrote:
> > There's the hung_task_panic sysctl, but that's a bit an extreme measure.
> > As a fallback taint at least the machine.
> > 
> > Our CI uses this to decide when a reboot is necessary, plus to figure
> > out whether the kernel is still happy.
> 
> Why your CI can't watch for "blocked for more than" message instead of
> setting the taint flag? How does your CI decide a reboot is necessary?

We spam an awful lot into dmesg, and at least historically had
occasionally trouble capturing it all (we're better than that now I
think). Plus the thing that parses dmesg isn't the thing that runs
testcases, hence why we started to use taint flags (or procfs lockdep
status) and similar things to check the kernel is still alive enough.

> There is no need to set the tainted flag when some task was just blocked
> for a while. It might be due to memory pressure, it might be due to setting
> very short timeout (e.g. a few seconds), it might be due to busy CPUs doing
> something else...

Yeah I realize that this probably doesn't have much use outside of our CI,
but maybe there's someone how likes the idea.

Wrt spurious taints: You can disable the hung_tasks checker outright,
which also stops the tainting.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
