Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D7CC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBF825ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="LYlHNdAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfE3RyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 13:54:04 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46427 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfE3RyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 13:54:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id n12so2333123edt.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 10:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QlYOqgGgItn5hucl8pZOYZeRpF+/j+lyZEX0rN4v98g=;
        b=LYlHNdAV/SNBSa2OU1jdHVGlps7i+f4ToRjbTl9D2wFgpxOnqYU6L0tHRyBKqXN8PS
         bA20mdUlqFwilW74sDweWwxCRjLlo9fuLRBJptvvxIq+vYgZ96pbtG7pADnxLsZ5u6Ed
         xa3CEpbgxATF5V1HpcSCSGovWdI7wIoti8PlUbQ7uPq+eFKDXrzPzbDKxcOs/rbfxHdW
         3wcYT/Y0vSetxxTI7PMr+4dEKBZMAaPHqAJ4cafp6No1HT2gZdPpzYTqxY9BWFqu5i8v
         c8SEsw9ZPMpf8Cmj587OTzTy+La1UCwO9pu1FiOK6SpUJ9aeYM0ra8QLMjn3GNWlh/JN
         PXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QlYOqgGgItn5hucl8pZOYZeRpF+/j+lyZEX0rN4v98g=;
        b=UoSfjEil4UXmxyHoLi2+T587uVQozecNvT70H6dBTFIjnydE2pB+RuflXW1X25bcR/
         U2kagLJDprvcYo6QWr6I0aotLOkyHjhN0Oy530hV3U5vZs15lipoF+rGwWEbGSLNxZXn
         9v3ZSWRjFRAskxW0lvM7oB7sy+KPQzCoPNCcL8zx87RrWHZGX2dqDuBE0jjzjeNDfcMl
         bZRNEBPXjPrEeAckEELYjhU8Nf4cK6BXfiyuclxzd17CS9Os5sPEVB5A3HMvEeIutyUr
         SKrYrRW8cSsIarxYbNChjDDYVD8ZMkEfREzxsd7aug23sCTZ0S2OnmjxorU5CGzKqQ2V
         //Qg==
X-Gm-Message-State: APjAAAXCnM8w6GSVL1PgIJXKMe23AYPz0uzaQ2LZQ47JMcy6IyxnFD5M
        +r6vfXQYdu4u9SX1yHkV2es8C6ug3aPu0cs49DKC3A==
X-Google-Smtp-Source: APXvYqxJpnEky/HQoCMiqMXy5GPOyKza2hJ+52II0wfo1HpL9rVDxjuGoL3UWKguhdIYjncFwf0xnjjAWLfB3JRkG5w=
X-Received: by 2002:a17:906:a354:: with SMTP id bz20mr4932536ejb.209.1559238840892;
 Thu, 30 May 2019 10:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190527111152.16324-1-david@redhat.com> <20190527111152.16324-2-david@redhat.com>
In-Reply-To: <20190527111152.16324-2-david@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 30 May 2019 13:53:50 -0400
Message-ID: <CA+CK2bBW4vH+J6bam1dOxjSwFwvoOEok0VNO0n_JjyHxpkGj+A@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] mm/memory_hotplug: Simplify and fix check_hotplug_memory_range()
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>, Qian Cai <cai@lca.pw>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>,
        Wei Yang <richardw.yang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 7:12 AM David Hildenbrand <david@redhat.com> wrote:
>
> By converting start and size to page granularity, we actually ignore
> unaligned parts within a page instead of properly bailing out with an
> error.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Arun KS <arunks@codeaurora.org>
> Cc: Mathieu Malaterre <malat@debian.org>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
