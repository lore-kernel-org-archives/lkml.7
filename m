Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C098CC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFED2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="i2mOYYKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391135AbfDXRvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:51:17 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38236 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390744AbfDXR24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:28:56 -0400
Received: by mail-io1-f67.google.com with SMTP id y6so8879859ior.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 10:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lN83+aUhu5iPVQmRA+/A9ER3XqiY5oN0TOslwMtjELs=;
        b=i2mOYYKHKNvE3s5wxV1VAY5d1U85VE5dw/XzMQ2N61fnvDiv/r8RJyAEFTcy+bYKeA
         5lwLVwQG8U2phsK3lWFRlU7us40i3b2NmJlGZlxl0Q5211N1BmugmPFcDXecbpbvK9m2
         q1FUQF8NMqIfNwirokdUznuAaV120kXrz9aD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lN83+aUhu5iPVQmRA+/A9ER3XqiY5oN0TOslwMtjELs=;
        b=nJjo5pMIRfCOu3/3Hp804ldmLZKGl/78RpcsquTP+hFXp2oMRKRH/wIbzgP3p5g6iP
         QCgbBeamSFNqzWNL2jKQEur27e9Xb+RMLy8vfFbCiRD4U65/4s/y6Zu7qWVt4QdfJO9Y
         7qmFChVNIMcuTHkvIgkBYWVrv6yR+pUAgaTZ4lx+KzwFlaJz4hWq2wzFLrz2gitHsIcq
         s4NF9GVCjqbVBjHNmU9OYy40BNk2qmZXO/Baett9MdqaiwVFEcq9mivFy/wRAVQXpmlS
         LvNSRB8O7v2RwolyBhChIncQW8np+bt8IDtVg4V7Xy3O/0DiwlSV4xp4XR347x7bCi2p
         H8Tw==
X-Gm-Message-State: APjAAAUjWzd5vuHgmA/0FVHOhxD+Yk0yFqowynsn/Qs0k1vPA7/MVnqK
        erWbLduQchnNAhuvpMwTGWdSNScqIu3YO3Qi0AZJQA==
X-Google-Smtp-Source: APXvYqz3cHuXu+wqxN0CPQ6FM2nAGgKq5onzw0iCS/4eLtfmBsY/d8KPFbc2/hMU5jji5J7RO/3qfdGuighQlaMzSnI=
X-Received: by 2002:a5e:8202:: with SMTP id l2mr18783581iom.144.1556126935594;
 Wed, 24 Apr 2019 10:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
 <155373036414.7602.7964458548629410897.stgit@warthog.procyon.org.uk>
 <CAJfpegvowwePJHEMRkaabx-NxLoJ5f8_QziPFyQUui+bmAaT1w@mail.gmail.com> <3217.1556119323@warthog.procyon.org.uk>
In-Reply-To: <3217.1556119323@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 24 Apr 2019 19:28:44 +0200
Message-ID: <CAJfpegssSDWijX2Qnd0fQhCMkfmS3EZWp+=gMn_9S6E3H8wQBg@mail.gmail.com>
Subject: Re: [RFC PATCH 44/68] vfs: Convert fuse to use the new mount API
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 5:22 PM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > Should I be applying this, together with the vfs dependencies?  Or
> > will you take care of these?
>
> I'm hoping Al will take the entire series.
>
> > One minor comment is that fuse conventionally uses "struct fuse_conn
> > *fc", so "struct fs_context *fc" is confusing here.  There's one place
> > you use "struct fs_context *fsc", which seems the right thing to do
> > for all the cases.
>
> Except in ceph, where "struct ceph_fs_client *fsc" is a common thing...

I'd be happy if it was consistently "struct fs_context *fsc" in just
fuse/inode.c.

Thanks,
Miklos
