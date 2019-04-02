Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BD2C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F2A2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbfDBRxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:53:17 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34431 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730220AbfDBRxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 13:53:17 -0400
Received: by mail-qt1-f196.google.com with SMTP id k2so16339350qtm.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 10:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OLJXHlhYI15g5py0OlU6OBcth4eT+AVlpGiVwqABwyM=;
        b=DFNmja42yMbdP8JPbeLau7M999bZ5Z5wpgDer33+SghDLfeCOe/xROXijtYLsUoQAf
         UQn7PH+TVPrYBu0bVEfK5BH2PDbrjjZ+Y5p/MnmvN/z+rs0y7N9/RnZlC5EYttSpXPKe
         HAjow7qXKoUHBgr+gtDVpO+RACuMlanXGZfmLJ7cc7x6Prh01rRDxQpYfQQceG8LjfO8
         aGGtuBHJREsSmmryJ1QytvWcGem2vUbEwIlWY4V2wOQInQ5c10Qg5w+70+XdNA9td0Fg
         R9BupsZ+enBUJ1OZgvmTQz95nVL2nox85DdjIA7fJZsz6iMKx+8Sq/9AI+62eEsS2XZo
         FxhQ==
X-Gm-Message-State: APjAAAVQDltw1Kj1Hux+XMSMMLe7qHzgA7eBtLTrCGd4SNI5hfYLY7/D
        NDF7CHUrjwucIA2ZFiEWM9DvVQ==
X-Google-Smtp-Source: APXvYqwBiZji2CbrWAPhiXLkuH2SxquqiO4kBtgNqdomsId+YeuaIw+i15Rp6ZVpaVK2OIU9Uu9l2g==
X-Received: by 2002:a0c:b2d6:: with SMTP id d22mr58846546qvf.39.1554227596333;
        Tue, 02 Apr 2019 10:53:16 -0700 (PDT)
Received: from redhat.com ([66.187.232.66])
        by smtp.gmail.com with ESMTPSA id y197sm7267625qkb.23.2019.04.02.10.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 10:53:15 -0700 (PDT)
Date:   Tue, 2 Apr 2019 13:53:12 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: On guest free page hinting and OOM
Message-ID: <20190402134722-mutt-send-email-mst@kernel.org>
References: <dc14a711-a306-d00b-c4ce-c308598ee386@redhat.com>
 <20190401104608-mutt-send-email-mst@kernel.org>
 <CAKgT0UcJuD-t+MqeS9geiGE1zsUiYUgZzeRrOJOJbOzn2C-KOw@mail.gmail.com>
 <6a612adf-e9c3-6aff-3285-2e2d02c8b80d@redhat.com>
 <CAKgT0Ue_By3Z0=5ZEvscmYAF2P40Bdyo-AXhH8sZv5VxUGGLvA@mail.gmail.com>
 <20190402112115-mutt-send-email-mst@kernel.org>
 <3dd76ce6-c138-b019-3a43-0bb0b793690a@redhat.com>
 <CAKgT0Uc78NYnva4T+G5uas_iSnE_YHGz+S5rkBckCvhNPV96gw@mail.gmail.com>
 <6b0a3610-0e7b-08dc-8b5f-707062f87bea@redhat.com>
 <CAKgT0UdHA66z1j=3H06AfgtiF4ThFdXwQ6i8p1MszdL2bRHeZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UdHA66z1j=3H06AfgtiF4ThFdXwQ6i8p1MszdL2bRHeZQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 10:45:43AM -0700, Alexander Duyck wrote:
> We went through this back in the day with
> networking. Adding more buffers is not the solution. The solution is
> to have a way to gracefully recover and keep our hinting latency and
> buffer bloat to a minimum.

That's an interesting approach, I think that things that end up working
well are NAPI (asychronous notifications), limited batching, XDP (big
aligned buffers) and BQL (accounting). Is that your perspective too?

-- 
MST
