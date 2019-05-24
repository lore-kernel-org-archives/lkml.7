Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729C3C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418BF20862
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W71ge/sC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389417AbfEXPLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:11:25 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:46727 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389079AbfEXPLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:11:25 -0400
Received: by mail-pg1-f177.google.com with SMTP id o11so603643pgm.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 08:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N4EgJZjlGHLwn0LnGRzqG910xvNy8GFmGDpAXkeN5vs=;
        b=W71ge/sCZHvRMYQQYMTjG4uhda4X/WdjwwcPZA7bbPij51mIzQtWSWH25BNPKXN4Zh
         ScJghfE5GCWlBb802+NDAgGau6DsInLWVQjXzRYQ0hNxzye1ABMHPo3uud9jaH5OXOc5
         pqWnRpajqOUtnufLI9jqWuJtRZmkshGq1Cv9OkU+geM4zDcvYGP8ivDJ94i86T2rJF6Q
         j0ffIEM/A/9kgq1/cldtxjc3JIByFioabiG9Y9UlYgcS9QLHteAEvnlj2U4KHNkNwq3q
         WWgauh1j8UZCqJb2Jv03XIJnEKJ3Z+CtW6+wfHiXL7L0yE5ubAJdKkohaqOs6QygdgNp
         1Cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N4EgJZjlGHLwn0LnGRzqG910xvNy8GFmGDpAXkeN5vs=;
        b=mGwv0wrv61A3ZJVmUvkHRCH/EkFbe4RVsMWLGMBmNBBFMxFf92lC/HJpgDrJFiHOYk
         0NndSc2VT22XG5imgbgfPMvgQ3EYGYaTqpspAtFFA4sVvBT4l8qCvdkqpUwvRL+FPBhK
         4TePcVtt/NqktO1XdmvOeHywv2YsyNalqALqcP7HztA5gKhxFBptnSi0PNsb3QkY8qR7
         co91o+bFYjFXr/ZvfYQ+YV9Ktw7LMgg0kuoXsmIamKj6dDYue0yG8noYDYKHcQi2wLDu
         Su1NpfQdb06drSAzHYK4fZTnfXnqx0iv7ME1q8EzqizntAdwwMBS+E+PB2IlHkrQTFgg
         qgdw==
X-Gm-Message-State: APjAAAU60ZF8P9klem3FzW1En7UA7XA74tcpICFNvxIMK66RVgq5oUzw
        2qIPAHHoWy2RxhT9yXXPQXf0FFAR3ibH1IwOz8vRVb88TJU=
X-Google-Smtp-Source: APXvYqxsoMZsh2NEt22b23Wfv9GDebk6BO5+TaAL+XPL3GtioG89T7K/NZHcRFK689a7feMISoC1nn1xI39BT2yQ6JE=
X-Received: by 2002:a63:d70b:: with SMTP id d11mr103752247pgg.178.1558710683990;
 Fri, 24 May 2019 08:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAMmhGqKc27W03roONYXhmwB0dtz5Z8nGoS2MLSsKJ3Zotv5-JA@mail.gmail.com>
 <20190329125258.2c6fe0cb@gandalf.local.home> <CAMmhGqKPw1sxB_Qc+Z-MXZue+wtAQsQDDgUvjs4JQTVY8bR65g@mail.gmail.com>
 <20190401222056.3da6e7a7@oasis.local.home> <CAMmhGqL0tvxW_ucJUFKYqRrMRTTfUfRGpm1BnXiEvqFntSXSjQ@mail.gmail.com>
 <CAMmhGq+8XKBB9GA3J0pwZ6X6Qb1syxKVqNU6i6digtyjMrGyWw@mail.gmail.com> <20190524110048.142efd44@gandalf.local.home>
In-Reply-To: <20190524110048.142efd44@gandalf.local.home>
From:   Jason Behmer <jbehmer@google.com>
Date:   Fri, 24 May 2019 08:11:12 -0700
Message-ID: <CAMmhGq+1gZvzR9RwJ6m1MzO1jnTy8yFx8jaRiWpGtZ=E6n9vig@mail.gmail.com>
Subject: Re: Nested events with zero deltas, can use absolute timestamps instead?
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     tom.zanussi@linux.intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 8:00 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 24 May 2019 07:17:15 -0700
> Jason Behmer <jbehmer@google.com> wrote:
>
>
> > Hi Steven,
> > Your other email reminded me of this thread.  The easy "fix" we
> > decided to pursue was to simply turn on absolute timestamps for all
> > events and use up the extra space, which in our particular application
> > isn't a huge deal.  We haven't yet gotten around to trying to send a
> > patch for plumbing user-configurable absolute timestamps, but as noted
> > immediately above, the configuration for timestamp_mode is actually a
> > bit tricky to implement with the existing histogram ref counting.  The
> > way I was thinking about dealing with that was to have a separate bool
> > to indicate the state the user has indicated they want, and then you
> > have to work through all the possible combinations of behavior:
> >
> > If user absolute timestamps is false, all behavior is exactly as today.
> > If user absolute timestamps is true, histogram refs transitioning 0->1
> > is a no-op, as is histogram refs transitioning 1->0.
> > If histogram refs are 0 and user absolute timestamps transition
> > false->true or true->false, they get what they want.
> > If histogram refs are >0 and user absolute timestamps transition
> > false->true, it's a no-op.
> >
> > And the confusing one:
> > If histogram refs are >0 and user absolute timestamps transitions
> > true->false we can't turn off absolute timestamps and screw up the
> > histograms, so we return an error.  But user absolute timestamps is
> > now false, which means when histogram refs transitions back to 0, it
> > will turn off absolute timestamps.
> >
> > What do you think of that?
>
> I don't think that's confusing if its well documented. Have the user
> flag called "force_absolute_timestamps", that way it's not something
> that the user will think that we wont have absolute timestamps if it is
> zero. Have the documentation say:
>
>  Various utilities within the tracing system require that the ring
>  buffer uses absolute timestamps. But you may force the ring buffer to
>  always use it, which will give you unique timings with nested tracing
>  at the cost of more usage in the ring buffer.
>
> -- Steve

Ah, I was thinking of doing this within the existing timestamp_mode
config file.  Having a separate file does make it much less confusing.
