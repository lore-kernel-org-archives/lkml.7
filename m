Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A56C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E9A21473
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfDICoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 22:44:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42021 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfDICo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 22:44:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id p20so18024429qtc.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 19:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GWVLGd3rRWNvU7sP85NRp5wt10btcwDSd57p3ueaPIg=;
        b=KrEdHQXfc4dc2G0xB8FsANccw9yWMYSVN1x6X0nWHgFefUjIvDpBR+2SkREIhDy6bC
         Fh90Src9bkNUCMW9T4qR32UhhLXR9EXdA6yan++lUAItMaH26kgooitTlflFfX5RB0Ab
         0kMQG8Dptas2igXlyEDI/im+aLeaw6qzWbQjPM5TfNfHRDOWiygQymzLTSgt9TO9WOte
         k91aMIs/1su/mE5/Xwratug6pjpd8yhkstLhocHYyIJ9xH12DTDYulVa0jjZRGy8ZMAZ
         K3ZjR8BkGU2VUIh6wJAQTcRL+EpHb/SM5GzcDitf77DdCEMdQoDsFO9ClOjqZgNx6HYz
         2MlA==
X-Gm-Message-State: APjAAAVDYvzt7BCQWsfP/aaO2RGAU8iorio+JBxBWeSO/DTQKNZcqhvJ
        1gVvd8sTrk5QZNSfjlWQJdZGEQ==
X-Google-Smtp-Source: APXvYqyA+PmYoJsgVkbSjy9sMazqV1hbg1cOyBmP6u5iAlIm/HSoNFnjKe4pAk1znbUJVzee8rnXlw==
X-Received: by 2002:ac8:184b:: with SMTP id n11mr28387822qtk.210.1554777868868;
        Mon, 08 Apr 2019 19:44:28 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id n188sm17572320qkb.40.2019.04.08.19.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 19:44:27 -0700 (PDT)
Date:   Mon, 8 Apr 2019 22:44:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: Thoughts on simple scanner approach for free page hinting
Message-ID: <20190408203541-mutt-send-email-mst@kernel.org>
References: <CAKgT0Ue4LufT4q4dLwjqhGRpDbVnucNWhmhwWxbwtytgjxx+Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Ue4LufT4q4dLwjqhGRpDbVnucNWhmhwWxbwtytgjxx+Kw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 05:09:45PM -0700, Alexander Duyck wrote:
> In addition we will need some way to identify which pages have been
> hinted on and which have not. The way I believe easiest to do this
> would be to overload the PageType value so that we could essentially
> have two values for "Buddy" pages. We would have our standard "Buddy"
> pages, and "Buddy" pages that also have the "Offline" value set in the
> PageType field. Tracking the Online vs Offline pages this way would
> actually allow us to do this with almost no overhead as the mapcount
> value is already being reset to clear the "Buddy" flag so adding a
> "Offline" flag to this clearing should come at no additional cost.

It bothers me a bit that this doesn't scale to multiple hint types
if we ever need them. Would it be better to have two
free lists: hinted and non-hinted one?


-- 
MST
