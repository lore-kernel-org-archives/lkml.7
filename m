Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DC6C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4B223407
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cbZ/eIqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732541AbfHVImx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 04:42:53 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37458 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732530AbfHVImv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 04:42:51 -0400
Received: by mail-ot1-f67.google.com with SMTP id f17so4753679otq.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 01:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NfCKuFdEeNBAgpgY3GQU9evNY2kKtJpvRWsNwL+v9LE=;
        b=cbZ/eIqa3UOnq5kZcw9ViWpQlwY6IoHQWwYFtH4j5KLaJRU0py33AbPiPiAJVlbc/Y
         BKVPPwYWmhbkGDR1ys452Hfk/wY38q87dT/NiRbDk43nh9KoZQCtcGVi2a+huvT45BW1
         DTkTcnHBZzI/xbpSr6wkE8INN5L/ml6Sq3+ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NfCKuFdEeNBAgpgY3GQU9evNY2kKtJpvRWsNwL+v9LE=;
        b=JDlQaI5/q/ZJlNX7k8MSSZjfQ+9PxLa15ajBOgQm9L7ABYU5ZAvRzF0A8zftim/rkY
         qtJ0UhZjrOJVjDchW7mKzlvsK6wYki22ckpTdUo4u0nrK9757qppD5UrZsY8reAVMOq6
         X7mpb6o2tEV5PTKuAlufqdXXvPIGfqKKTW0X/nC6rIs0qrQVa87ZDCg7NCS7iSS780lq
         dH1dh9By5Mfof9kKgia4KliKKV6G3tnTvKps7dRjP6Y8uB8n1KmfZP4oSG66ndZ0BsHc
         agQ+gzZAOLTAlBECMdmwAcfbt1z0SmEyxbu1rfB8tsafKh9z/WzM2IUOrS5J6gtB8Io6
         zwaw==
X-Gm-Message-State: APjAAAXZSV3Pm0u/TBkO8hTUXEhkKwpkt5AV451e7J6WZeniOEphmuuX
        2SS3LYlWvJbVCRFF7ndNPpRZcKWVD3YIG6rh3yMt8Q==
X-Google-Smtp-Source: APXvYqxpz8kgbP+ugs1KUhnBtoipkM40G0JFM2B8mwDRWFu9+c1XE/VWtgoMVi8Vtvm95XZX33AsAYp4bMyumd0+MLk=
X-Received: by 2002:a9d:7cc9:: with SMTP id r9mr31457513otn.188.1566463370802;
 Thu, 22 Aug 2019 01:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190820081902.24815-1-daniel.vetter@ffwll.ch>
 <20190820081902.24815-5-daniel.vetter@ffwll.ch> <20190820133418.GG29246@ziepe.ca>
 <20190820151810.GG11147@phenom.ffwll.local> <20190821154151.GK11147@phenom.ffwll.local>
 <20190821161635.GC8653@ziepe.ca>
In-Reply-To: <20190821161635.GC8653@ziepe.ca>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 22 Aug 2019 10:42:39 +0200
Message-ID: <CAKMK7uERsmgFqDVHMCWs=4s_3fHM0eRr7MV6A8Mdv7xVouyxJw@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm, notifier: Catch sleeping/blocking for !blockable
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 10:16 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Aug 21, 2019 at 05:41:51PM +0200, Daniel Vetter wrote:
>
> > > Hm, I thought the page table locks we're holding there already prevent any
> > > sleeping, so would be redundant? But reading through code I think that's
> > > not guaranteed, so yeah makes sense to add it for invalidate_range_end
> > > too. I'll respin once I have the ack/nack from scheduler people.
> >
> > So I started to look into this, and I'm a bit confused. There's no
> > _nonblock version of this, so does this means blocking is never allowed,
> > or always allowed?
>
> RDMA has a mutex:
>
> ib_umem_notifier_invalidate_range_end
>   rbt_ib_umem_for_each_in_range
>    invalidate_range_start_trampoline
>     ib_umem_notifier_end_account
>       mutex_lock(&umem_odp->umem_mutex);
>
> I'm working to delete this path though!
>
> nonblocking or not follows the start, the same flag gets placed into
> the mmu_notifier_range struct passed to end.

Ok, makes sense.

I guess that also means the might_sleep (I started on that) in
invalidate_range_end also needs to be conditional? Or not bother with
a might_sleep in invalidate_range_end since you're working on removing
the last sleep in there?

> > From a quick look through implementations I've only seen spinlocks, and
> > one up_read. So I guess I should wrape this callback in some unconditional
> > non_block_start/end, but I'm not sure.
>
> For now, we should keep it the same as start, conditionally blocking.
>
> Hopefully before LPC I can send a RFC series that eliminates most
> invalidate_range_end users in favor of common locking..

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
