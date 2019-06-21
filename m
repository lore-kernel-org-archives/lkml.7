Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EBBC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87DB206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfFUOWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:22:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35488 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUOWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:22:24 -0400
Received: by mail-qt1-f196.google.com with SMTP id d23so7101845qto.2;
        Fri, 21 Jun 2019 07:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5PE8+ZmRqaDgbYz+jdvymCbhXbNAet42InIv22KkQoU=;
        b=cRQwEYuZIJQn1GMV8p9rtdpABwtMCcfgobvQT6gdgq7Cu5yrmKmIPr3M62AO8cp2zU
         8dpTXV/BMwc9MTbEEOARsE1aGqUKSuPAa0LwSvcqYGZ5UHmSEZVCw7f49oLAWCjKStpB
         5deqDDapX4SMp+pg1qyqj/0ogBpuTclSe+URc44f76rzhj2I8UJC6sDay64bdN3zoyhS
         ya4/HJPBCaMHiuHQAFxBKt/JqBlSG/EQKYzjmzHIodI0jF+Pva9GB+APwW3szc3+Xy0X
         t8Rwz5ueOGuXyLJeyOrD+9dnwm+X+ztBU0ADJNTF2Uoo3/8HKgpQ5GJAbT2YBh9vJF36
         OeEQ==
X-Gm-Message-State: APjAAAVp7o606G9wz5GXknqM8J7vsUEJ8gXD7pRwJYxonzFkA3jfBlZe
        5Al+eUPf3B7AhF9tHcLNuUOQ+X1pVzORqkjvcE4=
X-Google-Smtp-Source: APXvYqz3TBMq9Z1vELupCLHXwlkzS26b6LIblcvrrh3roMREnWTSham3Z/PLOuj2kZ81P3IeXjjYn+8wNsf1fKYBPRQ=
X-Received: by 2002:ac8:8dd:: with SMTP id y29mr51176855qth.304.1561126943626;
 Fri, 21 Jun 2019 07:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190617124822epcas2p2c93d6cec3b60d08d85f228945d5c7623@epcas2p2.samsung.com>
 <20190617124758.1252449-1-arnd@arndb.de> <3ee91294-044d-9bcd-0c4c-3365c0c97604@samsung.com>
In-Reply-To: <3ee91294-044d-9bcd-0c4c-3365c0c97604@samsung.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 21 Jun 2019 16:22:07 +0200
Message-ID: <CAK8P3a3=5iMx4UEi6pX6AGGsZWHzyiMQRNnUHuA4peZbGQRQZw@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: pvr2fb: fix compile-testing as module
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Mike Marshall <hubcap@omnibond.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 1:15 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
>
> On 6/17/19 2:47 PM, Arnd Bergmann wrote:
> > Building an allmodconfig kernel now produces a harmless warning:
> >
> > drivers/video/fbdev/pvr2fb.c:726:12: error: unused function 'pvr2_get_param_val' [-Werror,-Wunused-function]
> >
> > Shut this up the same way as we do for other unused functions
> > in the same file, using the __maybe_unused attribute.
> >
> > Fixes: 0f5a5712ad1e ("video: fbdev: pvr2fb: add COMPILE_TEST support")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks but I've fixed it already by adding #ifndef MODULE (since other
> functions in the same file using __maybe_unused depend on either PCI or
> SH_DREAMCAST I've preferred not to use this attribute):
>
> https://marc.info/?l=linux-fbdev&m=156050904010778&w=2

Ok, dropping my patch from the local queue, your version is obviously
correct as well.

      Arnd
