Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D31AC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE9F2166E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="F54v5r3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfENTYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 15:24:34 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45726 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfENTYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 15:24:34 -0400
Received: by mail-ot1-f68.google.com with SMTP id t24so7635789otl.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 12:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dgq3UM6Fy7t89KBsWPa/dNwubJ5x9NhFBR3nKkdGxBQ=;
        b=F54v5r3Q2UY3p0fjMipKOr0SMEZcrmYQxQ6eq9lQTgFwD5XGRo7ab2Bz8ptu15lqGi
         KZME0yohwroLEHCqjTihL6T8ZzRNmzMX7XD8jv7Z+22fnjT4CvamuDPDwm9ZqC92NFbL
         psOyeN7hAWl/ayAPPh+L4sKlmOR9e4FXsgXAFcGuaBankMius3erJ5ABRCntGuZtIkgO
         9jeDxqXQHS2OhoN7nFNVwmCrmTOEL+tP7bKNE5KCXPZpUqEb8Q3ZSOO0v0EPUhAncVKX
         R8ZR5TfBmbtgDvjr2jF88CVkbM+5tHyeeTNmn91CplwgR3mz7BuLfoQZwny3cygAJMrY
         Lw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dgq3UM6Fy7t89KBsWPa/dNwubJ5x9NhFBR3nKkdGxBQ=;
        b=UPoUcKOkCAy/3f2SY0eLrkRFHyGKmeiMG4k0PviOEGAqFdKzi9VJmLBgrYKOgsXJjE
         zhP1EfblA9rwI+2xJphlRWuBWlSHADGJiv6ge2tiaIx3aHUmh3LJIGhRSVi4D6vaEtTs
         fmAV3Gn+OCMeZABmj2wi0n21OWj14Oqj3yF2MQE5H/TaAWTfHubVmmbotOzAI1VMlWXc
         V4udkcP7O35GNWaBWeQrB2PN9Wf6W/c+A+ZnuEC7EfQqlEZa+JMXkZD8rxvhjbgYPSfR
         EwML/adydmMuWz5mLO+RgSUI9sZrhsfbYnenVWiGRJeSFWq/OBngPDs8wWxcUcjY/QGq
         yeSg==
X-Gm-Message-State: APjAAAXuzNIpI/UeQCfkIWbX6R6pFpYyp+v2fGgy0Pj0HRtKzW+LMBva
        qx3PUpniJEpFizlZr7FBIH4oFyr2vLirOndw3NqpOg==
X-Google-Smtp-Source: APXvYqwKrS+xjnV2C39v/K43aWh/ONuM204U4eBm/zYWLBvQbW5tmknEyf9ZYMNzmmuNbTGmVFMfdvg9LHWShr9lgv0=
X-Received: by 2002:a9d:6a8a:: with SMTP id l10mr21177381otq.197.1557861873856;
 Tue, 14 May 2019 12:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <155727335978.292046.12068191395005445711.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155727336530.292046.2926860263201336366.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190514191243.GA17226@kroah.com>
In-Reply-To: <20190514191243.GA17226@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 14 May 2019 12:24:23 -0700
Message-ID: <CAPcyv4jO5KA4ddvBx6PFTgv2D+PfJ4Znzt5RFP4ry9NUDZ+eSQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] drivers/base/devres: Introduce devm_release_action()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 12:12 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, May 07, 2019 at 04:56:05PM -0700, Dan Williams wrote:
> > The devm_add_action() facility allows a resource allocation routine to
> > add custom devm semantics. One such user is devm_memremap_pages().
> >
> > There is now a need to manually trigger devm_memremap_pages_release().
> > Introduce devm_release_action() so the release action can be triggered
> > via a new devm_memunmap_pages() api in a follow-on change.
> >
> > Cc: Logan Gunthorpe <logang@deltatee.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/base/devres.c  |   24 +++++++++++++++++++++++-
> >  include/linux/device.h |    1 +
> >  2 files changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> > index e038e2b3b7ea..0bbb328bd17f 100644
> > --- a/drivers/base/devres.c
> > +++ b/drivers/base/devres.c
> > @@ -755,10 +755,32 @@ void devm_remove_action(struct device *dev, void (*action)(void *), void *data)
> >
> >       WARN_ON(devres_destroy(dev, devm_action_release, devm_action_match,
> >                              &devres));
> > -
> >  }
> >  EXPORT_SYMBOL_GPL(devm_remove_action);
> >
> > +/**
> > + * devm_release_action() - release previously added custom action
> > + * @dev: Device that owns the action
> > + * @action: Function implementing the action
> > + * @data: Pointer to data passed to @action implementation
> > + *
> > + * Releases and removes instance of @action previously added by
> > + * devm_add_action().  Both action and data should match one of the
> > + * existing entries.
> > + */
> > +void devm_release_action(struct device *dev, void (*action)(void *), void *data)
> > +{
> > +     struct action_devres devres = {
> > +             .data = data,
> > +             .action = action,
> > +     };
> > +
> > +     WARN_ON(devres_release(dev, devm_action_release, devm_action_match,
> > +                            &devres));
>
> What does WARN_ON help here?  are we going to start getting syzbot
> reports of this happening?

Hopefully, yes, if developers misuse the api they get a loud
notification similar to devm_remove_action() misuse.

> How can this fail?

It's a catch to make sure that @dev actually has a live devres
resource that can be found via @action and @data.
