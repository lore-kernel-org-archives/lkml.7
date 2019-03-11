Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBE2C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B0D214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfCKUqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:46:33 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43547 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKUqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:46:32 -0400
Received: by mail-ot1-f66.google.com with SMTP id n71so443632ota.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 13:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j9c9mo+8DPUzk82qtoerfgEHz5CQacA8eGqE4SQcQfw=;
        b=RCLmskJGdvan27ggVGkOH/FIqkvY7hM2Qu8q12xaImMizLeGGNiAWYOWDG4J9mTplA
         Xtok0rciHIbE1q/T2d9YQtNFbr1mvnp1pUEx7/mj45JEDQF+1dpocJJWt4fElOrl2E1p
         W2/Y36O2VaNAmEkJ1rREqK3YC1Y13efTI3+dgx8pHpAeZoohHeAMTeRt8tUFj3H4Hyhx
         aYcrJd1LTkdFNno5gtvtYyk8cleMfJFLZC4GKPIq4DkwgjespL5YKB1XCmYNvUKW9Hwg
         sA7sKaYkvp2yvn7Dz64+jvI7Oln4Hwhd8odT5bgd9RXWK8423AokBqUMj1JHSpE387pR
         YfnA==
X-Gm-Message-State: APjAAAX9lEOHhUF9rG6aWT5fXlytUNG7uH7Sn1bCtvgb6ive8qMOHvA7
        a5Ibhtqk8QhLhEe+w5VVhvQ=
X-Google-Smtp-Source: APXvYqxQRiH803qpRcDOxJglErXRvHzf9M4g8BMJclGzpIiuZOsHoUODljrh4Klro9fRvKGZfiIk+g==
X-Received: by 2002:a9d:7b4e:: with SMTP id f14mr21423244oto.141.1552337191930;
        Mon, 11 Mar 2019 13:46:31 -0700 (PDT)
Received: from sultan-box.localdomain ([2600:1700:7c70:1680::21])
        by smtp.gmail.com with ESMTPSA id v2sm2621521otk.60.2019.03.11.13.46.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 13:46:31 -0700 (PDT)
Date:   Mon, 11 Mar 2019 13:46:26 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
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
Message-ID: <20190311204626.GA3119@sultan-box.localdomain>
References: <20190310203403.27915-1-sultan@kerneltoast.com>
 <20190311174320.GC5721@dhcp22.suse.cz>
 <20190311175800.GA5522@sultan-box.localdomain>
 <CAJuCfpHTjXejo+u--3MLZZj7kWQVbptyya4yp1GLE3hB=BBX7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHTjXejo+u--3MLZZj7kWQVbptyya4yp1GLE3hB=BBX7w@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 01:10:36PM -0700, Suren Baghdasaryan wrote:
> The idea seems interesting although I need to think about this a bit
> more. Killing processes based on failed page allocation might backfire
> during transient spikes in memory usage.

This issue could be alleviated if tasks could be killed and have their pages
reaped faster. Currently, Linux takes a _very_ long time to free a task's memory
after an initial privileged SIGKILL is sent to a task, even with the task's
priority being set to the highest possible (so unwanted scheduler preemption
starving dying tasks of CPU time is not the issue at play here). I've
frequently measured the difference in time between when a SIGKILL is sent for a
task and when free_task() is called for that task to be hundreds of
milliseconds, which is incredibly long. AFAIK, this is a problem that LMKD
suffers from as well, and perhaps any OOM killer implementation in Linux, since
you cannot evaluate effect you've had on memory pressure by killing a process
for at least several tens of milliseconds.

> AFAIKT the biggest issue with using this approach in userspace is that
> it's not practically implementable without heavy in-kernel support.
> How to implement such interaction between kernel and userspace would
> be an interesting discussion which I would be happy to participate in.

You could signal a lightweight userspace process that has maximum scheduler
priority and have it kill the tasks it'd like.

Thanks,
Sultan
