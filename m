Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DCFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDAE21925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="go6xalmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfCVRqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:46:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45917 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbfCVRqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:46:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so3250380wra.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 10:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XtOY91txFPHm4rtxLdZR/qdm4ndXlGT3t8QOvyWFvqw=;
        b=go6xalmOAVzyh7fUS7CoLSk7r0AgGhLqXBJoVOsd6VMu83hG/NSEu/VSfFiX9g2Xjw
         HcLIVsR84CdozyegyIpahVhAdQL6MAE2ydkJ1fEVDpW1rH1v2Nw8UZFH4N76EWwWBmBI
         Qer1XHv0Y/Wlceu9WgrC93ABocb00RbuIVJfDUCtW8L9+4/YGrkcetOqZ540+YVD4wNe
         vRIHIMLHzqL1L99pdvB1aCUuLchI4vz5pNl+5E7s+FkECf13aLqbA0FlfONW3tCCicDN
         dhQwc1yRwOBFddllO2IyWrRlBLMkiIHVU7txZPm2Qy4LIBs82e2d0smD5J5NYawAyzAv
         cfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XtOY91txFPHm4rtxLdZR/qdm4ndXlGT3t8QOvyWFvqw=;
        b=e00OagNUijv+Tdw0Z0gEgdI8qZDkhjcf/PUZMRRe+asQc1hpqyj26ZtcAdFwR8RIXv
         LuO+8HJQp4qijLhYy3Kr0RcgksqML/CprdBwd+rrUj9RoYfh6aCWhv4vYuDxoEYCw9YA
         pqWxPIcvMzvhwqKnatH6SrDjvSwhCxQ57wpQbsGDVitpHSEa3OpeONuNAE67vEVvoLrV
         m2sNNCZ4kga3tRyQMuXgqvuQESs1hb0E5na1mufar26dM1gMOUzhO2Kcmr+T8Bnn6iOw
         QVugZtKJTJs9Qm500sJEbPDJda1ZTZsP3KUpEp7uryk58Hk4y1MXoguohRnqQl+Y4Tf3
         moaw==
X-Gm-Message-State: APjAAAUN6fYwepz1Uqe2loNhNTDSO2CGdU31B/IF5YbH+A5F8QABwN8r
        wurU+3L2sRqUiuT8kRiOX4sG0xbH9b+SIZ6Bj/M=
X-Google-Smtp-Source: APXvYqyhRNkqFEwpo5QSrDyBXzjIohW0tOZczszJDClqtZTv7Dvx1h2p0ULtmUbN3k7E9sfwUMOos1gNmJL0gdJU81M=
X-Received: by 2002:adf:a382:: with SMTP id l2mr789819wrb.79.1553276768058;
 Fri, 22 Mar 2019 10:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190322032901.12045-1-andrew.smirnov@gmail.com>
 <20190322032901.12045-6-andrew.smirnov@gmail.com> <19eddb76-38f7-e7cb-9a9f-5b435e67c63e@ti.com>
In-Reply-To: <19eddb76-38f7-e7cb-9a9f-5b435e67c63e@ti.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 22 Mar 2019 10:45:56 -0700
Message-ID: <CAHQ1cqGz0MP-5faRO9JU78G07LERLaNY=Qc8hxfUxcNRyxGugQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/15] drm/bridge: tc358767: Drop custom
 tc_write()/tc_read() accessors
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 3:29 AM Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
> On 22/03/2019 05:28, Andrey Smirnov wrote:
> > A very unfortunate aspect of tc_write()/tc_read() macro helpers is
> > that they capture quite a bit of context around them and thus require
> > the caller to have magic variables 'ret' and 'tc' as well as label
> > 'err'. That makes a number of code paths rather counterintuitive and
> > somewhat clunky, for example tc_stream_clock_calc() ends up being like
> > this:
> >
> >       int ret;
> >
> >       tc_write(DP0_VIDMNGEN1, 32768);
> >
> >       return 0;
> > err:
> >       return ret;
> >
> > which is rather surprising when you read the code for the first
> > time. Since those helpers arguably aren't really saving that much code
> > and there's no way of fixing them without making them too verbose to
> > be worth it change the driver code to not use them at all.
>
> I fully agree with this patch and thought about the same thing during my
> work.
>
> However, the timing of this patch is not too good, as this one will
> totally conflict with any other patch for tc358767, and my series is
> still evolving.
>

The reason I rebased this series on top of yours is because I think
mine should go after yours gets accepted and lands in the tree. I am
more than happy to wait for your series to mature. This submission was
done mostly for the sake of discussion, looping original authors in as
well as making you aware of its existence.

> We need to figure out how to combine this series and mine, but I think
> either this patch should be dropped for now, and reapplied after the
> other patches have stabilized, or I think preferably, this one could be
> rebased on top of 5.1-rc1, and used as a base for all other tc358767 work.
>

I think waiting for your work to be done before proceeding to apply
this series, should solve this problem.

Thanks,
Andrey Smirnov
