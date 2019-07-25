Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F71C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19EB21901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9zktBfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389618AbfGYPvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:51:48 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44971 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfGYPvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:51:48 -0400
Received: by mail-yb1-f196.google.com with SMTP id a14so18636273ybm.11;
        Thu, 25 Jul 2019 08:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XzjdGqC1KanFcesRBecTPozKcz3xVgLXZiKoPtdXfLQ=;
        b=T9zktBfj+oIxSDxV7DWaLUAtH2lZn9X3qyEgmZLH8oxDJbdLzxZs8KVT5g71EiS24V
         WUCGpIhvT1iOHx4m9D1eXKfWRkfoVDFIj+CvJggpIz4t3oMMCo0xEHDYkh069VVT5nrt
         u1dom5QKGlXYL4Mob17aMXYResfKZIqi4lzTEoq8Hi4EsvMveNO3tULKiiO/v0b4sktB
         8dOvUyeV00ZX9qOnMIku/9GFiUxW32mZCh5dzAPVkH7GK2Lc0f3Ywgq0SDHl99QLGvpz
         LWKzv3AerCcDpkAmvjWZAAuBi0JpxoJ9eJFra0rDD5bPVbmcXJ6p4TMVGTxPy0BgK3t1
         uYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XzjdGqC1KanFcesRBecTPozKcz3xVgLXZiKoPtdXfLQ=;
        b=tgs/iXapveGYic8saRb6GLeZ7jp1U0i8EBsoR05iMEPsRJsiwVmtq449QxaN+EZ+5l
         LLI5GNRCVZYVCVYqxInhvf24CIGxQJs4O1e9xhnFE86cJp1vZqmsuAVq4R6/nEneG+pi
         QD0N2ydsdElIgVuOUWBgSp6mI9EZD/vltzibDDGgCCEVLIum/Z+zvqF/soPHhG4gOpq2
         RvnaZqtsXgZGLB0SWSCEfPgXrjfB0QHOBYHGO8VLk7yM223tsVXDic+CPPk9nvIuACio
         uiCVES4+E0x17W3nR1yCxhFU3xZGkxMZpTKQof5ZU7T865eXFauWZnE35ft0knuUEkwA
         dGgw==
X-Gm-Message-State: APjAAAWznfKVJna9pw09lpmdnjcDQArhK/VCwBGJFOSSfVGM/Rbj78yL
        0P2CX1DD8ZAQ1i56PgmFPVbUxx/XV2u+uwVohCQ=
X-Google-Smtp-Source: APXvYqxVeHgUtZr3g2omkLN2Ixlk+Mh+izDz6CjHC02+EydHhcvHTGyI31ttuRNSPp42UdH7BEv0v18FRIh/4DxbAoc=
X-Received: by 2002:a25:9a08:: with SMTP id x8mr53552715ybn.439.1564069907073;
 Thu, 25 Jul 2019 08:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190724195719.218307-1-salyzyn@android.com> <20190724195719.218307-5-salyzyn@android.com>
 <CAOQ4uxhtASSymEOdh4XByXbxWO2_ZivzqjBrgK7jB3fWXLqr_w@mail.gmail.com> <20df8497-17ea-27db-43c8-fcd73633e7f3@android.com>
In-Reply-To: <20df8497-17ea-27db-43c8-fcd73633e7f3@android.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 25 Jul 2019 18:51:36 +0300
Message-ID: <CAOQ4uxhE77ZvUBv_ZLhSf8fdsWcJJkewjZAQKbgw3BdvgjRUOA@mail.gmail.com>
Subject: Re: [PATCH v10 4/5] overlayfs: internal getxattr operations without
 sepolicy checking
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 5:37 PM Mark Salyzyn <salyzyn@android.com> wrote:
>
> Thanks for the review.
>
> On 7/25/19 4:00 AM, Amir Goldstein wrote:
> > On Wed, Jul 24, 2019 at 10:57 PM Mark Salyzyn <salyzyn@android.com> wrote:
> >> Check impure, opaque, origin & meta xattr with no sepolicy audit
> >> (using __vfs_getxattr) since these operations are internal to
> >> overlayfs operations and do not disclose any data.  This became
> >> an issue for credential override off since sys_admin would have
> >> been required by the caller; whereas would have been inherently
> >> present for the creator since it performed the mount.
> >>
> >> This is a change in operations since we do not check in the new
> >> ovl_vfs_getxattr function if the credential override is off or
> >> not.  Reasoning is that the sepolicy check is unnecessary overhead,
> >> especially since the check can be expensive.
> > I don't know that this reasoning suffice to skip the sepolicy checks
> > for overlayfs private xattrs.
> > Can't sepolicy be defined to allow get access to trusted.overlay.*?
>
> Because for override credentials off, _everyone_ would need it (at least
> on Android, the sole user AFAIK, and only on userdebug builds, not user
> builds), and if everyone is special, and possibly including the random
> applications we add from the play store, then no one is ...
>

OK. I am convinced.

One weak argument in favor of the patch:
ecryptfs also uses __vfs_getxattr for private xattrs.

Thanks,
Amir.
