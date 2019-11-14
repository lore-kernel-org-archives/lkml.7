Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94510C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697DB2070E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fTvqlHWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfKNPha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 10:37:30 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:32907 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfKNPh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:37:29 -0500
Received: by mail-io1-f65.google.com with SMTP id j13so7301035ioe.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 07:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ik2QPcY3BYCfa0MQAyReN6/fOyeG4H8aydWoIfeiFRY=;
        b=fTvqlHWsZQDIK2GyerKHBwgtfpQAKh/wtLVJoadFkpdZrIpkSrhlvd86vYCm18vs0z
         NpYjz+YByzIaXLXhpormeBpxb3hNbCirGsiKENMbJFYngesxR5NrA6tFcbrrOCpbkIwA
         1EEGVEgz+VUtog7y2BocnNUr0FAbrkzSiGbdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ik2QPcY3BYCfa0MQAyReN6/fOyeG4H8aydWoIfeiFRY=;
        b=El96Gus7a+uTOIAwFkVS2Ksw4TQcPrL4tfT/EZEOGLNbkKw8s3LxQHF2m77lkbB7os
         qqGBRYPw10er8lqD5iB34rUom6UrE23XVAATJhJH6eWzXONtbarD9c3tVbL8HFHF0gDQ
         UMyk0vE8Q2U7mlt/ECqCThlKdHUZIb21ctfgu/kul+xsiELxpOkONn0va0NC2iJ5GdwU
         twoVDUyLVH028mwXZtl/JoVMlrg2MszP6Wf+QK7vDAc89uKt0XtD7H799ocKwcDUk/q0
         F/qNTNT4DN5jgLfXs12dHVdemhGG56PdsKeVrc5R5+Kta7kR+iaT88piW1q22UZhIFY7
         sSkQ==
X-Gm-Message-State: APjAAAUKOM7C7LJMlVxU4BEjWhRkCYRS2XOeJ4iT7zD4866DoVIowpbO
        avS8PA1zq8yf/Cjq3m4SgzoTz3DmB5f6ZD+o2nDG+Q==
X-Google-Smtp-Source: APXvYqyr8938NcGeqVTFkZxhcbLap8X2n5hHy/codIajFJc5Ys6sxBaAs35GhxBULIhoIzGlqj56jyyV7GU8KeVgW04=
X-Received: by 2002:a6b:3bca:: with SMTP id i193mr7568923ioa.285.1573745849024;
 Thu, 14 Nov 2019 07:37:29 -0800 (PST)
MIME-Version: 1.0
References: <20191113200651.114606-1-colin.king@canonical.com>
 <CAJfpegug-saOEigqDNKfwMR5qdzrbLnRBD=0eN5juGioFH_L_Q@mail.gmail.com> <CAOQ4uxgf5KAq7VoHVNVUD9QtA7Y++-_TdwOe6=icHLgJvyrg1A@mail.gmail.com>
In-Reply-To: <CAOQ4uxgf5KAq7VoHVNVUD9QtA7Y++-_TdwOe6=icHLgJvyrg1A@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 14 Nov 2019 16:37:17 +0100
Message-ID: <CAJfpegufS=OGcvFbWEVumNSCPO_JXyEuJNAbmO5ubscSarVtRQ@mail.gmail.com>
Subject: Re: [PATCH][V4] ovl: fix lookup failure on multi lower squashfs
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Colin King <colin.king@canonical.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 3:43 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Nov 14, 2019 at 12:30 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Wed, Nov 13, 2019 at 9:06 PM Colin King <colin.king@canonical.com> wrote:
> > >
> > > From: Amir Goldstein <amir73il@gmail.com>
> > >
> > > In the past, overlayfs required that lower fs have non null
> > > uuid in order to support nfs export and decode copy up origin file handles.
> > >
> > > Commit 9df085f3c9a2 ("ovl: relax requirement for non null uuid of
> > > lower fs") relaxed this requirement for nfs export support, as long
> > > as uuid (even if null) is unique among all lower fs.
> >
> > I see another corner case:
> >
> > n- two filesystems, A and B, both have null uuid
> >  - upper layer is on A
> >  - lower layer 1 is also on A
> >  - lower layer 2 is on B
> >
> > In this case bad_uuid won't be set for B, because the check only
> > involves the list of lower fs.  Hence we'll try to decode a layer 2
> > origin on layer 1 and fail.
>
> Right.
>
> >
> > Can we fix this without special casing lower layer fsid == 0 in
> > various places?  I guess that involves using lower_fs[0] for the
> > fsid=0 case (i.e. index lower_fs by fsid, rather than (fsid -1)).
> > Probably warrants a separate patch.
> >
>
> I guess we should.
> I do hate that special casing.
> I can work of that, but would you like to hold back this patch now?
> Or just fix that corner case later?

Okay, let's fix the main case first, then the corner case...

Thanks,
Miklos
