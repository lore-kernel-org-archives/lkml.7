Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1ACC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8265520684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfCFVCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:02:39 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54085 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfCFVCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:02:38 -0500
Received: from mail-vk1-f197.google.com ([209.85.221.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <christian.brauner@canonical.com>)
        id 1h1dgT-0005Vh-Ca
        for linux-kernel@vger.kernel.org; Wed, 06 Mar 2019 21:02:37 +0000
Received: by mail-vk1-f197.google.com with SMTP id b202so7234688vke.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 13:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0QcrydL38OtMb0fF0uJyFZ8CpCYGXfoKCV1KajAUXE=;
        b=hMt6GOOkMV2P+Urn6uVcFNK91wxKyIIqIpEWzIVBXj2bMrxlvjOBfDESN450UJou3a
         pKaOxy8WW1cYNGqm/pz2pY5ztWmxNhym2zIhg1XCkvHLXCmVjTBhXNxAoUyZ3ed/4Gds
         4FdinOOOYg/fgYZdHrajo0PLcoBBUtwfnsMJPZBOmrGmd4n4AmZFj6DC8xb2fc9oZ9SS
         PhVahJGtRFJHINeILabFjcVLJxvzKuUZbPMVzlTSPOxp1+ig4N76qlE88sQKkYhl7k/k
         yDO6pY+mVauaMH40LGBQfumUyvM7jCHwIaD5RlwDnN9a9h3JLkxnUQo6t0qBotZd3X2A
         4eaA==
X-Gm-Message-State: APjAAAUtu4OwNJTJfKSHRs0qGIkGt9g3iUU9E5MHNgii9nqrF0lCZsHL
        k1z+gUSVrN9chULzIPtEhI0lYvg9sWd94kFpKMs+yh5Ruqye7zPp0WZ8HbubHcHQBVUbTq0mt1A
        ZlY0AXdF2V5baQklMBrTR6wF1u1kYfSbwwIWrDPip2xmAbehI8zeDoE72fg==
X-Received: by 2002:a1f:91c4:: with SMTP id t187mr4346052vkd.86.1551906156116;
        Wed, 06 Mar 2019 13:02:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqwc8zN5IHj2qVA/wtkpVvFmkKwpJ4Yj2WQmR6NB51l4DuOCqBSASQPlvqQOy0n3fki7OGkIA/jmGbCo0ikBWCc=
X-Received: by 2002:a1f:91c4:: with SMTP id t187mr4346036vkd.86.1551906155768;
 Wed, 06 Mar 2019 13:02:35 -0800 (PST)
MIME-Version: 1.0
References: <20190306201413.14153-1-tycho@tycho.ws> <20190306201413.14153-2-tycho@tycho.ws>
 <20190306203932.im7lkblvmd227td3@gmail.com> <20190306204611.GH7413@cisco>
In-Reply-To: <20190306204611.GH7413@cisco>
From:   Christian Brauner <christian.brauner@canonical.com>
Date:   Wed, 6 Mar 2019 22:02:25 +0100
Message-ID: <CAPP7u0Wp6q=LwtnbNk3YNaKKHXAfDqXd0Dx6xXXesvKpR-p+Gg@mail.gmail.com>
Subject: Re: [PATCH 2/2] seccomp: disallow NEW_LISTENER and TSYNC flags
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 9:46 PM Tycho Andersen <tycho@tycho.ws> wrote:
>
> On Wed, Mar 06, 2019 at 09:39:35PM +0100, Christian Brauner wrote:
> > > +
> > >     /* Prepare the new filter before holding any locks. */
> > >     prepared = seccomp_prepare_user_filter(filter);
> > >     if (IS_ERR(prepared))
> > > @@ -1302,7 +1315,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
> > >             mutex_unlock(&current->signal->cred_guard_mutex);
> > >  out_put_fd:
> > >     if (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER) {
> > > -           if (ret < 0) {
> > > +           if (ret) {
> >
> > Why that change but keep checking if (ret < 0) further up?
>
> Not sure what you mean here. The only other place I see that we check
> something is < 0 in that function is the return value of
> get_unused_fd_flags(), which looks right to me?

The change just seemed it had nothing to do with the rest of the patch.
Just making sure this didn't happen on accident and would cause regressions.
