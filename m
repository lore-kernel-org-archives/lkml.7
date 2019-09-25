Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CC3C4320D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 05:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DF7217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 05:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411759AbfIYFYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 01:24:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411745AbfIYFYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 01:24:15 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 18E113B714
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 05:24:15 +0000 (UTC)
Received: by mail-pl1-f200.google.com with SMTP id z7so2650572plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 22:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/HNMfngrL2dVAv5oEf18q1bL4tnGnZHoARTtclw/zOQ=;
        b=Axdq9Zw0cyexjOZRoCY0x4m/hgNED57havN03D4y4oGxZxHK97ix+QZhYCfF5XiBsc
         JrafHjuIcqw6iE82joxo0sxLdI/cVtjK8JnzkB7gMq8Ih51UER0sKMLngstKBxri6vWr
         5lNgdqwL82aDFq8/LbWvznSiMoxNp71ER0FkWIxAuEADAyCdMCKk41Wn0cVxQgGINCbp
         Ap3do/JkxpDTad+OoohD4ebO3/qQbU8ACnqYmkOopagMqlu7/863HVZqm0SQz2UjlyPe
         Edtx04G1H7C0mSLkfJeHRbZJWpD2/YArfRCTUfYq3kBYex8obtzdeqIVyBP64Z36Jl7Y
         iekQ==
X-Gm-Message-State: APjAAAUtpjBMi5jUm9Kyx0SyuYLJVS8N2IQi0jRFmrrl50l0gSpf4jNX
        fTYtpiv2j3hORGxNLJkA6DnJlpN6qrZ2HgLarBE7Od3pLftClbpyGrnXHq/nmxa/hXRLLssuOru
        qHThuhOCug9odYHV0oEjSYftR
X-Received: by 2002:a62:5e42:: with SMTP id s63mr6745436pfb.96.1569389054615;
        Tue, 24 Sep 2019 22:24:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxwAC3wXoJ2PHgPRN3g8rZaANg2eV6wPnk6cDT4cSKrtUcaQ5efDKrefQ8BuOVG39h90nRsFQ==
X-Received: by 2002:a62:5e42:: with SMTP id s63mr6745421pfb.96.1569389054455;
        Tue, 24 Sep 2019 22:24:14 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d76sm9015810pga.80.2019.09.24.22.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 22:24:13 -0700 (PDT)
Date:   Wed, 25 Sep 2019 13:24:02 +0800
From:   Peter Xu <peterx@redhat.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Yi Sun <yi.y.sun@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC PATCH 2/4] iommu/vt-d: Add first level page table interfaces
Message-ID: <20190925052402.GM28074@xz-x1>
References: <20190923122454.9888-1-baolu.lu@linux.intel.com>
 <20190923122454.9888-3-baolu.lu@linux.intel.com>
 <20190923203102.GB21816@araj-mobl1.jf.intel.com>
 <9cfe6042-f0fb-ea5e-e134-f6f5bb9eb7b0@linux.intel.com>
 <20190925043050.GK28074@xz-x1>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D58F018@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D58F018@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 04:38:31AM +0000, Tian, Kevin wrote:
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Wednesday, September 25, 2019 12:31 PM
> > 
> > On Tue, Sep 24, 2019 at 09:38:53AM +0800, Lu Baolu wrote:
> > > > > intel_mmmap_range(domain, addr, end, phys_addr, prot)
> > > >
> > > > Maybe think of a different name..? mmmap seems a bit weird :-)
> > >
> > > Yes. I don't like it either. I've thought about it and haven't
> > > figured out a satisfied one. Do you have any suggestions?
> > 
> > How about at least split the word using "_"?  Like "mm_map", then
> > apply it to all the "mmm*" prefixes.  Otherwise it'll be easily
> > misread as mmap() which is totally irrelevant to this...
> > 
> 
> what is the point of keeping 'mm' here? replace it with 'iommu'?

I'm not sure of what Baolu thought, but to me "mm" makes sense itself
to identify this from real IOMMU page tables (because IIUC these will
be MMU page tables).  We can come up with better names, but IMHO
"iommu" can be a bit misleading to let people refer to the 2nd level
page table.

Regards,

-- 
Peter Xu
