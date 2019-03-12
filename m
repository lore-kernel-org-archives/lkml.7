Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7ECFC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83AF2206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfCLQht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:37:49 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42796 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfCLQhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:37:48 -0400
Received: by mail-ot1-f65.google.com with SMTP id i5so3048704oto.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 09:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NpM11hIB0n3yQhJ/sBrftpwbwYTEMvFewCfyZrELSOY=;
        b=lOsYN9kLGti7LoZMmp62HX0dUOgJ3ZeM7eTYzUx/W/Lw58WnwUhr3ZH9qu638AJiHb
         6lnnSGdlzUyqzofH/bzqxhPIt+oohcrW5YkyrnjYpfE7c6DaoZri6ZBbSWoXPiyFX8kU
         INPFu1OcG4AQNmYJxP89JSTuZiB/AMHAqn59527iywE0F9zAyxEwvKu+NLZPgEl4RnkB
         6r/904rEco/FOpWEjZWucosKCvfZxP+TGwz9jVt4QdBRLhlVT4iIMuukT+WQaOpYvQAp
         RpwYAMwQS0tehfSY6lvAv8QIs8lw6uG+5AuXmWR9Dwz/dvL2uJwTb0CInMiKfUsj3RS8
         o1nQ==
X-Gm-Message-State: APjAAAWXtGQwWRC/VXwAzFqm++J4WxyjuNM2fThK1xSvkwiYk8ecxrEj
        mTF2RKC/cZIGfzizUv8ThZdVk1nf
X-Google-Smtp-Source: APXvYqwfZPbiQHE8MnOV1ufVTRg1Zl49w8DhEYFFealjY7DbjEoz7zfH9VFfZWBjcFLOm7HAbUx4/A==
X-Received: by 2002:a9d:76d4:: with SMTP id p20mr25164261otl.11.1552408667449;
        Tue, 12 Mar 2019 09:37:47 -0700 (PDT)
Received: from sultan-box.localdomain ([107.193.118.89])
        by smtp.gmail.com with ESMTPSA id 97sm4321579otn.39.2019.03.12.09.37.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 09:37:46 -0700 (PDT)
Date:   Tue, 12 Mar 2019 09:37:41 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, devel@driverdev.osuosl.org,
        linux-mm <linux-mm@kvack.org>, Tim Murray <timmurray@google.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190312163741.GA2762@sultan-box.localdomain>
References: <20190310203403.27915-1-sultan@kerneltoast.com>
 <20190311174320.GC5721@dhcp22.suse.cz>
 <20190311175800.GA5522@sultan-box.localdomain>
 <CAJuCfpHTjXejo+u--3MLZZj7kWQVbptyya4yp1GLE3hB=BBX7w@mail.gmail.com>
 <20190311204626.GA3119@sultan-box.localdomain>
 <CAJuCfpGpBxofTT-ANEEY+dFCSdwkQswox3s8Uk9Eq0BnK9i0iA@mail.gmail.com>
 <20190312080532.GE5721@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312080532.GE5721@dhcp22.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 09:05:32AM +0100, Michal Hocko wrote:
> The only way to control the OOM behavior pro-actively is to throttle
> allocation speed. We have memcg high limit for that purpose. Along with
> PSI, I can imagine a reasonably working user space early oom
> notifications and reasonable acting upon that.

The issue with pro-active memory management that prompted me to create this was
poor memory utilization. All of the alternative means of reclaiming pages in the
page allocator's slow path turn out to be very useful for maximizing memory
utilization, which is something that we would have to forgo by relying on a
purely pro-active solution. I have not had a chance to look at PSI yet, but
unless a PSI-enabled solution allows allocations to reach the same point as when
the OOM killer is invoked (which is contradictory to what it sets out to do),
then it cannot take advantage of all of the alternative memory-reclaim means
employed in the slowpath, and will result in killing a process before it is
_really_ necessary.

> If you design is relies on the speed of killing then it is fundamentally
> flawed AFAICT. You cannot assume anything about how quickly a task dies.
> It might be blocked in an uninterruptible sleep or performin an
> operation which takes some time. Sure, oom_reaper might help here but
> still.

In theory we could instantly zap any process that is not trapped in the kernel
at the time that the OOM killer is invoked without any consequences though, no?

Thanks,
Sultan
