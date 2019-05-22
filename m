Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78340C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E00520881
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjykhJul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfEVQHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:07:45 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:35902 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbfEVQHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:07:45 -0400
Received: by mail-wr1-f49.google.com with SMTP id s17so2963198wru.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 09:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YSj064d0hw3SYGGx1dV9qIMu4XfaHheFcrqbd4pDwRI=;
        b=NjykhJul2wXEorqygAyXvtescUMOllr4pPxlWg1DqvfpY5+N13ZlQ43we/yQgTbTC2
         UoUoyEEWvXq4bj6zqGAUbmDjwbbbj2e1GLZ8NGZLgKD5KWX8gs2bkzbW+pHoNeWHz3Ik
         /b+jMRati3vF6txN+v+n14Hay5sXQjLo77JDKWuLNXta9Bw5jIcHKauoe8hprr297EnD
         /G6YS4sjV9kEPk0lpkAUXY75oq3yn+1y0q96IoczX3vyloXvJN//Ns2Ytlc0WMBhidfK
         ovOfXaxno5DlqZyDbkJ++UvhniTVHMaOjZpDvgdL5OFYJHNqz3CCIs1TEZPhcZMBRtFM
         FKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YSj064d0hw3SYGGx1dV9qIMu4XfaHheFcrqbd4pDwRI=;
        b=RJbOAQ21d09riFo3hcHUk3SzspUcLxHab2BdAUSDjniKZ9KHqYpHBqscc8OEd+Zw0+
         /Jf9F5DDn9a2c3BkRaUshZtCscsiqTHSMb7B2lMmFZHyD42r4OuN9OKzLfgW88EkfZ6h
         LaGhsBDnZL0Ra040AgUH5dopVCm85OyYPuXOwCPngwyVZicYAaIiJn97xcHhne5WuZLu
         P38nugqJB8GRmxpbKwz6Gz5lmR+xABdSeX8EWhJjGlBQsFMQtziSFZA4tDLCqpPtQPCm
         ZEFPNQRpCJO8lcT7h51Fggldjz59vZEvTwtyI/0DUyRHgXUNYqaIxqy9GVpUlIoobavw
         WbWQ==
X-Gm-Message-State: APjAAAWoBDjOMV1v6fZxbE87mVgAhkm/LvAzqHyHZbfl6IwE0I0xosfo
        nsvEk3+lpjlxzO82E8IOVHwKla0GfAywKcPE/C0=
X-Google-Smtp-Source: APXvYqydeMqeOfwRlypdIh18rqsQg5TVyAGeV9ovPh4f+qKh1jzYeUgKuuFHqHoCP8zKFSkKJ2BanZN9xS3DKlT+TDA=
X-Received: by 2002:adf:ce8e:: with SMTP id r14mr42676957wrn.289.1558541263503;
 Wed, 22 May 2019 09:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
 <199564879.15267174.1556199472004.JavaMail.zimbra@redhat.com>
 <CA+bK7J7tHOkz5KMVHpaV1x_dy6X6A7gtxcBYXJO8jj98qvWETw@mail.gmail.com>
 <20190516003915.GT11972@sasha-vm> <ECADFF3FD767C149AD96A924E7EA6EAF9771A6DF@USCULXMSG01.am.sony.com>
 <CACT4Y+aq0eu5gG=Xnc6nDkQoH+_Hh=q3iiivq4nOowG8ncG+Cw@mail.gmail.com>
In-Reply-To: <CACT4Y+aq0eu5gG=Xnc6nDkQoH+_Hh=q3iiivq4nOowG8ncG+Cw@mail.gmail.com>
From:   Dhaval Giani <dhaval.giani@gmail.com>
Date:   Wed, 22 May 2019 18:07:31 +0200
Message-ID: <CAPhKKr-6Zi_69+J3MF00Unv3C9ovK0Y-SmW1Y1oVFo36Ez-82A@mail.gmail.com>
Subject: Re: Linux Testing Microconference at LPC
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Tim Bird <Tim.Bird@sony.com>, Sasha Levin <sashal@kernel.org>,
        Tim Bird <tbird20d@gmail.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Shuah Khan <shuah@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        gustavo padovan <gustavo.padovan@collabora.co.uk>,
        knut omang <knut.omang@oracle.com>,
        Eliska Slobodova <eslobodo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 6:04 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, May 16, 2019 at 2:51 AM <Tim.Bird@sony.com> wrote:
> > > -----Original Message-----
> > > From: Sasha Levin
> > >
> > > On Fri, Apr 26, 2019 at 02:02:53PM -0700, Tim Bird wrote:
> > ...
> > > >
> > > >With regards to the Testing microconference at Plumbers, I would like
> > > >to do a presentation on the current status of test standards and test
> > > >framework interoperability.  We recently had some good meetings
> > > >between the LAVA and Fuego people at Linaro Connect
> > > >on this topic.
> > >
> > > Hi Tim,
> > >
> > > Sorry for the delayed response, this mail got marked as read as a result
> > > of fat fingers :(
> > >
> > > I'd want to avoid having an 'overview' talk as part of the MC. We have
> > > quite a few discussion topics this year and in the spirit of LPC I'd
> > > prefer to avoid presentations.
> >
> > OK.  Sounds good.
> >
> > > Maybe it's more appropriate for the refereed track?
> > I'll consider submitting it there, but there's a certain "fun" aspect
> > to attending a conference that I don't have to prepare a talk for. :-)
> >
> > Thanks for getting back to me.  I'm already registered for Plumbers,
> > so I'll see you there.
> >  -- Tim
>
>
> I would like to give an update on syzkaller/syzbot and discuss:
>  - testability of kernel components in this context
>  - test coverage and what's still not tested
>  - discussion of the process (again): what works, what doesn't work, feedback
>

This sounds good to me.

> I also submitted a refereed track talk called "Reflections on kernel
> quality, development process and testing". If it's not accepted, I
> would like to do it on Testing MC.

I don't think refereed talks fit in the MC
