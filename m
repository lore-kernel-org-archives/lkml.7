Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC45C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 11:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40E120896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 11:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HQtANcgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404211AbfFKLw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 07:52:27 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55113 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404168AbfFKLw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 07:52:26 -0400
Received: by mail-it1-f194.google.com with SMTP id m138so4349529ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 04:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Rnl+iv878Jbd5yCAXuEFcxBsr6AC4Z7Q26Ty1H00uQ=;
        b=HQtANcgMFRytOvbSTwSjIfJ8BxF95qiHKWOo73rFifB37lQdNF6obb3FoYqoilaRrH
         b7duEikwgALL+TnLznPIpCHPol4S1xW6N7PPH6KR+wTmk2ed9V0UNj83zbPHTyaJTFMe
         uHCgYjoOIUVa27dJRIQSu4wBGf9a1L1yki5U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Rnl+iv878Jbd5yCAXuEFcxBsr6AC4Z7Q26Ty1H00uQ=;
        b=YhK8NFQSfeN1MMcu+Sep2NS6svn/rRjZJxEmfAGbBWpC7DbjkFBCpqGlgDeP70GIV6
         6kh+4B3vHrAO2Kdnvlber3AZHve/hCmnNWPUAWR3JV9g8zvtZs/JQDx3m/Sm80FnUe4u
         dZnPKlgP1uOUzf3vASpS0RCkqDTN7t2QIWAsQsLg8xXxLcde0z5DMVs2vsPs+v2Ot/vn
         C1FnzVI6sDMQo5rJ2Zpp5VO56oJyAvi3GW6jb3p3esKk3VrTRC4L0wggtTm/qO1vTW7R
         cCeUrTf9jf5LzwhYxJh/cLw6m0ebYqPj0JVL0vdlt2jJYQAltnSJrucGRO46lZ3M1EA8
         HcaQ==
X-Gm-Message-State: APjAAAWt2ToknVvesKBmOVyby0d2Y8BohfNdUdg9dj8VpK3PHZjAqQmZ
        gCp2tWRZbwamC5UCQy5Plsw1wD+GxiXVPmmYTp0itQ==
X-Google-Smtp-Source: APXvYqyBqb2mf4EIhWTha2V0Nr+epAc/RrG6INwplSgR+9kR5PXgvLBJYF2E1ctg/yS1B7vB6IQcvJkG/kFgqfIavZg=
X-Received: by 2002:a24:292:: with SMTP id 140mr18945217itu.57.1560253945573;
 Tue, 11 Jun 2019 04:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <876aefd0-808a-bb4b-0897-191f0a8d9e12@eikelenboom.it>
In-Reply-To: <876aefd0-808a-bb4b-0897-191f0a8d9e12@eikelenboom.it>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 11 Jun 2019 13:52:14 +0200
Message-ID: <CAJfpegvRBm3M8fUJ1Le1dPd0QSJgAWAYJGLCQKa6YLTE+4oucw@mail.gmail.com>
Subject: Re: Linux 5.2-RC regression bisected, mounting glusterfs volumes
 fails after commit: fuse: require /dev/fuse reads to have enough buffer capacity
To:     Sander Eikelenboom <linux@eikelenboom.it>
Cc:     Kirill Smelkov <kirr@nexedi.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        gluster-devel@gluster.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 1:03 PM Sander Eikelenboom <linux@eikelenboom.it> wrote:
>
> L.S.,
>
> While testing a linux 5.2 kernel I noticed it fails to mount my glusterfs volumes.
>
> It repeatedly fails with:
>    [2019-06-11 09:15:27.106946] W [fuse-bridge.c:4993:fuse_thread_proc] 0-glusterfs-fuse: read from /dev/fuse returned -1 (Invalid argument)
>    [2019-06-11 09:15:27.106955] W [fuse-bridge.c:4993:fuse_thread_proc] 0-glusterfs-fuse: read from /dev/fuse returned -1 (Invalid argument)
>    [2019-06-11 09:15:27.106963] W [fuse-bridge.c:4993:fuse_thread_proc] 0-glusterfs-fuse: read from /dev/fuse returned -1 (Invalid argument)
>    [2019-06-11 09:15:27.106971] W [fuse-bridge.c:4993:fuse_thread_proc] 0-glusterfs-fuse: read from /dev/fuse returned -1 (Invalid argument)
>    etc.
>    etc.
>
> Bisecting turned up as culprit:
>     commit d4b13963f217dd947da5c0cabd1569e914d21699: fuse: require /dev/fuse reads to have enough buffer capacity
>
> The glusterfs version i'm using is from Debian stable:
>     ii  glusterfs-client                3.8.8-1                      amd64        clustered file-system (client package)
>     ii  glusterfs-common                3.8.8-1                      amd64        GlusterFS common libraries and translator modules
>
>
> A 5.1.* kernel works fine, as does a 5.2-rc4 kernel with said commit reverted.

Thanks for the report, reverted the bad commit.

Thanks,
Miklos
