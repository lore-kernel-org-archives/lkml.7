Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C42C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55AB021850
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nJ2/WBaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388503AbfDRJJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:09:24 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:42541 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfDRJJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:09:20 -0400
Received: by mail-ot1-f49.google.com with SMTP id 103so1095153otd.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 02:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AjyEUT+ab80WGVik8eC4hnVor/wcNPvxm5+K1GbKPVU=;
        b=nJ2/WBaMZxihi8ZoJKr+xJATIygjafUtMqTcFAWJJ1xJonmnn02k1UPZOCxEsP8Eii
         y8le723HAb0OvyCHTmTa8yNWoqdrgbljEw/bUx31ETSTGb5UJ6dpb9cPdmxN3Tm4Q9W9
         imdWIOx2YR/YvjzV0vQL97h2LzpR46YrQ69hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AjyEUT+ab80WGVik8eC4hnVor/wcNPvxm5+K1GbKPVU=;
        b=T070kVPs6zg5XuW2p/0rbGeCSDclvg9R2/ABLvUegHqPdyfMWymjnK0Cp94mcS/bMT
         sjuRadhp/Yt2bDSonv/Bw0e3Hh3CuABvdWspfVak16HcsFvxR9Ms6KmcZPMiWMZmbxhD
         tYtOS4cHNoy5hhVqwhdMz1n8I6rdktsBeJaKIAoPbTtozIJV5rh+txQkhpBZlWrKS3Uo
         0RxAuy2hiuDVCdf69/AQlxkorJKmAmUa3oKNmg4hK732USVgFXTZZ3uCK8qws3mhPsnB
         Wfvf/WBhGrToK7+l3E3TAqRddRpMTdMTdWSu9sciEslVzrG9EwMEKYy8QO5cOwHuTkcB
         ZBzA==
X-Gm-Message-State: APjAAAUxnVnpcUDTePgTyVpqjKKubCrCNRxtzndov5Jf8HvK91EaDyjL
        zZB93Zv8jDnJw/FnD7rKOCWzcL7WKNE=
X-Google-Smtp-Source: APXvYqzGtVP4lqID7mfDbiyu1p3I1Yc4RCNTzhWq5og4KUdXgaoBQ28Mv5u+oYaZcivCjHs6jiOVnw==
X-Received: by 2002:a9d:27e3:: with SMTP id c90mr58703286otb.214.1555578559020;
        Thu, 18 Apr 2019 02:09:19 -0700 (PDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id v201sm703991oia.39.2019.04.18.02.09.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 02:09:18 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id e80so1120104ote.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 02:09:17 -0700 (PDT)
X-Received: by 2002:a9d:ef4:: with SMTP id 107mr59375180otj.152.1555578557366;
 Thu, 18 Apr 2019 02:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <0df3d4b5178d8a37b67b275e0771741c6c268de3.camel@bootlin.com>
 <20190418081816.GO13337@phenom.ffwll.local> <522d6a7734a29df47fe11f5f6311b49e14dabae0.camel@bootlin.com>
In-Reply-To: <522d6a7734a29df47fe11f5f6311b49e14dabae0.camel@bootlin.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 18 Apr 2019 18:09:06 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Bou1abM4QMPFHqEcJnqGW7F1rZdAoLGmjZnVQTPh4WSw@mail.gmail.com>
Message-ID: <CAAFQd5Bou1abM4QMPFHqEcJnqGW7F1rZdAoLGmjZnVQTPh4WSw@mail.gmail.com>
Subject: Re: Support for 2D engines/blitters in V4L2 and DRM
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eric Anholt <eric@anholt.net>, Rob Clark <robdclark@gmail.com>,
        Dave Airlie <airlied@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 5:55 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi Daniel,
>
> On Thu, 2019-04-18 at 10:18 +0200, Daniel Vetter wrote:
> > On Wed, Apr 17, 2019 at 08:10:15PM +0200, Paul Kocialkowski wrote:
> > > Hi Nicolas,
> > >
> > > I'm detaching this thread from our V4L2 stateless decoding spec since
> > > it has drifted off and would certainly be interesting to DRM folks as
> > > well!
> > >
> > > For context: I was initially talking about writing up support for the
> > > Allwinner 2D engine as a DRM render driver, where I'd like to be able
> > > to batch jobs that affect the same destination buffer to only signal
> > > the out fence once when the batch is done. We have a similar issue in
> > > v4l2 where we'd like the destination buffer for a set of requests (each
> > > covering one H264 slice) to be marked as done once the set was decoded.
> > >

Out of curiosity, what area did you find a 2D blitter useful for?

Best regards,
Tomasz
