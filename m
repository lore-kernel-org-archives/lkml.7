Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C22C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780352075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbfDBTtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:49:06 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38343 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbfDBTtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:49:05 -0400
Received: by mail-qt1-f196.google.com with SMTP id d13so16762766qth.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 12:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hj5v9f5m4XcpUD3AHCmGwsgzwcyKpLxNeHtv55UKsvQ=;
        b=OPdkhTj36sxaN/lwev1Ghu3fLH156ZOkxxgcMiL8Q2THeiS4v5m/skvqAA/vVQxeU/
         LBbOMTvH1r8jBV37JW4mMfghGH6YR3uuaIDmFKlnlOQh+oHu047CZB9y5lOqYbmMbVyf
         GX78LDf4qmUFhVD+lFYgRO3CuqShb9EdUt5UZ2qsZXRfizqVcvU9b46YpZgOUXe7L4Rh
         +pfX6dLMQwfwiWsCMUOqnIteF/MWX9nHl55PTiU0kdRWJnUDDYZr0DoFgQ5NXLUW1Z8a
         fjrBNb79JutZfNQfVIu4OUkE29lr4pHEskb/NfjOydjDApFPNHCXfmB2duuMbDN5XLRs
         7f7Q==
X-Gm-Message-State: APjAAAUH1PmJ98UEw14grOJxTOtuNMmaQXAfr7v/uh0qqGGv5K/alarc
        D3kMtwPFR+n9gZL3tf9HBkLWng==
X-Google-Smtp-Source: APXvYqyssdHTS/DKlsZsXRC9d0R0s3gdduOA5QVLCvuRf6QzAqxPUhlhL0TEas0IduN6EdWwMJPg8g==
X-Received: by 2002:ac8:21c7:: with SMTP id 7mr58333120qtz.66.1554234544899;
        Tue, 02 Apr 2019 12:49:04 -0700 (PDT)
Received: from redhat.com ([66.187.232.66])
        by smtp.gmail.com with ESMTPSA id a75sm6940361qkg.84.2019.04.02.12.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 12:49:03 -0700 (PDT)
Date:   Tue, 2 Apr 2019 15:49:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
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
Message-ID: <20190402154732-mutt-send-email-mst@kernel.org>
References: <20190401104608-mutt-send-email-mst@kernel.org>
 <CAKgT0UcJuD-t+MqeS9geiGE1zsUiYUgZzeRrOJOJbOzn2C-KOw@mail.gmail.com>
 <6a612adf-e9c3-6aff-3285-2e2d02c8b80d@redhat.com>
 <CAKgT0Ue_By3Z0=5ZEvscmYAF2P40Bdyo-AXhH8sZv5VxUGGLvA@mail.gmail.com>
 <20190402112115-mutt-send-email-mst@kernel.org>
 <3dd76ce6-c138-b019-3a43-0bb0b793690a@redhat.com>
 <CAKgT0Uc78NYnva4T+G5uas_iSnE_YHGz+S5rkBckCvhNPV96gw@mail.gmail.com>
 <6b0a3610-0e7b-08dc-8b5f-707062f87bea@redhat.com>
 <CAKgT0UdHA66z1j=3H06AfgtiF4ThFdXwQ6i8p1MszdL2bRHeZQ@mail.gmail.com>
 <d105e3c7-52b4-de94-9f61-0aee5442d463@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d105e3c7-52b4-de94-9f61-0aee5442d463@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 08:21:30PM +0200, David Hildenbrand wrote:
> The other extreme is a system that barely frees (MAX_ORDER - X) pages,
> however your thread will waste cycles scanning for such.

I don't think we need to scan as such. An arch hook
that queues a job to a wq only when there's work to
do will fix the issue, right?

-- 
MST
