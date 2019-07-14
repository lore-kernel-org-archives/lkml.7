Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E597C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 22:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3661620C01
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 22:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="fudPfO0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfGNWcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 18:32:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36909 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbfGNWcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 18:32:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so15098222wrr.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 15:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WELgY9IZYEXGTJ8dcs9uLC05/i8dmDlcq9yJsFdpQiY=;
        b=fudPfO0iTEUaJIHyFl+KwryFHmQIfoKmVtcDDtaTwnxI+BlXto9QZTQKlDMZrJ/D9u
         mbbE7gr/8UG68D20ChuLeMi/dIl4uFNxjc9xtmFiv8hE9//fGFAhjIceYdzBQH2s6g1Y
         mRREvHZo+zfJPUCBhmT+JUbFYfY9pqZKZO5Gfk5TUgHEDol9090zwmWe7rptcwa3o/p7
         ZO9Ef8/+TZkzozcCfilPaFxPYGtwSPuFDiYs9QS5awXzTsrWodDHuuxxDAmp3mtSJc/q
         757tL8G05c2nS79lQvBlvIfwi0uNTI+TWbMM26MYheiB6/2H24AKStpItXizlKXzRLoT
         UJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WELgY9IZYEXGTJ8dcs9uLC05/i8dmDlcq9yJsFdpQiY=;
        b=Ir5/pLA6Et4mcBJhJzko2jZrEnU2PGD8g4sJk8qgd/NRgGC6PIPO2iURRmGmIII7BR
         UKU6y0ODdCPFO0qEkqkgwmJOBnNqx6S4Gushf4wpRYCrXj+2++QQKiDx8Ifhs7ps9+y+
         c4w60lI7XrZVvl60jCUw9XNkaowGKVSoyTrSzoT5DX59yp9Des42sZktj3BPBq5AWlL3
         TZ1zfbMQpCjodheOi8rWu6PrxEbiBlqHtF2eiAKSQNIDguzL87JPyal6m/f8jz+/SFwD
         KdX3ZsQdrkU98moJgRy9ZGQUSOApklu325PzNca643a7AWsfy5u4CgT51Bh7+/n3WRvr
         1i4g==
X-Gm-Message-State: APjAAAVUDZ0BOFwm9LwShVLVQt/6gWOKuhUr7Gp24Zrc5tsRuwfaO2Dk
        /ZokvkjPE9QTDkYpYF5+PBA=
X-Google-Smtp-Source: APXvYqxyNXfeIVr7FkVtIjyU3xfz0nXSOFLYp6SOFNkXpMgTB/CtXKbUrlJaL6lGJ3NUgJ93t4uNYQ==
X-Received: by 2002:adf:fa42:: with SMTP id y2mr4609759wrr.170.1563143550495;
        Sun, 14 Jul 2019 15:32:30 -0700 (PDT)
Received: from brauner.io ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id l25sm11547785wme.13.2019.07.14.15.32.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 15:32:30 -0700 (PDT)
Date:   Mon, 15 Jul 2019 00:32:29 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, mchehab+samsung@kernel.org
Subject: Re: [PATCH] MAINTAINERS: add new entry for pidfd api
Message-ID: <20190714223228.f32lkszztbuencbn@brauner.io>
References: <20190714193344.29100-1-christian@brauner.io>
 <8dbfa2d12bb0c76a19f46128af083921c8feb562.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8dbfa2d12bb0c76a19f46128af083921c8feb562.camel@perches.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2019 at 03:10:06PM -0700, Joe Perches wrote:
> On Sun, 2019-07-14 at 21:33 +0200, Christian Brauner wrote:
> > Add me as a maintainer for pidfd stuff. This way we can easily see when
> > changes come in and people know who to yell at.
> []
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > []
> > @@ -12567,6 +12567,18 @@ F:	arch/arm/boot/dts/picoxcell*
> >  F:	arch/arm/mach-picoxcell/
> >  F:	drivers/crypto/picoxcell*
> >  
> > +PIDFD API
> > +M:	Christian Brauner <christian@brauner.io>
> > +L:	linux-kernel@vger.kernel.org
> > +S:	Maintained
> > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
> > +F:	samples/pidfd/
> > +F:	tools/testing/selftests/pidfd/
> > +K:	(?i)pidfd
> > +K:	(?i)clone3
> 
> These seem fairly specific without false positives.
> 
> > +K:	\b(clone_args|kernel_clone_args)\b
> > +N:	pidfd
> 
> This one I'd suggest using 2 F: patterns instead
> as the patterns are more comprehensive and do not
> use git history when looked up with get_maintainer

Just to clarify, you suggest removing N: pidfd and just leaving in the
two F: patterns for samples/pidfd and tools/testing/selftests/pidfd/
below?

> 
> F:	samples/pidfd/
> F:	tools/testing/selftests/pidfd/
> 
> 
