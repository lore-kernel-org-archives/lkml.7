Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C26CC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AE4217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M4QUoyns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390194AbfEXPs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:48:58 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:39134 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389079AbfEXPs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:48:58 -0400
Received: by mail-pl1-f178.google.com with SMTP id g9so4325442plm.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 08:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m6gKYz7wkMPGTWMNM0luL5MmLCYmBXD7EJslrvo/nuI=;
        b=M4QUoyns4jSgst9lr4PwNHSUiJULHUtmzpXOWndjKxy4R6IxbXauo5MLpecOAGHzVd
         7txaUQB3BUrcseBlcRGnzxH6ugyzMaXst4C4Xf/PfNBsOQJUsgDQrawrNBRwa+j+pzai
         dc4HndGGbrZHemNVGV8OQfhSl+KDkQ2iKoDV5zOceF3NFyMJM6zYHFV4aTGB0bFXZ3MB
         kttg0HiaviV/rHqN/nX4fIjA3SxT730gE4iDAoHjprM+Ib+UJL66opcCEwtwIwLXd4dW
         ICuaRA9wXlfR87lMl0KpAaevH/emFdCSUuqbDqXhvfdMdj59LhoIpW+3yuk/OsqdoHUO
         lPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m6gKYz7wkMPGTWMNM0luL5MmLCYmBXD7EJslrvo/nuI=;
        b=pI8hbRY4Wn5GJblWJPA7yJ1rec6eA1TD/lWzc53voClwv7TYP5l9dsOuWXNRupUwN9
         FgsKT3yWNPU3dJb+3g3ZnRr35IDa60JcSLvhWuzYuI7Kq2bpa4kipPB6AK/hlx3qcQmj
         2fKyWB0R6RAoC9bDNQtXkZuFp6tZyS9pdV4LIoUx/F93CfAarf9tO+sMakdbOzU0V17A
         lFvBShjb6N5wzU0P5umqJqy8ap/t5qSuQhMzbqp+ZggzfHHXP47lSUVsdkg72cfrGM2c
         tof7V8D4Cv6IbmU+MqoyifgfWfmDyyg/OP26RMlivd6w84yxxsaaaHsiUZREPVi37EU0
         E5Rg==
X-Gm-Message-State: APjAAAVFCdHg6HQZel6Ypoj735aXzU9PY1x1xdzd4Eihzqh+0J1XtiZc
        2Jl/ti1U99x1zKK3dh+qk6CuOWpE2xt/GOVBggwLvPEjbho=
X-Google-Smtp-Source: APXvYqzt+tANlU8Rah8eIjD2c2ndYNOEsbqihsbGfnF3jgLGWI/bEJDx77myq9kw+EFJoQEvuqsFy2MjrsQQ7oENbaY=
X-Received: by 2002:a17:902:7486:: with SMTP id h6mr11158387pll.262.1558712936535;
 Fri, 24 May 2019 08:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAMmhGqKc27W03roONYXhmwB0dtz5Z8nGoS2MLSsKJ3Zotv5-JA@mail.gmail.com>
 <20190329125258.2c6fe0cb@gandalf.local.home> <CAMmhGqKPw1sxB_Qc+Z-MXZue+wtAQsQDDgUvjs4JQTVY8bR65g@mail.gmail.com>
 <20190401222056.3da6e7a7@oasis.local.home> <CAMmhGqL0tvxW_ucJUFKYqRrMRTTfUfRGpm1BnXiEvqFntSXSjQ@mail.gmail.com>
 <CAMmhGq+8XKBB9GA3J0pwZ6X6Qb1syxKVqNU6i6digtyjMrGyWw@mail.gmail.com>
 <20190524110048.142efd44@gandalf.local.home> <CAMmhGq+1gZvzR9RwJ6m1MzO1jnTy8yFx8jaRiWpGtZ=E6n9vig@mail.gmail.com>
 <20190524112457.58b24d89@gandalf.local.home>
In-Reply-To: <20190524112457.58b24d89@gandalf.local.home>
From:   Jason Behmer <jbehmer@google.com>
Date:   Fri, 24 May 2019 08:48:44 -0700
Message-ID: <CAMmhGqK7LxvR2t=v3NY5Um+EPurtbSfkpPtCAhDagFs_Sz0Kuw@mail.gmail.com>
Subject: Re: Nested events with zero deltas, can use absolute timestamps instead?
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     tom.zanussi@linux.intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 8:25 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 24 May 2019 08:11:12 -0700
> Jason Behmer <jbehmer@google.com> wrote:
>
> > > > What do you think of that?
> > >
> > > I don't think that's confusing if its well documented. Have the user
> > > flag called "force_absolute_timestamps", that way it's not something
> > > that the user will think that we wont have absolute timestamps if it is
> > > zero. Have the documentation say:
> > >
> > >  Various utilities within the tracing system require that the ring
> > >  buffer uses absolute timestamps. But you may force the ring buffer to
> > >  always use it, which will give you unique timings with nested tracing
> > >  at the cost of more usage in the ring buffer.
> > >
> > > -- Steve
> >
> > Ah, I was thinking of doing this within the existing timestamp_mode
> > config file.  Having a separate file does make it much less confusing.
>
> Not a separate file, but a new tracing option.
>
> -- Steve

Sorry, I'm not sure I follow.  By new tracing option do you mean a new
option in the timestamp_mode file?  I guess in that case would that
still be the only writable option?  You could write 1/0 to the file
which would turn on/off force_absolute_timestamps, and reading the
file would show which of absolute, delta, and force_absolute was set?
Or did you mean something else by tracing option?
