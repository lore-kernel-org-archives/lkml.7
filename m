Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB34BC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86122166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ntope72j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437357AbfHISF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 14:05:56 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46157 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436767AbfHISF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 14:05:56 -0400
Received: by mail-ot1-f65.google.com with SMTP id z17so17471917otk.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 11:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aXqwFbZXLc0jc6LmbghFnYdfUqr8zle8MxM4PnoEM74=;
        b=Ntope72jwTxtu3Yysu6SNp8tcmL3H+NFI7czF31eOSqr4bal2SL/RrlLvEAayx2Ppj
         Es40PbT9e5+Zgr+Ba1AEytbNAAULO/iK0f1/uJN4haBod2IZjQguq4yHjlQTCQIKReRt
         /lN9A/E3wWfGY6skJCuhbuMvEaHxMHxL9OARpTq4DI8pSoAqPrAAhABRLIBmAX/sUgxv
         0nh3pdV5vI1ptGadMwRdWf27a8ufQdcJ2pMvk7HDwgizlapWvxb8XnU8zYSZQj8ePcuw
         nX0f6it3SQzuzRohHkPFgUjaNJ9ZNvw8PnZj8l9JeRYW+eqQItb5r/MzXgt4Dn7z9X3C
         fZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aXqwFbZXLc0jc6LmbghFnYdfUqr8zle8MxM4PnoEM74=;
        b=Qxk8mo1IV1smLMhvoHul6Na6dATL7t5QHGsw7nur9/JWkwoRG5n7KQrxfznrtJXmIO
         KBaPc6whGrOzamqKHSY6cOfqY2TYg5P5P1ZwafOd+pl+L4m5DHdM7Gev56q54WGLWmfB
         KdOvErSs7j6TMhSroEQ49eM7tjibo1azMHdSnd638VAC1NvGTpTo70qTnf3r/2fC3lKp
         SAhLC2MesX1rUvxlgTHNeeAeumOJQFVsgJks/W+573tJ/OU5Ap7TI1pjUNZnoZ41kiET
         qii5xMebx3n34+tXSJTQYxUcbdpI9iW52mAlYWI4lyK1laSvbPZ4cvuhgZ8xepuCbXeE
         9ZSA==
X-Gm-Message-State: APjAAAVNIVTLEdl/CwvEfMewsRWxEx9JWtFVVz5nWszkz2gySHPQiwYq
        5rvALZSKxUSDAxUKGv5WJ1X3DqdF35dH8mGfpewkaQ==
X-Google-Smtp-Source: APXvYqzBzQeIAM/yjyqWmposhI/WI4/2AmabiVnKsQMoOTrkpJzf/aSrJcKPk7atxAAWEz/+DMmblUGjWOYHlqAxuCA=
X-Received: by 2002:a05:6830:1249:: with SMTP id s9mr19888526otp.33.1565373954812;
 Fri, 09 Aug 2019 11:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190808194002.226688-1-almasrymina@google.com> <20190809112738.GB13061@blackbody.suse.cz>
In-Reply-To: <20190809112738.GB13061@blackbody.suse.cz>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 9 Aug 2019 11:05:43 -0700
Message-ID: <CAHS8izNM3jYFWHY5UJ7cmJ402f-RKXzQ=JFHpD7EkvpAdC2_SA@mail.gmail.com>
Subject: Re: [RFC PATCH] hugetlbfs: Add hugetlb_cgroup reservation limits
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     mike.kravetz@oracle.com, shuah <shuah@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 4:27 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> (+CC cgroups@vger.kernel.org)
>
> On Thu, Aug 08, 2019 at 12:40:02PM -0700, Mina Almasry <almasrymina@googl=
e.com> wrote:
> > We have developers interested in using hugetlb_cgroups, and they have e=
xpressed
> > dissatisfaction regarding this behavior.
> I assume you still want to enforce a limit on a particular group and the
> application must be able to handle resource scarcity (but better
> notified than SIGBUS).
>
> > Alternatives considered:
> > [...]
> (I did not try that but) have you considered:
> 3) MAP_POPULATE while you're making the reservation,

I have tried this, and the behaviour is not great. Basically if
userspace mmaps more memory than its cgroup limit allows with
MAP_POPULATE, the kernel will reserve the total amount requested by
the userspace, it will fault in up to the cgroup limit, and then it
will SIGBUS the task when it tries to access the rest of its
'reserved' memory.

So for example:
- if /proc/sys/vm/nr_hugepages =3D=3D 10, and
- your cgroup limit is 5 pages, and
- you mmap(MAP_POPULATE) 7 pages.

Then the kernel will reserve 7 pages, and will fault in 5 of those 7
pages, and will SIGBUS you when you try to access the remaining 2
pages. So the problem persists. Folks would still like to know they
are crossing the limits on mmap time.

> 4) Using multple hugetlbfs mounts with respective limits.
>

I assume you mean the size=3D<value> option on the hugetlbfs mount. This
would only limit hugetlb memory usage via the hugetlbfs mount. Tasks
can still allocate hugetlb memory without any mount via
mmap(MAP_HUGETLB) and shmget/shmat APIs, and all these calls will
deplete the global, shared hugetlb memory pool.

> > Caveats:
> > 1. This support is implemented for cgroups-v1. I have not tried
> >    hugetlb_cgroups with cgroups v2, and AFAICT it's not supported yet.
> >    This is largely because we use cgroups-v1 for now.
> Adding something new into v1 without v2 counterpart, is making migration
> harder, that's one of the reasons why v1 API is rather frozen now. (I'm
> not sure whether current hugetlb controller fits into v2 at all though.)
>

In my estimation it's maybe fine to make this change in v1 because, as
far as I understand, hugetlb_cgroups are a little used feature of the
kernel (although we see it getting requested) and hugetlb_cgroups
aren't supported in v2 yet, and I don't *think* this change makes it
any harder to port hugetlb_cgroups to v2.

But, like I said if there is consensus this must not be checked in
without hugetlb_cgroups v2 supported is added alongside, I can take a
look at that.

> Michal
