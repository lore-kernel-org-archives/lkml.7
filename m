Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1848FC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66BD218AD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562225296;
	bh=xnjoJ5uRKxN2SwJIRmQ3BoiVS3WzaeR7la2IcTjKU6k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Tt/XEYHBJQ5iB9qjSS01I7KsqEYYy/919bPOyrnNhi+1NRVb9RQ0H5HRrDLH3Lm3a
	 PDzvpBAVReZpA4FdNK0Xk5JxcqxLXKIzBim5YWN/ENPepb4uU40OYEPQCT6/Ornf5u
	 1rV2K/Whr+QRCabKB0AmQC0tv6wpuWSZ9uE43C+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfGDH2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:28:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43848 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbfGDH2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:28:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so5404023wru.10;
        Thu, 04 Jul 2019 00:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yJ2qF6WswaWh96cn5HP5uy/GUcGaruE8FXgQ/WQTJv4=;
        b=osEXVYsxBy03KybZ7sPbEALbw7zYr/2xdVANwUc3oenqNmgeKcMzUt4mE63UZCFnnE
         /veMXWKEeA8c+tdJK4l/RVs70vY24A+4mPsDMA5aj+A3ePtqtPc8iLl5oMfSW15hRi2L
         5VpxqetdRfqn9vLEn3voh8jHpf0r+GOdgD1ylJpaur90bKAJduIGYvMtn00LrI+6lAzp
         oAyACxbapUec7+lA7Ggw6RLsM5cQ91x8gOKHw/rqJchRijUVGPdoiVSHjI33goMXrvh0
         xKU3IjVJ1StQsKeZjGj3C2vwZ1+U6x+8VaMHUyHpoYN/l89scBgLI/1jqgT/CGhzUiPR
         LhIg==
X-Gm-Message-State: APjAAAXrmeiCPz6E47QCsxgL/b0hx9IIYJEelIE+0UX7xUbABRfIORGG
        bhMLYSfRQbEkWHt9cIq1+2M5G3E2/T/PZsh7naU=
X-Google-Smtp-Source: APXvYqyS2u/lE6Z3jB9ospQ0eVycgRKJl0bdmGtr3M8/SxpS3tBKVBAgO7TRgcJ+wGFnscxTUZV1bEYtjz/aTOqPpps=
X-Received: by 2002:a5d:66ca:: with SMTP id k10mr11033017wrw.61.1562225292427;
 Thu, 04 Jul 2019 00:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190704163458.63ed69d2@canb.auug.org.au> <20190704065949.GA32707@kroah.com>
In-Reply-To: <20190704065949.GA32707@kroah.com>
From:   Felipe Balbi <balbi@kernel.org>
Date:   Thu, 4 Jul 2019 10:28:34 +0300
Message-ID: <CAH8TKc_4ggxOPgii8gLGo2d7nvx08cbTk8_xDUQfA2Ckcxb_Aw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the usb and usb-gadget trees
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 4, 2019 at 9:59 AM Greg KH <greg@kroah.com> wrote:
>
> On Thu, Jul 04, 2019 at 04:34:58PM +1000, Stephen Rothwell wrote:
> > Hi all,
> >
> > After merging the usb tree, today's linux-next build (arm
> > multi_v7_defconfig) failed like this:
> >
> > arm-linux-gnueabi-ld: drivers/usb/dwc3/trace.o: in function `trace_raw_output_dwc3_log_ctrl':
> > trace.c:(.text+0x119c): undefined reference to `usb_decode_ctrl'
> >
> > Caused by commit
> >
> >   3db1b636c07e ("usb:gadget Separated decoding functions from dwc3 driver.")
> >
> > I have used the usb tree from next-20190703 for today.
> >
> > This also occurs in the usb-gadget tree so I have used the version of
> > that from next-20190703 as well.
>
> Odd, I thought I pulled the usb-gadget tree into mine.  Felipe, can you
> take a look at this to see if I messed something up?

This looks like it was caused by Pawel's patches.

I'll try to reproduce here and see what's causing it.

-- 
balbi
