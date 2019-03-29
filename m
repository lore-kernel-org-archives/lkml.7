Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D10C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D3B206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AhDuVScI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbfC2PLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:11:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38282 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbfC2PLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:11:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id g37so1179198plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 08:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OTBdFezmv2EnFZkdo0Cxts8DR9hCzZN2BLstPO3yMA8=;
        b=AhDuVScI5Wyq3g1xfQPrsVqophJqTB/Jo97YFWBtzEr03Dtu4yfs884jgSYCn0BjSc
         ww32efvbNXDvT1ctGfBw4hmb5VuP0ZhC8QBVD8Si8miPiJmszczvoh+8DT89Pw6wNkvx
         jtMCfyS3AzOt5ZwnmEiTQ+7LR+OfL+UGj1eF1ETHK5rjAr9LUKMrVoSUqaVQpeNVsLh5
         MjzCc/FeX7nUTYSOs9U89vi+C5of+IIbgX3szxvLbh99kAUf/GAoMo91mnrf60/VO/w+
         BeIGOlIIuPqLJEerUF/o6eckI0JZBmX3/m7kRn5tDj87JxbMiD/SnE4tzLuyaTMheROh
         Qo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OTBdFezmv2EnFZkdo0Cxts8DR9hCzZN2BLstPO3yMA8=;
        b=ED6JbEulEoID+faERETsdjufOIdihmSl8A55YEjevOBYL3X+Yc6Gss+kJHm6WQ3Toa
         zgQff5kMMPZWfZaSQl+JmSUKgPX8tatRm7Tw0fnusLRVNh9nTPrCfLTBQx1pqlEmDvUn
         QkzGv5qiJ6ivrZjvVtZZ/QwpLUUJbIrexgWo2UyJK+sQck8bq4ATXGyJTRJ1sgbigoP9
         BTsg2vVOtTj2FdxDZYJjNBKbR2MpaQhvyyU7BnI3+MN76kvprtYNqmRvKFzMic341JfZ
         0j+1/WqiIPPJqXvR5mtxUhCOqMjG0s0iIfxBgn866GFzEHk3ve0jCkc08qVnqJAwWPlk
         uqRg==
X-Gm-Message-State: APjAAAVEwUfPCcbJBwLN2As9fmyy88kZ4QF8++7ZapY4CiYX10ELN492
        I2oWew5eEX2JguLvO40seS7xpNcrJ6UoMNr/TPn5Ww==
X-Google-Smtp-Source: APXvYqyGx9mJobb/u1uesxxmDZimOGD+c5LVCBx9n7RoCGi700Mmx53cFRZOlOzMFRWQZpL5q7J/d9jLVyGH5I2gHq4=
X-Received: by 2002:a17:902:e701:: with SMTP id co1mr49682842plb.61.1553872272230;
 Fri, 29 Mar 2019 08:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190327212155.80730-1-venture@google.com> <20190328165009.GA25705@bogus>
 <CAO=notxxYF4noXbR1BeVrwqCBHaVCaXy+jPV4OVbex=w=fV+Rg@mail.gmail.com>
 <CAL_JsqJSvzOQbJSgz7z2wZj9-z=bfhzF_C+662Gnf68TgAPFaA@mail.gmail.com>
 <CAO=notx6K7xTW1VG6BGJFBM5k8EQsWXn3WoWSPSrZRsxkwueSA@mail.gmail.com> <CAO=notxD=5pa5sT15a+VrA7qVNPBoJoTo=5sLxibBxc+HWcG4g@mail.gmail.com>
In-Reply-To: <CAO=notxD=5pa5sT15a+VrA7qVNPBoJoTo=5sLxibBxc+HWcG4g@mail.gmail.com>
From:   Patrick Venture <venture@google.com>
Date:   Fri, 29 Mar 2019 08:11:00 -0700
Message-ID: <CAO=notynUJGUn3tuJZ_jFPdz23_T1FPyzS46mm5msphLnLW_JA@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg KH <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 7:59 AM Patrick Venture <venture@google.com> wrote:
>
> On Fri, Mar 29, 2019 at 7:56 AM Patrick Venture <venture@google.com> wrote:
> >
> > On Fri, Mar 29, 2019 at 6:38 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Thu, Mar 28, 2019 at 12:03 PM Patrick Venture <venture@google.com> wrote:
> > > >
> > > > On Thu, Mar 28, 2019 at 9:50 AM Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Wed, 27 Mar 2019 14:21:55 -0700, Patrick Venture wrote:
> > > > > > Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.
> > > > > >
> > > > > > Signed-off-by: Patrick Venture <venture@google.com>
> > > > > > ---
> > > > > > Changes for v8:
> > > > > > - None
> > > > > > Changes for v7:
> > > > > > - Moved node under the syscon node it requires
> > > > > > Changes for v6:
> > > > > > - None
> > > > > > Changes for v5:
> > > > > > - None
> > > > > > Changes for v4:
> > > > > > - None
> > > > > > Changes for v3:
> > > > > > - None
> > > > > > Changes for v2:
> > > > > > - Added comment about syscon required parameter.
> > > > > > ---
> > > > > >  .../bindings/misc/aspeed-p2a-ctrl.txt         | 48 +++++++++++++++++++
> > > > > >  1 file changed, 48 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > > > > >
> > > > >
> > > > > Please add Acked-by/Reviewed-by tags when posting new versions. However,
> > > > > there's no need to repost patches *only* to add the tags. The upstream
> > > > > maintainer will do that for acks received on the version they apply.
> > > > >
> > > > > If a tag was not added on purpose, please state why and what changed.
> > > >
> > > > Adding tags in this case is adding a change version?  I was doing this
> > > > to keep the two patches version-synced.  I thought that was required.
> > > > There was a version change in the other patch in this set.
> > >
> > > Adding tags is not considered a change. I gave a Reviewed-by in v7.
> > > Subsequent versions should carry that tag if there's no change (or
> > > only minor changes) in this patch. What happens in the other patches
> > > is not really important. Maintainers are not going to go searching
> > > thru the versions to find all the ack/review tags. And if I've already
> > > reviewed this, I don't want to look at it again.
> >
> > Thank you, I didn't realize that had happened.
>
> I went back through my email and found the line of your email that
> included it.  I apologize.
>
> So, before I send the updated patch with your ack -- do I need to send
> a v9? or is this just me sending v8 again?

Sorry.  I see you already answered that when you said that adding a
tag isn't considered a change.  I have therefore re-sent v8 of this
patch with your tag added.

>
> >
> > >
> > > Rob
