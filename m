Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D362C00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 08:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F674206A1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 08:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="mOY+F7Io"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389476AbfIFIP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 04:15:26 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36774 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfIFIPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 04:15:25 -0400
Received: by mail-io1-f66.google.com with SMTP id b136so10899637iof.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 01:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=71+P9Y1aQOgw6Dp9fK4XNoBcCfSmpfYHfETpowIUBEc=;
        b=mOY+F7IoXze5/oEY9qnxW4BtDV3c6OGnOM65rcAz4tBQ+pP1oCmZx3kBCsHFdm9ssi
         tdD9aqu1qDCinK7SZKtFdQ7WsDaXA5OVnxl3jnwgL/Rl00M0BEsmJ/uoAk72kSFu5qei
         FYQzoLZKR/w9+CtVp9n067d669r/fYv2PpYlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=71+P9Y1aQOgw6Dp9fK4XNoBcCfSmpfYHfETpowIUBEc=;
        b=hkvgzoRROKKmBoM6vt81Svo3IbG3V5oBMob/LLIkZiQuw6LDjR/MCX0J0M2janadxr
         PhOZrSROqzXmQ4ztvbG7dCMLsXrmuJle4+fPJWuc6+XuK4BbmsWZqcLmRiRJZimWAK7v
         u64+SahKyX/MTHdIVIM45N/SQo7ajfSLu/kxia1tm+wdhBtQR6DCw8tcRhymL/aGdsX3
         bN1sOCFyk66dicmd1MwDj5pu63xi3HrCL6u5hSj2cSWHbZl30SXN2cEukJAwSxbwFrz4
         gk7OsK9O4igMEx+iXk5kUgJhh3jdfpeTLHs5QmGK/d0Zm2J94WYrjxXAJ9tChNSgPI9P
         VcRA==
X-Gm-Message-State: APjAAAXrr0h7J+HvOzW016wPxzYGHIoSR8Qcl3adTy68yxJinSZc9S/t
        Oa1tj8lIUqarCL5+Ezo7q1o8a7lVIBmULuHS3Y1osA==
X-Google-Smtp-Source: APXvYqzMtxa4XtA7wApmndxSDp7Bu8ZqzrPn0Tms4HAAjPUjMhyeA/vR5U1wZspaH+eF6zgoriVn3BWfEXcffE6I7Is=
X-Received: by 2002:a6b:bec6:: with SMTP id o189mr8631585iof.62.1567757724963;
 Fri, 06 Sep 2019 01:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190905194859.16219-1-vgoyal@redhat.com>
In-Reply-To: <20190905194859.16219-1-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Sep 2019 10:15:14 +0200
Message-ID: <CAJfpegu8POz9gC4MDEcXxDWBD0giUNFgJhMEzntJX_u4+cS9Zw@mail.gmail.com>
Subject: Re: [PATCH 00/18] virtiofs: Fix various races and cleanups round 1
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 9:49 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Hi,
>
> Michael Tsirkin pointed out issues w.r.t various locking related TODO
> items and races w.r.t device removal.
>
> In this first round of cleanups, I have taken care of most pressing
> issues.
>
> These patches apply on top of following.
>
> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#virtiofs-v4
>
> I have tested these patches with mount/umount and device removal using
> qemu monitor. For example.

Is device removal mandatory?  Can't this be made a non-removable
device?  Is there a good reason why removing the virtio-fs device
makes sense?

Thanks,
Miklos
