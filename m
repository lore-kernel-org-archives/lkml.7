Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368EEC10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2E520879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfCYPh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:37:26 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39474 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfCYPh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:37:26 -0400
Received: by mail-qk1-f196.google.com with SMTP id c189so5580649qke.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 08:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ULt4UAznv66zNgUvqi5PYm74n/6JzDtsJmpKbhGf0Hc=;
        b=VvggE18u1AdFUTV8LXELecgSKU3VGor0t6tBzSjgIlpBgGkAYY+FnzphQJlMqAYB1T
         xB+D17aAjq8swQ430pyQb5tzoI0kZLLMDcNhFSozge9fY8JJ4OTSQpjO2P76MGcz2Yn9
         UkHz24y8wymMwPyBXDq6LCDY/I0IUGXKFnO9sptsrqr/ad8yTKnEC4x2OQXaltS+1daj
         XsAqeudcZvHX3qQYVIHNNWDAW4SQ7+EiouRGsfNmuLQIkPRENMyO3zQVnSY88poofMcq
         3bQ/pf4Hpbup/gLax5Q1SDFTb7Ji9gmCRBwGD4g7Rl90XZQnYU483Q606BtD0vgIMBzc
         XSlg==
X-Gm-Message-State: APjAAAXb6xVCd02IQw9VZoLXFtCn/4G9gXdYr4z/eHv4Y/ZITS/H3Ha3
        XtOCMIP5sw0cqF9LG/JDNorflQ==
X-Google-Smtp-Source: APXvYqzEUyn4wi4Muptc2YOpiuM7Xps1sZy26/sOBF6ZgKXmq1Rh2mOG+RfvwzCK/Bg9K1n8TZ90Nw==
X-Received: by 2002:a37:4dc5:: with SMTP id a188mr19611207qkb.181.1553528245451;
        Mon, 25 Mar 2019 08:37:25 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id p188sm9361806qkb.43.2019.03.25.08.37.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 08:37:24 -0700 (PDT)
Date:   Mon, 25 Mar 2019 11:37:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC][Patch v9 0/6] KVM: Guest Free Page Hinting
Message-ID: <20190325113543-mutt-send-email-mst@kernel.org>
References: <20190306130955-mutt-send-email-mst@kernel.org>
 <ce55943e-87b6-c102-9827-2cfd45b7192c@redhat.com>
 <CAKgT0UcGCFNQRZFmp8oMkG+wKzRtwN292vtFWgyLsdyRnO04gQ@mail.gmail.com>
 <ed9f7c2e-a7e3-a990-bcc3-459e4f2b4a44@redhat.com>
 <4bd54f8b-3e9a-3493-40be-668962282431@redhat.com>
 <6d744ed6-9c1c-b29f-aa32-d38387187b74@redhat.com>
 <CAKgT0UcBDKr0ACHQWUCvmm8atxM6wSu7aCRFJkFvfjT_W_femQ@mail.gmail.com>
 <6709bb82-5e99-019d-7de0-3fded385b9ac@redhat.com>
 <6ab9b763-ac90-b3db-3712-79a20c949d5d@redhat.com>
 <99b9fa88-17b1-f2a9-7dd4-7a8f6e790d30@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99b9fa88-17b1-f2a9-7dd4-7a8f6e790d30@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 10:27:46AM -0400, Nitesh Narayan Lal wrote:
> I performed some experiments to see if the current implementation of
> hinting breaks THP. I used AnonHugePages to track the THP pages
> currently in use and memhog as the guest workload.
> Setup:
> Host Size: 30GB (No swap)
> Guest Size: 15GB
> THP Size: 2MB
> Process: Guest is installed with different kernels to hint different
> granularities(MAX_ORDER - 1, MAX_ORDER - 2 and MAX_ORDER - 3). Memhog 
> 15G is run multiple times in the same guest to see AnonHugePages usage
> in the host.
> 
> Observation:
> There is no THP split for order MAX_ORDER - 1 & MAX_ORDER - 2 whereas
> for hinting granularity MAX_ORDER - 3 THP does split irrespective of
> MADVISE_FREE or MADVISE_DONTNEED.
> -- 
> Regards
> Nitesh
> 

This is on x86 right? So THP is 2M and MAX_ORDER is 8M.
MAX_ORDER - 3 ==> 1M.
Seems to work out.

-- 
MST
