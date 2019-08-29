Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1699EC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D875D2339E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BdfA7qON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfH2Nlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:41:40 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36507 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfH2Nlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:41:39 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so7003137iom.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 06:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ul0ttpZX8OaU+EBmALZ96xYYyCTstLYpC4GnYFarZNw=;
        b=BdfA7qONrUsx4A59nrxQQRxyjZMRkrGbqIPEVHms5IqmXTPPwE1mOuiPUmLjh3idfb
         qaC5Ifvf8wMelanxFTmnu/IIA21Q8dVP2kH44Urk3sHVXB1taDT3p9kO0Bf0wtJn8NPb
         33QKwni3K68F/+upvxd3jimKoGWOkSBUfSxu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ul0ttpZX8OaU+EBmALZ96xYYyCTstLYpC4GnYFarZNw=;
        b=jcXHpHCZiz3tbe0o1iBp5ixmzO4dH46WbG1LYGQuQFT5FvRKUGaUXXDWnC72OxxbYx
         PrspY5Oq7+fACb56V/iipNrA6KL++c9g+oTM5N08wyxnLiv4gDDEKq6V9thfhqN3gCnX
         5UnJI5OvgTl6ncY0Xilj52k+E1LSPqDmGU7n4BE3G0VCGiuuKCKPO4MnM2lj55HnMd7l
         +Scyc1VVWCebCWTYzvIvyTIXaPgQ//54cYVZg+IcAmIQs6x7xVqL8LK9X8GPpTE3SohT
         wnIpcTKI1ylDLatFE7a4zvf5aJzyOgTUrPLRgvFMac7Ms++SZ8TqYp7d/4qHxri7YYwZ
         f5YA==
X-Gm-Message-State: APjAAAWqS5QAZ1jj9tUwhu4+kLCN0ibe+gIIGQOvYxQLENkRyR67z6Cf
        uxA5SeuXWzuwREul5rP/z7oSOV//2WJTnCAc1crhwA==
X-Google-Smtp-Source: APXvYqxfpG+jMqi5qihZJi9IHh9FiDX9js/5q0ycE73tZwZBFFnEG8Lz+l/93G/VZExz+enUcOKKN0q3BCm8e/kHvME=
X-Received: by 2002:a5e:aa03:: with SMTP id s3mr3381601ioe.212.1567086099021;
 Thu, 29 Aug 2019 06:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190821173742.24574-1-vgoyal@redhat.com> <CAJfpegv_XS=kLxw_FzWNM2Xao5wsn7oGbk3ow78gU8tpXwo-sg@mail.gmail.com>
 <20190829132949.GA6744@redhat.com>
In-Reply-To: <20190829132949.GA6744@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 29 Aug 2019 15:41:26 +0200
Message-ID: <CAJfpegtd-MQNbUW9YuL4xdXDkGR8K6LMHCqDG2Ppu9F_Hyk2RQ@mail.gmail.com>
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

On Thu, Aug 29, 2019 at 3:29 PM Vivek Goyal <vgoyal@redhat.com> wrote:

> #ifdef CONFIG_VIRTIO_FS
>         /** virtio-fs's physically contiguous buffer for in and out args */
>         void *argbuf;
> #endif
>
> It should have worked. Not sure why it is not working.

Needs to be changed to

#if IS_ENABLED(CONFIG_VIRTIO_FS)

Pushed out fixed version.

Thanks,
Miklos
