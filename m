Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F6FC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CBE206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="cmGbh+cP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfEQHZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 03:25:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37589 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbfEQHZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 03:25:34 -0400
Received: by mail-io1-f65.google.com with SMTP id u2so4718160ioc.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 00:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ye8jut5rxl+0GMAFKnOCRncXMpbDpjVXA4oZoWpQTz4=;
        b=cmGbh+cPPNLCmAlgZhq/+G+m3XSej85ipZrbMM2pPPU+o0yz9wqWOJi7eTugqWc6wa
         sgoENPX5qH8QvfdTnflHyrnJvufBJsRP7ONNs/KcO5CdIP2SMuRL2Qn2H4ZGf50wOzry
         ATRX+rPNcBtuRzhbc6X69QL6pcTkVMNEt8wYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ye8jut5rxl+0GMAFKnOCRncXMpbDpjVXA4oZoWpQTz4=;
        b=LpyiPNplMeDm7p/pN3sy77XbXsGbM/Rkvw9F5G39mh/dFXyoKZYmcDKpeRJE4wZyHz
         O5e0uRvxFrt07DpoZHdXxviW8G94MLyLEYa8i4ZA1ynD9gMP8hlIJoH252gM0GdMnMxQ
         TFvfMd1qDG6OT8wRSuz7hbi5mo6Td39LNEh6rJ73hDfwivFc3VAY4zeA+0v+DJALoVnW
         qPjyqYrDkMXUqxCJLGCLvA2xgW17y1Fm/gVjN5NpeqOyBOBWYhaOGLcdMegw72NN68o7
         gQgRXuJgr4EPp3ExOTqum0y6O+8YwXhOLF0C3N4C+/lenN18Lpp3wkNy18ruKKiu5Fr6
         2leQ==
X-Gm-Message-State: APjAAAW5Lib+jkIkmv//brdu8+W7Xi5qfH0hTa8uOsp5oxyFDyjqf0QX
        RQy6ViomP37dxfYF0MKNBIE6G3RJk0f2BxJAo41uqQ==
X-Google-Smtp-Source: APXvYqxbPOP1gx8Ygd75lZfjIpUpVr7rERQI1OIKXqdBNgYpv1NoZlovKiQv3HkEZyevwO1u9eqOylMgDR79rsTBWa8=
X-Received: by 2002:a5d:9f11:: with SMTP id q17mr7323652iot.212.1558077933370;
 Fri, 17 May 2019 00:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <155800752418.4037.9567789434648701032.stgit@warthog.procyon.org.uk>
 <20190516162259.GB17978@ZenIV.linux.org.uk> <20190516163151.urrmrueugockxtdy@brauner.io>
 <20190516165021.GD17978@ZenIV.linux.org.uk> <F67AF221-C576-4424-88D7-7C6074D0A6C6@brauner.io>
 <11455.1558077206@warthog.procyon.org.uk>
In-Reply-To: <11455.1558077206@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 17 May 2019 09:25:21 +0200
Message-ID: <CAJfpegu0Ckc9tvuPKGtf1mrfj3mLmgw_gcJER9yyRLre4iwZiw@mail.gmail.com>
Subject: Re: [PATCH 0/4] uapi, vfs: Change the mount API UAPI [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 9:13 AM David Howells <dhowells@redhat.com> wrote:
>
> Christian Brauner <christian@brauner.io> wrote:
>
> > If you still prefer to have cloexec flags
> > for the 4 new syscalls then yes,
> > if they could at least all have the same name
> > (FSMOUNT_CLOEXEC?) that would be good.
>
> They don't all have the same value (see OPEN_TREE_CLOEXEC).
>
> Note that I also don't want to blindly #define them to O_CLOEXEC because it's
> not necessarily the same value on all arches.  Currently it can be 02000000,
> 010000000 or 0x400000 for instance, which means that if it's sharing a mask
> with other flags, at least three bits have to be reserved for it or we have to
> have arch-dependent bit juggling.
>
> One thing I like about your approach of just making them O_CLOEXEC by default
> and removing the constants is that it avoids this mess entirely.

+1.

Confusion caused by inconsistency of naming is going to hurt more than
inconsistency of semantics wrt. open(2).

Thanks,
Miklos
