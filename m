Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7053BC48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419D2208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="thXTMTeT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfFTOok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:44:40 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43646 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfFTOoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:44:39 -0400
Received: by mail-yw1-f66.google.com with SMTP id t2so1263048ywe.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 07:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hkFAHTitPkfoSMrSNRMsrnAtfZq9o+iv5woQgM2GCxU=;
        b=thXTMTeTx0xXiZ9u/a78f4w6z2h57qLbhWVkhGpc5uU4+H4pPEGPk9N0YCZIJUb/U4
         TnuCUQ66JQqC0RvWoZCgR5L5jwqo76zVzKpMp8pXzP0t0CQ13sojAuWtJV7WnzKSCT2L
         TWtmySeyPfLwUziR7l0nrBHtk8fljJ+2ySjxfL+NG8AENzVWfMDj+iozng9mw4Awlsxa
         skqETBHwe+amhnj7vzDXN7JX46bW7xj9yy4+eq7BrRCQxowABoE0AiBdKbjHH05Jx41W
         5BmmPDMNbpX33eiLB6cDqnj9kFawoUkLCrF0p8UIYzkm0l8IfyFnL90oSO42R54TvW4k
         dHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hkFAHTitPkfoSMrSNRMsrnAtfZq9o+iv5woQgM2GCxU=;
        b=YVpfnJ4JQruoL7R5sL5ZfxxaZwk2jaFtIDHem0DnNzSacJFx1HrYxXe5SzOH8qP1Zy
         OeVvchJ+FqigvBP90S3x1tI6mrm5u8v0uoXqhnRIWthITzxHS0oDpbSmjrpSuh/jhTda
         7lHkDzMb2F6PaXuU5olZmMD6cV6vJr0SaTl4gy+XwRxiCBpS9KHRr2P6RZpZ8JFAbDDD
         7jvz8SAwOKVEGGHeC71Yr9jypH4L1bkhmdMDW06zfyzVWq5DG5sWGxmQSWumfYnTkbDO
         P2nCdCHFKRra97121xVsmCmTKiSqy/g4CIrM3cD30bK713y7KTxPyLY2/G3Xb5MAx5rI
         7HEA==
X-Gm-Message-State: APjAAAXb9vNUWHrQoJuHRjn+Nq64y12S7mu+QKqHFSgEq/EsbFYJJG8I
        68waGD5TeotQxXAQj5ByPE6k8tigKq4UmIBlNKraTw==
X-Google-Smtp-Source: APXvYqx6zBr4fQkuPVHdnX/C78xgvMrTTDAZuq5i6MOjKE9DTzL7jnNL4Y6jb/qP1KrId0xDX5nVw5xKzMf3llYMevw=
X-Received: by 2002:a81:ae0e:: with SMTP id m14mr55624057ywh.308.1561041878378;
 Thu, 20 Jun 2019 07:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190619232514.58994-1-shakeelb@google.com> <20190620055028.GA12083@dhcp22.suse.cz>
In-Reply-To: <20190620055028.GA12083@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 20 Jun 2019 07:44:27 -0700
Message-ID: <CALvZod4Fd5X91CzDLaVAvspQL-zoD7+9OGTiOro-hiMda=DqBA@mail.gmail.com>
Subject: Re: [PATCH] slub: Don't panic for memcg kmem cache creation failure
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 10:50 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 19-06-19 16:25:14, Shakeel Butt wrote:
> > Currently for CONFIG_SLUB, if a memcg kmem cache creation is failed and
> > the corresponding root kmem cache has SLAB_PANIC flag, the kernel will
> > be crashed. This is unnecessary as the kernel can handle the creation
> > failures of memcg kmem caches.
>
> AFAICS it will handle those by simply not accounting those objects
> right?
>

The memcg kmem cache creation is async. The allocation has already
been decided not to be accounted on creation trigger. If memcg kmem
cache creation is failed, it will fail silently and the next
allocation will trigger the creation process again.

> > Additionally CONFIG_SLAB does not
> > implement this behavior. So, to keep the behavior consistent between
> > SLAB and SLUB, removing the panic for memcg kmem cache creation
> > failures. The root kmem cache creation failure for SLAB_PANIC correctly
> > panics for both SLAB and SLUB.
>
> I do agree that panicing is really dubious especially because it opens
> doors to shut the system down from a restricted environment. So the
> patch makes sesne to me.
>
> I am wondering whether SLAB_PANIC makes sense in general though. Why is
> it any different from any other essential early allocations? We tend to
> not care about allocation failures for those on bases that the system
> must be in a broken state to fail that early already. Do you think it is
> time to remove SLAB_PANIC altogether?
>

That would need some investigation into the history of SLAB_PANIC. I
will look into it.

> > Reported-by: Dave Hansen <dave.hansen@intel.com>
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks.
