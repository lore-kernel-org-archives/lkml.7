Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F814C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F1020836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575990181;
	bh=K76G3cVUUeYZUUxq73YqLUM6DOi9jrR8rIey74F35F8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DkIBqBz1F4sXGuHlQbUHvhJQYlvJTaWTmStsnDDSpPgfjlNN6oT651HnD0rgxPbkb
	 d7Co3SWQW9BGVxxoywevZ6REIWIeQ0ufrQFm6wznIVOs1fXgwi7HJNjueLoUkYnxAg
	 iz+rF8F1kFUrEwfg5Qwst3lw6kjZbgBJdk5NDBiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfLJPDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:03:00 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38766 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfLJPDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:03:00 -0500
Received: by mail-lj1-f193.google.com with SMTP id k8so20232792ljh.5;
        Tue, 10 Dec 2019 07:02:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zZvlC4T9nIKrmQ0za8Fs/QkXcNOS/gB1wIJZfDFQaxw=;
        b=NUecQHZ3IkeyD16Naef7ZaGgEeLuY5VXoi+u9DxfhKmzYjm21jH36a1ucl9QRzow0N
         CvZmHfvhw9dyXdWLvS7amu+1llZXCMdu2JZ7wfzg3TGgRLz6EyQRqtUyBi4Q1WpK6ezZ
         k9t6wecnzk7O8f8VERMFDM6Sqm/Au256B1UxlKFaK6tIOfXz+EUz91z22Tv8gqZcQR/C
         4AscOLwy3irOIMC5Cx8W1Fcj86iNjHk0gutplRHYTxfrl8zEc5aDHCjLy51GdvCyEDSE
         S7TdtpNhRMntZ5mtxxmnzzH7/S2Uu3lp2dxFmWh/ORK9W55SldPqIlg3TkD4FE+pP6MX
         Xx3w==
X-Gm-Message-State: APjAAAVafjyDw9UJED8RpQJ7IL2UmahkaQFH4hDyfTsFeoM52dzQZIW7
        0wJg8klEzZ9vLXS+oaioH6A43QPZ
X-Google-Smtp-Source: APXvYqyYOVuyJGcheKE6lebutv2vO1Q1g7X4vaGbCew/f8TJnvXKBtkx8qoTAWNpjTw/AY/O3Bn8hA==
X-Received: by 2002:a2e:9e16:: with SMTP id e22mr12832375ljk.220.1575990178082;
        Tue, 10 Dec 2019 07:02:58 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id i19sm2047375ljj.24.2019.12.10.07.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:02:57 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1ieh2Q-0007jT-Bt; Tue, 10 Dec 2019 16:02:58 +0100
Date:   Tue, 10 Dec 2019 16:02:58 +0100
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
Message-ID: <20191210150258.GR10631@localhost>
References: <20191203101552.199339-1-ikjn@chromium.org>
 <20191203165301.GH10631@localhost>
 <CAATdQgCqYrd_aXN5GDsso+F3WadNx3DQKK3Efk3tgkrv2VXjyw@mail.gmail.com>
 <20191204075533.GI10631@localhost>
 <CAATdQgBcuJenS2VSm+y4Yhn5mWE1P0CGJQ3NRdoe68dd2SRPGg@mail.gmail.com>
 <20191205142641.GL10631@localhost>
 <CAATdQgBK4gWvR06YJ3Z_y5NeqLKYY7Ajc0KG78rG2deR3Ga11A@mail.gmail.com>
 <20191206152604.GO10631@localhost>
 <CAATdQgDAZ21bEXh+YFh+fCdBxnuRi-1_x0o_hpxW0Vj0zY-j8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAATdQgDAZ21bEXh+YFh+fCdBxnuRi-1_x0o_hpxW0Vj0zY-j8A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 12:05:53PM +0800, Ikjoon Jang wrote:
> On Fri, Dec 6, 2019 at 11:25 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Fri, Dec 06, 2019 at 11:57:30AM +0800, Ikjoon Jang wrote:
> > > On Thu, Dec 5, 2019 at 10:26 PM Johan Hovold <johan@kernel.org> wrote:

> > > > The fundamental problem here is that you're using devicetree, which is
> > > > supposed to only describe the hardware, to encode policy which should be
> > > > deferred to user space.
> > >
> > > The hub hardware has a default bInterval inside which is actually
> > > adjustable. So I can think setting bInterval is to describe the hardware
> > > rather than policy.
> >
> > No, the USB spec says bInterval is a maximum requested value and that
> > the host is free to poll more often. And that's policy.
> 
> Honestly I'm a bit confused on the border line between hardware
> and software definition. That's quite reasonable it's policy that software
> can poll more often than hardware specified, but can we think it's just
> overriding hardware property specifying maximum value from beginning?
> Is it still policy? or 'overriding hardware property' part is already not
> a hardware description? :-S

The hardware is supposed to give you the upper limit, and then software
is allowed to poll more often if it wants to and is able to do so.

In this case that decision depends partly on what is connected to the
hub but also on how that device in turn has been configured,
specifically, whether runtime PM has been enabled or not.

Someone who doesn't use the downstream device, or who prefers to never
suspend it, may not be willing to pay the price for polling the hub more
frequently, for example. 

So this ends up being very much a policy decision which should be left
for user space.

But if you can come up with a generic interface for this, it could be
useful in other setups as well (non-DT, hot-pluggable, etc).

Johan
