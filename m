Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CEBC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3973208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfFSFUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 01:20:30 -0400
Received: from mail-ua1-f54.google.com ([209.85.222.54]:42148 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfFSFUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 01:20:30 -0400
Received: by mail-ua1-f54.google.com with SMTP id a97so8458598uaa.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 22:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k0PXc5nauUb4o3lsnx5Ny3+HWZRzLpYvPScpFb82/ck=;
        b=Hy94K/l1LhCMhuveTHnfhrJecHpfBb2pH8mIRv3nrJvplcZJ2i2mwy+JrAlj3VO+53
         JsczCrehocZpE0H6ZQ6bTwNihCg0cvPGF8RlYGecPdICgOP7s1zdYfk5mzNbwkJZSlFy
         RM7kWhp9p8CtENx3J2iKN5JPE69CnxAfR5OTbuQtm2O1bLL3SiVSnSE7XUKBTqtq9IjR
         jLisTuWYi5zYJ6fIw8GUrT2H4Wbyk1tjZ26TorE4gAm27tRw8De0PmYR1a/RI1O81e+8
         anHGIlhzFt8v2FoAoiVWI9PyxUmQSbJnFbHbtu34kLSf8eV9cI8kW7t3mWRP4gCt8XoK
         /N1Q==
X-Gm-Message-State: APjAAAV25mmOOBAWuuc+HW9DFiANqMPo+pztwXGPZ4HRhbpRy3RLb0c9
        6LYfxCyNiPPe5cIP2yRfqrV7+OPWlQUjseArFuU=
X-Google-Smtp-Source: APXvYqwRf/92/Ddb/2Bf0CEDUV+3cymdzw6KRPCQW0cUpqPq5iMiVwt1kNX1Y0ekGtWsdMUxoCjbkmMVKH8avR8MfbI=
X-Received: by 2002:a9f:31a2:: with SMTP id v31mr13080252uad.15.1560921628950;
 Tue, 18 Jun 2019 22:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190614024957.GA9645@jagdpanzerIV> <20190619050811.GA15221@jagdpanzerIV>
In-Reply-To: <20190619050811.GA15221@jagdpanzerIV>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Wed, 19 Jun 2019 01:20:17 -0400
Message-ID: <CAKb7UvhdN=RUdfrnWswT4ANK5UwPcM-upDP85=84zsCF+a5-bg@mail.gmail.com>
Subject: Re: nouveau: DRM: GPU lockup - switching to software fbcon
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 1:08 AM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> On (06/14/19 11:50), Sergey Senozhatsky wrote:
> > dmesg
> >
> >  nouveau 0000:01:00.0: DRM: GPU lockup - switching to software fbcon
> >  nouveau 0000:01:00.0: fifo: SCHED_ERROR 0a [CTXSW_TIMEOUT]
> >  nouveau 0000:01:00.0: fifo: runlist 0: scheduled for recovery
> >  nouveau 0000:01:00.0: fifo: channel 5: killed
> >  nouveau 0000:01:00.0: fifo: engine 6: scheduled for recovery
> >  nouveau 0000:01:00.0: fifo: engine 0: scheduled for recovery
> >  nouveau 0000:01:00.0: firefox[476]: channel 5 killed!
> >  nouveau 0000:01:00.0: firefox[476]: failed to idle channel 5 [firefox[476]]
> >
> > It lockups several times a day. Twice in just one hour today.
> > Can we fix this?
>
> Unusable

Are you using a GTX 660 by any chance? You've provided rather minimal
system info.

  -ilia
