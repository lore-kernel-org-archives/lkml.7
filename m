Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB30C04E87
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2E920843
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="fQHacpe2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfEPBql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 21:46:41 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41415 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfEPA0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 20:26:54 -0400
Received: by mail-oi1-f194.google.com with SMTP id y10so1191525oia.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 17:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ImJX0tiITgi2zeWUkjyeNnlcEhTnJ18f85h6yaNeNP4=;
        b=fQHacpe2ymfI8sqJ+whv4r+9XvKZbkea86O3xoYBqguZpTOJRspjOhxU64Qq/4vsH5
         oDLmngQ68PW81lPv5coyyGI58fcFPrrixmApE8YoVBMYYWjnerugGd8IPXk8j4syWpug
         Lriz/uX0F2DXGsHCNpWx1HztMF7wV0O+8B+3go5zyF9mxw4pxGvPJgCgdiV7nJCumxmU
         1j5ClsNI05YpSBM/kp8JsA78iJijlHPOVKyo2zxBZynLYyCU8WQje8Zuq0izaBU864LD
         DLY2Xi3L22XXzhTdH69p5ubKJCm6s1XHfBYzcfxNV6FVhGiRxCIVVjZKO1w7D9hPXzoZ
         CKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ImJX0tiITgi2zeWUkjyeNnlcEhTnJ18f85h6yaNeNP4=;
        b=jfFzlMJgImI6I6Om6h2yT/JULAQQIqfTgzk31lGKOea3b/Swq7lPtlKPmtbqpeNbDT
         oAntmcysZbWfjtN8hxH6/i3KklutAmuIK/gi6WxwZIsOMxYeME3U9OXJjYj6qs9M0zKz
         1PFF1nOQr6S8MN1AcWulmsmCFZzcP3DDVC50uIYDJwII5iQmx8jT4htn4VD2wp6w0Yju
         wc/ITdI3yTOgzB4x0T7xhfZCuj1Q0z5Lsy7Bsa7lKcUnRHLWh5POWYiTU3pSlWrWqlVd
         d43OkgSQk0jZGXx1sz8yrlUaCwarGZrdWLHT0fXK0GjBU++TR519nLrQ4QACSiwcqoIb
         YQUA==
X-Gm-Message-State: APjAAAUo+soKZGJN6JpWIKkfWGF4sg7TI9faBV9Y1jEjXLPbIgY0Wv91
        Z39SRmFKx8VCo2uHxmPTJjzzDatxrNyIbmLX+E9C7Q==
X-Google-Smtp-Source: APXvYqz1lPEsteF4K+RpI1xzzM89PLC7bK4Z05lIhq9ljpLi+5CiwTZXSrfgudjrTM34TT+MrQbfj8EWmzgk0MRe5Zw=
X-Received: by 2002:aca:ab07:: with SMTP id u7mr4326676oie.73.1557966413422;
 Wed, 15 May 2019 17:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190514150735.39625-1-cai@lca.pw> <CAPcyv4gGwyPf0j4rXRM3JjsjGSHB6bGdZfwg+v2y8NQ6hNVK8g@mail.gmail.com>
 <7ba8164b60be4e41707559ed6623f9462c942735.camel@intel.com>
In-Reply-To: <7ba8164b60be4e41707559ed6623f9462c942735.camel@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 15 May 2019 17:26:42 -0700
Message-ID: <CAPcyv4gLr_WrNOg58C5tfpZTp2wso1C=kHGDkMvH4+sGniLQMQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] nvdimm: fix some compilation warnings
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "cai@lca.pw" <cai@lca.pw>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 5:25 PM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
>
> On Wed, 2019-05-15 at 16:25 -0700, Dan Williams wrote:
> >
> > > diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> > > index 4671776f5623..9f02a99cfac0 100644
> > > --- a/drivers/nvdimm/btt.c
> > > +++ b/drivers/nvdimm/btt.c
> > > @@ -1269,11 +1269,9 @@ static int btt_read_pg(struct btt *btt, struct bio_integrity_payload *bip,
> > >
> > >                 ret = btt_data_read(arena, page, off, postmap, cur_len);
> > >                 if (ret) {
> > > -                       int rc;
> > > -
> > >                         /* Media error - set the e_flag */
> > > -                       rc = btt_map_write(arena, premap, postmap, 0, 1,
> > > -                               NVDIMM_IO_ATOMIC);
> > > +                       btt_map_write(arena, premap, postmap, 0, 1,
> > > +                                     NVDIMM_IO_ATOMIC);
> > >                         goto out_rtt;
> >
> > This doesn't look correct to me, shouldn't we at least be logging that
> > the bad-block failed to be persistently tracked?
>
> Yes logging it sounds good to me. Qian, can you include this in your
> respin or shall I send a fix for it separately (since we were always
> ignoring the failure here regardless of this patch)?

I think a separate fix for this makes more sense. Likely also needs to
be a ratelimited message in case a storm of errors is encountered.
