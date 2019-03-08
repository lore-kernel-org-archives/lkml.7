Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4A0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C252081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfCHCcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 21:32:11 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40020 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfCHCcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 21:32:11 -0500
Received: by mail-qt1-f194.google.com with SMTP id f11so2429257qti.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 18:32:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iF16cgfp12yoaJJ5MQem592rInh+vH6ZaUK3pS+44v4=;
        b=BIUTrOk83AkkjzBwLwtNegPwH6T2pWRMx1U9LeILcka/HfDyGWu601qHV5l7UvMMf1
         kgIDF9S/tTOY47F5JlB8dKw3+UjJONhqzOJM4ITmql3PUe5lWbjzikMLVu8PA9WPft91
         XGmaEvj3PBEdBhtZsd0PIDz+5VJa4FbspTvEu4KqaJeTxohdRA/SvQaef0NGpUBWfznM
         8ViYy2DBQjQdP8pfvGOlf4hN6w257HVy0TQyYJ7GMu6EwN8C/Dfz5vE11IlP/e5c18m8
         H7rDtMFuozcAsHouH3Y15UfYc6zL7HnvainSd2yrGRerLYF+V/wYQBuQqNIbIqC7Ym6A
         8ZIw==
X-Gm-Message-State: APjAAAWU6AsygF7vz0h8jbSPkqhe7LdQfoWoeMISO1RRimqPK4Zmh7yV
        eTMSSlWvn3K+MYSzpNNZG9jCpA==
X-Google-Smtp-Source: APXvYqwFsRg/Gqf8+NEhgHdzJyicZWPFO0RBwKAp8m1NoEf1T1SAM90gXXpZVFq9IrBbWHCt/WLQtA==
X-Received: by 2002:a0c:b485:: with SMTP id c5mr13538580qve.78.1552012330342;
        Thu, 07 Mar 2019 18:32:10 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id p10sm2973617qkg.76.2019.03.07.18.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 18:32:09 -0800 (PST)
Date:   Thu, 7 Mar 2019 21:32:07 -0500
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
Subject: Re: [RFC][Patch v9 2/6] KVM: Enables the kernel to isolate guest
 free pages
Message-ID: <20190307212845-mutt-send-email-mst@kernel.org>
References: <20190306155048.12868-1-nitesh@redhat.com>
 <20190306155048.12868-3-nitesh@redhat.com>
 <CAKgT0UdDohCXZY3q9qhQsHw-2vKp_CAgvf2dd2e6U6KLsAkVng@mail.gmail.com>
 <2d9ae889-a9b9-7969-4455-ff36944f388b@redhat.com>
 <22e4b1cd-38a5-6642-8cbe-d68e4fcbb0b7@redhat.com>
 <CAKgT0UcAqGX26pcQLzFUevHsLu-CtiyOYe15uG3bkhGZ5BJKAg@mail.gmail.com>
 <78b604be-2129-a716-a7a6-f5b382c9fb9c@redhat.com>
 <CAKgT0Uc_z9Vi+JhQcJYX+J9c4J56RRSkzzegbb2=9xO-NY3dgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Uc_z9Vi+JhQcJYX+J9c4J56RRSkzzegbb2=9xO-NY3dgw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 02:35:53PM -0800, Alexander Duyck wrote:
> The only other thing I still want to try and see if I can do is to add
> a jiffies value to the page private data in the case of the buddy
> pages.

Actually there's one extra thing I think we should do, and that is make
sure we do not leave less than X% off the free memory at a time.
This way chances of triggering an OOM are lower.

> With that we could track the age of the page so it becomes
> easier to only target pages that are truly going cold rather than
> trying to grab pages that were added to the freelist recently.

I like that but I have a vague memory of discussing this with Rik van
Riel and him saying it's actually better to take away recently used
ones. Can't see why would that be but maybe I remember wrong. Rik - am I
just confused?


-- 
MST
