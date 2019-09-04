Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D149C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8D920882
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i3Woe2pW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732339AbfIDQva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:51:30 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:32806 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732212AbfIDQv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:51:29 -0400
Received: by mail-io1-f54.google.com with SMTP id m11so13743874ioo.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 09:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZhwDl6poxhpjErg8726fERGH8TrIU1vOsYDyQkch3E=;
        b=i3Woe2pWDCqAw20ncPSTH8Ql/DNWO3edrHq446JMjqWucW0BQjssI4ttLhKd71iIyA
         s4xgPPgqhtUZDObsdTA0/iwkPfmg+Uz/cfT/9iJpj/RDTX/MtG83BLLsK+bHQxU+LbCJ
         Jse0xUFXD6Uzij7kOt7TziTiqtDRxp8wvxVVPsLKaCquivp6GEMrHerFs7w64WsyQDoy
         Ki44kzBodecZCrKnR4RzT9Nw1C94M2ntE8SKSIbn+OzoGXMEuGDuYKmYPX6bb2yvC1lr
         ChOh5yXl2tF0pod2DjqiglMA155srRe6QOwrzQBKXSalbNM9bk2Hfr1AgrVFR7xavRyN
         7J1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZhwDl6poxhpjErg8726fERGH8TrIU1vOsYDyQkch3E=;
        b=G/4T782IExvz3TT3HG8+uvXZt7wm3ICRiNOnvWTPnuajrOBegDqrLmpJ19aRwT1WNo
         HyQMDOE4/zD5ad0EZvirCiZ/OkiCiLaPYPb/XdAWGCIimgL14J+gsmoydr/2r8FUNUhK
         ZZiF26pt6XzicehNK6uzvaqWQ7foo1OC9V3w6We82PMn6RcYckr9ggjtNhu5KrmppfGW
         oQqPfyDpQ8yvv6AWDVL69ZZxloarqe3BtJlzQ+6BuZC+lhdAWoM5mBJbP/p4s1EsVUPR
         cm/b3lYsOGSUObacilFUmfOaWgkxn4DVokGppNuny4h+ZOyHnnEITAK17COH6t3s1SYR
         hxRg==
X-Gm-Message-State: APjAAAWLhQvIOgJgnkVoaUsOIXwNcykgzHI4rJz8nufNdwXm0JyntN9S
        utlPLXKcc0F3XvY+50MiQ5M11CV+dEEli7iR/M5P+g==
X-Google-Smtp-Source: APXvYqwjRF8a99iUluCFFe+DjE80oak9svxYnq42f+Yw74Cq7sqW1SVYbnVAS0cHrDmZBYUEGkazDlwCG7/YSNLiOY8=
X-Received: by 2002:a6b:6303:: with SMTP id p3mr5303269iog.169.1567615888614;
 Wed, 04 Sep 2019 09:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
 <20190820001805.241928-4-matthewgarrett@google.com> <3440.1567182506@warthog.procyon.org.uk>
In-Reply-To: <3440.1567182506@warthog.procyon.org.uk>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 4 Sep 2019 09:51:16 -0700
Message-ID: <CACdnJuvR7mqhpzEQZdgw9EE_PsM-QWQ_JmwFLcoeLbAuKCHnOA@mail.gmail.com>
Subject: Re: [PATCH V40 03/29] security: Add a static lockdown policy LSM
To:     David Howells <dhowells@redhat.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 9:28 AM David Howells <dhowells@redhat.com> wrote:
>
> Matthew Garrett <matthewgarrett@google.com> wrote:
>
> > +static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>
> const char *const maybe?

Seems reasonable.

> > +static enum lockdown_reason lockdown_levels[] = {LOCKDOWN_NONE,
> > +                                              LOCKDOWN_INTEGRITY_MAX,
> > +                                              LOCKDOWN_CONFIDENTIALITY_MAX};
> > +
>
> const?
>
> Isn't this also a 1:1 mapping?

Sorry, a 1:1 mapping to what?

> > +static int lock_kernel_down(const char *where, enum lockdown_reason level)
>
> Is the last parameter the reason or the level?  You're mixing the terms.

Fair.
