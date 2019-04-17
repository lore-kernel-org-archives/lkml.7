Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48030C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1903B217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="qxYyT4+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387468AbfDQWJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:09:55 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46283 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfDQWJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:09:54 -0400
Received: by mail-oi1-f194.google.com with SMTP id x188so21018oia.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 15:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dbqIQjFBMMXB1QiDrqfCIlgRtfAJx8u+7/Kk91bmkDU=;
        b=qxYyT4+3M1kES1Z9MB2Bc+EJPmMxlo39ENZvj07r/1BFoWw3Gzizgk83iGo7ofBitO
         eSnkTptB3wyvaPBZVZS7vu6hUmkZDvrnrzhDfmmwWJduxQ7RySCGfmddd22RIbAi/XRq
         yZNnS2HSE46V8eFMepOGpn0AmC65T5+0Lg+mth0CJ//ZptXecCmfAzLvskzcxg5rDy5n
         RDKbGUzmwqce0+oIRr9rOKmuc1zzcK0gBZxxhcdY/3T6KtbZFldw6MrHriHslysr0OkG
         75uXpkOQRNGAYIuO1cgvKMm6VoxMITLmvb+25APghcgs6GjlpeWuK2Vb93ltPxYVROEM
         Cugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dbqIQjFBMMXB1QiDrqfCIlgRtfAJx8u+7/Kk91bmkDU=;
        b=R2SDqVQk03206R6XJ2ZMcV445C8q8fB80mav/fXhFbHEKMi8V7JhHKcahIYwKQWZE8
         ljHR39M8VNY6VJ/8uYPeuIRtbkwFqEhHEy3aw77zS2S60YJGPMLi2xUizyuUkKzwPiO6
         OUVHQ/eT/4DUJUCvfPOUv8baFYMq8pKMQOZLbnNBUfrmLqdiHCKvsffIG8dB6Xu4gnBt
         njt3lKHEavuiogOi0Xmk/oOop6SJvR7iEroQhJXhD6LJXUsVEVYA7Du6uywon/bkhwKb
         EeOFO+5wfE+XbFqamWxmy10rHlgmnirpg+PkYoRHZkBuhGaepWywcPIuQqcPRQQ1YhP4
         e9bA==
X-Gm-Message-State: APjAAAUm07XNMfX4k945xmGTkpHRiyfc8NZsybgpWRnh+IQZVNRadAgg
        lpk4xn12sk4QqIO9w/sLiNnWKDljNKXLAop1W5084Q==
X-Google-Smtp-Source: APXvYqynMZNwDQfqs8yDEzntG4uXIuFy3zSkRRV7QtLiDk67MpPov0CvVUxNNEfuZQx8w4f3273kBnv/f1nGDvPrj04=
X-Received: by 2002:aca:e64f:: with SMTP id d76mr637171oih.105.1555538993969;
 Wed, 17 Apr 2019 15:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552639290.2015392.17304211251966796338.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190417150202.b7cec444cf81ed44a150ea9d@linux-foundation.org>
In-Reply-To: <20190417150202.b7cec444cf81ed44a150ea9d@linux-foundation.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 17 Apr 2019 15:09:42 -0700
Message-ID: <CAPcyv4jL4V=cV0rb=CYFDN=hs-1ETyH8JXJ2DOT3iB4UQemJXw@mail.gmail.com>
Subject: Re: [PATCH v6 11/12] libnvdimm/pfn: Fix fsdax-mode namespace
 info-block zero-fields
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     stable <stable@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 3:02 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 17 Apr 2019 11:39:52 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
>
> > At namespace creation time there is the potential for the "expected to
> > be zero" fields of a 'pfn' info-block to be filled with indeterminate
> > data. While the kernel buffer is zeroed on allocation it is immediately
> > overwritten by nd_pfn_validate() filling it with the current contents of
> > the on-media info-block location. For fields like, 'flags' and the
> > 'padding' it potentially means that future implementations can not rely
> > on those fields being zero.
> >
> > In preparation to stop using the 'start_pad' and 'end_trunc' fields for
> > section alignment, arrange for fields that are not explicitly
> > initialized to be guaranteed zero. Bump the minor version to indicate it
> > is safe to assume the 'padding' and 'flags' are zero. Otherwise, this
> > corruption is expected to benign since all other critical fields are
> > explicitly initialized.
> >
> > Fixes: 32ab0a3f5170 ("libnvdimm, pmem: 'struct page' for pmem")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Buried at the end of a 12 patch series.  Should this be a standalone
> patch, suitable for a prompt merge?

It's not a problem unless a kernel implementation is explicitly
expecting those fields to be zero-initialized. I only marked it for
-stable in case some future kernel backports patch12. Otherwise it's
benign on older kernels that don't have patch12 since all fields are
indeed initialized.
