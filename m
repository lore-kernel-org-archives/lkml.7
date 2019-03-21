Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC115C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965BA218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Ih26zWHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfCUBD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:03:59 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37150 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfCUBD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:03:59 -0400
Received: by mail-lf1-f67.google.com with SMTP id u2so3349230lfd.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 18:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XByYNqTBSkGfbQQdJYJCEEyn3to82S+c0NeJ7pJZ2MQ=;
        b=Ih26zWHNYKJeM5AKfUF9Pnmlj+YtIKVyPV1Y+buVHkeDP8rX14kLp7jr2PEVNERH2Z
         Y+UrezSPPKs7bmyookHqG9aL2AADcYWv33Lr1YwxAt7IzybGdXKbHsDrpP927eRdUyJU
         80NT8/7R92tVhqI1q5LTfpqIXxeWXnJHfF6i6NmupdQAy6A5ziAkTPwKM+axR/BSwNdv
         1naJx3RcZvCLS+OB5MTQvQnBizRxWex5agG1LEGtsG7qkXwrRpckX9D66KnrByfkB40A
         emlAq9+0eLo1NgH8HWhOzjQEhbrK0UOvDfCdiQwfDYMV5RCShIJS4//loy+rNiTMSooU
         N9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XByYNqTBSkGfbQQdJYJCEEyn3to82S+c0NeJ7pJZ2MQ=;
        b=oiw1Dlph3eO046LrnA6ZlPsThFB8i8zgYaM9R5foFMZ78y251Q+jZlMHMAtga72/DO
         YRTx1juebCh/AB+/U9MAzt5zbh7tE+i0fEGaNrWrlK/PYrMswEfq2fv132dJIVOB41GU
         B21Y30vTweOBJjqSWVU1TsUE34FFL9rwURfBhmkCxuaNGEJ5CefvDjaPC6OJ2+eJzZp9
         xMI0bagqxpDdRqmgcRFUJV6j67aN6euP6ROXgte4TOSGIvcZFrjPBYCJBQSlECqLiqCL
         2SbbQzmetaaX4BXgCOprcnJB/d4zZX6Yn2qP0lkp69RBKCpdYWQ6tLowUr2CVtPKWelt
         p1Cw==
X-Gm-Message-State: APjAAAWED9YNJt9M+eqj1MXYEt99ZeMTD1Qj/aEi7EIguieCsrvxfE1C
        0kTOwUm0lDOQtn3NxIC6wh67Q4sKXLh915Qttgd0
X-Google-Smtp-Source: APXvYqxET7lW0kqOOmQatOQMqnKI+Cvaf0nlfQyIC/3ov2wK1XTBYhQKU5IVCvQWGJQJJWJf+CVSCVkEVKWQ023Hjts=
X-Received: by 2002:ac2:42da:: with SMTP id n26mr321163lfl.91.1553130236833;
 Wed, 20 Mar 2019 18:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <81d0122d14c4fbb3a2ad33d25fdf2dd001c7dcc7.1552737854.git.rgb@redhat.com>
 <CAHC9VhS61LTQMXiALRre+5_+wvwe6Wa9RN-WYNTjvz5LVsA5rw@mail.gmail.com> <20190321005008.wfz3bk7q262km5fz@madcap2.tricolour.ca>
In-Reply-To: <20190321005008.wfz3bk7q262km5fz@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 20 Mar 2019 21:03:45 -0400
Message-ID: <CAHC9VhTPBF=8PNr4800yTWedrxxO91n8AQ8xmkBiNMK+cxGNGg@mail.gmail.com>
Subject: Re: [PATCH ghak109 V1] audit: link integrity evm_write_xattrs record
 to syscall event
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, sgrubb@redhat.com,
        omosnace@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, zohar@linux.ibm.com,
        mjg59@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 8:50 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2019-03-20 19:48, Paul Moore wrote:
> > On Sat, Mar 16, 2019 at 8:10 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > In commit fa516b66a1bf ("EVM: Allow runtime modification of the set of
> > > verified xattrs"), the call to audit_log_start() is missing a context to
> > > link it to an audit event. Since this event is in user context, add
> > > the process' syscall context to the record.
> > >
> > > In addition, the orphaned keyword "locked" appears in the record.
> > > Normalize this by changing it to "xattr=(locked)".
> > >
> > > Please see the github issue
> > > https://github.com/linux-audit/audit-kernel/issues/109
> > >
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > >  security/integrity/evm/evm_secfs.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)

...

> > > @@ -222,7 +223,7 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
> > >                 inode_lock(inode);
> > >                 err = simple_setattr(evm_xattrs, &newattrs);
> > >                 inode_unlock(inode);
> > > -               audit_log_format(ab, "locked");
> > > +               audit_log_format(ab, "xattr=(locked)");
> >
> > Two things come to mind:
> >
> > * While we can clearly trust the string above, should we be logging
> > the xattr field value as an untrusted string so it is consistent with
> > how we record other xattr names?
>
> That would be a question for Steve.

Yep, that's who I wanted to hear from, it's not really something I
expected you to answer Richard.  I vaguely remember something about
Steve's audit libs being able to handle both trusted and untrusted
value strings for a given field, but I could have confused "able to
handle" with "don't care".

-- 
paul moore
www.paul-moore.com
