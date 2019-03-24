Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF36C10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5C52147C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kpr2Pj89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfCXStF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 14:49:05 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:44955 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfCXStE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 14:49:04 -0400
Received: by mail-qt1-f170.google.com with SMTP id w5so7905729qtb.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 11:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3E5PbD/R8KE0AK8IEXA0HiRaTNZrWClh6JLvVEMcjJA=;
        b=Kpr2Pj89AACdsy9YXGxjPNM2856WloQP5gTnJGcMPHcDulRXB24JL1Q+55SZ8atsZ5
         pTu+lL+XbvMqTKShWIDc2U1PeoFD/B0fTrhrmRmWHQL39Y2XUuH3WcWHArJ1fChakr8M
         +EQugGx8TeJA6+qHQWTme3C9lUj/6RhHLE8pKqo9CAO9rB/MTEFgfWe9ZuB4k7PmnI/k
         7aJ3xsiegOQE/AqwkFIiHUTDJZZPTG8tjvyTShIZRB/ft+NCDYcNMITqGZilJqRKZHGJ
         kx++06XqoMPr0nh41EIxB69l6ghrb5N80kv2wK9f8K2619cn8tz2Rpgp8rzE15hkiie1
         mkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3E5PbD/R8KE0AK8IEXA0HiRaTNZrWClh6JLvVEMcjJA=;
        b=iwnMVVHw0SFALkvyMi3Jj7itRJYi95xFyTSv7t/xb/PTu04UE2zzumivkgMr/+AQP3
         WZUIkabyVRa/LsFmL2P2tG0kS+5CvM4HWgKR0IEkJ3U7peyJZgl8Pbp6OYjn+YiC7o+k
         S5kJF/wVctSruYqjPsHPM42t5GwvGnM/dzA3A8vBnYxin0TiXQKcLnlRf4Em7jShXM3m
         rALuDYvpkddsdTiXw/NHcF6M9C7QBupqgg4PwpCrLHoTu446G1imojs7lLEJmyK++ZlV
         KnGl2zDchJEy0sBk/LNKGmg+ZPF8dRnZDB02FixKBx1ytF2Jz+XwUnJbd9UXluMQvD+W
         j5xw==
X-Gm-Message-State: APjAAAVp61I1mAbzF9oFcoIH6GSAaAX/U9tWLmSQdWBYENvrJwB30NPz
        QETFB1rNiRFpNig/1t1motsRlJe7i9KQU7EifAudFw==
X-Google-Smtp-Source: APXvYqwCwbatcl/nUNjqKbqJbunhhvR2uPQnvJ0q0OU9X7yHkG1uyIFEAYpQ+V9uE6Rkswj54NQTVvUhOderhX900JE=
X-Received: by 2002:a0c:d2fa:: with SMTP id x55mr17704481qvh.161.1553453343410;
 Sun, 24 Mar 2019 11:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190319231020.tdcttojlbmx57gke@brauner.io> <20190320015249.GC129907@google.com>
 <CAKOZuetJzg_EiyuK7Pa13X3LKuBbreg7zJ5g4uQv_uV4wpmZjg@mail.gmail.com>
 <20190320035953.mnhax3vd47ya4zzm@brauner.io> <CAKOZuet3-VhmC3oHtEbPPvdiar_k_QXTf0TkgmH9LiwmW-_oNA@mail.gmail.com>
 <4A06C5BB-9171-4E70-BE31-9574B4083A9F@joelfernandes.org> <20190320182649.spryp5uaeiaxijum@brauner.io>
 <CAKOZuevHbQtrq+Nb-jw1L7O72BmAzcXmbUnfnseeXZjX4PE4tg@mail.gmail.com>
 <20190320185156.7bq775vvtsxqlzfn@brauner.io> <CAKOZuetKkPaAZvRZyG3V6RMAgOJx08dH4K4ABqLnAf53WRUHTg@mail.gmail.com>
 <20190324144404.GA32603@mail.hallyn.com>
In-Reply-To: <20190324144404.GA32603@mail.hallyn.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Sun, 24 Mar 2019 14:48:51 -0400
Message-ID: <CAJWu+op62YzbpKmgMMXROt-qaAVfx++XsYQCcK6MHu1qBfd=fg@mail.gmail.com>
Subject: Re: pidfd design
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Daniel Colascione <dancol@google.com>,
        Christian Brauner <christian@brauner.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 10:44 AM Serge E. Hallyn <serge@hallyn.com> wrote:
>
> On Wed, Mar 20, 2019 at 12:29:31PM -0700, Daniel Colascione wrote:
> > On Wed, Mar 20, 2019 at 11:52 AM Christian Brauner <christian@brauner.io> wrote:
> > > I really want to see Joel's pidfd_wait() patchset and have more people
> > > review the actual code.
> >
> > Sure. But it's also unpleasant to have people write code and then have
> > to throw it away due to guessing incorrectly about unclear
> > requirements.
>
> No, it is not.  It is not unpleasant.  And it is useful.  It is the best way to
> identify and resolve those incorrect guesses and unclear requirements.

No problem, a bit of discussion helped set the direction. Personally
it did help clarify lot of things for me.  We are hard at work with
come up with an implementation and are looking at posting something
soon. I agree that the best is to discuss on actual code where
possible.
