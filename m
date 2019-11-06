Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06AAC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA232075C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1lHCxJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732111AbfKFQJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:09:09 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33589 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfKFQJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:09:09 -0500
Received: by mail-io1-f65.google.com with SMTP id j13so11154299ioe.0;
        Wed, 06 Nov 2019 08:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eslp/JOdom/CjX+lqK7aTxy3Zlxzb9eP02urmOqXPMg=;
        b=V1lHCxJjL24doCsDQORDRuYc65FLSxoyO+yeN8LQ6+a6bBa7Ni3PHgdIYBdU7z11pX
         bXGhShRrurLCUczQmkOJyEi9BHl2pUwsFmyxRG+NI1GtUov4+1i6LNOgI2zZexAY2f/o
         Q8s0OT1wx0UJNUzVjWrYNPaPoWnUCRxq7OE9RozRf3TeSg+g10rB5gj1a5Fr9+CnDFtO
         xfqP+EwKKRZRJDeFT/W2qyPARmt6kZGCA5iQjzVygViW7ETd1hLvDn3SNavi6482FmPc
         J0SOSX/CfMqlnPZX2yKI1UErVzHzT4Fsv6tcdo5+hHzmzDHLHksnR4k0U414JwgHjqXW
         r0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eslp/JOdom/CjX+lqK7aTxy3Zlxzb9eP02urmOqXPMg=;
        b=cWTwYfOV/RnWum+nhVti3YW+EixQPHdn3h9oimR1s5GAqqzTe2BhGb1v0rSwBoU4jJ
         vdv2KsVuczkujmuQyl3VGgXQ8oXTvVXuTQSrghHZrpFHL1mmdDKoXDxVHra9YXuKJ5IE
         NSxk3lE2bakwwNLEYjFEjd6wbhnQWAr0bW5vJrHBGh47V2DOE0FHCVoUDxojr5GSn+ND
         viOcwJgbaGjeuv15/RZet9Lt45mlfDEJOTSeCtJDWlTSJEZK7qy4I6HDLJRq30A7bzbj
         dk95FbCk1P/8r+GZHEwwI6lUiWqAKNX3llTQVd/XK7WsKBT70Prb86jyqpVskpPWqFqh
         Gpig==
X-Gm-Message-State: APjAAAX99Ynb1TZm4UtjiOWvu+ZO38HjFgn86A+piyFqb2PphCEfCbVr
        FbnWYoZ3klJoVE99oquH5iYBMnnBke3i7FMQkoE=
X-Google-Smtp-Source: APXvYqy5kJoWBZiTxw/dDVVMuUPSYCWnnxAVaiVeezNoTg8iPLqxkU1nEQQY3XC19b0GB5v+uFBmT4TpOwI9mroLZUA=
X-Received: by 2002:a5e:8a04:: with SMTP id d4mr7583607iok.42.1573056547980;
 Wed, 06 Nov 2019 08:09:07 -0800 (PST)
MIME-Version: 1.0
References: <20191105215940.15144.65968.stgit@localhost.localdomain>
 <20191105220219.15144.69031.stgit@localhost.localdomain> <20191105200022.ed3b5f803bef55377bcc5d30@linux-foundation.org>
In-Reply-To: <20191105200022.ed3b5f803bef55377bcc5d30@linux-foundation.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 6 Nov 2019 08:08:56 -0800
Message-ID: <CAKgT0UeAPve6bWG_orQ=D5TOhagZ9FSrgNZRahj1ZsuQMD38LA@mail.gmail.com>
Subject: Re: [PATCH v13 3/6] mm: Introduce Reported pages
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kvm list <kvm@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com,
        Dave Hansen <dave.hansen@intel.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 8:00 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 05 Nov 2019 14:02:19 -0800 Alexander Duyck <alexander.duyck@gmail.com> wrote:
>
> > In order to pave the way for free page reporting in virtualized
> > environments we will need a way to get pages out of the free lists and
> > identify those pages after they have been returned. To accomplish this,
> > this patch adds the concept of a Reported Buddy, which is essentially
> > meant to just be the Uptodate flag used in conjunction with the Buddy
> > page type.
>
> build fix
>
> --- a/mm/page_reporting.h~mm-introduce-reported-pages-fix
> +++ a/mm/page_reporting.h
> @@ -158,7 +158,7 @@ free_area_reporting(struct zone *zone, u
>         return false;
>  }
>  static inline struct list_head *
> -get_unreported_tail(struct zone *zone, unsigned int order, int migratetype)
> +get_unreported_tail(unsigned int order, int migratetype)
>  {
>         return NULL;
>  }
>

Sorry about that. I will make sure to include the fix in v14.

Thanks.

- Alex
