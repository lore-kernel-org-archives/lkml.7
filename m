Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA56C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 01:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2169422CE8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 01:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Ez1qSTYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbfHTBoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 21:44:14 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41789 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfHTBoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 21:44:14 -0400
Received: by mail-oi1-f196.google.com with SMTP id g7so2884082oia.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 18:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hiy2qLGFsI5yCOQjtGw2FlRnrKh/058pTpkwHbYjWn4=;
        b=Ez1qSTYyLQaCZn2QMhz67IzLc8/urEfYaskSA3mavaP51YH8ju0nHD9GTDngUpbjbP
         1AiLAnxbvNCGyrPXwBVEu36Q3uaEuDEqiP2VJkxKTCexg2w+ZjewRqlRgykjbOFRlbTH
         2fLPm9B7vaGcBl10TazsQUg322pErV5Xk4X538qIO8M5JcXIZvaCsR4gzqy01slpxyax
         4G8CymZh5RFI/0K2keiFQUFWjyvgpPwfdc90TOWyfBZs4Eyt8GPcrfEYWBqURbl8VN06
         FBPr/5UyLCA35gk26Ovlht9WPFWzb00trqxgpQVrfYqYIqgKxH+fYUvZyy+4n4tgykEC
         7HdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hiy2qLGFsI5yCOQjtGw2FlRnrKh/058pTpkwHbYjWn4=;
        b=I5kXnuGjI/S5cxRMoog1qxG6VTMep4fLbT6PUWDh6kRab+UN41pM8TF6i06RV1zoyx
         YiJ6IDv9XGjHj+uu3qhaZZh0MqMCIstlz6xpJ0MauslKRbAd3P+7Lj/LzSZ6dlxlyEom
         P6r6wcEPeZB/1gjQoClAwCEPfSRyztFI8budN7AHFyGHYaZcK2l4d+XGgYg6qtAevhuw
         noIrNBavRIRJZlcsIEJSTI8joE6+wB/jtx3pgSSE1/x4MYBR87ZynsFG5NdXXdTvwYCf
         5iagM7/fq0tGcrUndVaZ4WjeWVZ1iXcziIXWrAnXmaDriMT38wknM3JTJ6ThO6FDJFFi
         2sOw==
X-Gm-Message-State: APjAAAXYul766PfkSMgrwJs/LqH14ML00aBfKyChVTeGxzHKJmc3Ja0e
        cCNEtLjvESbBDY8Uc+zYJ2e86miKGGAAE4kEW2/c6w==
X-Google-Smtp-Source: APXvYqxaNpMRYLbfGIBxgJOZMZpvJzzYO44wJfPyyGnlz73jF7wI7dbsRvMZy5tGKZb+Q0OELWHnimWe8R9UTMynpps=
X-Received: by 2002:aca:be43:: with SMTP id o64mr15940919oif.149.1566265453559;
 Mon, 19 Aug 2019 18:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190818090557.17853-1-hch@lst.de> <20190818090557.17853-3-hch@lst.de>
In-Reply-To: <20190818090557.17853-3-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 19 Aug 2019 18:44:02 -0700
Message-ID: <CAPcyv4iYytOoX3QMRmvNLbroxD0szrVLauXFjnQMvtQOH3as_w@mail.gmail.com>
Subject: Re: [PATCH 2/4] memremap: remove the dev field in struct dev_pagemap
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
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

On Sun, Aug 18, 2019 at 2:12 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The dev field in struct dev_pagemap is only used to print dev_name in
> two places, which are at best nice to have.  Just remove the field
> and thus the name in those two messages.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Needs the below as well.

/me goes to check if he ever merged the fix to make the unit test
stuff get built by default with COMPILE_TEST [1]. Argh! Nope, didn't
submit it for 5.3-rc1, sorry for the thrash.

You can otherwise add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

[1]: https://lore.kernel.org/lkml/156097224232.1086847.9463861924683372741.stgit@dwillia2-desk3.amr.corp.intel.com/

---

diff --git a/tools/testing/nvdimm/test/iomap.c
b/tools/testing/nvdimm/test/iomap.c
index cd040b5abffe..3f55f2f99112 100644
--- a/tools/testing/nvdimm/test/iomap.c
+++ b/tools/testing/nvdimm/test/iomap.c
@@ -132,7 +132,6 @@ void *__wrap_devm_memremap_pages(struct device
*dev, struct dev_pagemap *pgmap)
        if (!nfit_res)
                return devm_memremap_pages(dev, pgmap);

-       pgmap->dev = dev;
        if (!pgmap->ref) {
                if (pgmap->ops && (pgmap->ops->kill || pgmap->ops->cleanup))
                        return ERR_PTR(-EINVAL);
