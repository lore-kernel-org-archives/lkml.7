Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE99C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6D121872
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390770AbfGRP1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 11:27:35 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43879 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRP1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 11:27:35 -0400
Received: by mail-qk1-f196.google.com with SMTP id m14so20717044qka.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 08:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=97JpaqZJUw6kOHercdAb+lo0dDWCEEL1RlsGMmUyUJQ=;
        b=tWJgr62KjtHPGUkyoVPZXKxBecZxa2nYe+IAyitW4DcGEA+SBcnVFSUx2M/nKeheUh
         vQoRxzO0KKZgwSveJzrsHiei6CPa4kpcVzgju5BdPphz4i1ySIDRWIZI5ssoWPYhl7Q9
         P1L9/EPn9EpV4OaYKEARqmnj+H9HY3AmEez/hSkcrrolscW26wJzlpLB+3IdFAEf5/FK
         tOQSJKfDm89WGoIUt3pnKLBJhsCy0TVKSfOk67KIvsLkJzKr+KUa4z2Cywvezi30JVYd
         AP+oT78Ii0UXB7a/n/ZikcuS5wq84E9nNQRcRzV1qQnrElDb5ndpNO3Dm63Irv5CK4Oz
         aCMg==
X-Gm-Message-State: APjAAAXjGNdR6cENuuX6hWOsHnlv6fnXW/Md0qAbxxEQls2KBYPbhHjY
        yBKWkmOxLR2gIy/ei3YQyibRjpW/9SE1SP6z1lw=
X-Google-Smtp-Source: APXvYqxCIjZHXKpNfPhDaPyGIIjSTqwDj1CDG3aJkAn737qQb0zmMiuJqk6Oo2xG5QZIRkFASljYqsiIXCBl020X4vI=
X-Received: by 2002:a37:4ac3:: with SMTP id x186mr30135208qka.138.1563463654235;
 Thu, 18 Jul 2019 08:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190718134253epcas3p32a5afece52c47aaac0cd5795ff4cf022@epcas3p3.samsung.com>
 <20190718134240.2265724-1-arnd@arndb.de> <ea59751e-7391-e3e9-bb46-00e86b25f1a8@samsung.com>
 <CAK8P3a0q5xmi+mCvb1ET4d1uQmbnw+J2VkjRCzjemCXGy+5OBg@mail.gmail.com>
 <7da08013-5ee0-1c39-e16b-8b6843a28381@samsung.com> <CAK8P3a2nYArwNQrifW2xgzN=GUkN2wAjmZVo21JNw6YjHzwh7Q@mail.gmail.com>
 <CAKdAkRS0w3KM-F95-F1jUicq2srAzWu21_7Npnw28F5fF+UxtA@mail.gmail.com>
In-Reply-To: <CAKdAkRS0w3KM-F95-F1jUicq2srAzWu21_7Npnw28F5fF+UxtA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 18 Jul 2019 17:27:18 +0200
Message-ID: <CAK8P3a2O9jaV=EfCLp=_X1wW6yAB9_cSGfMUBwFHjS+1x76yPg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: fix RC_CORE dependency
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Ronald_Tschal=C3=A4r?= <ronald@innovation.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 5:17 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Jul 18, 2019 at 6:13 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Jul 18, 2019 at 4:56 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> > > On 18.07.2019 16:21, Arnd Bergmann wrote:
> > > > On Thu, Jul 18, 2019 at 4:16 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> > > >> Proper solution has been already merged via input tree[1].
> > > >>
> > > >>
> > > >> [1]:
> > > >> https://lore.kernel.org/lkml/CAKdAkRTGXNbUsuKASNGLfwUwC7Asod9K5baYLPWPU7EX-42-yA@mail.gmail.com/
> > > > At that link, I only see the patch that caused the regression, not
> > > > the solution. Are you sure it's fixed?
> > >
> > >
> > > Ups, you are right, I though you are fixing what this patch attempted to
> > > fix :)
> > >
> > > Anyway, we want to avoid dependency on RC_CORE - this driver does not
> > > require it, but with RC_CORE it has additional features.
> >
> > Right, that's what my patch does: if RC_CORE is disabled, you can
> > still set DRM_SIL_SII8620=y, but if RC_CORE=m, DRM_SIL_SII8620
> > can only be =m or =n.
> >
> > > Maybe "imply INPUT" would help?
> >
> > No, that would make it worse. Device drivers really have no business
> > turning on other subsystems.
> >
>
> OK, in the meantime I will redo the branch by dropping the
> sil-sii8620.c Kconfig changes and also drop all "imply" business from
> applespi driver as they give us more trouble than they are worth. We
> do not have "imply" for i801_smbus for Symaptics SMBUS mode and it
> works fine. It it distro's task to configure the kernel properly.

Thanks!

I think the "drm/bridge: make remote control optional" patch is
fine with my fixup, the IS_ENABLED() checks take care of the
case where RC_CORE is unavailable, and the 'depends on
RC_CORE || !RC_CORE' line takes care of the RC_CORE=m
case.

I suppose Ronald could send a replacement patch with my
fixup after the merge window.

      Arnd
