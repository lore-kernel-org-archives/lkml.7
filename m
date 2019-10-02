Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E77C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB172070B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jlO+NBPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbfJBUxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 16:53:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44309 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfJBUxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 16:53:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id i14so272336pgt.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 13:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Teht8krjV9I4yoAGotugiVYKYlwLiVfKSfSqCO8cNf4=;
        b=jlO+NBPyz5tQDZY3RDxFnyu8Rcjfnq1ndJUH+zU/dejpBmvQ1oYCQL37A62CESeFsA
         OLZXA9IM92ZVhJl/Gdz8aaqfWhniBPVbkgjzL2OhtNuvL8I/qJuWcdMUg6t7T1J7kQ7X
         VED/vH0i8d/iEIoMjDbmzKYBysNutlFszdEVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Teht8krjV9I4yoAGotugiVYKYlwLiVfKSfSqCO8cNf4=;
        b=Hre1lcMeEET3XTJe0moT2SbTb9R6FG/PUUV8PUHh6gwCyAiAFq++G1K8uXGE5H0glx
         rfcnMHP0wqomLMhtWhTO1Z624y2tP89fbQInIH3vVWyazZG4JD8AVOxwSNDZ62jhRdi1
         9CAcqvlEG+obdVibSecHYkjQf39ZPmL51HB0HoWyLr9eYCwfKSYnXezyU7kvdxbFkuyx
         9tmK+UVD48FBRPxFTwcQJM9GVEa54P1Rr0HXavMXrlN4Vhj/JKf2MEAXOP7TAfLZJxK5
         roxp15lxO8a/idIwKfm/nXBhdWkwOA66bEohxWEMHey0WI9YKJ7Ml3nRL3mpKV/Fszgu
         83ug==
X-Gm-Message-State: APjAAAURduHGESDxRYfkpOFid3dwySZmL1rfpjZqqQnoKwDghHbTCO35
        WPe0fRqUzqc/tmUDK9yLRWb+ewuEJ54=
X-Google-Smtp-Source: APXvYqz56NGqvNvM7wNZehM8lOTKZaqznv7OGeNO25LGl5UqtgpsSqdJxQLNnpGeTB2FDnioEMMVzA==
X-Received: by 2002:a63:5356:: with SMTP id t22mr5429101pgl.400.1570049582624;
        Wed, 02 Oct 2019 13:53:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j24sm340646pff.71.2019.10.02.13.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 13:53:01 -0700 (PDT)
Date:   Wed, 2 Oct 2019 13:53:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        pankaj.laxminarayan.bharadiya@intel.com, joe@perches.com,
        adobriyan@gmail.com, netdev@vger.kernel.org,
        David Miller <davem@davemloft.net>
Subject: Re: renaming FIELD_SIZEOF to sizeof_member
Message-ID: <201910021349.9B19DCFD6@keescook>
References: <CAHk-=wg8+eNK+SK1Ekqm0qNQHVM6e6YOdZx3yhsX6Ajo3gEupg@mail.gmail.com>
 <201909261347.3F04AFA0@keescook>
 <201910021115.9888E9B@keescook>
 <20191002.132121.402975401040540710.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002.132121.402975401040540710.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 01:21:21PM -0700, David Miller wrote:
> From: Kees Cook <keescook@chromium.org>
> Date: Wed, 2 Oct 2019 11:19:16 -0700
> 
> > On Thu, Sep 26, 2019 at 01:56:55PM -0700, Kees Cook wrote:
> >> On Thu, Sep 26, 2019 at 01:06:01PM -0700, Linus Torvalds wrote:
> >> >  (a) why didn't this use the already existing and well-named macro
> >> > that nobody really had issues with?
> >> 
> >> That was suggested, but other folks wanted the more accurate "member"
> >> instead of "field" since a treewide change was happening anyway:
> >> https://www.openwall.com/lists/kernel-hardening/2019/07/02/2
> >> 
> >> At the end of the day, I really don't care -- I just want to have _one_
> >> macro. :)
> >> 
> >> >  (b) I see no sign of the networking people having been asked about
> >> > their preferences.
> >> 
> >> Yeah, that's entirely true. Totally my mistake; it seemed like a trivial
> >> enough change that I didn't want to bother too many people. But let's
> >> fix that now... Dave, do you have any concerns about this change of
> >> FIELD_SIZEOF() to sizeof_member() (or if it prevails, sizeof_field())?
> > 
> > David, can you weight in on this? Are you okay with a mass renaming of
> > FIELD_SIZEOF() to sizeof_member(), as the largest user of the old macro
> > is in networking?
> 
> I have no objection to moving to sizeof_member().

Great; thank you!

Linus, are you still open to taking this series with Dave's buy-in? I'd
really hate to break it up since it's such a mechanical treewide
change. I'm also happy to wait until the next -rc1 window; whatever you
think is best here.

Thanks!

-- 
Kees Cook
