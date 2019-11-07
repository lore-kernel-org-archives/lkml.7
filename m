Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582B2C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24798214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddw4oBqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388530AbfKGP13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:27:29 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43582 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfKGP13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:27:29 -0500
Received: by mail-pf1-f193.google.com with SMTP id 3so2832629pfb.10;
        Thu, 07 Nov 2019 07:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yilNLCr1c6Ml6FQ1FJVrLK12cLXoyvMqaAPZ1XR1bBE=;
        b=ddw4oBqFIe9B3eABR985yxY2hyMhaBDvBNajIrJF4ywTO8qJO27QmhfYUH46EBomv7
         8QgeBGJARRXT0nT5zQca4fxBJ8J8vdl74VScUxBCeTtqjehzcYRF6mRNMfQkJREKe66/
         2/+QMRFBQXQYRzgmWhChXijxNntU7iDTMezUXqxfoAZL/aDG+7KzTD2ZPxhiN/9YVa7n
         VIHsnoi4gxbzdvVDqOOx8BkeHh+Zh5VEohqOhbswOBwLwGFpBJ3qe1xzskLvMWbOIC9m
         otS9L1QpABxXbGngujhkgJWLx3lsqpUPMDDDnhMmlAKz8qf2zYrBI9msvInhOG8+IHiX
         oxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yilNLCr1c6Ml6FQ1FJVrLK12cLXoyvMqaAPZ1XR1bBE=;
        b=mpH8ENvuUp4pmeYgixxc7zG37oIWzy0OHb1C39ejt3BTmKo9p+oBW+fqZJcAG1YDq/
         uKRttWs/bJaG9F1IGJqq9QUqc3slMRjqTCBkNU5OVktHiyFLBO3+LneV8gdeC1VO3x7/
         hJG1FV3v0k5nG/lmNtrYDz5uWBREQvdgtTghNil0fTTTSgSGfMKNIrPWoDvZDO5Urqmf
         bpZjCLRIz2nQALaRk0J3gxLYjDcTtabYw1SJLoXI596lCWABPe8/NsDjff+wHTgS2w+i
         dBpTL1+Gb1vgur4vgkgTbAyBtm8yihpgYmSaarcnIq74zH5/2yQgDlOFqFJy6y+GmGC2
         783w==
X-Gm-Message-State: APjAAAUiQm4pR2+w3/0JL0nvw1IvhRm4yO8vLoRvMOqAT2jEU+iD/z0p
        PVe9A7qrCXcNC78kKJ589KUdl8VGA2Q9ibUG/hc=
X-Google-Smtp-Source: APXvYqxpLmz49ioA8Vq155EazIHx2dJN5w3RjuTuADatwrxxP3OP2aDmZ1B3eoTR73XTlwo14VI08FPtGOUFVF+tzJ8=
X-Received: by 2002:a63:3c6:: with SMTP id 189mr5152538pgd.4.1573140448063;
 Thu, 07 Nov 2019 07:27:28 -0800 (PST)
MIME-Version: 1.0
References: <20190926192603.18647-1-gayatri.kammela@intel.com>
 <CAHp75Vcrp2ffDCE=tm2dwSEhwfPCPWGhb-Nw0v-7ga2y=_dL8w@mail.gmail.com>
 <BL0PR11MB31709BA9A5F4E4F5455D913CF2820@BL0PR11MB3170.namprd11.prod.outlook.com>
 <MN2PR11MB37113F569E63A2CF3D2AC70BF2660@MN2PR11MB3711.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB37113F569E63A2CF3D2AC70BF2660@MN2PR11MB3711.namprd11.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 Nov 2019 17:27:17 +0200
Message-ID: <CAHp75Vc=+ZLLqv0_w6NzW5j8BLhCBVoNzFtQ7856c6WsogYTUg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Add Tiger Lake/Elkhart Lake support to pmc_core driver
To:     "Kammela, Gayatri" <gayatri.kammela@intel.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Somayaji, Vishwanath" <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>,
        "Box, David E" <david.e.box@intel.com>,
        "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 6:41 PM Kammela, Gayatri
<gayatri.kammela@intel.com> wrote:
>
> > -----Original Message-----
> > From: Kammela, Gayatri
> > Sent: Monday, September 30, 2019 11:24 AM
> > To: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Cc: Platform Driver <platform-driver-x86@vger.kernel.org>; Somayaji,
> > Vishwanath <vishwanath.somayaji@intel.com>; Darren Hart
> > <dvhart@infradead.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; Prestopine, Charles D
> > <charles.d.prestopine@intel.com>; Peter Zijlstra <peterz@infradead.org>;
> > Pandruvada, Srinivas <srinivas.pandruvada@intel.com>; Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com>; Liang, Kan <kan.liang@intel.com>;
> > Box, David E <david.e.box@intel.com>; Bhardwaj, Rajneesh
> > <rajneesh.bhardwaj@intel.com>; Luck, Tony <tony.luck@intel.com>
> > Subject: RE: [PATCH v1 0/5] Add Tiger Lake/Elkhart Lake support to pmc_core
> > driver
> >
> > > On Thu, Sep 26, 2019 at 9:43 PM Gayatri Kammela
> > > <gayatri.kammela@intel.com> wrote:
> > >
> > > Thank you for the series, I'll comment them later.
> > Thank you Andy!
> > >
>
> Hi Andy! I'm wondering if you have any comments for this patch series. Thanks!

Please, address above mentioned comments and send a v2. I'll push it
to review branch.

-- 
With Best Regards,
Andy Shevchenko
