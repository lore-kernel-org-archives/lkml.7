Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C743BC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9C220873
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u/7F3yeE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388886AbfJDOHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:07:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52301 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388376AbfJDOHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:07:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id r19so5998956wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 07:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=A0tzZseII5xzIl9YCNKonWwWH+g7D6y/11SCn90fFa0=;
        b=u/7F3yeEkzbmYPJdYJn3nRYRckHjBCQ/LmlWRUSYF9lyEOSHzRjcawwke4+jFXVLUT
         kHsbcb5/E/yHItCsd/pfddSmHrr66hfrm7S92SnviPG8VNIdXeoic245Jt6SJbS34P0W
         bteXozhw8aTWpbHKm7zmDgLZAqVyK8BlaNN3u6JrK7l+vtdRDZa8KtFAVn4DaY5/q38i
         01oVyZbK8k6hERzBywOCoP2bEkUe99K29/EeOxIqxWHVfSvpgS+rEnXc99i/D/I9FueC
         yTBX6S5geM6Ca81yhK8au3IDpY0W2ioZFjCYUFZRm14fhgJEMx8xWXpkB21jB6AuvCR6
         nPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=A0tzZseII5xzIl9YCNKonWwWH+g7D6y/11SCn90fFa0=;
        b=a11pzRc2mzAYEWcjK0srkyDF+ZCgtVobGhwaetxn7R7NTeLi3vPOzsFZHW86myGhuu
         DZe66wBgccqQFFKSa/p6ETRy5PGpxyNoNQ7f7dpmSOn98xQx6xHLPWtNagWZAJ+Pn6eL
         HjG/drxO7qFCiGxX/+5BMIONfIEt36Ius+YkT466TAPva3BLbJNfRx4W/tiOGQ36i2rB
         eSLj/hM9G+eifK6BZtLxBidhPPjgu2A+2pdYhtqgLCDKhTrc4ZQyG5RW9UEJUvBvau1u
         hFplLHAUYqh96BjIwnXiRve4PZ1ECfPIPJ3ppb6YcMIgiVy3Xo5EAhOXVR+IfKhPmHJG
         a0dA==
X-Gm-Message-State: APjAAAUj9Bn++0/DCkysGp3ipSETekttmZhtnyqFSpcVjJ4oa+2GeNdc
        tQbusuiaMQ1+NOTjPfBlqvun+A==
X-Google-Smtp-Source: APXvYqwK7+3XZzG9HhNAdrLbxuLF7sxCmgoMIkqzIGlV1kFiPlSv6FGn0BRxH07QIGRB7Ylj6B44dA==
X-Received: by 2002:a1c:5411:: with SMTP id i17mr10885330wmb.170.1570198071459;
        Fri, 04 Oct 2019 07:07:51 -0700 (PDT)
Received: from dell ([2.27.167.122])
        by smtp.gmail.com with ESMTPSA id a3sm9658820wmc.3.2019.10.04.07.07.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 07:07:51 -0700 (PDT)
Date:   Fri, 4 Oct 2019 15:07:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-input@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 0/3] mfd: mc13xxx: Fixes and enhancements for NXP's
 mc34708
Message-ID: <20191004140749.GH18429@dell>
References: <20190909214440.30674-1-lukma@denx.de>
 <20190930095159.64e1001a@jawa>
 <20191001064130.GA11769@dell>
 <20191001101909.79aacda0@jawa>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191001101909.79aacda0@jawa>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Oct 2019, Lukasz Majewski wrote:
> > On Mon, 30 Sep 2019, Lukasz Majewski wrote:
> > 
> > > Dear Lee,
> > >   
> > > > This patch set provides several enhancements to mc13xxx MFD family
> > > > of devices by introducing mc34708 as a separate device.
> > > > 
> > > > This IC has dedicated pen detection feature, which allows better
> > > > touchscreen experience.
> > > > 
> > > > This is the fifth version of this code (v5).
> > > > Discussion regarding previous versions can be found here:
> > > > https://lkml.org/lkml/2018/4/12/351
> > > > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1661934.html
> > > > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1664296.html
> > > > https://lkml.org/lkml/2019/7/17/705  
> > > 
> > > Gentle ping on this patch series. It is now 3 weeks without any
> > > reply...  
> > 
> > Please take note and follow the kernel release cycle.
> > 
> > These patches were sent after the release of -rc7 i.e. very late
> > in the release cycle and a point where most kernel maintainers stop
> > reviewing/applying patches
> 
> Maybe something has changed recently, but I thought that the review is
> an ongoing process (that the discussion about patches takes place all
> the time to refine the code).
> 
> (and nobody expects maintainers pulling new patches after merge window).

Nothing changed recently.  Some maintainers will review just before
and during the merge windows, others use the time to prepare their
branches for submission and welcome the break from reviewing during
this time.  Either way, please do not *expect* a fast turn-around
during in this period of the cycle.

> > and start to prepare for the impending
> > merge-window.
> > 
> > Also, there is no such thing as a gentle ping.
> 
> I'm a bit puzzled now. 
> I do know that maintainers are overworked - and I do understand that.
> 
> However, NO reply for such a long time is at best confusing for
> somebody who is willing to fix the kernel.

If you respect the merge cycle, you will come to expect a short delay
at the end and during the merge-window.  Please also understand that
Maintainers also take vacation, attend conferences and have other work
to attend to.

> (Maybe this has changed too - but I do remember that there was a "rule
> of thumb" to express any comment about the patch in 2 weeks time).

Same rule of thumb applies.  If after 2 weeks you have not received a
review, feel free to send a [RESEND].  However, bumping threads with
contentless pings is considered bad form.

As an aside, I (and others) conduct reviews in batches and in
chronological order (first come, first served) of how the mails are
represented in my inbox.  Thus, if you bump a thread, it goes to the
back of the queue.

> >  If you genuinely think
> > your patches have unlikely("slipped though the gaps"), then post a
> > [RESEND] complete with a note alluding your reasons doing such.
> > 
> 
> Please forgive me, but are patches from this series eligible for pulling
> (to v5.4 or even next release)?

v5.4-rc1 has already been released.  No new functionality will hit
v5.4.  We have around 6-7 weeks to agree on acceptance for this set
for them to be eligible for v5.5.

> > > > Sascha Hauer (3):
> > > >   mfd: mc13xxx: Add mc34708 adc support
> > > >   input: touchscreen mc13xxx: Make platform data optional
> > > >   input: touchscreen mc13xxx: Add mc34708 support
> > > > 
> > > >  drivers/input/touchscreen/mc13783_ts.c | 63 ++++++++++++++---
> > > >  drivers/mfd/mc13xxx-core.c             | 98
> > > > +++++++++++++++++++++++++- include/linux/mfd/mc34708.h
> > > > | 37 ++++++++++ 3 files changed, 185 insertions(+), 13
> > > > deletions(-) create mode 100644 include/linux/mfd/mc34708.h  

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
