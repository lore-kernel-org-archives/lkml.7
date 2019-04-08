Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C1CC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59A220833
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y82hja5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbfDHSsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:48:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39307 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfDHSr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:47:57 -0400
Received: by mail-lj1-f195.google.com with SMTP id l7so12227452ljg.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 11:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XqZU5+DlMUpi8284eOudgl8vYH/2zMpoCd9V4U+Mz/k=;
        b=Y82hja5s3DRRr5uCWYmfkcHcH8/6bjcvj26ZCKHqlzQKJDOwTOHLPU40uIGLWNowEe
         iw1dGl96VElWR61/gdGZipcJPhMQucDEMJhZop7kN0FR1Ag/wp8I9cRJsTqKejFh2zMS
         LNVBsP0jWgU3wSwo/PZVOwjgjLDaeDQm1OxU5Awoo+6af34uDBV0l5/kF5JkFKrXkmSy
         ucLvjQhx+m8i5ZY811E2mFdNvuXqBTR3hastVq/XeN0HoI5fapIi07NlF1kwaAK34BGP
         VVb9lDGptjf0qIYCuSFG8NNArwG7yfJO0n+HHnYXHYx9hSl8wD3HWBVV7mxykJtBDnNm
         odWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XqZU5+DlMUpi8284eOudgl8vYH/2zMpoCd9V4U+Mz/k=;
        b=VMCxxeYbyMICTPxlbBh282UDgIzih9qPXfyufmVmqzK4MvypPqHIS5IafzXll8GWCn
         Fd7MzaezIdonwvQ2NoY93XuP/ojyJIMZ/5OZWwJoZTU4azRMg+SQSkPwPl6kLzD2cQJ9
         oI+uhS+2MVL+D7EUB56uPCAMpNM/9uSf82eldOHgQWSWpqPivH2sUwibBtes/lw8ukmu
         Gd/SrX8QwdcCidtT/JBNz8wfRyNIqsGJi63dJLWpIkcwfjMzTrrdzhExMLg21YeS9OnZ
         ZjGkud/oLsWbdaYpPzSdHv61qOHpz4Mpd7SJlPuO8bsNXEywOcolQC9nAzMSI27/ktnL
         RJzA==
X-Gm-Message-State: APjAAAWWxmqIuvHPhpE49zBjDppBHNLQdhcEJ2fIA648qBPrGG6k2sET
        xZFghZqGCzRtSJEnozAm5KdUTBlNvxDCOle6vN/doQ==
X-Google-Smtp-Source: APXvYqwkwbOIuxKg2UGmMr92LqWClgoseQmtJdGOkkF9UvKuaSJ29TGeO8qBz3pHPhrkkYTD0y29Issz6AKcca9kB7o=
X-Received: by 2002:a2e:6a14:: with SMTP id f20mr17713158ljc.65.1554749274819;
 Mon, 08 Apr 2019 11:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190405203558.19160-1-rajatja@google.com>
 <CAHp75Vd+_aFxomzPP_-8y5D1p0crbYo6R+=7fGGOKW86D2+=CQ@mail.gmail.com>
 <CACK8Z6HcqsRxRNGhN9sTRGp5kx=kVCTgqL_cVGy_Tznu=gL6jQ@mail.gmail.com> <CAHp75VfdE0upv1=HbNs35fcozTY6kXGpLt4tTAMVRDQZ90GHtw@mail.gmail.com>
In-Reply-To: <CAHp75VfdE0upv1=HbNs35fcozTY6kXGpLt4tTAMVRDQZ90GHtw@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 8 Apr 2019 11:47:17 -0700
Message-ID: <CACK8Z6ESTpukVLCoX56CvKuCrecj0gnb7RzB_xjOgiW=+WSBvg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] platform/x86: intel_pmc_core: Convert to a platform_driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Wysocki <Wysocki@google.com>,
        Rafael J <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Furquan Shaikh <furquan@google.com>,
        Evan Green <evgreen@google.com>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 11:44 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Apr 8, 2019 at 9:43 PM Rajat Jain <rajatja@google.com> wrote:
> > On Mon, Apr 8, 2019 at 9:51 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Fri, Apr 5, 2019 at 11:36 PM Rajat Jain <rajatja@google.com> wrote:
>
> > > > +       switch (boot_cpu_data.x86_model) {
> > >
> > > I didn't get why this should be boot CPU?
> > > Otherwise, leave the structure and leave the x86_match_cpu() call.
> >
> > I didn't quite understand the concern. The x86_match_cpu() also uses
> > the same boot_cpu_data that I've used, am I missing something?
>
> It's a detail of implementation, and instead of continue using nice
> helpers, you open coded the similar.
> Why?

OK, sure. I will put back the intel_pmc_core_ids structure and the
x86_match_cpu().

Thanks,

Rajat

>
> --
> With Best Regards,
> Andy Shevchenko
