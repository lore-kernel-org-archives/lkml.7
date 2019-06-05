Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613BEC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 04:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B47620866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 04:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559708379;
	bh=zYVkKrsRGGhh3G+M1LBBD0g0Wbld0arg59wAbduMlSI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wxVyvY847m3oZ2PF7SZxLUGUUd528lmJI8UWcB7TMxZhQV8HMG3iJO6EaLxAH7/r2
	 4gaHnq/FISoW61gmuN3x8AYjsLjw9aLKRWVQRuI1VBJZ2nisIuUUjoBsa6L6q9Ptt9
	 xZEy9hxvgIIKpOUZellieneAacXoHScwusxPtZT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfFEETi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 00:19:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfFEETh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 00:19:37 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DC31208CB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2019 04:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559708375;
        bh=zYVkKrsRGGhh3G+M1LBBD0g0Wbld0arg59wAbduMlSI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sqzIG8Ac/XGYwFOfFcnp+f8yyXegkUSWId9BnKAMFZAt+5ifXzeDjZCSTMrbE48EM
         l1MfmMq8ZwokbIQ02JYIzRI8pu8vI+dvJt76E+8mks8/Xz1cuxbtSMuyhCX7V0hI3z
         QZ+D66fxWRfYtklKRWiFZCpRFlOj0H6is+zp/G+w=
Received: by mail-wr1-f43.google.com with SMTP id n4so14911258wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 21:19:35 -0700 (PDT)
X-Gm-Message-State: APjAAAVuU6OJg2wZR1kbCoi1oISnkfdyxkw+XpRFhBql2fezaMs2Zu8C
        qpGrN+xgx6DUB4XSWIjFizq+sYZGpBnDYg0Aw1JGUw==
X-Google-Smtp-Source: APXvYqxhostrhJhIh52FwT41X8mcaPiXaiVmU0xdROFHfMrObNl3EFLG2cUYEeao/vkACRfu24yUXMuO0ctVPr4FAvw=
X-Received: by 2002:a5d:610e:: with SMTP id v14mr23672717wrt.343.1559708373961;
 Tue, 04 Jun 2019 21:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <155966609977.17449.5624614375035334363.stgit@warthog.procyon.org.uk>
 <CALCETrWzDR=Ap8NQ5-YrVhXCEBgr+hwpjw9fBn0m2NkZzZ7XLQ@mail.gmail.com>
 <1207.1559680778@warthog.procyon.org.uk> <CALCETrXmjpSvVj_GROhgouNtbzLm5U9B4b364wycMaqApqDVNA@mail.gmail.com>
 <CAB9W1A0AgMYOwGx9c-TmAt=1O6Bjsr2P3Nhd=2+QV39dgw0CrA@mail.gmail.com>
In-Reply-To: <CAB9W1A0AgMYOwGx9c-TmAt=1O6Bjsr2P3Nhd=2+QV39dgw0CrA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 4 Jun 2019 21:19:22 -0700
X-Gmail-Original-Message-ID: <CALCETrU_5djawkwW-GRyHZXHwOUjaei1Cp7NEJaVFDm_bK6G3w@mail.gmail.com>
Message-ID: <CALCETrU_5djawkwW-GRyHZXHwOUjaei1Cp7NEJaVFDm_bK6G3w@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/8] Mount, FS, Block and Keyrings notifications [ver #2]
To:     Stephen Smalley <stephen.smalley@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 6:18 PM Stephen Smalley
<stephen.smalley@gmail.com> wrote:
>
> On Tue, Jun 4, 2019 at 4:58 PM Andy Lutomirski <luto@kernel.org> wrote:
>>
>> On Tue, Jun 4, 2019 at 1:39 PM David Howells <dhowells@redhat.com> wrote=
:
>> >
>> > Andy Lutomirski <luto@kernel.org> wrote:
>> >
>> > > > Here's a set of patches to add a general variable-length notificat=
ion queue
>> > > > concept and to add sources of events for:
>> > >
>> > > I asked before and didn't see a response, so I'll ask again.  Why ar=
e you
>> > > paying any attention at all to the creds that generate an event?
>> >
>> > Casey responded to you.  It's one of his requirements.
>> >
>>
>> It being a "requirement" doesn't make it okay.
>>
>> > However, the LSMs (or at least SELinux) ignore f_cred and use current_=
cred()
>> > when checking permissions.  See selinux_revalidate_file_permission() f=
or
>> > example - it uses current_cred() not file->f_cred to re-evaluate the p=
erms,
>> > and the fd might be shared between a number of processes with differen=
t creds.
>>
>> That's a bug.  It's arguably a rather severe bug.  If I ever get
>> around to writing the patch I keep thinking of that will warn if we
>> use creds from invalid contexts, it will warn.
>
>
> No, not a bug.  Working as designed. Initial validation on open, but reva=
lidation upon read/write if something has changed since open (process SID d=
iffers from opener, inode SID has changed, policy has changed). Current sub=
ject SID should be used for the revalidation. It's a MAC vs DAC difference.
>

Can you explain how the design is valid, then?  Consider nasty cases like t=
his:

$ sudo -u lotsofgarbage 2>/dev/whatever

It is certainly the case that drivers, fs code, and other core code
MUST NOT look at current_cred() in the context of syscalls like
open().  Jann, I, and others have found quite a few rootable bugs of
this sort.  What makes MAC special here?

I would believe there are cases where auditing write() callers makes
some sense, but anyone reading those logs needs to understand that the
creds are dubious at best.
