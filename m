Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D5DC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 00:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333672184D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 00:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BOKfXFP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfELAkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 20:40:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33630 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfELAkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 20:40:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id c66so3652541wme.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 17:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wk3f4ANAQNQm/6HdNn8LfEGD/oRb9SnWdmYEOPacBzQ=;
        b=BOKfXFP9WO8riV2TiJcZ/UAvMT0xfTyAgEyEC0F8jGW4Uunsa5nyxJalCNR1eHRPrU
         pKFn+W9BYrxucMHuMqpwzoltoFsLErFtD9MooJ7lFRZb87rQN3hH5MNNg8iQqCfaGiYd
         JikyWgoQjzMvwDmXwTHpxdruW1doZUEyoRh2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wk3f4ANAQNQm/6HdNn8LfEGD/oRb9SnWdmYEOPacBzQ=;
        b=p+UmpjX7N00fjPhvVbIshGPNrs1jxoWC3qGdhhL2uEDrbECufggK7PuZ2/1QJ6AOAg
         0axjFmEHsIPtTeMFEkG9J2vJ5Jy3m/dn3Sx424qqK7HvHLvsxkQ7CcX2afzRT4MfAtPG
         hcmNrDacUJYOh4d4fn34xGzLgOesdNwnyutCLboq45yQKnJRf7RkhsXpDynYkwdtUH6m
         ZLF7mT585BP1zHwq8xg2/lFwtXareOKqmJ5BXu0aZOBA2HA2UfWiWl8PPe3GbfNX3Ehf
         8j8fhq28TW5FMLryJvKdNfEsFUNAgxxtEgAT71tTuqSPn6HMVT8axW6qAfvKC3yshPZr
         w0NA==
X-Gm-Message-State: APjAAAXf2P+5pyB4gs6SEbJ+VdLkerNNQXhtiKGBkmb7+0wEp+yV++8y
        6Ccyd90liy+qS2v5lr32Q/B8eA==
X-Google-Smtp-Source: APXvYqwO7hlKzpKe2GxIIkGr7hU5j/a2dkUkVDvruYgoiVAwEW0tA4ftGam+QGX8FXXTunhR+a+Drg==
X-Received: by 2002:a1c:f207:: with SMTP id s7mr11693724wmc.137.1557621615546;
        Sat, 11 May 2019 17:40:15 -0700 (PDT)
Received: from andrea ([89.22.71.151])
        by smtp.gmail.com with ESMTPSA id z8sm3382248wrh.48.2019.05.11.17.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 17:40:14 -0700 (PDT)
Date:   Sun, 12 May 2019 02:40:08 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Dhaval Giani <dhaval.giani@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        shuah <shuah@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Carpenter,Dan" <dan.carpenter@oracle.com>, willy@infradead.org,
        gustavo.padovan@collabora.co.uk,
        Dmitry Vyukov <dvyukov@google.com>, knut.omang@oracle.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Linux Testing Microconference at LPC
Message-ID: <20190512004008.GA6062@andrea>
References: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
 <20190423102250.GA56999@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423102250.GA56999@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 11:22:50AM +0100, Mark Rutland wrote:
> On Thu, Apr 11, 2019 at 10:37:51AM -0700, Dhaval Giani wrote:
> > Hi Folks,
> > 
> > This is a call for participation for the Linux Testing microconference
> > at LPC this year.
> > 
> > For those who were at LPC last year, as the closing panel mentioned,
> > testing is probably the next big push needed to improve quality. From
> > getting more selftests in, to regression testing to ensure we don't
> > break realtime as more of PREEMPT_RT comes in, to more stable distros,
> > we need more testing around the kernel.
> > 
> > We have talked about different efforts around testing, such as fuzzing
> > (using syzkaller and trinity), automating fuzzing with syzbot, 0day
> > testing, test frameworks such as ktests, smatch to find bugs in the
> > past. We want to push this discussion further this year and are
> > interested in hearing from you what you want to talk about, and where
> > kernel testing needs to go next.
> 
> I'd be interested to discuss what we could do with annotations and
> compiler instrumentation to make the kernel more amenable to static and
> dynamic analysis (and to some extent, documenting implicit
> requirements).
> 
> One idea that I'd like to explore in the context of RT is to annotate
> function signatures with their required IRQ/preempt context, such that
> we could dynamically check whether those requirements were violated
> (even if it didn't happen to cause a problem at that point in time), and
> static analysis would be able to find some obviously broken usage. I had
> some rough ideas of how to do the dynamic part atop/within ftrace. Maybe
> there are similar problems elsewhere.
> 
> I know that some clang folk were interested in similar stuff. IIRC Nick
> Desaulniers was interested in whether clang's thread safety analysis
> tooling could be applied to the kernel (e.g. based on lockdep
> annotations).

FWIW, I'd also be interested in discussing these developments.

There have been several activities/projects related to such "tooling"
(thread safety analysis) recently:  I could point out the (brand new)
Google Summer of Code "Applying Clang Thread Safety Analyser to Linux
Kernel" project [1] and (for the "dynamic analysis" side) the efforts
to revive the Kernel Thread sanitizer [2].  I should also mention the
efforts to add (support for) "unmarked" accesses and to formalize the
notion of "data race" in the memory consistency model [3].

So, again, I'd welcome a discussion on these works/ideas.

Thanks,
  Andrea


[1] https://summerofcode.withgoogle.com/projects/#5358212549705728
    https://github.com/ClangBuiltLinux/thread-safety-analysis
[2] https://github.com/google/ktsan/commits/ktsan
[3] https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=dev&id=c602b9e58cb9c13f260791dd7da6687e06809923
    https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=dev&id=3b1fe99c68b5673879a8018a46b23f431e4d4b7a
    https://lkml.kernel.org/r/Pine.LNX.4.44L0.1903191459270.1593-200000@iolanthe.rowland.org
