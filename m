Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16435C04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B81205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="anlXyzLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfEBT2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 15:28:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42387 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBT2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 15:28:34 -0400
Received: by mail-ed1-f65.google.com with SMTP id l25so3145988eda.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 12:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2BtVF69qKBrz9RiY6v2/KzAanhM7UTkuvfK1eqLRPts=;
        b=anlXyzLHl7/mu36RIFAIxcKsrMSkce8RmXLT6gA8XWonyrduEZz1Kg+UsC5D7z8FMT
         pj/5pMF5ClMHohgj3ZkruEIp4c2E5vQjyL591Z6YSXLnoKPyWVamFD6tN0pTpi2Xf+h/
         6EzBRSlftPpfc3PWdfVmuQ20DUG8J6I1uPHl0PHVXqEYgJSmeLguWSTy+gizwQEVh6D4
         zU9Rll/WLv1aAxKOG1/NLVtaNEEZD0tv0yxKuRd4XH5bskMKWYH80Kho+m1Dm+hRb0yt
         zHtzKyeb1W4lTDOJ3OHpU0hw3N/Lnedq8p2bBwEGvzkeS6cCOEC/t+VkwYNJtyLd9K+K
         BM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2BtVF69qKBrz9RiY6v2/KzAanhM7UTkuvfK1eqLRPts=;
        b=FhLASa0AeEEhCH6sUSyoLYFUeIromr9yZNUbipz+DJ/zn4AFkg+VCXHdw095ASdciF
         xhYyKeqBFblpfGv12Ny3Tr+z8yiCXtGiLTqK2fCnQkC9c5Iwem1GCfPtpw6fd98eiCD3
         xep+61tH8CDLB8aWfUe51bzJU3U/oOcI2Bqzj4m9cTA/EH+Oqecyn5NGS8q94/R8cTrk
         Q1yBYA2ekG+NqaBzp+UBYmkZ7QQ76iV2Q1LJ8uheH0TnNHJWjwmMmq3NPiFy+DcQgALJ
         Eiatq7grLfOFF+E2UmyAWQ7wGnPfcDiDuijm2nnEuFQlGAwrHrQq6papITSjYGSU5BjE
         lHcg==
X-Gm-Message-State: APjAAAWYg5XgZ1JbvQsH5PyB6J9tol0M/XWgQTddmEtFVIjwF9kdDAdm
        jIJaB0Htegql7jKCZXyflrwDajjhm4MznE1jbZoQoA==
X-Google-Smtp-Source: APXvYqzhKsKRt3YYywySk19JgdcvKgG4zttzP8aHLHqRlNIg61SzvLJCSfVQUqqi+2uhnhEboRWyoEvmzKYQf/GF1Ns=
X-Received: by 2002:a50:b4f7:: with SMTP id x52mr2879275edd.190.1556825312425;
 Thu, 02 May 2019 12:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552636181.2015392.6062894291885124658.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155552636181.2015392.6062894291885124658.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 2 May 2019 15:28:21 -0400
Message-ID: <CA+CK2bAfw=pkYF2Ux-PM5r7U46JbDA-fM3NjQ3a5F_Fs0D0GHA@mail.gmail.com>
Subject: Re: [PATCH v6 05/12] mm/sparsemem: Convert kmalloc_section_memmap()
 to populate_section_memmap()
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 2:53 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Allow sub-section sized ranges to be added to the memmap.
> populate_section_memmap() takes an explict pfn range rather than
> assuming a full section, and those parameters are plumbed all the way
> through to vmmemap_populate(). There should be no sub-section usage in
> current deployments. New warnings are added to clarify which memmap
> allocation paths are sub-section capable.
>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

 Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
