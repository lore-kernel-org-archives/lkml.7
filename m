Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C548C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84E72085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqrY87qO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfCSV64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:58:56 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42479 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbfCSV6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:58:54 -0400
Received: by mail-ed1-f65.google.com with SMTP id j89so227006edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 14:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ncs3bAUx8AfzAxdAQTuTe7JsEGRRFAYLs1ydkd4n6C4=;
        b=GqrY87qO336qzu0Ujh2noUyzq++R48002MqCNm+FS7e8VB8odIrPBNbkqhbun1ZbQr
         pswOwAFfkLryJ4tOJ3vdURxtvqATLAzflJ+JdrFdxNK82cx/p/fmTLW5zSXr6RAoOdhK
         naT0C2LqQwwkdq3XJP0QZ2Vs5BF9lGB8l7iwy21VD6jLqD/8gI6CfOaf7OtrNygxiY38
         xzMcZlX7ySbAPKVTgDaoJ+BqIsj1rDGBmgVQTSf77oo0XTk66GS8UTC67PHRXCFc+hKs
         iwygG59cFpj9qdvX9wmPbGGFhbdDXBBl6b9nAVHygQMdtes5ibQXv7MvfYz8AvXmUSgH
         y5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ncs3bAUx8AfzAxdAQTuTe7JsEGRRFAYLs1ydkd4n6C4=;
        b=G6kmZ5p2SLrHAV9BQIQBL+XJsS3NfTRH7LFRH/gS7MMe/0zLgoc7qAsgXv7rtjqdAe
         qtpIfNQZ5efiIeP1Il2RLA41Fa+xc12Eu1c7Z71YAC3FQxGuGeXFC45BDGakIbPUw5As
         WCmAV30pZlMP/piAMktwQ2ik7AsgGvylpMY4JTLUmCa+iguNQGFnCWjmBdDZ4TOX3X1g
         ObSOXsri/9kHYDYvAkc1m/mrK0Cn5YQ/hTJ6lWCljvcL7uGrtK3hBO8B013jkPusIbCq
         pzbb1cnAz/1bq8jU4Kt7AENybOj2QOAnaoW3emdUwnjKKOfns0xRfQwdYbdiK9/tPHOB
         RVNg==
X-Gm-Message-State: APjAAAX4qYONcnAmqIakevtdSwlj9jLTHJveoGgUHHocCNLerXWMB3g1
        Sr4SIhiGMikHslQYS2CLLYLFgsIPREFB5m6ubcE=
X-Google-Smtp-Source: APXvYqyTi+h761HD6UlsOWW/o7MqEcfHB133RehnD27w4aI2gBLgjPx1KBOYqCirTt4C2bBouCoEGHFLIG4pxwXkjq8=
X-Received: by 2002:a50:d8ce:: with SMTP id y14mr17768752edj.101.1553032732274;
 Tue, 19 Mar 2019 14:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <alpine.DEB.2.10.1903131309260.5023@lmark-linux.qualcomm.com>
 <CALAqxLUkGME+K=0g5QSja4CvN0w9z0WV60djy+5rRC+Dg-jCGg@mail.gmail.com>
 <CA+M3ks7q8QnNirk_WkaE5CmFWkEPn4uu5Hfb2kP+4d5qapHvrA@mail.gmail.com> <c51be371-086a-bd5b-b70a-5579f5b95320@ti.com>
In-Reply-To: <c51be371-086a-bd5b-b70a-5579f5b95320@ti.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 19 Mar 2019 17:58:40 -0400
Message-ID: <CAF6AEGss21WmpF7sHGTxOEjuadSNpM6M_Z-WweK2W68FEHOFdA@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/5 v2] DMA-BUF Heaps (destaging ION)
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Alistair Strachan <astrachan@google.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Chenbo Feng <fengc@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Liam Mark <lmark@codeaurora.org>,
        Marissa Wall <marissaw@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 1:00 PM Andrew F. Davis <afd@ti.com> wrote:
>
> On 3/19/19 11:54 AM, Benjamin Gaignard wrote:
> > Le mer. 13 mars 2019 =C3=A0 23:31, John Stultz <john.stultz@linaro.org>=
 a =C3=A9crit :
> >>
> >> On Wed, Mar 13, 2019 at 1:11 PM Liam Mark <lmark@codeaurora.org> wrote=
:
> >>> On Tue, 5 Mar 2019, John Stultz wrote:
> >>>>
> >>>> Eventual TODOS:
> >>>> * Reimplement page-pool for system heap (working on this)
> >>>> * Add stats accounting to system/cma heaps
> >>>> * Make the kselftest actually useful
> >>>> * Add other heaps folks see as useful (would love to get
> >>>>   some help from actual carveout/chunk users)!
> >>>
> >>> We use a modified carveout heap for certain secure use cases.
> >>
> >> Cool! It would be great to see if you have any concerns about adding
> >> such a secure-carveout heap to this framework. I suspect it would be
> >> fairly similar to how its integrated into ION, but particularly I'd be
> >> interested in issues around the lack of private flags and other
> >> allocation arguments like alignment.
> >>
> >>> Although there would probably be some benefit in discssing how the dm=
a-buf
> >>> heap framework may want to support
> >>> secure heaps in the future it is a large topic which I assume you don=
't
> >>> want to tackle now.
> >>
> >> So I suspect others (Benjamin?) would have a more informed opinion on
> >> the details, but the intent is to allow secure heap implementations.
> >> I'm not sure what areas of concern you have for this allocation
> >> framework in particular?
> >
> > yes I would be great to understand how you provide the information to
> > tell that a dmabuf
> > is secure (or not) since we can't add flag in dmabuf structure itself.
> > An option is manage
> > the access rights when a device attach itself to the dmabuf but in
> > this case you need define
> > a list of allowed devices per heap...
> > If you have a good solution for secure heaps you are welcome :-)
> >
>
> Do we really need any of that? A secure buffer is secured by the
> hardware firewalls that keep out certain IP (including often the
> processor running Linux). So the only thing we need to track internally
> is that we should not allow mmap/kmap on the buffer. That can be done in
> the per-heap layer, everything else stays the same as a standard
> carveout heap.

