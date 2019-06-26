Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E3DC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 23:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCB0217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 23:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FS7iy+g9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfFZXQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 19:16:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43079 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfFZXQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 19:16:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so74136pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 16:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rIf45gOhciYi+BEA1QhcjyjxejhgA9SV6NIAGt0tSas=;
        b=FS7iy+g9zx3oAMlGG3D0W0JPwy/tDVHMgqzpmeT3Jjn6nxVRhEdg5/NYFSTnvkmFQ2
         PgRZcXG3jBuuwnI/8XWYb2iNxhsmALBgVW1c+OkAbD4ooDo4VMNk0SbnbK4TQmaTMWM3
         C1Y+vTBcFOAcuS0BxH7wa9KaorGywvPrTRh5boVWorsYt9KP2pP0AkauYNjtxUyeIzRw
         xZ78zCa6IxdboMARhhpRN0KyB2+jWNV/gaWAy0FPdMUwYRb01kQ6+TburGkruRGhusW2
         iZAw1ncDgj+WIQh8eG4JQl0hVsvxKNHEHwtaTtLP7v4fChdp7sWSJpcL0svKF/MOd89q
         z4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rIf45gOhciYi+BEA1QhcjyjxejhgA9SV6NIAGt0tSas=;
        b=M+DUuMnTaFC8lT5H1v2ZhH5KsP40sV0daz7CFoF8iKT0kQsDK6gWcZAnQ8WFU0L9wO
         KnmAp6S0mCnISCYKQRQiGRIiqRMWl6eFMf67Qc64FOI6VYBzO3o86OVnWdf561ZONKqV
         d6Yc2o3LeEv/iUBuYKLncST4oOnbH+7phYlxYMTD0Vu1gYDECElzYdpF1mxooISjC/tH
         BEFd5jA6RmY59Ot7xVRhGuaQcs3e8c43F7zmiEerhFJArBhlEdhlQxXyZygfgIlQxTgt
         BAMemsTTdObu2t/qtfB9lD7F8UAg7MDjF5DTJ+CMTHDnewBJu0oIWL2aVtRyd8jELAC7
         XVuQ==
X-Gm-Message-State: APjAAAWCEDMEDwku3ZvLGzVuByFPIcwQiKcZSIBxs9KgUHxLQpIiSwF0
        zuVmPgsDkl92WQ3Lfwxq70OBGAvYWF+z8b23bcI3yg==
X-Google-Smtp-Source: APXvYqyNTvkeYr9yHAr4kkMQHawMvd4eAgdghexDn0r87WS31+gHv8nTPqSRhuedpXee40C9Duptq1f/n/6kv4UnlhY=
X-Received: by 2002:a63:52:: with SMTP id 79mr442512pga.381.1561590971627;
 Wed, 26 Jun 2019 16:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190617222034.10799-1-linux@rasmusvillemoes.dk>
 <20190617222034.10799-8-linux@rasmusvillemoes.dk> <CAKwvOdn5fhCTqtciKBwAj3vYQMhi06annzxcdC1GjKxri=dHnw@mail.gmail.com>
 <12bd1adc-2258-ad5d-f6c9-079fdf0821b8@rasmusvillemoes.dk> <CAKwvOdkqy8=V17qEM_SMDEAh=UX5Y2-nj9EUkC169nEiXc_JzA@mail.gmail.com>
 <70aa7b96-e19d-5f8b-1ff6-af15715623e5@rasmusvillemoes.dk> <CAKwvOdkWo5yG7LrtGL_ht-XHFgNqx_t6rP+hHhcPyb+Ud1N+HA@mail.gmail.com>
In-Reply-To: <CAKwvOdkWo5yG7LrtGL_ht-XHFgNqx_t6rP+hHhcPyb+Ud1N+HA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 26 Jun 2019 16:16:00 -0700
Message-ID: <CAKwvOdnFt18ffO0BV-AZ9+mYuOBMroPObxrakXdV1v4iL3CS3Q@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] dynamic_debug: add asm-generic implementation for DYNAMIC_DEBUG_RELATIVE_POINTERS
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 3:18 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
> 2. pci_pm_suspend_noirq seems to exist twice(?) before your patches, once after
> 3. xhci_urb_enqueue seems to exist three times before your patches, twice after

PEBKAC, I advanced my master branch without rebasing my local branch
with these changes.  With the local branch rebased onto master, there
are no differences.  2888 in both cases, line numbers do not differ.

I wasn't able to trip any logs in kobject:
(initramfs) echo "file kobject.c +p" > /dfs/dynamic_debug/control
(initramfs) cat /dfs/dynamic_debug/control | grep kobject
lib/kobject.c:161 [kobject]fill_kobj_path =p "kobject: '%s' (%p): %s:
path = '%s'\012"
lib/kobject.c:668 [kobject]kobject_cleanup =p "kobject: '%s' (%p): %s,
parent %p\012"
lib/kobject.c:672 [kobject]kobject_cleanup =p "kobject: '%s' (%p):
does not have a release() func"
lib/kobject.c:677 [kobject]kobject_cleanup =p "kobject: '%s' (%p):
auto cleanup 'remove' event\01"
lib/kobject.c:684 [kobject]kobject_cleanup =p "kobject: '%s' (%p):
auto cleanup kobject_del\012"
lib/kobject.c:690 [kobject]kobject_cleanup =p "kobject: '%s' (%p):
calling ktype release\012"
lib/kobject.c:696 [kobject]kobject_cleanup =p "kobject: '%s': free name\012"
lib/kobject.c:744 [kobject]dynamic_kobj_release =p "kobject: (%p): %s\012"
lib/kobject.c:253 [kobject]kobject_add_internal =p "kobject: '%s'
(%p): %s: parent: '%s', set: '%"
lib/kobject.c:915 [kobject]kset_release =p "kobject: '%s' (%p): %s\012"

The prints should show up in dmesg right, assuming you do something to
trigger them?  Can you provide more details for a test case that's
easy to trip? What's an easy case to reproduce from a limited
buildroot env (basic shell/toybox)?
-- 
Thanks,
~Nick Desaulniers
