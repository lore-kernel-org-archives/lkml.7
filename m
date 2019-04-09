Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEC6C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4568C20833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554822086;
	bh=W21Nz4ZkQct2t0cht45dDWihtEr9kuxSC4+dPscHVis=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1xDf6voJMQl6wn6OBcJEvZvtkbJ0P9inSwCplK24Z8oHkAWlmv2XPK9wUIC9dbLAg
	 PwNAEkzlcJvMH8fT6JEEjDJbTb5zaBYX6LBhogIbzDGBf1eBQyaW4c8pWylAAUtaIn
	 jnMfltw/3n6M9O7xE8kzJ/6Uzr++vqC6H9yMZJzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfDIPBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:01:25 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40549 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDIPBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:01:25 -0400
Received: by mail-ot1-f68.google.com with SMTP id t8so15838480otp.7;
        Tue, 09 Apr 2019 08:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bOxeDOi9YuZikEmkRk4+bi9LOEftyf1ZfouDkT4x5To=;
        b=DUkfNGFwibQ57Zv07piyqCZh9VGTtc6XZ91p4dt6V+UkmsMzF6QgOKHwtQQ1KvwTJt
         KR7hVKqwBuGCahlvLFzQwVuA9E5Zundy4Gb/pY7//MRKN65AwflXmJt09LWR78YKMMBc
         N7hWMVUcUpOuJEX01Y4JRiPV9Zo9plA7it5sju/n/pKjUc1M67Jl/6fqt1Yz/rwkMbja
         FaH9eRQmEpcoL4uqeeR0F3Ufr0MLZjMxFXdgkjHqb9Cp+/szdND8GwghS2UVzn2AO8xn
         V9lUkv0x0zh7ASQrF7M5JxDAe/iKw6yv93E5F1ZVaL5/dy4aEyi0c1aJkPiYbWvVjX1D
         dk1w==
X-Gm-Message-State: APjAAAUkjXXkSzRjKD0lLXGCpYfhui5u4bYHfaELVeqnRh2uBUwyyeak
        lGTAvV9L0zsi21I/uAKOaW4CP5ADy9VBlgw5dnk=
X-Google-Smtp-Source: APXvYqwN4Uj1cY8i1C64kPL3Qk/iAK+N2m7Hkjxrn/tJVViJV2CdZnMCOlFlowZ8+Ou2Sn+mFLDpjEzyPYHrJOpiNQA=
X-Received: by 2002:a05:6830:11d0:: with SMTP id v16mr23893597otq.159.1554822083976;
 Tue, 09 Apr 2019 08:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190327143548.25305-1-ulf.hansson@linaro.org> <CAPDyKFqc9OeaCGrSu7toMcgZesN2xBqqWNQfqUt+4+FvQ4kmDw@mail.gmail.com>
In-Reply-To: <CAPDyKFqc9OeaCGrSu7toMcgZesN2xBqqWNQfqUt+4+FvQ4kmDw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Apr 2019 17:01:12 +0200
Message-ID: <CAJZ5v0g57V=tHdTJ2THLfTH_CbHQyS8xpNaeZUojPiHp=+gS4Q@mail.gmail.com>
Subject: Re: [PATCH v13 0/4] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 1:57 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 27 Mar 2019 at 15:35, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Changes in v13:
> >  - Use WRITE|READ_ONCE when reading/writing the "next_hrtimer" variable in the
> > struct cpuidle_device. Also reset the same variable after resumed from idle to
> > avoid it from containing a stale value.
> >  - Added acks from Daniel Lezcano.
> >  - The entire v13 series, including the PSCI/ARM changes are available in a
> > git branch [3].
>
> Rafael, I have address the received comments on this version $subject
> series, is there anything that is holding you back from queuing it?
>
> If you like I can send a pull-request, to simplify for you.

I will get to this one shortly.  I've been waiting for possible
comments on patch [3/4], but since no one has commented so far, it
seems to be non-controversial. :-)

I'm going to add this material to the cpuidle branch rather than genpd.

> Moreover, there is another series which I have pinged you about
> earlier, which I would appreciate to queue via your tree. It's acked
> by PSCI maintainers and is ready to go. "[PATCH v2 0/5] drivers:
> firmware: psci: Some cleanup and refactoring".

If you want me to merge the PSCI series, please resent it with a
request to that end in the cover letter.  Also please let me know
whether or not it depends on the $subject series.