For at least some hw the importing driver needs to configure things
differently for secure buffers :-/

BR,
-R

>
> Andrew
>
> > Benjamin
> >>
> >>> We don't have any non-secure carveout heap use cases but the client u=
se
> >>> case I have seen usually revolve around
> >>> wanting large allocations to succeed very quickly.
> >>> For example I have seen camera use cases which do very large allocati=
ons
> >>> on camera bootup from the carveout heap, these allocations would come=
 from
> >>> the carveout heap and fallback to the system heap when the carveout h=
eap
> >>> was full.
> >>> Actual non-secure carveout heap can perhaps provide more detail.
> >>
> >> Yea, I'm aware that folks still see carveout as preferable to CMA due
> >> to more consistent/predictable allocation latency.  I think we still
> >> have the issue that we don't have bindings to establish/configure
> >> carveout regions w/ dts, and I'm not really wanting to hold up the
> >> allocation API on that issue.
> >>
> >>
> >>> Since we are making some fundamental changes to how ION worked and si=
nce
> >>> Android is likely also be the largest user of the dma-buf heaps frame=
work
> >>> I think it would be good
> >>> to have a path to resolve the issues which are currently preventing
> >>> commercial Android releases from moving to the upstream version of IO=
N.
> >>
> >> Yea, I do see solving the cache management efficiency issues as
> >> critical for the dmabuf heaps to be actually usable (my previous
> >> version of this patchset accidentally had my hacks to improve
> >> performance rolled in!).  And there are discussions going on in
> >> various channels to try to figure out how to either change Android to
> >> use dma-bufs more in line with how upstream expects, or what more
> >> generic dma-buf changes we may need to allow Android to use dmabufs
> >> with the expected performance they need.
> >>
> >>> I can understand if you don't necessarily want to put all/any of thes=
e
> >>> changes into the dma-buf heaps framework as part of this series, but =
my
> >>> hope is we can get
> >>> the upstream community and the Android framework team to agree on wha=
t
> >>> upstreamable changes to dma-buf heaps framework, and/or the Android
> >>> framework, would be required in order for Android to move to the upst=
ream
> >>> dma-buf heaps framework for commercial devices.
> >>
> >> Yes. Though I also don't want to get the bigger dma-buf usage
> >> discussion (which really affects all dmabuf exporters) too tied up
> >> with this patch sets attempt to provide a usable allocation interface.
> >> Part of the problem that I think we've seen with ION is that there is
> >> a nest of of related issues, and the entire thing is just too big to
> >> address at once, which I think is part of why ION has sat in staging
> >> for so long. This patchset just tries to provide an dmabuf allocation
> >> interface, and a few example exporter heap types.
> >>
> >>> I don't mean to make this specific to Android, but my assumption is t=
hat
> >>> many of the ION/dma-buf heaps issues which affect Android would likel=
y
> >>> affect other new large users of the dma-buf heaps framework, so if we
> >>> resolve it for Android we would be helping these future users as well=
.
> >>> And I do understand that some the issues facing Android may need to b=
e
> >>> resolved by making changes to Android framework.
> >>
> >> While true, I also think some of the assumptions in how the dma-bufs
> >> are used (pre-attachment of all devices, etc) are maybe not so
> >> realistic given how Android is using them.  I do want to explore if
> >> Android can change how they use dma-bufs, but I also worry that we
> >> need to think about how we could loosen the expectations for dma-bufs,
> >> as well as trying to figure out how to support things folks have
> >> brought up like partial cache maintenance.
> >>
> >>> I think it would be helpful to try and get as much of this agreed upo=
n as
> >>> possible before the dma-buf heaps framework moves out of staging.
> >>>
> >>> As part of my review I will highlight some of the issues which would
> >>> affect Android.
> >>> In my comments I will apply them to the system heap since that is wha=
t
> >>> Android currently uses for a lot of its use cases.
> >>> I realize that this new framework provides more flexibility to heaps,=
 so
> >>> perhaps some of these issues can be solved by creating a new type of
> >>> system heap which Android can use, but even if the solution involves
> >>> creating a new system heap I would like to make sure that this "new"
> >>> system heap is upstreamable.
> >>
> >> So yea, I do realize I'm dodging the hard problem here, but I think
> >> the cache-management/usage issue is far more generic.
> >>
> >> You're right that this implementation give a lot of flexibility to the
> >> exporter heaps in how they implement the dmabuf ops (just like how
> >> other device drivers that are dmabuf exporters have the same
> >> flexibility), but I very much agree we don't want to add a system and
> >> then later a "system-android" heap. So yea, a reasonable amount of
> >> caution is warranted here.
> >>
> >> Thanks so much for the review and feedback! I'll try to address things
> >> as I can as I'm traveling this week (so I may be a bit spotty).
> >>
> >> thanks
> >> -john
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
