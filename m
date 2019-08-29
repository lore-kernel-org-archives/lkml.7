Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896DDC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1F820644
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CQYTV7T/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfH2Or3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:47:29 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34897 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbfH2Or3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:47:29 -0400
Received: by mail-io1-f68.google.com with SMTP id b10so7494354ioj.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 07:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7kmZfKphmPDJyPhB1aEwSutJQo/nVZHIpGqlV62NkC0=;
        b=CQYTV7T/6dptI2gBfu2uXwU4RqC1UIrULXwa1LcNs212HPvwiKRj5wzH9w17HNj1/S
         xgABLrdaMQrQKih8MZ3en05XSPZ6cYtpvN8zEPBJT0wL6K+HI44uIDZofAFjGDHjjwcZ
         LWo+0RcMIe0icmrDfhi9RpZ6cZJmo1ANKTqLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7kmZfKphmPDJyPhB1aEwSutJQo/nVZHIpGqlV62NkC0=;
        b=fO8x9r6O5ABMnSPS2VAlI6l5UdbXcpNnyiR+8ZHtwK0ha8GYNoKMa3acGCsPvHbNbJ
         6gMi487Fo3SOaFpkXwW7UDvyWvQpT+7QK4XM17A2o++8X6n6gken+wXcp3n22FWq71iL
         /ApXbjxkhG5PYgfXJbj8DnyO4dAHgLmXwQT8ChuE1Ng8a58q5yR89MgpiZVDofhqUALw
         s5Mqoizu9lI5DKyGI9eu5qm4LyUXiUHQx1x9SUVIHAh+R6HaQrt2tiE57XREBGSW7xD8
         FBMX/gEfgSYT97UV7ojyfNKQ6NbfKKtlaT1n5tB7lI1RCQg19VtwcKzNnrikPgHA5JH9
         /k+w==
X-Gm-Message-State: APjAAAXqEAutth9fD2qB27mI/ar/aQIEe/EzXy7Rk8pao7mtSLj7ZaU/
        8uyclQTwEFzIrXvOVktZ/v7Cxq3JLRIE0HzLrkYIyQ==
X-Google-Smtp-Source: APXvYqzC9sQXggpAZSpx4nKtBi8MjQ5jIGvf78c61EYJdJ7tngwSYacvoloREplBdZk2eAZlmMR9aiBXIUXMXSL2oBM=
X-Received: by 2002:a05:6638:627:: with SMTP id h7mr11129076jar.33.1567090048417;
 Thu, 29 Aug 2019 07:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190821173742.24574-1-vgoyal@redhat.com> <CAJfpegv_XS=kLxw_FzWNM2Xao5wsn7oGbk3ow78gU8tpXwo-sg@mail.gmail.com>
 <20190829132949.GA6744@redhat.com> <CAJfpegtd-MQNbUW9YuL4xdXDkGR8K6LMHCqDG2Ppu9F_Hyk2RQ@mail.gmail.com>
 <20190829143107.GB6744@redhat.com>
In-Reply-To: <20190829143107.GB6744@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 29 Aug 2019 16:47:17 +0200
Message-ID: <CAJfpegtOC8dHofLmpYpryKv9+93KHwn9Xb-NCyvgg0rG8XspTw@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] virtio-fs: shared file system for virtual machines
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 4:31 PM Vivek Goyal <vgoyal@redhat.com> wrote:

> Cool. That works. Faced another compilation error with "make allmodconfig"
> config file.
>
>   HDRINST usr/include/linux/virtio_fs.h
> error: include/uapi/linux/virtio_fs.h: missing "WITH Linux-syscall-note" for SPDX-License-Identifier
> make[1]: *** [scripts/Makefile.headersinst:66: usr/include/linux/virtio_fs.h] Error 1
>
> Looks like include/uapi/linux/virtio_fs.h needs following.
>
> -/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */

Fixed and pushed.

Thanks,
Miklos
