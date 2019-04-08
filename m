Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FBAC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095A2213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MNNGH9ib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfDHRZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:25:48 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46168 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfDHRZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:25:44 -0400
Received: by mail-vs1-f66.google.com with SMTP id e2so8067969vsc.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 10:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SFkD/PegX130Roia1EM+1l7LEFA+D+0PxdCR3h8muNQ=;
        b=MNNGH9ibp+2NhoUqD1a6aPTrnfV9XljQZVKcdkhdCskUhDQy8NT07CRxmLxChbh+dI
         VB/naX4kQUKYcmcWN54EYcJbEn8eaJ9GDza1+H1HjbOwn3L4tJ+muyuVWi3j5Wmf89nK
         GhO5MwQfO9WhlRSQNNdGKU/OoJ2EBo//a+o+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SFkD/PegX130Roia1EM+1l7LEFA+D+0PxdCR3h8muNQ=;
        b=Agj1bP4JL93HmYkB+ozx4eI+0dSpps+S5JBpr3CCSvcLM7e3cZ7UdBCal6A9gmbemg
         89q27SaXaHDk9P2UaKlNZsf040X57VjYcSyCvzBH/4QDaAGDATJutTCzwUAkXr5ABsnv
         C2FLJtzeoxWhpvUZCbEhjcLUmI2VPYtJlZn6idzZ9mtkNlM/+GrwHZphlTcb9fA7BoQm
         GnNkRSb0s6/+HuGlIOq27XCf6vn2Np/O3HooTYG2AcXXeIvy8PU+FOb46M0126LM0iVv
         RrJ4/cs+v7IMW/JgxKTRjUKxZaiuU5YovUo5hMLbvjnVS0is7ZXxbdQqJcyXaxwz7DH9
         icig==
X-Gm-Message-State: APjAAAWqxeZfAFr4ARJpsiQk9T/SSarK35qcmxgXZkbY+Vd5fovCtMVo
        jW1PYongeXfn6nI6mZjfK+b0JzYOmAM=
X-Google-Smtp-Source: APXvYqybXuChwB4f9PGtiLJwT4XpJftu0hqQU88pQBMQhBI3gC7FBmzEs1yT9J8tPzHc3OU5dQ7lsw==
X-Received: by 2002:a67:fb19:: with SMTP id d25mr15859225vsr.36.1554744342328;
        Mon, 08 Apr 2019 10:25:42 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id q190sm11062395vkd.50.2019.04.08.10.25.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 10:25:41 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id w13so8103518vsc.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 10:25:41 -0700 (PDT)
X-Received: by 2002:a67:76c7:: with SMTP id r190mr18005932vsc.196.1554744340551;
 Mon, 08 Apr 2019 10:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190408160706.GA18786@beast> <73c80352-ded1-626b-0eb0-a9481165f25d@canonical.com>
In-Reply-To: <73c80352-ded1-626b-0eb0-a9481165f25d@canonical.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 8 Apr 2019 10:25:28 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+k86VtegoRxV1s++YZdMxXEhQhqx1Yh7eu+YKHn0wNZA@mail.gmail.com>
Message-ID: <CAGXu5j+k86VtegoRxV1s++YZdMxXEhQhqx1Yh7eu+YKHn0wNZA@mail.gmail.com>
Subject: Re: [PATCH] apparmor: Restore Y/N in /sys for apparmor's "enabled"
To:     John Johansen <john.johansen@canonical.com>
Cc:     James Morris <jmorris@namei.org>,
        David Rheinsberg <david.rheinsberg@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 9:58 AM John Johansen
<john.johansen@canonical.com> wrote:
> > +/* Can only be set before AppArmor is initialized (i.e. on boot cmdline). */
> > +static int param_set_aaintbool(const char *val, const struct kernel_param *kp)
> > +{
> > +     struct kernel_param kp_local;
> > +     bool value;
> > +     int error;
> > +
> > +     if (apparmor_initialized)
> > +             return -EPERM;
> > +
> This isn't sufficient/correct. apparmor_initialized is only set after
> apparmor has gone through and completed initialization. However if
> apparmor is not selected as one of the LSMs to enable, then this check
> won't stop apparmor_enabled from being set post boot.
>
> However with the apparmor_enabled param being 0444 and the
> apparmor_enabled_setup() fn handling boot cmdline do with even need
> the set parameter fn?

Yup, that's true. I've gone and tested this, and yes, the 0444 is
sufficient to protect the logic here (even if root chmods the inode).
So the test here is redundant. However, very early in the threads
about LSM boot cmdline enabling it was made clear that
"apparmor.enabled=..." needed to stay working, which means the "set"
op is still needed. (But I'm happy to do whatever you want here -- I
was just trying to keep the functionality as it was.)

Should I send a v2 without the "initialized" check or is this okay to
leave as-is with the redundant check?

-- 
Kees Cook
