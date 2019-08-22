Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8861C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 03:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F5E22CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 03:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="eXE3475x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbfHVDjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 23:39:45 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34461 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfHVDjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 23:39:44 -0400
Received: by mail-oi1-f194.google.com with SMTP id g128so3340033oib.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 20:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DcgDXQJ7Sbm8FXh01qFeLyuuK1Iph1Tzrxc/aBWGcaU=;
        b=eXE3475xcHKKW5d+UZ3aQkd3F+q2lJG32c4rQx+Ll5k/X1A8KvcDqn+zrnRMvF2zXu
         DvqY89e1izlDq1R7kc5hmQRlOI+bJRAO1zmN4/b3qaKNzXZEkGJlRFKeT4CTOupOuefj
         zg9VgInCIVMy17OpVT7sSsuEFLnfkPgH4Gpr0vKEB8Vx/2OPR6n/2+AhC+sMP0CDaZU/
         FdO6j0esA09TtJJjBjWhXyr0/bc6Xz85XfBzDl4KZ06k2rGr/ypYbAv5CJMHqZLXIPHd
         tFqZvTuZvIngmIS+OxaCARJSeAjrwdpjWtfnrGylPxg7K5loiMiHMpdLjy2Eaq/1cmyW
         dn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DcgDXQJ7Sbm8FXh01qFeLyuuK1Iph1Tzrxc/aBWGcaU=;
        b=s7YE0jbrMH/LrAP9wjJ1gCTwddHwVggRvxJ16Eut5eOsDTYuHFDyqXmM6E3TdGtJAS
         HrGa1XkNZKGrm+72I2jF/Hy8lmkEjw95OAAvXCiCglES0FLsjL1GTV0nox66SymXhxUQ
         buM8jqgXHxYnvwPI6B2Dxqq78J+jEE+Ud9e/Wh89lDiZXVg1miqSa+mRsWB9Cx4/j+wh
         lUXOTPFPnHW1vkh9QffTp9dUCXwm2HNZwA021RNabHEvFh3W116o2EleEhCZMWLia6/P
         gxYCssVOykEopTapUj9PgGBnq5Ow5k8flWNYZE8jDBDAWTgVe11MeR6QMhr5GR7MsE5O
         WPuA==
X-Gm-Message-State: APjAAAWJ+qmb2YRBbIup0+5JEuzPHG4ZdsL2HBPEd+5lrVxQUj/pqfOG
        qLhLjM8ID173im2Bt6qpHyeHmh86HpjQMTZsoW6wtA==
X-Google-Smtp-Source: APXvYqzSAJh90ed5uEoS1LSslo2SckTHl8JI7KY/tC5msX3Q9Ql8Er8WnuH87s+JOWBY8v+KaWLN9APIZd2VEdUR1OM=
X-Received: by 2002:aca:d707:: with SMTP id o7mr2421106oig.105.1566445183805;
 Wed, 21 Aug 2019 20:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190818090557.17853-1-hch@lst.de> <20190818090557.17853-3-hch@lst.de>
 <CAPcyv4iYytOoX3QMRmvNLbroxD0szrVLauXFjnQMvtQOH3as_w@mail.gmail.com>
 <20190820132649.GD29225@mellanox.com> <CAPcyv4hfowyD4L0W3eTJrrPK5rfrmU6G29_vBVV+ea54eoJenA@mail.gmail.com>
 <20190821162420.GI8667@mellanox.com> <20190821235055.GQ8667@mellanox.com>
In-Reply-To: <20190821235055.GQ8667@mellanox.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 21 Aug 2019 20:39:32 -0700
Message-ID: <CAPcyv4iiuFD+5qNEpU9Cpg7ry-tLu2ycvLv8Hfomnuu+857sww@mail.gmail.com>
Subject: Re: [PATCH 2/4] memremap: remove the dev field in struct dev_pagemap
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 4:51 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Wed, Aug 21, 2019 at 01:24:20PM -0300, Jason Gunthorpe wrote:
> > On Tue, Aug 20, 2019 at 07:58:22PM -0700, Dan Williams wrote:
> > > On Tue, Aug 20, 2019 at 6:27 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> > > >
> > > > On Mon, Aug 19, 2019 at 06:44:02PM -0700, Dan Williams wrote:
> > > > > On Sun, Aug 18, 2019 at 2:12 AM Christoph Hellwig <hch@lst.de> wrote:
> > > > > >
> > > > > > The dev field in struct dev_pagemap is only used to print dev_name in
> > > > > > two places, which are at best nice to have.  Just remove the field
> > > > > > and thus the name in those two messages.
> > > > > >
> > > > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > > > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > > > >
> > > > > Needs the below as well.
> > > > >
> > > > > /me goes to check if he ever merged the fix to make the unit test
> > > > > stuff get built by default with COMPILE_TEST [1]. Argh! Nope, didn't
> > > > > submit it for 5.3-rc1, sorry for the thrash.
> > > > >
> > > > > You can otherwise add:
> > > > >
> > > > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > > >
> > > > > [1]: https://lore.kernel.org/lkml/156097224232.1086847.9463861924683372741.stgit@dwillia2-desk3.amr.corp.intel.com/
> > > >
> > > > Can you get this merged? Do you want it to go with this series?
> > >
> > > Yeah, makes some sense to let you merge it so that you can get
> > > kbuild-robot reports about any follow-on memremap_pages() work that
> > > may trip up the build. Otherwise let me know and I'll get it queued
> > > with the other v5.4 libnvdimm pending bits.
> >
> > Done, I used it already to test build the last series from CH..
>
> It failed 0-day, I'm guessing some missing kconfig stuff
>
> For now I dropped it, but, if you send a v2 I can forward it toward
> 0-day again!

The system works!

Sorry for that thrash, I'll track it down.
