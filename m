Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E584C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA55218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juR3nwN5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfGCMey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 08:34:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39456 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCMey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 08:34:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id j2so1217048pfe.6;
        Wed, 03 Jul 2019 05:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Zh20eDctD0uOEV0CBXCsFL9AJVrhJiOwnTyIfCiyLk=;
        b=juR3nwN5y1Vfy8DPE02baVsCeSRViaMYHk+S4uDbhHuLH5MAq5ZIwCPPeWzuAoQWEr
         q/T9d0d07vyhW0jpijo9gtha4BBIcpYi2CU89ryqxHp1sGIfC6/SjN0HjNyX26sArnx0
         cBoQjhsQ/YfDu7kwOE3ROdTtmEeg5b5Dw7L3BSudvhU4oj8WoN4RJvFaVq5NhM+2kdj8
         3UwWTG0RE5budldOxweKdMFtMLv171pdKA1M7atbl3RICeKlLGcyRh8tMSxZcIlvZ2pi
         p06bjlxztC/ipuw+oN2f+CDqWl6eCxfowaT/e4ZKBvtp+c4zPmB7r/EFzDCEczeitNdB
         ffMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Zh20eDctD0uOEV0CBXCsFL9AJVrhJiOwnTyIfCiyLk=;
        b=KZrH5DsxJZxuRcL1SiGGTegunqU+xtFxiJNRA0YXxQ68lrwUh3CRXF+S7ilH2KYtjg
         NBn3GJv6zQ0bDJDx5x6zqj3waex+slV2esiHF0wMdObO4RZokqEbgmWShPOKjtUcSUDK
         xm0H3EuYVDa29StDP/iESg3Rcbs72mjmDZpnzaACyrE8vvSeQBYMxAJnoVUwB5gYdDYm
         VDUs79wRYVy1d//WwTwhqNR0N5DlyuBAGF87JDuex06xorRwrp+WDCWBhPrDDxnEFLzT
         94swsFZh2WicgApAtYEH6OYfXA5vhtYG6OaMvvmHUwjisuCvWSvmPNLoF/oRQQStZIx2
         +jMg==
X-Gm-Message-State: APjAAAW+e3moqodm/Vq75F72YnRbXeqsI+l3zuNeJRaGNZAdgmlTWpuv
        9vm/m7I9MoYMbArfw2TisZ3E54trp9cU38AEowE=
X-Google-Smtp-Source: APXvYqwhvsbepyecIWiKw8WItcH0EeKOA5NuVUrLIcR1ZqNEDhprorOf1qBquvFPxObqAxPod+IQn9sVj80Nhjpd0KU=
X-Received: by 2002:a63:c0e:: with SMTP id b14mr36789780pgl.4.1562157293314;
 Wed, 03 Jul 2019 05:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190703015331.5449-1-srinivas.pandruvada@linux.intel.com> <1893254.mYh7M8VbD2@kreacher>
In-Reply-To: <1893254.mYh7M8VbD2@kreacher>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 3 Jul 2019 15:34:41 +0300
Message-ID: <CAHp75VcALNWX-WsfvBt9Q4aE_6AzF=6WV9PUpdnszugi4z+nzw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update for Intel Speed Select Technology
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Cox <alan@linux.intel.com>, Len Brown <lenb@kernel.org>,
        Prarit Bhargava <prarit@redhat.com>,
        David Arcari <darcari@redhat.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 2:59 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Wednesday, July 3, 2019 3:53:31 AM CEST Srinivas Pandruvada wrote:
> > Added myself as the maintainer.
> >
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>

Pushed along with the driver, thanks!

> > ---
> >  MAINTAINERS | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5cfbea4ce575..b6ed7958372d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8101,6 +8101,14 @@ S:     Supported
> >  F:   drivers/infiniband/hw/i40iw/
> >  F:   include/uapi/rdma/i40iw-abi.h
> >
> > +INTEL SPEED SELECT TECHNOLOGY
> > +M:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > +L:   platform-driver-x86@vger.kernel.org
> > +S:   Maintained
> > +F:   drivers/platform/x86/intel_speed_select_if/
> > +F:   tools/power/x86/intel-speed-select/
> > +F:   include/uapi/linux/isst_if.h
> > +
> >  INTEL TELEMETRY DRIVER
> >  M:   Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> >  M:   "David E. Box" <david.e.box@linux.intel.com>
> >
>
>
>
>


-- 
With Best Regards,
Andy Shevchenko
