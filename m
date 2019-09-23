Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC94C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A231205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732793AbfIWPum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 11:50:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728353AbfIWPul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:50:41 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B670781DEC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 15:50:40 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id x62so18133039qkb.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 08:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cj6Y1lnq7bXcC3kz0vWm87eC1U075TsPfURyzMigVaw=;
        b=YLQAC1O1vDqOrkW1BmKYdYnyiB/xNsl31Tw7QZtL6RSo+Ao5mc/szQrp7Z3LL1yRUW
         uZ+tYahvhddFVdKGMSlnOHqHgk3zdhfDA3LBlgs7pgNwDiSZlrNjw8+cApDXQ2mnzk87
         hN88kxnoeLXvj5VTks4lYGRDjrqDIViNpEvZDy/MtZrWs7+m5yplWUhfaYeLxV4R25eJ
         aldomSkpv9cQIn7KWceXPv2XL8XC2KskvTxYc+Hqm23spHkYj//A6OowqKxYgsPh3got
         jwkeYhvrf3pAZv3+kCgcGOn8Jsuf2AUwS+s7HbJX3Z4r2Qvlfb+3yDU29XKiqEN68E0F
         oLIg==
X-Gm-Message-State: APjAAAXcs6bciHvEt8E5zmSqOh/khwDaIadMUeaimUJWgnK5/TrjJ+Qo
        tjlIurjDH1ks8LJf1CRYW46D3zagtFfc4/oOCgoz4baaOEwuVj/waSizlAKsyrx/eYAhqvNUAJi
        Gd3OkKrv+0FlKT8R/jKbe2w2x
X-Received: by 2002:a37:bc82:: with SMTP id m124mr466933qkf.231.1569253840054;
        Mon, 23 Sep 2019 08:50:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxEKUtkTOCpbmKAVsuN5DEp8c5GEKKqBTQD9x7NMYUI+PUXnD6G5Fo6ixIl97M10Uj/81ScUg==
X-Received: by 2002:a37:bc82:: with SMTP id m124mr466905qkf.231.1569253839907;
        Mon, 23 Sep 2019 08:50:39 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id g10sm5061349qki.41.2019.09.23.08.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 08:50:39 -0700 (PDT)
Date:   Mon, 23 Sep 2019 11:50:31 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        virtio-dev@lists.oasis-open.org, kvm list <kvm@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-arm-kernel@lists.infradead.org,
        Oscar Salvador <osalvador@suse.de>,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [PATCH v10 3/6] mm: Introduce Reported pages
Message-ID: <20190923114946-mutt-send-email-mst@kernel.org>
References: <20190918175109.23474.67039.stgit@localhost.localdomain>
 <20190918175249.23474.51171.stgit@localhost.localdomain>
 <20190923041330-mutt-send-email-mst@kernel.org>
 <CAKgT0UfFBO9h3heGSo+AaZgUNpy5uuOm3yh62bYwYJ5dq+t1gQ@mail.gmail.com>
 <20190923105746-mutt-send-email-mst@kernel.org>
 <CAKgT0Ufp0bdz3YkbAoKWd5DALFjAkHaSUn_UywW1+3hk4tjPSQ@mail.gmail.com>
 <20190923113722-mutt-send-email-mst@kernel.org>
 <baf3dd5c-9368-d621-a83a-114bb5ae8291@redhat.com>
 <49395e48-175f-8483-77f5-5fc3aca8b7cb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49395e48-175f-8483-77f5-5fc3aca8b7cb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 05:47:24PM +0200, David Hildenbrand wrote:
> On 23.09.19 17:45, David Hildenbrand wrote:
> > On 23.09.19 17:37, Michael S. Tsirkin wrote:
> >> On Mon, Sep 23, 2019 at 08:28:00AM -0700, Alexander Duyck wrote:
> >>> On Mon, Sep 23, 2019 at 8:00 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>>>
> >>>> On Mon, Sep 23, 2019 at 07:50:15AM -0700, Alexander Duyck wrote:
> >>>>>>> +static inline void
> >>>>>>> +page_reporting_reset_boundary(struct zone *zone, unsigned int order, int mt)
> >>>>>>> +{
> >>>>>>> +     int index;
> >>>>>>> +
> >>>>>>> +     if (order < PAGE_REPORTING_MIN_ORDER)
> >>>>>>> +             return;
> >>>>>>> +     if (!test_bit(ZONE_PAGE_REPORTING_ACTIVE, &zone->flags))
> >>>>>>> +             return;
> >>>>>>> +
> >>>>>>> +     index = get_reporting_index(order, mt);
> >>>>>>> +     reported_boundary[index] = &zone->free_area[order].free_list[mt];
> >>>>>>> +}
> >>>>>>
> >>>>>> So this seems to be costly.
> >>>>>> I'm guessing it's the access to flags:
> >>>>>>
> >>>>>>
> >>>>>>         /* zone flags, see below */
> >>>>>>         unsigned long           flags;
> >>>>>>
> >>>>>>         /* Primarily protects free_area */
> >>>>>>         spinlock_t              lock;
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> which is in the same cache line as the lock.
> >>>>>
> >>>>> I'm not sure what you mean by this being costly?
> >>>>
> >>>> I've just been wondering why does will it scale report a 1.5% regression
> >>>> with this patch.
> >>>
> >>> Are you talking about data you have collected from a test you have
> >>> run, or the data I have run?
> >>
> >> About the kernel test robot auto report that was sent recently.
> > 
> > https://lkml.org/lkml/2019/9/21/112
> > 
> > And if I'm correct, that regression is observable in case reporting is
> > not enabled. (so with this patch applied only, e.g., on a bare-metal system)
> > 
> 
> To be even more precise: # CONFIG_PAGE_REPORTING is not set

Even if it was, I'd hope for 0 overhead when not present runtime.

-- 
MST
