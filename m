Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABDBC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17502146E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5qU6jv/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbfDBOkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:40:07 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46880 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbfDBOkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:40:06 -0400
Received: by mail-qt1-f193.google.com with SMTP id z17so15205827qts.13;
        Tue, 02 Apr 2019 07:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LYC+RxtQwxH16TNk/fXaRpRGuPwPLr8g5GZ5yFg0rBw=;
        b=A5qU6jv/8+aiYuIyfUCQAByQ201Llx9m2PYw1oUWZROERdanRIk4kw9N3bGVdxYP5I
         YAPHldO7nuE69j8mg7F3A0tJjN/pxwK1ZQkcBm1EqeihHiLteiiSLjYqvOcmsWTtl5ni
         s+avOEo/cnCcdN52oYgmQHsO3Tv2sT6GDRkmJyFnkWXFc3QrW2G4mogPjrHRmEj6xDE1
         QFiHlZ2OyW+xbV14cqdrl8h8UNeAfMaCf9v6fsfVD7PLGIWsSOu78JwAD9sOhH6af9zp
         J7DggDT+D+Z8bDiMu/HYSgK6igF4Sf7/eMcB3bPqqO6ueKmbdPlRqc842ocn2ZbwCJJ4
         aGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LYC+RxtQwxH16TNk/fXaRpRGuPwPLr8g5GZ5yFg0rBw=;
        b=HV4pIPjrpT2sEjJUTMG4j8bc2TlhRU8BfgvVGjI4iXeHtG1U10vUEY+fuvun64kr5i
         oZQUu1RF8hS7jDZ8XAK3Tl+JC8wCRTvwAL2hDX2azMwDUEpKQfC5ObFx/hqmjdyBk+bq
         NBMthWzBs8c8/SbvCk9Zte2i9rwHlyI+zGB8Zr4C1eiaBXkNJh9OhcKZqSgw9FcIJaDE
         pMOzYtEfQXEz6AhH2fnlH49TtlmM4+PTwsmYByGYOwiU8MdPdHEGjuLj6Ntb+i7ufbkm
         JnovtPs8dQGvkthElwZ/AU3z8C9PIjBryQ/3Qi5uoembQo6dvIoX1FMUhb+5dIx+F8YM
         37/g==
X-Gm-Message-State: APjAAAXg0gaq6Yxe+4vmgYqPyyFV9uMQjtGyG8xH3rgbftt8cks2v3Gi
        t+4gupDl8pU5yHgAxkapfu4=
X-Google-Smtp-Source: APXvYqyoI5aAgR6ke0kibHcIu/438gT7QDatqIz4MBC6eQfXL+WNucZj/rijYaUL5XMvOFVHUeBgMQ==
X-Received: by 2002:a0c:9861:: with SMTP id e30mr59479340qvd.52.1554216005591;
        Tue, 02 Apr 2019 07:40:05 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id t69sm6679961qke.38.2019.04.02.07.40.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Apr 2019 07:40:04 -0700 (PDT)
Date:   Tue, 2 Apr 2019 11:40:00 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Mukesh Ojha <mojha@codeaurora.org>, lars@metafoo.de,
        Michael.Hennerich@analog.com, stefan.popa@analog.com,
        jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH 2/4] staging: iio: ad9832: add SPDX identifier
Message-ID: <20190402144000.pjtygmqi4pxn2p5j@smtp.gmail.com>
References: <20190401143724.mcn73jhdtq3zp3nk@smtp.gmail.com>
 <ac167cc8-4236-2e15-d5f2-fa222d95da49@codeaurora.org>
 <20190401171355.GA19716@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401171355.GA19716@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01, Greg KH wrote:
> On Mon, Apr 01, 2019 at 08:36:50PM +0530, Mukesh Ojha wrote:
> > 
> > On 4/1/2019 8:07 PM, Marcelo Schmitt wrote:
> > > Add SPDX identifier of GPL-2.0 for the ad9832 driver.
> > > 
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > > ---
> > >   drivers/staging/iio/frequency/ad9832.c | 3 +--
> > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> > > index 50a583020072..d8d4a7936275 100644
> > > --- a/drivers/staging/iio/frequency/ad9832.c
> > > +++ b/drivers/staging/iio/frequency/ad9832.c
> > > @@ -1,9 +1,8 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > 
> > FYI
> > 
> > Use C notations here as per https://lkml.org/lkml/2019/2/13/570.
> > 
> > <https://lkml.org/lkml/2019/2/13/570>

OK, I'll check it out.

> > 
> > Once you fix it then you can take mine
> > Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> 
> Did you read the documentation about how to put a proper SPDX line in
> the kernel documentation?  For .c files, you have to use "//", not "/* */"
> 
> Please read:
> 	Documentation/process/license-rules.rst
> and see the section "Style" for all of the details.

Thanks, I'll read it to understand the details.

> 
> thanks,
> 
> greg k-h

Thanks for the advises,

Marcelo
