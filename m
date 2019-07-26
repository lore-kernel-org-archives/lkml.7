Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92B6C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C050E218DA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BcbB9dYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfGZIwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:52:44 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46823 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfGZIwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:52:43 -0400
Received: by mail-io1-f67.google.com with SMTP id i10so103176163iol.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 01:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ivu7mmuUCBtRCJ9+296IctrbfYNXAVCIQ5a8QkkFxDo=;
        b=BcbB9dYEb6fL2ssaGCJwDjSepgxhHuOJBsItX3hrLsfKUFk5WZgW0heTRA+zC+/9ki
         epLl9ANmgYHGtkc3Uqix9qGThZR50Myd2iSEOnydNe8nrEbh5evDIlUXXLW6hWf+6EwY
         X0n577EY+VzxpMbP8Wy6TqPvogcrYcyOEn6Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ivu7mmuUCBtRCJ9+296IctrbfYNXAVCIQ5a8QkkFxDo=;
        b=Di7on5p4u3dL1azFlPG0dBjAkmuMHN73CFU7ppjMT9Bl6ylGboChegFOixXQ4/vSsp
         l06bNKX2OltojT2/S8h8CfQ/vip4KSMMdgodd21TOg+ew8OJAuym5yTwhOpBh0I3FJHU
         FZiFqgBirp0/P0rNyIh5H60aNQa7immPUt4mmtr6dFPwVRQbzBAXHaJb/2a5cP4B5m1a
         R1nXf6E4J3h5xvJaYPA4opjlZ7HepS+JSMUz1DTxa1D3iIJKGKNmH/xyIxgJOhtBoorM
         RSP9Oxmnvrfw7fl7XHpnCw/VA6Pj4Tj0mVyjK6F7ktHPevIoE24PTD78vIwFCYsdHVBP
         P5yw==
X-Gm-Message-State: APjAAAX255PiSdQ6uK39VSrw3cB5ZRjCtg/p4H2BtH8gQwxT6ZoNSv1X
        e7s4xnthTVX65b6KlG+aEVNfsHlh33/J8VfTnBU=
X-Google-Smtp-Source: APXvYqwi441df8XodqoYa2JUoE1MGP2LwR3hrCQfE9nZyRGKSRipZoxCCSSAFMCVBaT7g2c2hNnccWtVKrkKS61oXVQ=
X-Received: by 2002:a02:ce52:: with SMTP id y18mr92451652jar.78.1564131162681;
 Fri, 26 Jul 2019 01:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <ae19f8ddc770135572323dd431d0efbe3e419582.camel@linux.ibm.com>
In-Reply-To: <ae19f8ddc770135572323dd431d0efbe3e419582.camel@linux.ibm.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 26 Jul 2019 10:52:31 +0200
Message-ID: <CAJfpegsLKY=M6PSBZjgpKkZTxUYBn+H44BxG2HVLsAVzTzyy_Q@mail.gmail.com>
Subject: Re: Question about vmsplice + SPLICE_F_GIFT
To:     Leonardo Bras <leonardo@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 10:33 PM Leonardo Bras <leonardo@linux.ibm.com> wrote:
>
> Hello everybody,
>
> I am not sure if this is the right place to be asking this. If is not,
> I apologize for the inconvenience. Also, please tell me where is a
> better way to as these questions.
>
> I am trying to create a basic C code to test vmsplice + SPLICE_F_GIFT
> for moving memory pages between two processes without copying.
>
> I have followed the man pages and several recipes across the web, but I
> could not reproduce it yet.
>
> Basically, I am doing:
> Sending process:
> - malloc + memcpy for generating pages to transfer
> - vmsplice with SPLICE_F_GIFT sending over named pipe (in a loop)
> Receiving process:
> - Create mmaped file to receive the pages
> - splice with SPLICE_F_MOVE receiving from named pipe (in a loop)

As the splice(2) man page says SPLICE_F_MOVE is currently a no-op.

> I have seen the SPLICE_F_MOVE being used on steal ops from the
> 'pipebuffer', but I couldn't find a way to call it from splice.
>
> Questions:
> It does what I think it does? (reassign memory pages from a process to
> another)

> If so, does page gifting still works?
> If so, is there a basic recipe to test it's workings?

What is the end goal?

It is easy to transfer pages using shared memory (see shm_open(3) and
related API), so why mess with splice?

Thanks,
Miklos
