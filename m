Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEE2C2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24303206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575965201;
	bh=gVwui2577dL2pUfNEe4w3OhJgDRz8B0CsTiK5IRqR4g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=z2UTYPhRNgJxjD418A/eoPhwg98tGJhnIOft6NzHNVWszKqLk5M6uWLs+Y0cqCgJE
	 JXOUF05UCafe8N29TL6A+akSLn6HX9pthIdkxzXe+sYrOHQoY2Tt+F0EGEwFuHvSSR
	 Jrebb7UUqST6G9yRWv1TEE29jjHwylsuMmPHNu0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfLJIGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:06:40 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36806 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfLJIGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:06:40 -0500
Received: by mail-ot1-f66.google.com with SMTP id i4so14764485otr.3;
        Tue, 10 Dec 2019 00:06:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eh72hrhAfXUBpQjvGXyz9qtzGmK/pxlzuig7hgG6ycA=;
        b=DaG0q4J6cZwUcx2kBHBVkShIyeuXB+eBN9fKAwVAxjvBeXLKNWpDaDPoqLQ7vyCQSi
         CqGD1uVOtSfeoqKj1iro7zE3HIefSjttKinaO5wAY793ketvW7/DHk5GsZN1UCRxJeea
         NdSs4lulzF2B/WVDYKylwjKf00xBIAH1eBpU7GqRfYWlqTuhct1lDj562uBRi6VvRqom
         8HDhifTYcDCR7YglscuD63MAqVtckXngNp8/NX3KfbN54y1BuoqFoS96EuYjJBb34RW8
         GdNvUuWJYGsUhtEDlgY/ZQiMb6HXqfzBgMlTLpJlqAxQG/HqCENkSFanX+4DOjZcdRlQ
         I7Nw==
X-Gm-Message-State: APjAAAU0o0zR9MkQwHXFnZVsC462DB8k2FAQ6+Yj4FFSsk1AhRfY8p56
        AyWCBuR6ot91za2AG9KM6V/pNDaKGNFCo0tWVWo=
X-Google-Smtp-Source: APXvYqyzzOzuSDhlPeIXG1zuLoSJlV2JCftfF3DCi+q7hk6xZu98OqjQfWqnznLKM5UYWBFyEzRMGADp1OelyVABS3s=
X-Received: by 2002:a05:6830:95:: with SMTP id a21mr23845111oto.167.1575965199471;
 Tue, 10 Dec 2019 00:06:39 -0800 (PST)
MIME-Version: 1.0
References: <20191202070348.32148-1-tao3.xu@intel.com> <CAJZ5v0hqjR5EdrxcdkLUpxseFiizqNjtA3nYdDtZiSt85JiywQ@mail.gmail.com>
 <6dbcdaff-feae-68b9-006d-dd8aec032553@intel.com>
In-Reply-To: <6dbcdaff-feae-68b9-006d-dd8aec032553@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Dec 2019 09:06:27 +0100
Message-ID: <CAJZ5v0jYb7XQC7u0rmxF-XVMAsEoOfmD11-FYDvMrZuOuzgyiA@mail.gmail.com>
Subject: Re: [PATCH] ACPI/HMAT: Fix the parsing of Cache Associativity and
 Write Policy
To:     Tao Xu <tao3.xu@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 2:04 AM Tao Xu <tao3.xu@intel.com> wrote:
>
> On 12/9/2019 6:01 PM, Rafael J. Wysocki wrote:
> > On Mon, Dec 2, 2019 at 8:03 AM Tao Xu <tao3.xu@intel.com> wrote:
> >>
> >> In chapter 5.2.27.5, Table 5-147: Field "Cache Attributes" of
> >> ACPI 6.3 spec: 0 is "None", 1 is "Direct Mapped", 2 is "Complex Cache
> >> Indexing" for Cache Associativity; 0 is "None", 1 is "Write Back",
> >> 2 is "Write Through" for Write Policy.
> >
> > Well, I'm not sure what the connection between the above statement,
> > which is correct AFAICS, and the changes made by the patch is.
> >
> > Is that the *_OTHER symbol names are confusing or something deeper?
> >
>
> Because in include/acpi/actbl1.h:
>
> #define ACPI_HMAT_CA_NONE                     (0)
>
> ACPI_HMAT_CA_NONE is 0, but in include/linux/node.h:
>
>     enum cache_indexing {
>            NODE_CACHE_DIRECT_MAP,
>            NODE_CACHE_INDEXED,
>            NODE_CACHE_OTHER,
>     };
> NODE_CACHE_OTHER is 2, and for otner enum:
>
>           case ACPI_HMAT_CA_DIRECT_MAPPED:
>                   tcache->cache_attrs.indexing = NODE_CACHE_DIRECT_MAP;
>                   break;
>           case ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING:
>                   tcache->cache_attrs.indexing = NODE_CACHE_INDEXED;
>                   break;
> in include/acpi/actbl1.h:
>
>   #define ACPI_HMAT_CA_DIRECT_MAPPED            (1)
>   #define ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING   (2)
>
> but in include/linux/node.h:
>
> NODE_CACHE_DIRECT_MAP is 0, NODE_CACHE_INDEXED is 1. This is incorrect.

Why is it incorrect?

> And same for enum cache_write_policy.
