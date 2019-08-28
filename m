Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645D7C41514
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6722189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbs47XKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfH1PGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:06:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40846 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfH1PGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:06:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so1620751pgj.7;
        Wed, 28 Aug 2019 08:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uQEfLMG3TnQ4c27LmLDMotrBwLZwv24Uyoxsstmog3Q=;
        b=dbs47XKylRv5PUp5OgY8YWS8zONTkSXbHA9wmBWV2s2rOs0LjaSevk8oDjSs/vA+Iz
         F3XtgUgrrit4fTDtzZAXbwO+xBrKIVPK+2dZbSN6BqEQUzdDeWnTy85E0DtagWKOunbG
         sMrPu3K6CHA7Z7eQGwKml7IikFgEhi4T1fp5S8DBCiIQzsNjg+lPU62Bc82hyGrSoPmC
         69dpdLXh2cLqLceBzZz/q4AaKOoh+jAOIdmDvgzjzCZ+40bQfoU8hp+F6YpB+90oNEU7
         ZvplHvpZC9fSd1FHtpIXFpknz5eNIrNWEDuDAUw0t367ZKvuq8N7Uv1iWHTZ1zORjrqZ
         lq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uQEfLMG3TnQ4c27LmLDMotrBwLZwv24Uyoxsstmog3Q=;
        b=Jai1vVaIOMtiUbJ4Ijg2P3LbRDtWtmSxnrHOOezKvuHBwF2ByVqlXVD69Hfw0/X+9t
         Aln3e1GLn1q3JwtFEqOJ+pM2m4vaHIiDT6COQ/jItHK6mkV5dTAZxGLBO6R0WfLBx457
         UQcXYvpxywiEYWqZR6poOFJJt3xnhIiEVglRdsctsuU73g3Gm17vAxqFh0hJpjuDPGBv
         Fh/EmrzPHm+MSsBFrVroAR8RwrbjPf4SvynDtvl0ViYXckHpJsz0Q4c313ctSMmlbVDB
         neA26FGt4PKlD3N1G2nvNTv2hDM3yudpF5k2oTVscLy8RirL2iSz9TYKvt0dK9riuLb7
         j9rg==
X-Gm-Message-State: APjAAAWsUsv8nYyF7+cRXu9+YOQqO1CXgWTWgt6BuatO7q7euk+/Tbq2
        1dMXW4fKGuIZongzIqtaikU=
X-Google-Smtp-Source: APXvYqyufDB4Uzqc91b/XtEIhS/sG3zG9APdnUA0Phsv3Vm1mGuepsBDdFEDeiwFuSa8c90GTsECSw==
X-Received: by 2002:a63:2ec9:: with SMTP id u192mr3806345pgu.16.1567004764285;
        Wed, 28 Aug 2019 08:06:04 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id l68sm3103530pfl.11.2019.08.28.08.06.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 08:06:03 -0700 (PDT)
Date:   Wed, 28 Aug 2019 08:06:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] driver core: platform: Introduce
 platform_get_irq_optional()
Message-ID: <20190828150602.GB21494@roeck-us.net>
References: <20190828083411.2496-1-thierry.reding@gmail.com>
 <20190828085724.GA31055@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828085724.GA31055@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 10:57:24AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 28, 2019 at 10:34:10AM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > In some cases the interrupt line of a device is optional. Introduce a
> > new platform_get_irq_optional() that works much like platform_get_irq()
> > but does not output an error on failure to find the interrupt.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/base/platform.c         | 22 ++++++++++++++++++++++
> >  include/linux/platform_device.h |  1 +
> >  2 files changed, 23 insertions(+)
> > 
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 8ad701068c11..0dda6ade50fd 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -192,6 +192,28 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
> >  }
> >  EXPORT_SYMBOL_GPL(platform_get_irq);
> >  
> > +/**
> > + * platform_get_irq_optional - get an optional IRQ for a device
> > + * @dev: platform device
> > + * @num: IRQ number index
> > + *
> > + * Gets an IRQ for a platform device. Device drivers should check the return
> > + * value for errors so as to not pass a negative integer value to the
> > + * request_irq() APIs. This is the same as platform_get_irq(), except that it
> > + * does not print an error message if an IRQ can not be obtained.
> 
> Kind of funny that the work people did to put error messages in a
> central place needs to be worked around at times :)
> 
> Anyway, I have no objection to this, but it looks like it has to go in
> through my tree.  I can take the hwmon patch as well through my tree if
> the hwmon maintainer(s) say it is ok to do so.
> 
Ok with me.

Guenter
