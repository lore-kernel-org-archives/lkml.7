Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD05C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1183E20811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="K5sWZ2dA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbfDXO14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:27:56 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52039 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfDXO1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:27:55 -0400
Received: by mail-it1-f194.google.com with SMTP id s3so6674857itk.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7oP5fT8kwItGkJYmh1HwDmxIPTSBkNNmQFuQY9MvsiE=;
        b=K5sWZ2dAMrxBProSStQH6dmf1gQ0JZFcMF8rxHGftJU9Z08CMj/7iOejnjNkef/5Vx
         rWSYPv2U30R4jVjcVH0IQ4CvhS/zWSeOOauy6R3OirrHvPzYEgK/KWBDuuHJlQOOdurJ
         T+jR1Zh9JMG72H4okNxfdGnJAxQwdEB1M9oa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7oP5fT8kwItGkJYmh1HwDmxIPTSBkNNmQFuQY9MvsiE=;
        b=EnX0reUfqW4+4jDi+ySjqXthBRGSB1GRwVNh9vyj7laYY+B5Eaz0EUJFRWKbjtPbO1
         T6UeFi7OG4Tao/Z8HOj0t1P+2lA10pebTE6+33x6TqXB7peSmK3YcHRzro2P+oX+hY/O
         C0ubFHzVc6o3oCkjTQH9jmT37Lv5d2mibeyFQaeESmQZk+mRxaC11fcwewzKVN6P9qh3
         j/MJrxHrgtzfpORbUCh1PBmFNF4iv/eQf3C1rpNeNrerk8h7OWfYjI4S+Oa+SAEYqpFH
         VUJVrcMAEGKEit4lkDJ/bm+A3TJhic+mED1x/C3JISpG9sagaP/oPI+G5pDgbzS8FAoj
         xnlA==
X-Gm-Message-State: APjAAAXxz3rD+vdeRByiXy1+1KcaKTPWRDND+WOKsbaNEQQmRAXuiQ6P
        2mAVnOiCqFDXdsrq2ZKEXgbOo67zlJiG6c7/xh0flw==
X-Google-Smtp-Source: APXvYqyNenOQH32bqmKHMKtLXUbfZ/rFiwkcVR3Yhj+HadqfFi52N7dC+3X5WV7ErHdcJbvFnlx/789SiZEuFNNfAG0=
X-Received: by 2002:a24:1312:: with SMTP id 18mr6171433itz.121.1556116074814;
 Wed, 24 Apr 2019 07:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190424141411.24418-1-abbotti@mev.co.uk>
In-Reply-To: <20190424141411.24418-1-abbotti@mev.co.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 24 Apr 2019 16:27:43 +0200
Message-ID: <CAJfpegsgfRdN9oAfmFZtr0cDnjdkikCKv_TTvNLLorHr22ERLw@mail.gmail.com>
Subject: Re: [PATCH] fuse: Add ioctl flag for x32 compat ioctl
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 4:14 PM Ian Abbott <abbotti@mev.co.uk> wrote:
>
> Currently, a CUSE server running on a 64-bit kernel can tell when an
> ioctl request comes from a process running a 32-bit ABI, but cannot tell
> whether the requesting process is using legacy IA32 emulation or x32
> ABI.  In particular, the server does not know the size of the client
> process's `time_t` type.
>
> For 64-bit kernels, the `FUSE_IOCTL_COMPAT` and `FUSE_IOCTL_32BIT` flags
> are currently set in the ioctl input request (`struct fuse_ioctl_in`
> member `flags`) for a 32-bit requesting process.  This patch defines a
> new flag `FUSE_IOCTL_COMPAT_X32` and sets it if the 32-bit requesting
> process is using the x32 ABI.  This allows the server process to
> distinguish between requests from requesting client processes using IA32
> emulation or the x32 ABI and so infer the size of the client process's
> `time_t` type and any other IA32/x32 differences.

Thanks, applied.

Miklos
