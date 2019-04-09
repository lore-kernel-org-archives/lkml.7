Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B647EC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3442064B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfDINh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:37:59 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37361 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfDINh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 09:37:58 -0400
Received: by mail-qk1-f196.google.com with SMTP id c1so10235546qkk.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 06:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NrH0wRjSc274UknaC3QIC9X+7Oupxwsgd4xWd2VOIbE=;
        b=J87sopU0PMdTLRTN1WjjObs/zqVZdWdAUuNiLdR2MMYEvErgVgPQphb1eHJyFqi5wa
         Hba7d5ndWeTKVe1vmfJWNRbaF92eNS5Y7vJdtsDOK/HKE+9GOZXyY83BWF7edktbSV//
         KoAaEfzFZhaTNHITHp4pfF6ulaaExe4lIF2n3ZVm6M2N7YaYoADiCtCsBM0At4GJ2L/L
         LjMcm3RZenPHMAz75qTeKS/3rnRgaU/I1VLHioUxmtt+HRkYryavdMAr3MVSnG9MgQKQ
         c1nRFgZQ3S5BznmoCS1bJpBLmbyO898YF8D6Za32D7Y5icMCTip2cImcA+kPVt6hnBOn
         khhA==
X-Gm-Message-State: APjAAAWSMNe+w18OuibC4CKWEOYteoYhcmUzVPaIIxKrPbY1nRzZBkOt
        YeRKurxYxA/cqGuJI6ZIgblQPA==
X-Google-Smtp-Source: APXvYqz0P59G4x2QFXgYvEOPGfKQvp0965gG/JLcggQUBLhwcwZLsi2c+wfUIMH4hZuN9U4Kbzx3ew==
X-Received: by 2002:a05:620a:15e7:: with SMTP id p7mr26856717qkm.283.1554817077928;
        Tue, 09 Apr 2019 06:37:57 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id v4sm17179402qtq.94.2019.04.09.06.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 06:37:57 -0700 (PDT)
Date:   Tue, 9 Apr 2019 09:37:54 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
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
Message-ID: <20190409093642-mutt-send-email-mst@kernel.org>
References: <CAKgT0Ue4LufT4q4dLwjqhGRpDbVnucNWhmhwWxbwtytgjxx+Kw@mail.gmail.com>
 <d2413648-8943-4414-708a-9442ab4b9e65@redhat.com>
 <20190409092625-mutt-send-email-mst@kernel.org>
 <43aa1bd2-4aac-5ac4-3bd4-fe1e4a342c79@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43aa1bd2-4aac-5ac4-3bd4-fe1e4a342c79@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 03:36:08PM +0200, David Hildenbrand wrote:
> On 09.04.19 15:31, Michael S. Tsirkin wrote:
> > On Tue, Apr 09, 2019 at 11:20:36AM +0200, David Hildenbrand wrote:
> >> BTW I like the idea of allocating pages that have already been hinted as
> >> last "choice", allocating pages that have not been hinted yet first.
> > 
> > OK I guess but note this is just a small window during which
> > not all pages have been hinted.
> 
> Yes, good point. It might sound desirable but might be completely
> irrelevant in practice.
> 
> > 
> > So if we actually think this has value then we need
> > to design something that will desist and not drop pages
> > in steady state too.
> 
> By dropping, you mean dropping hints of e.g. MAX_ORDER - 1 or e.g. not
> reporting MAX_ORDER - 3?

I mean the issue is host unmaps the pages from guest right?  That is
what makes hinted pages slower than non-hinted ones.  If we do not want
that to happen for some pages, then either host can defer acting on the
hint, or we can defer hinting.

> -- 
> 
> Thanks,
> 
> David / dhildenb
