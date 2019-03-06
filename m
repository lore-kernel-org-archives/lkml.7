Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2850C10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C364D20657
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="ILCMLu3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfCFUqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:46:15 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41867 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfCFUqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:46:15 -0500
Received: by mail-yw1-f68.google.com with SMTP id q128so11254200ywg.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 12:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FlQ1pcWvvsqF6RZpvT/LXNlOVdVPkEXR+sAsFDFnBdk=;
        b=ILCMLu3JjB9VIVpWIcPdYd6U9fh2ZWn+UiYwnKJSwWj21lYl73riyTeID0655yx1Pr
         LQSR+PAIW6lNfgA5pq1+0WYZqKKKp7v0XodaAkeasA8N3LZl8XxEMJtsv6157Ju6G/eJ
         NnqZr41k7rDB9rXlnxjdLDWHQQzqcfQDIyq3N+YfBUvtkd9W0NnT8ICp872sNjeMU3pX
         X5kl9jlBAGf16F4JrvQO2Ff8emkb36F/Ndsmmwqe7PDQfOayPAqCnmCt6p11IX2hji4O
         1v8FkVPO3y2jDkD+q44sQ6HQpMvnysfRvWHqr1qXcGwZmgkhhll4fHAKscwyMK6ptwF9
         M2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FlQ1pcWvvsqF6RZpvT/LXNlOVdVPkEXR+sAsFDFnBdk=;
        b=R+nvWx7N+g4p2gptrnlz484szgdy7zysknCRPQADAu8f17RE6kqJk8z6EDlx9Qr6+U
         qFqn4vy23wE1QnYQ47cHErKeFlqmWEB6mdOQGJ3XZvcOw9b/AMuOvaxsH0Qyb9YtR9Ke
         FRsRvYHNpM72ROT6NBhgOKNWwS4YaM6PSQpYcE7Z9yS87jWkEntsk+X240cWKjEXMZI8
         zORoXIVmF6qRbVTUh2MeToKIHBAW7fJr7KDQmdliU4AJ1zcy+WmzwPXzUZDoJvLUZ+lA
         yKda3dNe4x0GJWbypbQa3823ygEeWMiOtbR0dCD1KoMHQK/EpnU9diVL0Ju9nIBd9SuW
         gR2g==
X-Gm-Message-State: APjAAAWFiw1Imzb9zvciVRZXnT2tKp04F6yFxtDBcE/HJJkRkiz/UTDP
        Wc/PcrSDsWN+pEp93G/zPtPflg==
X-Google-Smtp-Source: APXvYqy3+RH5AZ/9D9pGBv8HyhmXitQxIDq2Au/fojdxR7pHCbuj8dko/wPbgkXpCKQ/bdE7GSueHA==
X-Received: by 2002:a25:7582:: with SMTP id q124mr8702778ybc.136.1551905174094;
        Wed, 06 Mar 2019 12:46:14 -0800 (PST)
Received: from cisco ([2601:282:901:dd7b:316c:2a55:1ab5:9f1c])
        by smtp.gmail.com with ESMTPSA id v198sm877150ywv.24.2019.03.06.12.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 12:46:13 -0800 (PST)
Date:   Wed, 6 Mar 2019 13:46:11 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christian Brauner <christian.brauner@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/2] seccomp: disallow NEW_LISTENER and TSYNC flags
Message-ID: <20190306204611.GH7413@cisco>
References: <20190306201413.14153-1-tycho@tycho.ws>
 <20190306201413.14153-2-tycho@tycho.ws>
 <20190306203932.im7lkblvmd227td3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306203932.im7lkblvmd227td3@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 09:39:35PM +0100, Christian Brauner wrote:
> > +
> >  	/* Prepare the new filter before holding any locks. */
> >  	prepared = seccomp_prepare_user_filter(filter);
> >  	if (IS_ERR(prepared))
> > @@ -1302,7 +1315,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
> >  		mutex_unlock(&current->signal->cred_guard_mutex);
> >  out_put_fd:
> >  	if (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER) {
> > -		if (ret < 0) {
> > +		if (ret) {
> 
> Why that change but keep checking if (ret < 0) further up?

Not sure what you mean here. The only other place I see that we check
something is < 0 in that function is the return value of
get_unused_fd_flags(), which looks right to me?

Tycho
