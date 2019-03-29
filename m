Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2866C10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9040F2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="m8WFbdHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbfC2Nda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:33:30 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36176 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729626AbfC2Nd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:33:29 -0400
Received: by mail-lf1-f68.google.com with SMTP id d18so1469343lfn.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 06:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ICLxlDvgOXE4niicJPsCQr3ooMrxPK2Z74nUDjEIeY=;
        b=m8WFbdHW28fcxm+5UfO0FtHXYBbM/Xbf4LSBwq4Xcilq5HeIE+uyjuAxfwY7alyWc5
         +Y3RVxG6cXDj9PTz+xaVlvzN6gfdkrSS/BNXI2mCMdJrS+uyJnxhM9SH11yhd83Ge9gf
         i7bwwEjGZ4y960idznfMTm+PcrenqdPObT99v5DctG8EUZ9igOSMvUrFz4rva93t2rvM
         8NU05flTEmOjrl0gkxu1nfcfzc5rzRsaIvZhwK3dlOzv3w53IdczjLtNuUmoVi34HqKb
         rCs9x0MCi49GGs4oBekAlY/6SsOt3BeEBfh4NghOAV0fHptR5tdcmn+BUZOYfRb/4eH9
         o1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ICLxlDvgOXE4niicJPsCQr3ooMrxPK2Z74nUDjEIeY=;
        b=XT5V7yuyGXz4eUaHXaMXc/pDy9YUdbXgbK7n0VwmuEutx75Mj8ww7t/WoaMUeNlYsO
         xfm3Yr/66gfz6NzQg1nLLLsTRvizklo8kxn7fhWEPn9WCBGePpwPO4IBNiL0/RmepLLe
         IEhu90M6OEgQS9R/9kbmAZqjJab8iG2Wa8XCA41WdbXEW8/ij2+0QiE8PFVwCBFt0Up6
         98jWRCiZH0bW920t+jReaJeid/9iMMLlcNh1E+LTfZfP5w1UJ0jj5Ht/r74kt8C8l9oP
         c4SrUs701+Hy9BuDZHcG0d3L+0AgnaLILIyDmcOuT0IAl2yHKQxohtWR+wKzMdTtMQBm
         iZ4A==
X-Gm-Message-State: APjAAAWgIY9iU2qQVOk6pdvMLZVGq2QP8z9a9SplTPh2kvVSUuBEHon7
        bGTO1jKpNAnYh4ct167K7fDxuIEKqBmzDR4YFLFPnw0=
X-Google-Smtp-Source: APXvYqxB583nnq5Y6ayoEtszTyM3UbDnC7mctZFHKlYt8qwRK7NU7UgIvKzooU8U2PWU3IpBtazZEsyYBCkCFNV2bww=
X-Received: by 2002:a19:c784:: with SMTP id x126mr7423601lff.91.1553866407256;
 Fri, 29 Mar 2019 06:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190325232125.1781-1-casey@schaufler-ca.com> <CAHC9VhRJUxnEyFvJQ3PR+aQTnGt=GZ+EZ-oBQihEE9WgQ9n5EA@mail.gmail.com>
In-Reply-To: <CAHC9VhRJUxnEyFvJQ3PR+aQTnGt=GZ+EZ-oBQihEE9WgQ9n5EA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 29 Mar 2019 09:33:16 -0400
Message-ID: <CAHC9VhReNxpWNg6WfCShRijO+AWC9TR8dzCP8COwz_Qe0xr4wA@mail.gmail.com>
Subject: Re: [PATCH] Bad file pattern in 'SELINUX SECURITY MODULE'
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     joe@perches.com, linux-kernel@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 7:52 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Mar 25, 2019 at 7:21 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > The include/linux/selinux.h file has been removed.
> > Remove the entry from the MAINTAINERS file.
> >
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > ---
> >  MAINTAINERS | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3e5a5d263f29..1039c34dff3c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13947,7 +13947,6 @@ W:      https://selinuxproject.org
> >  W:     https://github.com/SELinuxProject
> >  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
> >  S:     Supported
> > -F:     include/linux/selinux*
>
> This is fine with me, but if we're updating this file, we should
> probably add the following:
>
> F: include/uapi/linux/selinux_netlink.h

Are you going to update this Casey or should I?

> >  F:     security/selinux/
> >  F:     scripts/selinux/
> >  F:     Documentation/admin-guide/LSM/SELinux.rst

-- 
paul moore
www.paul-moore.com
