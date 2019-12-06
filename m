Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E080CC2BBE2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B703C24659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575645962;
	bh=/iyFqzdjWCE/1ladvh5WRTVhYfMABE2N8xjiJODIcBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dQUu6mi2zszNv7UVdpwOqUZ6vYjtMx/pxIKovJrrqnF9t1wUbl+pbVD5x9UcyEytj
	 jOyDY+Pn0Zl1z/BdgXsZCRa/0O42iuv9SYNuYRDGJ/Gujrc5oW+W+Qa9SewdWqx2/+
	 ARo4N3Q0iGsr+xBct5Rjf0UAiXGEyswt3K2L56tU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfLFP0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 10:26:01 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40700 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfLFP0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 10:26:01 -0500
Received: by mail-lf1-f66.google.com with SMTP id y5so5569021lfy.7;
        Fri, 06 Dec 2019 07:25:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ehQLu8k8mjUAanGmyYx+MeCss32pgffQdbVz/2SjwNM=;
        b=q1SH5JmrGeNnpIKv14tWDMQIuM5i7xWlId8PljHxhiCzq038sLO9cwK0pGRbdGQich
         VoeIks+asKnI7TYSYpiirsdcx/vKN2TRy8FVtL5Xj3lOQMWlJqWDLIrdMOEoI1MHeZJ3
         FzqSCWTMCKziR+7DDcK1ExFq+hEprNV6nL5M+XSuK4Lbs0NMZyDPYn/EQu/Ul6GXCGD2
         +eiLfsnmzTvhHbUaH6mUa/gIHC9xwpEKCqTm4i0lKdnQKUDdcRx9ZKJBgA97b2O1y4EE
         eIG7ev4sBBovpsS/jSen1oEY8OBqdB/Xyk0lVUT3OhMczYx+7OKzElazVM1pp/cw00T/
         KGGQ==
X-Gm-Message-State: APjAAAXd9I/LMtTkrT6zPUvpd1ZUKiu6Xlr88E2oYlE+6Pp5BCDCR61C
        VdCJGn1rNBE3hQFIEG8laKs=
X-Google-Smtp-Source: APXvYqyIgT0YRYWFaZulpWl+tH0c4WRtzjyvp74Gwj59+8iPNMeSaI0fkJOgKRlO9Y3dBuHdRES63g==
X-Received: by 2002:ac2:44a3:: with SMTP id c3mr5452943lfm.1.1575645959064;
        Fri, 06 Dec 2019 07:25:59 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id o69sm6782605lff.14.2019.12.06.07.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 07:25:58 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1idFUa-00054S-8o; Fri, 06 Dec 2019 16:26:04 +0100
Date:   Fri, 6 Dec 2019 16:26:04 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        GregKroah-Hartman <gregkh@linuxfoundation.org>,
        RobHerring <robh+dt@kernel.org>,
        MarkRutland <mark.rutland@arm.com>,
        AlanStern <stern@rowland.harvard.edu>,
        SuwanKim <suwan.kim027@gmail.com>,
        "GustavoA . R . Silva" <gustavo@embeddedor.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v4 2/2] usb: overridable hub bInterval by device node
Message-ID: <20191206152604.GO10631@localhost>
References: <20191203101552.199339-1-ikjn@chromium.org>
 <20191203165301.GH10631@localhost>
 <CAATdQgCqYrd_aXN5GDsso+F3WadNx3DQKK3Efk3tgkrv2VXjyw@mail.gmail.com>
 <20191204075533.GI10631@localhost>
 <CAATdQgBcuJenS2VSm+y4Yhn5mWE1P0CGJQ3NRdoe68dd2SRPGg@mail.gmail.com>
 <20191205142641.GL10631@localhost>
 <CAATdQgBK4gWvR06YJ3Z_y5NeqLKYY7Ajc0KG78rG2deR3Ga11A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAATdQgBK4gWvR06YJ3Z_y5NeqLKYY7Ajc0KG78rG2deR3Ga11A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 11:57:30AM +0800, Ikjoon Jang wrote:
> On Thu, Dec 5, 2019 at 10:26 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Thu, Dec 05, 2019 at 03:32:38PM +0800, Ikjoon Jang wrote:
> > > On Wed, Dec 4, 2019 at 3:55 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > > > But related to my question above, why do you need to do this during
> > > > enumeration? Why not just set the lower interval value in the hub
> > > > driver?
> > >
> > > Because I want device tree's bInterval to be checked against the same rules
> > > defined in usb_parse_endpoint(). e.g. although hardware says its maximum
> > > is 255, but the practical limit is still 0 to 16, so the code can
> > > print warnings when bInterval from device node is too weird.
> >
> > But that could be handled refactoring the code in question or similar.
> 
> Yes, that should be worked. I can't exactly figure out how to refactor
> the code for now, but maybe parsed endpoint descriptors are being
> checked with default hard wired bInterval value and after that
> an overridden value should be checked again.
> 
> Actually I don't care about the details of software policies. I just want
> all devices to be handled in the same manner without any further
> special treatments.

I'd say you're indeed trying to give a specific device special
treatment. ;)

> > The fundamental problem here is that you're using devicetree, which is
> > supposed to only describe the hardware, to encode policy which should be
> > deferred to user space.
> 
> The hub hardware has a default bInterval inside which is actually
> adjustable. So I can think setting bInterval is to describe the hardware
> rather than policy.

No, the USB spec says bInterval is a maximum requested value and that
the host is free to poll more often. And that's policy.

> > So I think you need to figure out an interface that allows user space to
> > set the polling interval for any hub at runtime instead.
> 
> Changing the interval at runtime is an another way to solve the
> power consumption problem, but it's not so easy. At least xhci needs
> to restart an endpoint and no devices are changing the interval after
> enumeration stage.

The usb-hid driver actually supports configuring the polling rate
for devices like mice and keyboards after enumeration (through a module
parameter, but still).

Unfortunately, the xhci driver does not yet support this and always uses
the device maximum bInterval. A bug report for this was filed many years
ago, perhaps it's time to address that (adding Mathias on CC):

	https://bugzilla.kernel.org/show_bug.cgi?id=82571

Johan
