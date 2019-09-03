Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AA1C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 23:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FE222CED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 23:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="s6bPlWOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfICXMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 19:12:05 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45553 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfICXMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 19:12:05 -0400
Received: by mail-oi1-f194.google.com with SMTP id v12so14269402oic.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 16:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mlQLaQvlkXWHfbC0WkbcIK1OnJ+9V9jk2J6qDB3o7A8=;
        b=s6bPlWOvTnGCHmLDSYs6mvInP+peq6dPXre2Is4PBVi7Nzs550bzm0b9j5BomfQrPW
         Gm7QeBnbt4KhYmd40QSjlxh/3Yot4knxhsgBD7GX+QZXm5SkmBI/QxgtA/3StiXJqn/Z
         b7bUa1Ll0A5MgaLxwDbC8VE5rsrR+OMLC4l1uxGtNWNE100rq4dPLH0NiCIugaIM/HDh
         ahlKEnaC8IKZOdfR8XJfOYMbMBMN0Iaaw7POT/idkQn/lVFfrlrpxEe0UyO3oIF+ozP4
         I+LVpYIx8lyirkkCfC/VVFSPB1pM7pccFLuIA8k+03mctWaGAKt6NJ9kc66ibQHUv+wy
         FJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mlQLaQvlkXWHfbC0WkbcIK1OnJ+9V9jk2J6qDB3o7A8=;
        b=YEaeauQZcHqBT9zjPCVlfJmjVU3o9n8PEZbznFYEHZszc0uQ3sq5tNRiLQ1Toi+tal
         cTOs93CQqiYa7rk0C5Q7WuH6giVCZa/csSlLBsEZZ7ASfFNBgq8u6qDBrgQJSevf9mo2
         g0eyTY3vGQpgFVJFa06aqSqCkPrhF6fkEd+I0MVD5ikkzC3qporY2v2Efdp0YBzB8nf7
         8yaK9vuhkSIAe76faiReGCXGX8eJp5OQW2eKYbnuthfaoMGa5l3g1fuehyVkEtsRT/nl
         ptI2PVpdsdZnpyXQZNGoWTvvp3wEzwweQE5wWI8eYuXG85vXXxaJFbVW67HBzNYRGxI2
         sEqw==
X-Gm-Message-State: APjAAAWXfmMCOzvYa/LFPwLl2A9xVFcLweo6Ra7j6e0h4vv0RAXG/mS9
        Zq1NXyV5dAugvQPCmSIOjvOmCbCgIoPaWGu1VFq00g==
X-Google-Smtp-Source: APXvYqzgcfqwHuR2A7kHVuIHE2Hf+WJ29iTwINYJMmvczfd45lBtiPynxw4hZGlxr0txgFCGFQpVmXsbUbJURLpCn38=
X-Received: by 2002:aca:b245:: with SMTP id b66mr1300871oif.70.1567552324232;
 Tue, 03 Sep 2019 16:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190902205017.3eca5b70@canb.auug.org.au> <20190902105137.GC20@mellanox.com>
 <20190903094511.2704484a@canb.auug.org.au> <CAPcyv4hyEK=jA=ATyzjKbJDeQfpOyRo4pxoFCTf1LHa-muC14w@mail.gmail.com>
 <20190903154232.636d9b3d@canb.auug.org.au>
In-Reply-To: <20190903154232.636d9b3d@canb.auug.org.au>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 3 Sep 2019 16:11:53 -0700
Message-ID: <CAPcyv4hfcO+2UVURKTQCv9vAyDcG_imjv5_DO8qFycv-LY-xkA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the hmm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 2, 2019 at 10:42 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Dan,
>
> On Mon, 2 Sep 2019 22:31:00 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Mon, Sep 2, 2019 at 4:45 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Hi Jason,
> > >
> > > On Mon, 2 Sep 2019 10:51:41 +0000 Jason Gunthorpe <jgg@mellanox.com> wrote:
> > > >
> > > > On Mon, Sep 02, 2019 at 08:50:17PM +1000, Stephen Rothwell wrote:
> > > >
> > > > > ERROR: "nd_region_provider_data" [drivers/acpi/nfit/nfit.ko] undefined!
> > > > > ERROR: "to_nd_blk_region" [drivers/acpi/nfit/nfit.ko] undefined!
> > > > > ERROR: "nvdimm_region_notify" [drivers/acpi/nfit/nfit.ko] undefined!
> > > > > ERROR: "nvdimm_blk_region_create" [drivers/acpi/nfit/nfit.ko] undefined!
> > > > >
> > > > > Caused by commit
> > > > >
> > > > >   126470c8a58b ("libnvdimm: Enable unit test infrastructure compile checks")
> > > > >
> > > > > I have reverted that commit for today.
> > > >
> > > > Looks like more kconfig trouble, can you send Dan your kconfig? I'll
> > > > drop this patch again
> > > >
> > >
> > > Thanks.  It was just an x86_64 allmodconfig build.  I don't actually
> > > have the .config file (it gets cleaned up, sorry).
> >
> > Strange. x86_64 allmodconfig is certainly a 0day build target. Could
> > this be toolchain dependent?
>
> Possible, I guess.  I am cross compiling on a PowerPC LE host
>
> $ x86_64-linux-gnu-gcc --version
> x86_64-linux-gnu-gcc (Debian 9.2.1-4) 9.2.1 20190821
>
> $ x86_64-linux-gnu-ld --version
> GNU ld (GNU Binutils for Debian) 2.32.51.20190821
>
> It could also be an interaction with something else in linux-next.

I was able to reproduce and it seems to be fixed with this change:

diff --git a/drivers/nvdimm/Makefile b/drivers/nvdimm/Makefile
index 6557e126892f..29203f3d3069 100644
--- a/drivers/nvdimm/Makefile
+++ b/drivers/nvdimm/Makefile
@@ -32,4 +32,4 @@ libnvdimm-$(CONFIG_NVDIMM_KEYS) += security.o

 TOOLS := ../../tools
 TEST_SRC := $(TOOLS)/testing/nvdimm/test
-obj-$(CONFIG_NVDIMM_TEST_BUILD) := $(TEST_SRC)/iomap.o
+obj-$(CONFIG_NVDIMM_TEST_BUILD) += $(TEST_SRC)/iomap.o

I'll send it through one more 0day run before asking Jason to try again.
