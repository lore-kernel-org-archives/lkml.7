Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C386C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 05:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3843A2467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 05:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="WNGXalv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfLTFWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 00:22:01 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42141 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfLTFWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 00:22:01 -0500
Received: by mail-ed1-f68.google.com with SMTP id e10so7081580edv.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 21:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c2KTmXeXeXMiud96l6nUg2edTQgCxfxouifxscVRf0g=;
        b=WNGXalv6wGknAwomwUwaovAuPTvIQk7Xl9TqqlQvmj1rGqrkoFkmOPGli//9tqbPOv
         bC0y5Bs/3eANQWEqTALhW5Dku73NB5ieBnYuYxc1jUL3Zr8Uqy/gnWwYBGWtxLUJLsqD
         Tp7EfFzYyAQ8cd9J2+BJ9gPXs0uV9dWqQzzK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c2KTmXeXeXMiud96l6nUg2edTQgCxfxouifxscVRf0g=;
        b=nzRTujtf2wBsde//Z5EcUQ7A7ZvsVDrqmsa6qDWuMfvmxmHPh9oaDznmRsvHcXtbBq
         x0MC1crhx9OiHgCD1kMnC7d3Jehy91vEEhUL9lOuJExwvy//R0gmjevbAU5R7ESIRnAH
         Cj+KSTv+d9CVW0N9fu+JT2KeTfakGfD6sUavXhz8cP4J+osNBArwI2gRGBhtPXHZex+z
         A/SoYLswzxJISJMnAhBoCAAVDvMEbUIvUyd9AVf0+R1GGPCbTyhhmCrNz5diOZH63/PZ
         85o+akogNiZnUThPYy/+aQYezC/Y91NtyjHBzSEPXZkO3fjsqjT6vVRwWbhFRRcIvGHy
         8+/Q==
X-Gm-Message-State: APjAAAWKNHOx0PCK/jREtkexNvsFGjL6n8gJLUKRBEejlyVlZ2QUZxxr
        C6WPoapQ8Sjaj7wvGT0vIQfBY6EaGllIVsmmBpAYeQ==
X-Google-Smtp-Source: APXvYqzEMj7wR7jQmLsuZlyg4/9OOkLUmtqWJIdzbQ1FdkEnv81xGqzaY4T0ckwcnUBu1qoHgE7EBOXhUrhFb4u6MaM=
X-Received: by 2002:a17:906:4f93:: with SMTP id o19mr13905879eju.52.1576819319133;
 Thu, 19 Dec 2019 21:21:59 -0800 (PST)
MIME-Version: 1.0
References: <20191218235459.GA17271@ircssh-2.c.rugged-nimbus-611.internal> <CALCETrUK-SHA=sOUrBscpf+Bpxxff2L3RpXEaAfRHNnHGxa-LQ@mail.gmail.com>
In-Reply-To: <CALCETrUK-SHA=sOUrBscpf+Bpxxff2L3RpXEaAfRHNnHGxa-LQ@mail.gmail.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Thu, 19 Dec 2019 21:21:23 -0800
Message-ID: <CAMp4zn9R3XoV=xLi9y0vn-DotUQGRFA8Cp14aYYvkVYEUuW48w@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] pid: Add PIDFD_IOCTL_GETFD to fetch file
 descriptors from processes
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gian-Carlo Pascutto <gpascutto@mozilla.com>,
        =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <ealvarez@mozilla.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jed Davis <jld@mozilla.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 5:43 PM Andy Lutomirski <luto@kernel.org> wrote:
>
>
> I don't think this is MODE_READ.  By copying an fd from the task, you
> can easily change its state.
Would PTRACE_MODE_ATTACH_REALCREDS  work? I'm curious what
kind of state change you can cause by borrowing an FD?


>
> IMO it would be really nice if pidfd could act more like a capability
> here and carry a ptrace mode, for example.  But I guess it doesn't
> right now.
>
>
> --Andy
