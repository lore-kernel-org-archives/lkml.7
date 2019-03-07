Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118F0C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF47A20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfCGSqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:46:21 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36572 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfCGSqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:46:21 -0500
Received: by mail-qk1-f196.google.com with SMTP id c2so9670214qkb.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 10:46:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2u7BP1Ui3tuNwWQLTQcvYHKSwz32ntxHiRkj8rks4cs=;
        b=JZeo5MsWGSp5drATuuD1bNMupyDR9wVk5FS4w6+1Pu8yxZCd6YmEetFqmHwfGQtI/0
         CPU4yYp9/wLuFB6RoKA6jZWNr2jiA7BzVqB2mt55I4bee2ObhABez4pONdGeQvG8NWJb
         r0Of8DoPYJCN1N2mpEHIzo4G447qlj/hQYXg2iLGfm7L1M2nUtDeQbKcJOEgVklzPFxq
         9ApPo1Qq0BNt2D44wTklNpgC3oEjku12wgqSjBogXM/6uqyRIEKODMhwJo2DWAM7HeMA
         jndMATLuu57JGSBLCjZNtWNBBxt3tw/WJpW8QsPZ+x5EN/8f7v/XhfjOOXfQZ3cOHjXp
         bk5w==
X-Gm-Message-State: APjAAAUWPcUZeesVfzbcYmD4Ny5Y8JOMV0xolsgoEsn/YGdtdbXWJ1pI
        wnGPpmeGVxmjn9W9CFMtTq6FtA==
X-Google-Smtp-Source: APXvYqwgo2MGDFDKita4Pt3kdeWKS1YwgR61gSXoAaqc66X2e+GMqH9GgtEtnl5cyDENN/P+vwyYrA==
X-Received: by 2002:a37:b105:: with SMTP id a5mr10850516qkf.298.1551984380034;
        Thu, 07 Mar 2019 10:46:20 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id h52sm3711686qte.78.2019.03.07.10.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 10:46:18 -0800 (PST)
Date:   Thu, 7 Mar 2019 13:46:16 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        David Hildenbrand <david@redhat.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC][Patch v9 0/6] KVM: Guest Free Page Hinting
Message-ID: <20190307134455-mutt-send-email-mst@kernel.org>
References: <20190306155048.12868-1-nitesh@redhat.com>
 <CAKgT0Ud35pmmfAabYJijWo8qpucUWS8-OzBW=gsotfxZFuS9PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Ud35pmmfAabYJijWo8qpucUWS8-OzBW=gsotfxZFuS9PQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 10:00:05AM -0800, Alexander Duyck wrote:
> I have been thinking about this. Instead of stealing the page couldn't
> you simply flag it that there is a hint in progress and simply wait in
> arch_alloc_page until the hint has been processed? The problem is in
> stealing pages you are going to introduce false OOM issues when the
> memory isn't available because it is being hinted on.

Can we not give them back in an OOM notifier?

-- 
MST
