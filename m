Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90279C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6723C222DE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K5edr+xe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfKRTbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 14:31:23 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36136 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfKRTbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 14:31:23 -0500
Received: by mail-oi1-f195.google.com with SMTP id j7so16441323oib.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 11:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lkip5tRvw12bpfehhEr6pH72dcrY21taqVrxtTzIpV4=;
        b=K5edr+xedFq5I4V/ASDZBcAzez637Hy6MHbuKWYWMplzF7Q96rNQJihqBuir4XV1FC
         bFEONPEMKWyPnaQZfdEVjnGHRw0gPHwA0Ll7tGFQQYu8bA75cXdCMZN/RWWmaf9xjOoo
         Nu7nTA0vyhxsK8GdZ1PjZmr2wFC0OzYxaltsU8gmgABemah1g8Or1M+RgmIlSMiHtrIa
         UGYBLBhpTsARKd0lf4PKdT6pdLOt8328tuV3E8nNHTrwcWJXRyPzOOvDrx1wg61zeGZQ
         aZEyBbrjy6ZeR4S7NCuSpTElcWb270L1oZc4DQe734W0vHnVCWNgJS9J4vmPKHmhsaff
         nWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lkip5tRvw12bpfehhEr6pH72dcrY21taqVrxtTzIpV4=;
        b=lNpcxcXRbo96qFz48Wa7vJmRl8ZnInO4OyHwqMWC+I1lCBqYgv4k6wtEFjyk8GqomZ
         cOzjd9DOWqXEeIp9St9Bqc8GEq2f78FlO2JKpHsLCYDwzFY/6mk+WjGxL2cOvB329Zac
         GBXoPnLp2MMkMuD6EZl8nO8F4Xz+Dpr7oi0h5aIa9W7VBav8qa+LvJ0JIKhiFcEB7Yvd
         n+BQOmIIIiNpGER1m/qdMcYUYgmvOmPEyfOAOVmPsx99tg3Kk7ftMYJTZIceACilAg6m
         sRgEyTYLWNhJFQcZu659VE5B41IiTYf45lwpM+pJYhseUGC83Wzo/YDW2vey8ClQewCt
         ROZQ==
X-Gm-Message-State: APjAAAUOjWS/u3kB0c6UykZwlRhNBx4qu/m3SlC3Wwu7ne/eZPpUox1m
        ow9D3s5T2MoDSMJPTFIS3Lm71qdYF+4B3ReLOOHJMw==
X-Google-Smtp-Source: APXvYqwC/dQIewkL8jJpS8RkN+IxPo0rT4nHVms2uEMtgI/pTTWeyaTajuhRqtBB+9pL1h5bgMiSiXGPfbJQKyGgYN4=
X-Received: by 2002:a05:6808:9a1:: with SMTP id e1mr494893oig.175.1574105480391;
 Mon, 18 Nov 2019 11:31:20 -0800 (PST)
MIME-Version: 1.0
References: <1574096478-11520-1-git-send-email-prakash.sangappa@oracle.com> <1574096478-11520-2-git-send-email-prakash.sangappa@oracle.com>
In-Reply-To: <1574096478-11520-2-git-send-email-prakash.sangappa@oracle.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 18 Nov 2019 20:30:54 +0100
Message-ID: <CAG48ez1i9LUd2DPoP9na9OyqXDZVRJZQqBbS1H6Dz_h7mtJ=Mw@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 1/1] Selectively allow CAP_SYS_NICE capability
 inside user namespaces
To:     Prakash Sangappa <prakash.sangappa@oracle.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 6:04 PM Prakash Sangappa
<prakash.sangappa@oracle.com> wrote:
> Allow CAP_SYS_NICE to take effect for processes having effective uid of a
> root user from init namespace.
[...]
> @@ -4548,6 +4548,8 @@ int can_nice(const struct task_struct *p, const int nice)
>         int nice_rlim = nice_to_rlimit(nice);
>
>         return (nice_rlim <= task_rlimit(p, RLIMIT_NICE) ||
> +               (ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE) &&
> +               uid_eq(current_euid(), GLOBAL_ROOT_UID)) ||
>                 capable(CAP_SYS_NICE));

I very strongly dislike tying such a feature to GLOBAL_ROOT_UID.
Wouldn't it be better to control this through procfs, similar to
uid_map and gid_map? If you really need an escape hatch to become
privileged outside a user namespace, then I'd much prefer a file
"cap_map" that lets someone with appropriate capabilities in the outer
namespace write a bitmask of capabilities that should have effect
outside the container, or something like that. And limit that to bits
where that's sane, like CAP_SYS_NICE.

If we tie features like this to GLOBAL_ROOT_UID, more people are going
to run their containers with GLOBAL_ROOT_UID. Which is a terrible,
terrible idea. GLOBAL_ROOT_UID gives you privilege over all sorts of
files that you shouldn't be able to access, and only things like mount
namespaces and possibly LSMs prevent you from exercising that
privilege. GLOBAL_ROOT_UID should only ever be given to processes that
you trust completely.
