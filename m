Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DB2C41514
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 15:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E579217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 15:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JXqy7J5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbfIBPKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 11:10:39 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46415 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbfIBPKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 11:10:39 -0400
Received: by mail-io1-f67.google.com with SMTP id x4so29607415iog.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 08:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eNoZVt93wCM2AD/WJsdKgmkl7QJYjyE8sIFzYDYEiq4=;
        b=JXqy7J5YOfHw70u2KMsOY+LVESQvc9tJmhEt/mn5NcgBhZXYx/JSUnUdBx236ujBr0
         k+LwyWG21gdvtU+kztx1imluhfGzI31fGEn2WgROzQeYSmNxsNksz6SG0LyBCebyUhRM
         C6TwF5G1VeF0mfS61qmlxog6FDqv1I06Bkvrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eNoZVt93wCM2AD/WJsdKgmkl7QJYjyE8sIFzYDYEiq4=;
        b=ApmLMvLNAbHHaU3jGC9vK2oxenbOTMAmGCpVkjoFSB1f8aniTZFe1vdE0VNGaCbj23
         qpralYigWinWoNyY9SKQV3bRYmGwb1KeV9xaTDpSn1LcMWenCbqbU7WajyQR2GIxVGFF
         Ojcdj+4hm9hCPtfj3jareI4znWf8LN1KN8Hwjq8ZRQZfxMuc8YUr0FdIEL+uqkr0L8sB
         ErDifUV1W8aoxCbRrwiha92hEwBy7i/ohGoa8PCx0ltH94ApO2T4cw9sT2x8IWSjSd5/
         9y4ln9Zhcp9Gf0A5+7nzAfIg+4M0YhAHl4UtO429RdCpe5sm28OY0hNpOZBx2/s3/144
         s7uA==
X-Gm-Message-State: APjAAAXdZnQNjDUS+CqSWuWjvalQ1hEEqYQpI80QzlpXoUkWI19Jm962
        iMjENtIFVDN69Fxol3CJ5akCaKwSd0IiGSm7yN7d6A==
X-Google-Smtp-Source: APXvYqwZRkt8fPWRtDpiKFOKXTy8fw0RHOy/5a1qDh7rttm4qMCirS6V7hOTFzeJsTNvgEwYZnkeRnwFnPJXwIhBKN0=
X-Received: by 2002:a6b:f80f:: with SMTP id o15mr1741553ioh.174.1567437038133;
 Mon, 02 Sep 2019 08:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190830130119.446e7389@canb.auug.org.au> <CAJfpeguxmJvCV+PXr=wz5HXONKv4RDmZ1LpYNEqAtvw_smP5Ag@mail.gmail.com>
In-Reply-To: <CAJfpeguxmJvCV+PXr=wz5HXONKv4RDmZ1LpYNEqAtvw_smP5Ag@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 2 Sep 2019 17:10:27 +0200
Message-ID: <CAJfpegsijOi6TdRcObGSAJ+tS0JiZky=v6Wqh5u8RZTzi6tkjA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the vfs tree with the fuse tree
To:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 2, 2019 at 11:00 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Fri, Aug 30, 2019 at 5:01 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > Today's linux-next merge of the vfs tree got a conflict in:
> >
> >   fs/fuse/inode.c
> >
> > between commit:
> >
> >   1458e5e9f99a ("fuse: extract fuse_fill_super_common()")
> >
> > from the fuse tree and commit:
> >
> >   2ad9ab0f7429 ("vfs: Convert fuse to use the new mount API")
> >   48ceb15f98c8 ("vfs: Move the subtype parameter into fuse")
>
> And the latter is b0rked anyway.

Both, actually.

Pushed fixed ones to fuse.git#for-next.

Thanks,
Miklos
