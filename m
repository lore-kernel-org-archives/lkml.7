Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EA9C04AAA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D193D2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="oY66xYN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfEBTSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 15:18:49 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36433 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfEBTSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 15:18:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id a8so3149380edx.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 12:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/EtrDUZnPlRu7IrcyamY8IpVJksLUEb2L4C6Vl0TUQE=;
        b=oY66xYN+gJbH6VpzA77vhKfQaiig9FE2gWSvaganWGQHxbnAWNBjdK5IxmHDl/lulB
         6W2/Xu6OkEtP8EzI5IoyuCT9YBGVw5tvyjPDFWBkUqfZQpnYmkvUeHHSR6HD9M3whi9I
         0RcBrH0LDorwvHBC018lfCEvaAiT8BwChZuwyw0bGNQ8t6reNn9yI72NAJTHpjLRUJlg
         LCM39zL0LwzvspTxYRli24Jer9qJRz+CVCjC6684O6EDMB0WaaYj3PyULoK2HTbRkXDi
         ghyRy0ZVgVkbC6WyahwWy/PSLoe00mm05d6lyrce//A9Vuv45sVK7mWoQ+xalrdJVd8R
         AILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/EtrDUZnPlRu7IrcyamY8IpVJksLUEb2L4C6Vl0TUQE=;
        b=SvYC0LFoN/TRhQKDl7DBBoWVYb1pvRMaMgOP6QFrwUuXlLGv5uEqOdb8m9o89HS0G9
         dtSKoiHFAdfgIieQd6yEMXAEEhLdoNfe+CPFkw3Le/mMyDUoLfa+V371p8C3Szs9hB5J
         45nZIxV/XGTdNEEyloolz7JSnwBr0i7nwjiduqvGzrwO4TqB0fSDfY7pyZw+EFuVfNxh
         J6diObkF7N4VxS5RIr8BqfiAKcPJp3c+E0rh6p2DZdg2LY4va6WImaNDopsqS81ARZLh
         /kXOgnCNOx/XGE4bLI4IY0Eph515qY0//Po/5ZR+eunfQXvVbQp2zFmZhLNPUA/3anNR
         JEIQ==
X-Gm-Message-State: APjAAAW0YJU5cTCy4jqDt+8Vp2JQx6/P8xxgwDTaLmbFj9UnOY1UGsHd
        JZ/loiCLQwMNc1XKDFHZVO6LkpDbY2fdct/cvTrvSQ==
X-Google-Smtp-Source: APXvYqzLcGp30q9Ib2/zU1la10GlqsQhJRi/epzUUZiwaqPYnOeJoISItPcXmhWHqTVl0n32Bm0pjTtLjkVqAOIx8xo=
X-Received: by 2002:a50:fb19:: with SMTP id d25mr3732372edq.61.1556824727400;
 Thu, 02 May 2019 12:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552635609.2015392.6246305135559796835.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155552635609.2015392.6246305135559796835.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 2 May 2019 15:18:36 -0400
Message-ID: <CA+CK2bD2b5XZCxGXQ47XXRA2RFvc69u2LKx7pu4Mtvw_ezMDLg@mail.gmail.com>
Subject: Re: [PATCH v6 04/12] mm/hotplug: Prepare shrink_{zone, pgdat}_span
 for sub-section removal
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 2:53 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Sub-section hotplug support reduces the unit of operation of hotplug
> from section-sized-units (PAGES_PER_SECTION) to sub-section-sized units
> (PAGES_PER_SUBSECTION). Teach shrink_{zone,pgdat}_span() to consider
> PAGES_PER_SUBSECTION boundaries as the points where pfn_valid(), not
> valid_section(), can toggle.
>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/mmzone.h |    2 ++
>  mm/memory_hotplug.c    |   16 ++++++++--------
>  2 files changed, 10 insertions(+), 8 deletions(-)

given removing all unused "*ms"

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
