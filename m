Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D49DC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB00021907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="fflVkpkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbfIROlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 10:41:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37398 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfIROlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 10:41:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id r4so231913edy.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 07:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WbdKZkVaqIeYXFAePQEUm0K6Q0pnIntJd0Ufr5WX588=;
        b=fflVkpkGmtKJ99haJdbinaGgTE5566RU3Ym0c0y8xZgW/dkasHGT/Jm18khXW6sWj2
         JH7Lt2KLvkYOCBD02BJ7KKYBAK24/dZ90xwa9siV5DIpJKjgRDHtFezwPqi1WYOMesPT
         2c0IGzpi7BnmF+lFnm8npt+rD4ybvXsivPyksghyz07fYAWfeQyKWjrt3prFugMo+zb/
         F/Y61NpZ75Ji3+fCoK/L13w9dgTZRQgPIOEUOPjdxNmzxVvbZXsFPkucoY51nFizv044
         OK/99jaffqyHYTJmvF0gLWAJL0AMX7OTosCnFpiDtp4WfbUtvs4C/tuYjUOJBDIpycyY
         ZW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WbdKZkVaqIeYXFAePQEUm0K6Q0pnIntJd0Ufr5WX588=;
        b=Q9Itz4FPOaEceqXHXNWpZBd7ZxqHAVuewpzNolpqX2BuPy4D+sWeeXM7h8c1y/pZ3h
         CBCMXgIL0SwzZyEraakShqlrmcjxVY0cR7ELsU3i4Y4FxuOvDIXF8iGQbGcYjlBDOQjr
         Hkqt2Ipg4/tJFfUZMhYYyClsm3kppcbBU8l5epoWw55LC+Eyf4UDRhL9YB9TKnWcRTqp
         qR9Yh124cQYCF3ZfKHwDsHwPo0JR2v3LR6fhm/kCocU0+YqHIJ5jrY0RdAjARxToWtB1
         Tfj6iX+FidgQkuFTGFmzl0CyVg5NF8RIbjuVBBfff3zRCL7JfSET5N6uPyUfmJ6qT3bb
         tICQ==
X-Gm-Message-State: APjAAAWibEaTQxrhQynlzFf/sNTaHQI74iBS53u0y9TO0cNt/eugOZYL
        elEacOkJLNHFGVY/lwqUgqqYtA==
X-Google-Smtp-Source: APXvYqxgmeVfhtDEtiJtgOKdVinAYjDvcBpPFWpBlvemIoPiWexeB0TF1pS1tIUsLeUKYzTg9rflAg==
X-Received: by 2002:a50:fd10:: with SMTP id i16mr8082111eds.239.1568817659723;
        Wed, 18 Sep 2019 07:40:59 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j1sm681317ejc.13.2019.09.18.07.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 07:40:59 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 55925101B27; Wed, 18 Sep 2019 17:41:02 +0300 (+03)
Date:   Wed, 18 Sep 2019 17:41:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH 1/7] mm: Add write-protect and clean utilities for
 address space ranges
Message-ID: <20190918144102.jkukmhifmweagmwt@box>
References: <20190918125914.38497-1-thomas_os@shipmail.org>
 <20190918125914.38497-2-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190918125914.38497-2-thomas_os@shipmail.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 02:59:08PM +0200, Thomas Hellström (VMware) wrote:
> From: Thomas Hellstrom <thellstrom@vmware.com>
> 
> Add two utilities to a) write-protect and b) clean all ptes pointing into
> a range of an address space.
> The utilities are intended to aid in tracking dirty pages (either
> driver-allocated system memory or pci device memory).
> The write-protect utility should be used in conjunction with
> page_mkwrite() and pfn_mkwrite() to trigger write page-faults on page
> accesses. Typically one would want to use this on sparse accesses into
> large memory regions. The clean utility should be used to utilize
> hardware dirtying functionality and avoid the overhead of page-faults,
> typically on large accesses into small memory regions.
> 
> The added file "as_dirty_helpers.c" is initially listed as maintained by
> VMware under our DRM driver. If somebody would like it elsewhere,
> that's of course no problem.

After quick glance, it looks a lot as rmap code duplication. Why not
extend rmap_walk() interface instead to cover range of pages?

> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> 
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> Reviewed-by: Ralph Campbell <rcampbell@nvidia.com> #v1
> ---
>  MAINTAINERS           |   1 +
>  include/linux/mm.h    |  13 +-
>  mm/Kconfig            |   3 +
>  mm/Makefile           |   1 +
>  mm/as_dirty_helpers.c | 392 ++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 409 insertions(+), 1 deletion(-)
>  create mode 100644 mm/as_dirty_helpers.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c2d975da561f..b596c7cf4a85 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5287,6 +5287,7 @@ T:	git git://people.freedesktop.org/~thomash/linux
>  S:	Supported
>  F:	drivers/gpu/drm/vmwgfx/
>  F:	include/uapi/drm/vmwgfx_drm.h
> +F:	mm/as_dirty_helpers.c

Emm.. No. Core MM functinality cannot belong to random driver.

-- 
 Kirill A. Shutemov
