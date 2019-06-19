Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A433FC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785102173E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="bQxaHy91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbfFSQ1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:27:48 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46602 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfFSQ1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 12:27:47 -0400
Received: by mail-ot1-f66.google.com with SMTP id z23so19884423ote.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 09:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sYm3Qu3GmGDbz1iuXTNe7mnFVkd+TNgT0k6IWwxysEE=;
        b=bQxaHy910j6x38V8Y/vXBzNsIRs9m485vwvTdEtDdezgAlfp4sbeCqQJDrgzlVd/2X
         cA7ywo2xqJRXweho1/Tk3BlC4M5zGpUElK5yQp6xAwBf7D+nnGLVOlNWoXbopMsjYAf/
         mYzE2L9ds2G5UFPq7wxbGsdf7sBJ9ZOPYyLdSTRI7xT2c4YUEjVc0Alm83+eoAHZspF9
         qSTPs3HQA1k9eWtmhp3yT+4TAf2czjK5Ofa1X2so4Y5Kvw6aXlTxpIGW7Q1b1PhDTbqL
         /Mt5QOPpJrXSTf/PYdwS1K4nrv9uKYMaLfgGaUkwKsiJlG0+cwiaCgQfia7efDjLeBe2
         7dyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sYm3Qu3GmGDbz1iuXTNe7mnFVkd+TNgT0k6IWwxysEE=;
        b=e00PMn8s5DY2d/wYWkRRg6+jnbRgbzYvnVQcogE9bK5ykVo+vxnCLRpx81oIFp/MpO
         Y4rxgJ9YalxOkOcQEtKaln7hjRHfDZgX68elxRsqhhLR15YPsulNhRFedokVgMIF+TPx
         uu/YofMtc1ralk3Amg+r7+rzc3xv9Gmk2HlMzh2MpuCp+2gHvdzc8Lfg/q2xsf4rXmtO
         M1sICCPmrOdAcMRk3CN40XijfgkErnIR4yjBVV08DR4C9qtQo4KQVDQICJ/oVPEnF546
         4MllDLT6aujckfXooCtNAZvxM5thOdXRQ8E9YK2KNyw0mMbhFx0qooxU+urNG6MSPMrt
         nQTg==
X-Gm-Message-State: APjAAAXP1YChfitqIgZeRjJvxGvD+5URGLuruEsM+H51HyqF9G1mcTcR
        9XMIXO9PaZVNJj1hkp7mzuyNfPb6banwnApSj83yyg==
X-Google-Smtp-Source: APXvYqyPiqsjOVAtYsRiCTCDyTqNTQ8I78Y7xY6a9lxN195JvlaNEod1fL5YZ587kRZQU+mrqYASgfo65cFu2zdLthE=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr9628583oto.207.1560961667174;
 Wed, 19 Jun 2019 09:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <156080474760.3765313.13075804303259765566.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190619112302.GA10534@lst.de>
In-Reply-To: <20190619112302.GA10534@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 19 Jun 2019 09:27:36 -0700
Message-ID: <CAPcyv4gLOqgRLiVoVJiSaY=QE=yOO0mg04oDFe+jXRj=G2xJRA@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm: Enable unit test infrastructure compile checks
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 4:23 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jun 17, 2019 at 01:52:27PM -0700, Dan Williams wrote:
> > The infrastructure to mock core libnvdimm routines for unit testing
> > purposes is prone to bitrot relative to refactoring of that core.
> > Arrange for the unit test core to be built when CONFIG_COMPILE_TEST=y.
> > This does not result in a functional unit test environment, it is only a
> > helper for 0day to catch unit test build regressions.
>
> Looks fine:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> I'm still curious what the point of hiding kernel code in tools/
> is vs fully integrating it with the build system.

The separation of tools/ is due to way the "--wrap=" ldflag behaves.
It can only wrap symbols across a module linking boundary. So to
produce a setup where libnvdimm is ingesting faked responses it all
needs to be built as external modules and relinked.

It's an inelegant way to get some test coverage beyond what qemu-kvm
can do, my hope is that down the road I can use the new Kunit
infrastructure to do something similar in a cleaner / more formal way.
