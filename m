Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A375C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DDE20657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="aTNnToCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfFQRwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 13:52:04 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34426 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFQRwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 13:52:04 -0400
Received: by mail-ot1-f65.google.com with SMTP id n5so10188888otk.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 10:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GjmvPRW/EB2UZMiXQmlwdUn3cNZy7MEt9OXtWGJNxz0=;
        b=aTNnToCYbt/RLgFmZg1PIvrCe0JVP4C32RN5cfyMVp2zYXXYY11JnD0P5Xn5tfOK6Y
         voW3Syk7UYIIG5SF4LSMDVtOlpmEa0YxFfvlu8+J6wAb/HPFiX2GuYxqo+V2fpMpF+jS
         NlrpFBkRARTzBSJzVDZzE7bQS2UMHOvFRAjYRiT9xL8/lOeALYe1ebk8LfMUYkoFpZaD
         PAFxFM2FYNf4FyGaTFye24KEnD9WdtERxcyZTxLFaidHht03PVJNbu4TuZbdbzHMaWbM
         oEiXMcpcSzAKgjPufMTuJybkt3G4uT6kQCK3aNOgUOJV87J/VA4uKxPCVrEi1MqSqx3i
         hB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GjmvPRW/EB2UZMiXQmlwdUn3cNZy7MEt9OXtWGJNxz0=;
        b=esGO/MZvbG3aSuBftrATdCLhXcDwuzIMuyBJLq58kRc0IsLrB2NdQ0/RWrPIOIfv/z
         7lQABa2iHF2DugxBnMCPIWKQNC4zrWbOxPBWW1eHeKgHi7W4Jyc/Wlh4nQQynte75E4Q
         PDFO+UXdodNp0yXwg/4+UbrhybRQSnDmgo8Lg4bPo47B4gth3msR7+So84kKmvWQOSue
         aUsWnbJEi6EI2rnlYQTsrSq2dEpRUeUxYjyksUvM73C2fxqFf2ZPyRyyyXE3K2lfLKsy
         GM8r5hJLnif3npskpdK0q5ZJ5cJKlbKHUI0OBxJd1/gvULAK4GRx77z4EimRBN/bSUEz
         okCA==
X-Gm-Message-State: APjAAAXHMZN+C+bZG8aSeOCf05i32SG9AI70+FOxIznFXa9OUA2hXH+P
        inBy0A5fvtJfmXPRypitjhLDA+yeqfbZwvUbk0Rg2g==
X-Google-Smtp-Source: APXvYqyhtBEP50oerFZs8TdK9nCsvOJRWYCWzRd2vhiNPfCpga0Ba5N2yHiBCHm+W4K6XflHhEhbg4A9IXDkc+ucm/c=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr54836696otn.247.1560793907524;
 Mon, 17 Jun 2019 10:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190617122733.22432-1-hch@lst.de> <20190617122733.22432-9-hch@lst.de>
In-Reply-To: <20190617122733.22432-9-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 17 Jun 2019 10:51:35 -0700
Message-ID: <CAPcyv4i_0wUJHDqY91R=x5M2o_De+_QKZxPyob5=E9CCv8rM7A@mail.gmail.com>
Subject: Re: [PATCH 08/25] memremap: move dev_pagemap callbacks into a
 separate structure
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 5:27 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The dev_pagemap is a growing too many callbacks.  Move them into a
> separate ops structure so that they are not duplicated for multiple
> instances, and an attacker can't easily overwrite them.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/dax/device.c              | 11 ++++++----
>  drivers/dax/pmem/core.c           |  2 +-
>  drivers/nvdimm/pmem.c             | 19 +++++++++-------
>  drivers/pci/p2pdma.c              |  9 +++++---
>  include/linux/memremap.h          | 36 +++++++++++++++++--------------
>  kernel/memremap.c                 | 18 ++++++++--------
>  mm/hmm.c                          | 10 ++++++---
>  tools/testing/nvdimm/test/iomap.c |  9 ++++----
>  8 files changed, 65 insertions(+), 49 deletions(-)
>
[..]
> diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/tes=
t/iomap.c
> index 219dd0a1cb08..a667d974155e 100644
> --- a/tools/testing/nvdimm/test/iomap.c
> +++ b/tools/testing/nvdimm/test/iomap.c
> @@ -106,11 +106,10 @@ EXPORT_SYMBOL(__wrap_devm_memremap);
>
>  static void nfit_test_kill(void *_pgmap)
>  {
> -       struct dev_pagemap *pgmap =3D _pgmap;

Whoops, needed to keep this line to avoid:

tools/testing/nvdimm/test/iomap.c:109:11: error: =E2=80=98pgmap=E2=80=99 un=
declared
(first use in this function); did you mean =E2=80=98_pgmap=E2=80=99?
