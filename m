Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D44C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD41521872
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XGXmNN3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfKLXTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 18:19:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36768 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfKLXTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 18:19:02 -0500
Received: by mail-pf1-f196.google.com with SMTP id b19so199768pfd.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 15:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6YV9sWAtldt7QV9Z/E9MQlXJpOYClepPj0qjQfRgXwA=;
        b=XGXmNN3ZtFcSV8anGunyLg32IAPhkzgurDq12Of06HDlvW+4TU61212ZPbAEkps7J6
         7Qa9r1bNn2sil0rw9KEflTbVHGutMm6nju0oQKdhZ8cmhPwwbf3vMV6roozAimYwRasg
         CIYlbuKg0UiKlJiwToV1Ma+VBoqXB0UZf4iCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6YV9sWAtldt7QV9Z/E9MQlXJpOYClepPj0qjQfRgXwA=;
        b=jIKIspk3La7XPTYLPlwgi5zOzumWgRbU0vS1ENo+NUchQ46vc3pET2CZOf25yDA+81
         3rFOCfPiFjKGmlOMo2Y9SBs/zEDkycplOiLTc8ghLb6TCFotzNBa3yemmWC8Kcnchxxx
         IaeUIoyqsoy7iX3/XliAU+gZgVtQ6ybyvkT5oZwlUVrxyHf/O7JR8sovYLYfKGeUB7sl
         DDJ0EHP+dn30djYJ/6NzHtXiR68bO1IMFpyJG22et81hbmO9UNbyb2b3MDPoxFIrL4W6
         2xkBRUqcCESygV/bc9TqbDHaviPA1oH+QfOY/mqiM6Z7KPlyllcpnnYbFaBeaMnb35Qk
         EWyA==
X-Gm-Message-State: APjAAAWu6pw8l4t1N4GIVBMmNDJKGTqz8Dj2VZXbS0OEG51+hLMkQzTp
        gLBPQORqIvrACTQnj2k09ktJ1g==
X-Google-Smtp-Source: APXvYqzQdx6tFm8+bFhI0MhOEBcFZb7HQJUVAkbjAwYjSIls6XpKRirm8QaRzCKijyu2DFLv8vtyGg==
X-Received: by 2002:a63:f441:: with SMTP id p1mr78629pgk.362.1573600742209;
        Tue, 12 Nov 2019 15:19:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x192sm42848pfd.96.2019.11.12.15.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:19:01 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:19:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Allow restricting permissions in /proc/sys
Message-ID: <201911121517.DC317D5D@keescook>
References: <74a91362-247c-c749-5200-7bdce704ed9e@gmail.com>
 <87d0e8g5f4.fsf@x220.int.ebiederm.org>
 <f272bdd3-526d-6737-c906-143d5e5fc478@gmail.com>
 <87h83jejei.fsf@x220.int.ebiederm.org>
 <eb2da7e4-23ff-597a-08e1-e0555d490f6f@gmail.com>
 <87tv7jciq3.fsf@x220.int.ebiederm.org>
 <1b0f94ef-ab1c-cb79-dd52-954cf0438af1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b0f94ef-ab1c-cb79-dd52-954cf0438af1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 09:35:46AM +0200, Topi Miettinen wrote:
> On 5.11.2019 1.41, Eric W. Biederman wrote:
> > My sense is that if there is any kind of compelling reason to make
> > world-readable values not world-readable, and it doesn't break anything
> > (except malicious applications) than a kernel patch is probably the way
> > to go.
> 
> With kernel patch, do you propose to change individual sysctls to not
> world-readable? That surely would help everybody instead of just those who
> care enough to change /proc/sys permissions. I guess it would also be more
> effort by an order of magnitude or two to convince each owner of a sysctl to
> accept the change.

I would think of this as a two-stage process: provide a mechanism to
tighten permissions arbitrarily so that it is easier to gather evidence
about which could have their default changed in the future.

> These code paths have not changed much or at all since the initial version
> in 2007, so I suppose the maintenance burden has not been overwhelming.
> 
> By the way, /proc/sys still allows changing the {a,c,m}time. I think those
> are not backed anywhere, so they probably suffer from same caching problems
> as my first version of the patch.

Is a v2 of this patch needed? It wasn't clear to me if the inode modes
were incorrectly cached...?

-- 
Kees Cook
