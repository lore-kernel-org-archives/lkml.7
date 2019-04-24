Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11303C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5476218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CTHN3J5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbfDXNxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:53:43 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43799 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730096AbfDXNxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:53:42 -0400
Received: by mail-io1-f65.google.com with SMTP id v9so51106iol.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 06:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tf3CjB2PxTkU5TU2/EIND2+4qjOUWPIkBjwis1N6aXo=;
        b=CTHN3J5er1UnnDYGsGk6fG/x9KcrMTyT0pO9eOPWkrUqFMGNW4b/SFje6V8IyIyph7
         aPiQWIo+RCw492hYTVhoIEyPEIuGLDWPGebEFrNnR7IkUdMBDz4BE21Qasxk/Kva51FV
         zsGb3+2dQmu7XEmWsr/TqxnDBE1YyZ0+VjU+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tf3CjB2PxTkU5TU2/EIND2+4qjOUWPIkBjwis1N6aXo=;
        b=OAWY9ndA4V4FoyCcwCtYnZjIKT6XuXkXwipE0zCJzYLOpUcoFbMF3d2IDzca1xybQo
         F37RwM8J4qtMZP84RLLhKOvtmWaUmZDr7BhytvEs9LplrRfCT2RqD0BIhV/jkMLdgT+t
         8/FXf5JFXbh+r6mMYQ2M6otmNaK+exP3aV2vZSglrkIa9hgusuq6UDgjaMnin2+YLsCv
         SuyES9uLIzweqlUWRGh9aMR1mjxulcbF3gm5xyOn3o3lnz5rf2oRP4UCwFtu6BZe7M4s
         kHliqoBn0IpahfTJNz0Ws9O6CU6cbbEnjdMyMyFJobvv4vWPpnu0zqSqgPlXfKasUL0R
         rPQA==
X-Gm-Message-State: APjAAAWjDRHO6CBBZlnbdzeQmqYAG/BaN2+s7KyRkM1tVgPPtwyAp/4s
        XB17M2FdOqH48H0ioQRZMt7vdWZwZtbt4DjaSGK/xQ==
X-Google-Smtp-Source: APXvYqxxv+5c6L0yVlsd+hDlEzMH7SD5bF2E6fJRJeUAXdiFbsQdCUjqciPfSqc7+kX99Uio9tTWYsiJlr4SAbl5smE=
X-Received: by 2002:a5e:8202:: with SMTP id l2mr18074592iom.144.1556114021179;
 Wed, 24 Apr 2019 06:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
 <155373036414.7602.7964458548629410897.stgit@warthog.procyon.org.uk>
In-Reply-To: <155373036414.7602.7964458548629410897.stgit@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 24 Apr 2019 15:53:29 +0200
Message-ID: <CAJfpegvowwePJHEMRkaabx-NxLoJ5f8_QziPFyQUui+bmAaT1w@mail.gmail.com>
Subject: Re: [RFC PATCH 44/68] vfs: Convert fuse to use the new mount API
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 12:46 AM David Howells <dhowells@redhat.com> wrote:
>
> Convert the fuse filesystem to the new internal mount API as the old
> one will be obsoleted and removed.  This allows greater flexibility in
> communication of mount parameters between userspace, the VFS and the
> filesystem.
>
> See Documentation/filesystems/mount_api.txt for more information.

Should I be applying this, together with the vfs dependencies?  Or
will you take care of these?

One minor comment is that fuse conventionally uses "struct fuse_conn
*fc", so "struct fs_context *fc" is confusing here.  There's one place
you use "struct fs_context *fsc", which seems the right thing to do
for all the cases.

Thanks,
Miklos
