Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71922C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF0E2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvlEAYgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbfFSFse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 01:48:34 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:39690 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfFSFsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 01:48:33 -0400
Received: by mail-pg1-f170.google.com with SMTP id 196so9007883pgc.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 22:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vRg33IzeZ7gCOlL1rfll5ZpLs+PXtNmVRt29cMs9Ajc=;
        b=jvlEAYgQ6zuc/XSMlLEyWt5CEKHcyEO5ngn7/7JaxQxZarajMzxweS/Q/5RU6m6ja0
         b/MLx3TAsLCqLAkLlrPn0+bzP+c9BHhgIttJIPg6kU8Tbn6GAQ0IBI3b4Nh3dmaLZzsS
         YhwE7j1sl/UqisvUCFuolR8siBYAtY3W9VkavTzO6uOWq/dvbHvZfPGHQ4tZPHDamSj2
         FUMpdfQbRL5RO01O90pBewn74uFHOzqwo1Lw+qLEYpb8r3skVKi+oYMq7QFBZ4IHSfJI
         8nF059Gxn3zgoE+Vx2RPD1fiMRg/dlU++1m4QemPqEUCunBdQUBu2ne9B9orpj19d82J
         gaww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vRg33IzeZ7gCOlL1rfll5ZpLs+PXtNmVRt29cMs9Ajc=;
        b=WuI5qCVKlfh2p/liQ+ZMmcrOFbsKJkPbpMzeHgT5RCsHW9+1lBnV85JbgwC0nc/z9H
         nGu/Bxy8WJX7FM7ZNsKFLsu/lBzRJXyECk4CXwxF8c1KZGBaHQ8UbefABWxGkAFl+ISq
         +pJw4sxh4v2OFbYrGJNfghRwPDcpHBTx9MkRIs/GvTZgZO9xm0U32yHSP0xPxKm88g9m
         Osuucp6QPCdDGqY93Eo8lkZ3aNrvbhpY6ibTOv42TgtEAw0nU1aIvdeBYhqFTSY2gCQg
         GUJbd4sLveNNi3MP1SaeU1ULfAzkVMqQ36gRfM37AyuaSTBRy4EqppDjOj9nqdkipLDc
         ed+A==
X-Gm-Message-State: APjAAAWUjvLrA7AASdWj9p0Ix0izorSH7tcyR3MxVAhclx3MEI8xNN5c
        Uct2qNrT7FEgW4vE14aS6Yc=
X-Google-Smtp-Source: APXvYqxIrkvJkpuuCUfCLmGtf+uSzSyTMm722+WFRYk41A34FHPZZZZLFplSLkkrVJXx+p9f7yrzNA==
X-Received: by 2002:a63:ca0f:: with SMTP id n15mr5914157pgi.197.1560923310824;
        Tue, 18 Jun 2019 22:48:30 -0700 (PDT)
Received: from localhost ([175.223.10.253])
        by smtp.gmail.com with ESMTPSA id y21sm13843971pfe.172.2019.06.18.22.48.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 22:48:30 -0700 (PDT)
Date:   Wed, 19 Jun 2019 14:48:26 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: nouveau: DRM: GPU lockup - switching to software fbcon
Message-ID: <20190619054826.GA2059@jagdpanzerIV>
References: <20190614024957.GA9645@jagdpanzerIV>
 <20190619050811.GA15221@jagdpanzerIV>
 <CAKb7UvhdN=RUdfrnWswT4ANK5UwPcM-upDP85=84zsCF+a5-bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKb7UvhdN=RUdfrnWswT4ANK5UwPcM-upDP85=84zsCF+a5-bg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/19/19 01:20), Ilia Mirkin wrote:
> On Wed, Jun 19, 2019 at 1:08 AM Sergey Senozhatsky
> <sergey.senozhatsky.work@gmail.com> wrote:
> >
> > On (06/14/19 11:50), Sergey Senozhatsky wrote:
> > > dmesg
> > >
> > >  nouveau 0000:01:00.0: DRM: GPU lockup - switching to software fbcon
> > >  nouveau 0000:01:00.0: fifo: SCHED_ERROR 0a [CTXSW_TIMEOUT]
> > >  nouveau 0000:01:00.0: fifo: runlist 0: scheduled for recovery
> > >  nouveau 0000:01:00.0: fifo: channel 5: killed
> > >  nouveau 0000:01:00.0: fifo: engine 6: scheduled for recovery
> > >  nouveau 0000:01:00.0: fifo: engine 0: scheduled for recovery
> > >  nouveau 0000:01:00.0: firefox[476]: channel 5 killed!
> > >  nouveau 0000:01:00.0: firefox[476]: failed to idle channel 5 [firefox[476]]
> > >
> > > It lockups several times a day. Twice in just one hour today.
> > > Can we fix this?
> >
> > Unusable
> 
> Are you using a GTX 660 by any chance? You've provided rather minimal
> system info.

01:00.0 VGA compatible controller: NVIDIA Corporation GK208B [GeForce GT 730] (rev a1)

	-ss
