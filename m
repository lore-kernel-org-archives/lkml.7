Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F196AECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DC521D79
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569967748;
	bh=8maXamxHXeONn3+/Ht51XGB6KzkeocmyGod4qWb7CnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D5W9XoOpR9vwfmtwN9Oy5cXHoVfD+BiY1euHv98YlTxkhJq7tKbzv3zUGL3w4gaGM
	 5a+Y8XENP5BzO7ahTNqZzyYS5a6j6LnsR/SN+dxH63jt05AH7KdfCic//mplJEJODS
	 LWVYoukQ8jq+KLMRJbghoDXgLIO1uIScFobqloiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfJAWJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 18:09:08 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38108 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfJAWJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 18:09:07 -0400
Received: by mail-io1-f67.google.com with SMTP id u8so52146502iom.5;
        Tue, 01 Oct 2019 15:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=7juTQtP1fGtdijjUC7WXaUFZUEcGC/S0f5sAvsKcGvM=;
        b=fqhjcf9BXhljxP4/ITKBY41/UUT2Y7qzTREbrCQ1snQ+i4jaE4MvZbzfPvBxB7zQkn
         uLe48Cx+VAlbyprrGEvPj3ydx4swophMTxLNIexFrK00G8eRFPPQ6Ol92vJGgTidCPoF
         3ddm9Yf46nJFEfNaiW8SZZEbpM3ng9m6TdbMHWr5WoWs9g39sw/MJqYmuXcaWHvYYtPJ
         dbVGQofAzeq9IXJNsmoO95kJQfz/4samg/JbjdyEcxZp2Xy3G42lsNgvF88JjAayBEZC
         iJSfwKbMaiRnYBdkwPqEEfZN26oGLcH/lKHzEipC64aOH/aXeyqQNcqnUizvb99xrgps
         TK4w==
X-Gm-Message-State: APjAAAWV/uNAqvCnSnGJRgoOGd4HaiO+OmG3iCr5dSjR/SsDbYKdc8tr
        CUehCwK8whRlZm+8wQLSAw==
X-Google-Smtp-Source: APXvYqykolsGzVvLwfhCwCGAeOSwjY/2fBqt0tw6OQPSLhk9S9zxk/mqa6LM3GcbwDVkbcL17Si9Hg==
X-Received: by 2002:a6b:f703:: with SMTP id k3mr464617iog.20.1569967745190;
        Tue, 01 Oct 2019 15:09:05 -0700 (PDT)
Received: from localhost ([2607:fb90:1780:6fbf:9c38:e932:436b:4079])
        by smtp.gmail.com with ESMTPSA id h62sm9876566ild.78.2019.10.01.15.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 15:09:04 -0700 (PDT)
Message-ID: <5d93ce80.1c69fb81.4acf3.4716@mx.google.com>
Date:   Tue, 01 Oct 2019 17:09:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     rananta@codeaurora.org
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Trilok Soni <tsoni@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: Add of_get_memory_prop()
References: <20190918184656.7633-1-rananta@codeaurora.org>
 <CAL_JsqJ2WeW0JHSHZuvo9bbc7JSFBr_qCuOp97i=b6Q+OPY7Cg@mail.gmail.com>
 <19d727bbfce08e59294920ba8097be7a@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19d727bbfce08e59294920ba8097be7a@codeaurora.org>
X-Mutt-References: <19d727bbfce08e59294920ba8097be7a@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 03:32:14PM -0700, rananta@codeaurora.org wrote:
> On 2019-09-18 13:13, Rob Herring wrote:
> > On Wed, Sep 18, 2019 at 1:47 PM Raghavendra Rao Ananta
> > <rananta@codeaurora.org> wrote:
> > > 
> > > On some embedded systems, the '/memory' dt-property gets updated
> > > by the bootloader (for example, the DDR configuration) and then
> > > gets passed onto the kernel. The device drivers may have to read
> > > the properties at runtime to make decisions. Hence, add
> > > of_get_memory_prop() for the device drivers to query the requested
> > 
> > Function name doesn't match. Device drivers don't need to access the
> > FDT.
> > 
> > > properties.
> > > 
> > > Signed-off-by: Raghavendra Rao Ananta <rananta@codeaurora.org>
> > > ---
> > >  drivers/of/fdt.c       | 27 +++++++++++++++++++++++++++
> > >  include/linux/of_fdt.h |  1 +
> > >  2 files changed, 28 insertions(+)
> > 
> > We don't add kernel api's without users.
> > 
> > > 
> > > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > > index 223d617ecfe1..925cf2852433 100644
> > > --- a/drivers/of/fdt.c
> > > +++ b/drivers/of/fdt.c
> > > @@ -79,6 +79,33 @@ void __init of_fdt_limit_memory(int limit)
> > >         }
> > >  }
> > > 
> > > +/**
> > > + * of_fdt_get_memory_prop - Return the requested property from the
> > > /memory node
> > > + *
> > > + * On match, returns a non-zero positive value which represents the
> > > property
> > > + * value. Otherwise returns -ENOENT.
> > > + */
> > > +int of_fdt_get_memory_prop(const char *pname)
> > > +{
> > > +       int memory;
> > > +       int len;
> > > +       fdt32_t *prop = NULL;
> > > +
> > > +       if (!pname)
> > > +               return -EINVAL;
> > > +
> > > +       memory = fdt_path_offset(initial_boot_params, "/memory");
> > 
> > Memory nodes should have a unit-address, so this won't work frequently.
> Sorry, can you please elaborate more on this? What do you mean by
> unit-address and working frequently?

A memory node is typically going to be something like: /memory@80000000. 
So your function will not work for any of those cases. And just 
'/memory' generates a dtc warning.

Rob

