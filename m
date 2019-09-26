Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31489C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 04:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E432146E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 04:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8y3gKmw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbfIZEm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 00:42:58 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42892 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfIZEm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 00:42:57 -0400
Received: by mail-io1-f68.google.com with SMTP id n197so2950059iod.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 21:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OFA5Uz5BCNq/MfwnbLzI5wj5RSqOhUTcf5ZFKST8Ysc=;
        b=G8y3gKmwchxeBHsPxLv2M7F8LxqYDpNRcEbzbe7SRU/i9dDi/U+0VW6ODvf8b4f2yq
         JrShp8aBM55VlFtxiBc+tBHa+GLdnJwcrHMic49pdkJya0U3WKfDfHf/egSde+9D+U6P
         BMSzyayB+kChdm2pL4hf/yFw4Iq2f1BYRprUpdDltmcqfRMVCEIQ42dlfG2W9HTEUXDV
         oKtuuqC7WrKvU2XRxI+ThTahHE21Rb7TwsVCBRbae6pf3AwygmYUvo4Nsq/miX9Iaalc
         mSLtaSVp/4wRCCBrIESWH9aS5TaKHBiOvJJbGF7Wjzej59+TDFAbmsp/k30/RPc72XFb
         vGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OFA5Uz5BCNq/MfwnbLzI5wj5RSqOhUTcf5ZFKST8Ysc=;
        b=TZb8m0kxf74a0UsR34LplIqWB51SzN2TMqlTM9WADF85mxJ6jgqIWOwcfWb0F+JTMe
         79SEQ7MzeY9V0BD8dpmefrHmsGXaG5ZO0cjrPR2u9N3MKT7IdCM86dZEhTqHRdhPwaBH
         doL8e34QcmnuRolrPx9vPXHaiF00VTsBaKAtLF3XgWLqqvFp8I+2ctPfqUDs/kUYHq9R
         j7p5n11NKcRsm3EIcPgK+8DxGi6NGMmmbmYhSda53hWV4i3X5qdHhcL1S6+7L4eCSQ5x
         n5FEXxQ4nYUSAyAad5wZgAGU9dGO3AVRVZ/VdCM8qKcpG2gOA4wXfIl6eLzsZDwkR+TC
         oGzQ==
X-Gm-Message-State: APjAAAU4rCB/ZeMRDgi/oL3666WxohoBO25dERcmgQhn1AqFuNzziAnT
        C51ncaO2tyyFZz3xCFE/gDr9BZ+lvEQsk3zDSB4=
X-Google-Smtp-Source: APXvYqyACWFEunMEyJ8CWeVZ1hfAko7oIMA7AR5qY8h393gn0f166rL2znmZpDm2RUirSuslv5CxJQppcWg8eRAzOVk=
X-Received: by 2002:a02:7009:: with SMTP id f9mr1897459jac.81.1569472976794;
 Wed, 25 Sep 2019 21:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <1568817522-8754-1-git-send-email-laoar.shao@gmail.com>
 <1568817522-8754-2-git-send-email-laoar.shao@gmail.com> <456c8216-a9f4-6821-e688-744e93df826f@suse.de>
In-Reply-To: <456c8216-a9f4-6821-e688-744e93df826f@suse.de>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 26 Sep 2019 12:42:20 +0800
Message-ID: <CALOAHbCho+SjpfaWrKFAoK-2CKMaqc4dyevk5kC-qenHgnHS5A@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf script python: integrate page reclaim analyze script
To:     Tony Jones <tonyj@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>, acme@kernel.org,
        namhyung@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        jolsa@redhat.com, mingo@redhat.com, Linux MM <linux-mm@kvack.org>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 9:56 AM Tony Jones <tonyj@suse.de> wrote:
>
> On 9/18/19 7:38 AM, Yafang Shao wrote:
> > A new perf script page-reclaim is introduced in this patch. This new sc=
ript
> > is used to report the page reclaim details. The possible usage of this
> > script is as bellow,
> > - identify latency spike caused by direct reclaim
> > - whehter the latency spike is relevant with pageout
> > - why is page reclaim requested, i.e. whether it is because of memory
> >   fragmentation
> > - page reclaim efficiency
> > etc
> > In the future we may also enhance it to analyze the memcg reclaim.
> >
> > Bellow is how to use this script,
> >     # Record, one of the following
> >     $ perf record -e 'vmscan:mm_vmscan_*' ./workload
> >     $ perf script record page-reclaim
> >
> >     # Report
> >     $ perf script report page-reclaim
> >
> >     # Report per process latency
> >     $ perf script report page-reclaim -- -p
>
>
> I tested it with global-dhp__pagereclaim-performance from mmtests and got=
 what appears to be reasonable results and the output looks correct and use=
ful.  However I'm not a vm expert so I can't comment further.  Hopefully so=
meone on linux-mm can give more specific feedback.
>

+ Mel

Hi Mel,

This is motivated by
Documentation/trace/postprocess/trace-vmscan-postprocess.pl created by
you.
Could you pls. help take a look ?

Thanks
Yafang

> There is one issue with Python3,  see below.  I didn't test with Python2.
>
> >
> > +     @classmethod
> > +     def shrink_inactive(cls, pid, scanned, reclaimed, flags):
> > +             event =3D cls.events.get(pid)
> > +             if event and event.tracing():
> > +                     # RECLAIM_WB_ANON 0x1
> > +                     # RECLAIM_WB_FILE 0x2
> > +                     _type =3D (flags & 0x2) >> 1
> > +                     event.process_lru(lru[_type], scanned, reclaimed)
> > +
> > +     @classmethod
> > +     def writepage(cls, pid, flags):
> > +             event =3D cls.events.get(pid)
> > +             if event and event.tracing():
> > +                     # RECLAIM_WB_ANON 0x1
> > +                     # RECLAIM_WB_FILE 0x2
> > +                     # RECLAIM_WB_SYNC 0x4
> > +                     # RECLAIM_WB_ASYNC 0x8
> > +                     _type =3D (flags & 0x2) >> 1
> > +                     _io =3D (flags & 0x4) >> 2
> > +
> > +                     event.process_writepage(lru[_type], sync_io[_io])
> > +
> > +        @classmethod
>
> Space indentation on line above.  For python3 this results in:
>
>   File "tools/perf/scripts/python/page-reclaim.py", line 217
>     @classmethod
>                ^
> TabError: inconsistent use of tabs and spaces in indentation
>
> > +     def iterate_proc(cls):
> > +             if show_opt !=3D Show.DEFAULT:
> > +                     print("\nPer process latency (ms):")
> > +                     print_proc_latency(latency_metric, 'pid', '[comm]=
')
> > +
> > +                     if show_opt =3D=3D Show.VERBOSE:
> > +                             print("%20s  %s" % ('timestamp','latency(=
ns)'))
>
>
> Thanks
>
> Tony
>
