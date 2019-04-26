Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C255EC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F28E208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556296584;
	bh=j5VmV0LTqlo0cJ5wg0tlMwL1js3aQ2hrIi+wcItV89Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ps+KXKupqXpJSJ+jqeEj/Kcs+6BTHbBIXQRc1bIguMyOxOxTWm3OD6mkFvbhqA3j2
	 hNmXCg0soypiPH1BjLm1yyNVG+FzLPfTSH4rqtZTGXYN0N45PRH20tvCIebnoIrA1n
	 jviFs/EZl8WTjR9pcIu0B9KjVEVEhclW78F9clPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfDZQgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:36:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37732 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfDZQgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:36:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id b12so2310172lji.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 09:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DEdb/dXXS4BmabuVj7tMWOPVyS6P8uPlgXYLftrG0EE=;
        b=h75dC+nGCj4qVfVP3NHHhRACGt5wq2lEMV1zHeI3Kn4urKTnUOrgSoQytgde9qbpVM
         GiVmB9UUGvPuXqMHWTcMf1b+bF9oQArQw9zod389zdpwyU1eUVhD4roCfLsmJb6m6f36
         V9ftvlpDloxCg9bY8bUbqmhGa1yeP8oFSSIzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DEdb/dXXS4BmabuVj7tMWOPVyS6P8uPlgXYLftrG0EE=;
        b=CCsHPzO8gSZ4k0r8hfUD9sbj7gR3CC3ZoBZOGXt3F90IEi3mj9GlOp15JcDvl35ZLO
         JQIKiylhKIvckYksZScA8peUuhTvYV3TFd/YWgyLZizhsZ2DzRsZtz5TN+Ab49j73aM5
         fPSGEvA07itvZgbIN7qTfc8bSCXVfgXWpckaJwsF65NfBI9I32XwIZGGNqgkPdpLvuu8
         xeC+xJ3/x01I71664q7u7vqSiCck2ktoq+tu7vMK1nYlKZS4LPb9bkBU0LcGx3mae6A8
         3yfZJFBSEek63tHaKWf53HccaCP++bHzSGSwG82Xj15EHq+OQkNX0NgqDlyxew+bMRCE
         r0NQ==
X-Gm-Message-State: APjAAAWaXJvxVsdxkqCOurw7eb9H4hdixU/TwRIFpcjtJ2zw263kIj8M
        fG6C6co6QumUc/g5jAhjQsYCmQm4qd8=
X-Google-Smtp-Source: APXvYqwBxkx4UTN1GqiB2bvT7XxUfhEeWbSVEPa8ZgmO8NE/o5kpi1C9JkOHcyLp5hJiC9mdv041jw==
X-Received: by 2002:a2e:7a09:: with SMTP id v9mr24209284ljc.167.1556296578355;
        Fri, 26 Apr 2019 09:36:18 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id p11sm2862203lfh.27.2019.04.26.09.36.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 09:36:17 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id q10so3487707ljc.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 09:36:17 -0700 (PDT)
X-Received: by 2002:a2e:960b:: with SMTP id v11mr24952343ljh.135.1556296576721;
 Fri, 26 Apr 2019 09:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190425174739.27604-1-idryomov@gmail.com> <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
 <342ef35feb1110197108068d10e518742823a210.camel@kernel.org>
 <20190425200941.GW2217@ZenIV.linux.org.uk> <86674e79e9f24e81feda75bc3c0dd4215604ffa5.camel@kernel.org>
In-Reply-To: <86674e79e9f24e81feda75bc3c0dd4215604ffa5.camel@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Apr 2019 09:36:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiaZoELovfo4gkfxB0zi6k5pQJNkmSRsEoWYr_z-oupiQ@mail.gmail.com>
Message-ID: <CAHk-=wiaZoELovfo4gkfxB0zi6k5pQJNkmSRsEoWYr_z-oupiQ@mail.gmail.com>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 9:25 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> Is it really ok to union the count and rcu_head there?

It should be fine, because the rcu_count should only ever be used once
the count has gone to zero and the name cannot be found any more.

And while RCU path walking may find and use the *name* after the
dentry has been killed off (but not free'd yet), all the actual
external_name() accesses should be serialized by the dentry lock, so
there's no access to those fields once the dentry is dead.

At least that's how it's supposed to work. Al would be the final
arbiter on this.

             Linus
