Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34866C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E552064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZoyMlSr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfCKUKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:10:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35797 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbfCKUKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:10:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id y15so415195wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 13:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZKCjSMCXnbl4Pu4JXE4MWbjLrTVkbghT9J2ILGHq6Q8=;
        b=ZoyMlSr4ebBY08p033osdVOmkU3R9VXs9CSVj/pQyFonxmrwtnSc0LmAVDsfbgP55D
         ddEnaeZ6ws19K7QMY4nRzaczDzZkCQCCyshQblMFWRu/p9vnvksfGlqiQpzEWPHfCHAv
         O2QKUZQ7GMZW0nuLBwPK3KFK9befY91P4bUk0zbAfc1mZTDhSKU6nSdb6IQtUIcVtNPs
         sdHDJ1Egdru01rBhc3N8MHLdIOhSc/XihtaTUrpIfYIttNUT91ca27+5fhDDVQZbXno4
         v5hFaJkbB8G0d4TGxibTSjoLPjvodmj+RX42iAMEJHe+K4qc+Nygj0cw9soZ+ous0rok
         fIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZKCjSMCXnbl4Pu4JXE4MWbjLrTVkbghT9J2ILGHq6Q8=;
        b=USa7Z8hz2yh+14V1ZZ6nv/ZqfSqeUwWrrx8nDyIJq34K1Yqop6uHDhLlc/tESgTxOV
         B0HkHaJSIh8use+ZEx65n6WZ2hmEUbjFNhvheZ1TegYNJIwQRR158Aq6hXtOXMnW0e1g
         Oryq1OGpCf+cMZ3bxszYyyoxGjHWSl8CXYS52GeAG1gQpL16NBbXbPPVxuZ/dola/eXa
         T5QpRVoU21zeye90yMLa3dLrEfkSLsbQGA93FzRedmeygnF8AbU280IQDCf7FkXs07SO
         sxkWHhCccesX2ooVwcKrQSoH/Kw+lUX9aDEpJOleX/dEI77JpmawurCkZmFNM/XTfFDk
         9dFw==
X-Gm-Message-State: APjAAAV9kVM1eYIhCY4ILhgKOerwxLQ8NMeVrvEcZ9wQM+0jrhqRFbUO
        0hPFuN/C+hGS+tyRlqFg1J/W/q3zZhYoOYqGMCleEA==
X-Google-Smtp-Source: APXvYqyAhHtIn/JyZsUQaWeDQx/1ZnVIq0WJwtHUsqjs8SGHawVn6dVOeO6ND9qSoUIG6lWkjiWgCCAM1fETYT6zmf4=
X-Received: by 2002:a1c:20d3:: with SMTP id g202mr11751wmg.74.1552335047677;
 Mon, 11 Mar 2019 13:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190310203403.27915-1-sultan@kerneltoast.com>
 <20190311174320.GC5721@dhcp22.suse.cz> <20190311175800.GA5522@sultan-box.localdomain>
In-Reply-To: <20190311175800.GA5522@sultan-box.localdomain>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 11 Mar 2019 13:10:36 -0700
Message-ID: <CAJuCfpHTjXejo+u--3MLZZj7kWQVbptyya4yp1GLE3hB=BBX7w@mail.gmail.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, devel@driverdev.osuosl.org,
        linux-mm <linux-mm@kvack.org>, Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sultan,

On Mon, Mar 11, 2019 at 10:58 AM Sultan Alsawaf <sultan@kerneltoast.com> wrote:
>
> On Mon, Mar 11, 2019 at 06:43:20PM +0100, Michal Hocko wrote:
> > I am sorry but we are not going to maintain two different OOM
> > implementations in the kernel. From a quick look the implementation is
> > quite a hack which is not really suitable for anything but a very
> > specific usecase. E.g. reusing a freed page for a waiting allocation
> > sounds like an interesting idea but it doesn't really work for many
> > reasons. E.g. any NUMA affinity is broken, zone protection doesn't work
> > either. Not to mention how the code hooks into the allocator hot paths.
> > This is simply no no.
> >
> > Last but not least people have worked really hard to provide means (PSI)
> > to do what you need in the userspace.
>
> Hi Michal,
>
> Thanks for the feedback. I had no doubt that this would be vehemently rejected
> on the mailing list, but I wanted feedback/opinions on it and thus sent it as anRFC.

Thanks for the proposal. I think Michal and Joel already answered why
in-kernel LMK will not be accepted and that was one of the reasons the
lowmemorykiller driver was removed in 4.12.

> At best I thought perhaps the mechanisms I've employed might serve as
> inspiration for LMKD improvements in Android, since this hacky OOM killer I've
> devised does work quite well for the very specific usecase it is set out to
> address. The NUMA affinity and zone protection bits are helpful insights too.

The idea seems interesting although I need to think about this a bit
more. Killing processes based on failed page allocation might backfire
during transient spikes in memory usage.
AFAIKT the biggest issue with using this approach in userspace is that
it's not practically implementable without heavy in-kernel support.
How to implement such interaction between kernel and userspace would
be an interesting discussion which I would be happy to participate in.

> I'll take a look at PSI which Joel mentioned as well.
>
> Thanks,
> Sultan Alsawaf

Thanks,
Suren.
