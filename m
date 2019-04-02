Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F2DC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB1E20674
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdMOtM1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfDBVAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:00:13 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35509 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfDBVAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:00:13 -0400
Received: by mail-oi1-f196.google.com with SMTP id j132so11751641oib.2;
        Tue, 02 Apr 2019 14:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1veYunazujK1FLlyRHHMR2aodw9HVx727e20SwJtXRA=;
        b=cdMOtM1ehqH15UxljvotUv36NW53Ne4kVY+GG4P0xg7k6bKvNp7QaQJfiWOEiZzVwa
         TV+cEBDOxDQoiwDYSxEYUdYsRln/HBCVbr+Z02f0KUtdKyUuuaDGvy8Jn0/+ndOA5gkd
         /lmSpPfFH2kGEfL2QQkXEHlaN+2aTJE0mP3LY3yZfVmyTPzvC0K2OvrocXTpG/L7A8Bf
         pEqBdv32qVBss9FbCuBqoX75ZgFQ48wzDC81pJTxa4orp0ERXcIp0GWfcTMsbDbedU9K
         j1lpJleOkAnyUUk6UMkGczzLG1wtjwR3L/XDz1K1sKoxdfDEXdnfoxlEAlCzrGR8B1jw
         +EAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1veYunazujK1FLlyRHHMR2aodw9HVx727e20SwJtXRA=;
        b=B93luhg10lOC1RO1hh0K9D9fa4WrF2DEWvibL/MXPwMTiM55oJuY0DMFuIAt0RvCor
         hQFxVEI0XpU5qU+ycWr5zYTSPNhv8xyLz8WrncY2ciLgK6RNAO47xa7Pe5B2khOhePcH
         HWeWWwUfP9eMTGhkLcA/rGDP+ekEkn6Q/AltFyIQs38v1FZ7yx4/U675KF9pHDyTHP5V
         Rqyfb/QQF6Jfle2rS8Ww8dAkeQ17GjovG24LVbzd5XbIf20KSs9hYCy32+8Bir607VcY
         IRaPQfwcceaPZC/1IOk9oQEF57L5ywi3IMu832JJoAmq+8Ra6tnDdPI6SjX5RS3a/q8p
         ofkg==
X-Gm-Message-State: APjAAAUzXSifkG2iojiFg2fe1mYGhnP1OrTKJ3rpSTEBRM5ex3etdmDT
        qQRIezB4bifQB4s1JT820VSfeSS2hUE2z85bNgg=
X-Google-Smtp-Source: APXvYqyq3e1yPU2ElPWORU/59F4YKtee495blbbV1R+uKllyKJ0B54h/PXR4CJmcRyMczO4wF1H6pR4tlXws00zxTDg=
X-Received: by 2002:aca:d9c4:: with SMTP id q187mr8953848oig.91.1554238812653;
 Tue, 02 Apr 2019 14:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190322051759.15007-1-tomli@tomli.me> <20190322051759.15007-5-tomli@tomli.me>
 <20190331183333.kpyt2hm5iy6m5u34@debian> <20190401164158.GC15736@localhost.localdomain>
In-Reply-To: <20190401164158.GC15736@localhost.localdomain>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Tue, 2 Apr 2019 21:59:36 +0100
Message-ID: <CADVatmMt6Au2pGETZoKc3W9nz9ys9Up=KvsA8P0YzyUCyEDDww@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] fbdev: sm712fb: add 32-bit color modes, drops some
 other modes.
To:     Tom Li <tomli@tomli.me>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        LFBDEV <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 5:42 PM Tom Li <tomli@tomli.me> wrote:
>
> On Sun, Mar 31, 2019 at 07:33:33PM +0100, Sudip Mukherjee wrote:
> > Why are you removing existing functionality from the driver? These are
> > supported but were never listed so could not be used. I think you can
> > just add these to vesa_mode_table[] and they can be used.
>
> If there are some "functionalities" in a system, but they are never used,
> even worse, they are programmed in a way that they cannot be used by any
> user no matter what, meanwhile not a single user had filed a bug report
> in the entire lifecycle of the program, then I'd call them "dead code",
> that serves no useful purposes, rather than "functionalities". I think
> most kernel developers can agree on this.

I think I will call that as a bug, a bug which did not export the
configuration and so it was not used. But, now that we know of the bug
we should fix the bug instead of removing the configuration.

>
> > I have an old CRT in India which supports 320x240 mode and can test there
> > when I am there next.
>
> Well... If someone (e.g. you) do see a need of this feature, then fixing
> them (instead of removing them) becomes a reasonable choice.
>
> Coincidentally, I've also purchased a video converter a few days ago. Please
> allow some time for me to testing it, so I can see if they're working. If so,
> I'll add them to the vesa_mode_table[] in PATCH v3.

Thanks.


-- 
Regards
Sudip
