Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9533C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA30217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387463AbfDQVcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:32:07 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38786 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQVcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 17:32:07 -0400
Received: by mail-qt1-f195.google.com with SMTP id d13so6714qth.5;
        Wed, 17 Apr 2019 14:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NS2VRDxKzZD0tRaotA5kqUlPsqan9DRxqtcv7Aye8Cc=;
        b=VEoOHoLJCvDYI2ik5yAApDqoRZwW6nMruQbA/I5RHeGS04Tv6o0kG/3Ic02XceYvez
         Hoy1LotyAd2r5KtPdK2e4TG8nDrDvbqs78r5W6/MPljOfsX/+8Cc2jGwxwl8wUKvpaL5
         VKNg/aJDx3nfa7bDJR75KPJ2UDoaW13jsNqZvg6Dzxk/HopzknR+QbakDTv6eq3OvZ2W
         PA4VcHzK2RXirctEXSYBmDIaYlvTv58S6vgDDc9bQNl2T+aOWVkmTrbdWf65EzlRwibF
         MJ9gxx1YZA6eWBXtVPOPj0QosMNRa7ZUiuOkn+ckiKsf1xip7J2GBrcpzNfYXaOuzPEI
         GQuA==
X-Gm-Message-State: APjAAAUXUl0BKgUsldT9NjpCwGkN03+WSkQSwtEjLp9+cK7/tEE9SboF
        KmalzSS+KPSk1wTf6pSBT1rgm/k3yuwcLFs3UCo=
X-Google-Smtp-Source: APXvYqyPa5UBM853md5L0dq/2nTACaXsFnZgRfeZ2BAgzI+nv7Hj4f6k+ENPc8OFmmPfUvvSvz602hYO3yyXoVZPoIM=
X-Received: by 2002:ac8:276b:: with SMTP id h40mr74468946qth.319.1555536725823;
 Wed, 17 Apr 2019 14:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190416202013.4034148-1-arnd@arndb.de> <20190416202013.4034148-12-arnd@arndb.de>
 <20190417212312.GY2217@ZenIV.linux.org.uk>
In-Reply-To: <20190417212312.GY2217@ZenIV.linux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Apr 2019 23:31:48 +0200
Message-ID: <CAK8P3a2aRKZDpLJzCW74kwQaYr-Y2txh_5NY2CkRoZFzV=Cn6Q@mail.gmail.com>
Subject: Re: [PATCH v3 11/26] ceph: fix compat_ioctl for ceph_dir_operations
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Yan, Zheng" <zyan@redhat.com>, "# 3.4.x" <stable@vger.kernel.org>,
        Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel <ceph-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 11:23 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Apr 16, 2019 at 10:19:49PM +0200, Arnd Bergmann wrote:
> > The ceph_ioctl function is used both for files and directories, but only
> > the files support doing that in 32-bit compat mode.
> >
> > For consistency, add the same compat handler to the dir operations
> > as well.
> >
> > Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  fs/ceph/dir.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> > index a8f429882249..7c060cb22aa3 100644
> > --- a/fs/ceph/dir.c
> > +++ b/fs/ceph/dir.c
> > @@ -1785,6 +1785,7 @@ const struct file_operations ceph_dir_fops = {
> >       .open = ceph_open,
> >       .release = ceph_release,
> >       .unlocked_ioctl = ceph_ioctl,
> > +     .compat_ioctl = ceph_ioctl,
>
> Again, broken on s390 (and so's the ceph_file_ops, of course).
> It wants compat_ptr() applied to argument...

This gets changed in a later patch, I intentionally left this one
doing the same as ceph_file_fops so the patch can be
backported if necessary, without also backporting the
patch that adds compat_ptr_ioctl.

       Arnd
