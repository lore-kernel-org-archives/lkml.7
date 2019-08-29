Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFC6C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA42423407
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="UDZgtwo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfH2VFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 17:05:02 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32956 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfH2VFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 17:05:02 -0400
Received: by mail-ot1-f67.google.com with SMTP id p23so4888661oto.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 14:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zz/IcpIogQHwbVO/Egjox/eu8Ruvdetizg0QLnWTWdk=;
        b=UDZgtwo0oFSbwbrZ20aRDIUOHVsOZ4QNSGS9i2xZYwSshsp9/Rx+od4w9K5/fI1EzL
         eEvX6n3R9d2FJVEF/ormhBdNO3FTcnJ99qUXUA0bDjdR3Gp9nMHV2syoniOtQtaYaS5Z
         MNrBmcnP1DaiX6cIsQXCAqc9cHw+47E4+lynszEsdDZgQMhRT18vNUKfnoOLNfWCJ3H6
         otegJ/kpPCyGYA7EFiNveGSds+xkWRS2fdfac0KqCIZy2zD4yjAD0x7bgEPgjT9b3bz4
         foAf/nd5dDoGc/34WbE2eWjhELAHjT4DjLyy0jbCfYxqLwBu7REDoKgzCC+NTu7a/XbV
         dc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zz/IcpIogQHwbVO/Egjox/eu8Ruvdetizg0QLnWTWdk=;
        b=bifOVaKEDgxALPRYYtnTYuYB414CL+4LHqDzgADAQ80hhJQUkXm+brDKmOhx7MIQtn
         OxWa2MbVkp9KbdYZ/TXzo7+rQe57HwvVAst7QOwymQvz9eqdjjLYXKkPfTlBdD0WeeAh
         HQoyDqwPsggPRdc9iZfZLtC3RQ8FvsFhlT9/iWjKGN2HyV0oGoeV0lBQAsSYPZNiJvFM
         kalK/v7DnZHOzAP/Rm1IMg1MBq2eb+FrHRecu6b7/hbTl1J0dWlmgE+QT9WIijSSm9v8
         cYro1DzAUcKT5bJNiICYZnDi3w2IYUGtS4d6MBoBy+bY6IBSQ05jiUXpWSIvkuL8GdWb
         aKRw==
X-Gm-Message-State: APjAAAXawHTzX+bjYjS5Q96dn+24RwFMRWelsFT7I45lbZwa7mDva3TK
        Oxn2Lblej7ejNmVjGR2R+1g7x9SW0YRWkLMSG+3OAXtN
X-Google-Smtp-Source: APXvYqyn5q3lBZI9Iea0wDtzH+/TmKJyq6/LhQkuOWmqohDbqlvPKPAPMzwMoHf1pVkA9pIvBmHIiTMv/SrZiOA0wyg=
X-Received: by 2002:a9d:6b96:: with SMTP id b22mr9855859otq.363.1567112701542;
 Thu, 29 Aug 2019 14:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190610210613.GA21989@embeddedor> <3e80b36c86942278ee66aebdd5ea2632f104083a.camel@intel.com>
 <d940183a-c00d-3a96-37bb-9553583f160a@embeddedor.com> <7980d0c0b43bc6f377e0daad4a066f7ab37c2258.camel@intel.com>
In-Reply-To: <7980d0c0b43bc6f377e0daad4a066f7ab37c2258.camel@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 29 Aug 2019 14:04:49 -0700
Message-ID: <CAPcyv4jEgk3Nsax0_KxDEsOPY91_py5NTyh2F58zVcoxaO0_Tw@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm, region: Use struct_size() in kzalloc()
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Jiang, Dave" <dave.jiang@intel.com>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 1:24 PM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
>
> On Wed, 2019-08-28 at 14:36 -0500, Gustavo A. R. Silva wrote:
>
> > struct_size() does not apply to those scenarios. See below...
> >
> > > [1]:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/tree/drivers/nvdimm/region_devs.c#n1030
> >
> > struct_size() only applies to structures of the following kind:
> >
> > struct foo {
> >    int stuff;
> >    struct boo entry[];
> > };
> >
> > and this scenario includes two different structures:
> >
> > struct nd_region {
> >       ...
> >         struct nd_mapping mapping[0];
> > };
> >
> > struct nd_blk_region {
> >       ...
> >         struct nd_region nd_region;
> > };
>
> Yep - I neglected to actually look at the structures involved - you're
> right, it doesn't apply here.
>
> >
> > > [2]:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/tree/drivers/nvdimm/region_devs.c#n96
> > >
> >
> > In this scenario struct_size() does not apply directly because of the
> > following
> > logic before the call to devm_kzalloc():
>
> Agreed, I missed that the calculation was more involved here.
>
> Thanks for the clarifications, you can add:
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>

Thanks, applied.
