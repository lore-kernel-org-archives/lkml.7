Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986E4C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741E820872
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442785AbfIYIfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 04:35:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442770AbfIYIfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 04:35:30 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A48E311A24
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 08:35:29 +0000 (UTC)
Received: by mail-pf1-f199.google.com with SMTP id v6so3472933pfm.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 01:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CBc45OeQcvvswm6VllW/DcLsxnRal5m6t5OBDsogK1c=;
        b=OKaIEdDu1pOw/RICa7BWKEgRP2A9TCrSGuMHGcMAoBo3I0d+iQd2++OifI/SLoirge
         DxFYvX8YhQ860+VZz+9u/PmwbHj9fyK716KgZY3yxoda0eh/20L7NKHkPewQ/fdlVuvQ
         /dG197l0E/NztYk3AssiW9EkbxdgFp6CxOv5MzwY/+ZemQaLCo5fUh7n9f/ImQDytl02
         As9cBs51trvrHxDPqSu/27w4XPun1dS/xOyNOJMsVm5/hlL6jX+JOOEViSAUvI5/OnOO
         CEHCuF3AzyX9bWDNWaASmn5T0BF3JB2fJkrdtsbWVaBoCvLMwsz7ABTVy1JUsEfgVfQs
         ZysA==
X-Gm-Message-State: APjAAAXfeayiRbjkKlTs5iFMRQoxxtS+B4wXjPe1gZuK57EDO44jxow6
        50PDumuGLvj7dzbvL78PX2zXecmeCNXV4jtqOX/bzGqKNCPXNoZlDYI/J1uHV5851ClAQkZ3wCr
        DXAbnzo4Fz2VkDtuOa1PqFt8B
X-Received: by 2002:a17:90a:a613:: with SMTP id c19mr5107209pjq.11.1569400529148;
        Wed, 25 Sep 2019 01:35:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwTwI2GBx3mYJA7q4j7DwyuCNyNYODVb5K7FYMon6YtcWvF63UgXcbRm5MG2PYtVak+7eQfkA==
X-Received: by 2002:a17:90a:a613:: with SMTP id c19mr5107183pjq.11.1569400528844;
        Wed, 25 Sep 2019 01:35:28 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x6sm9264648pfd.53.2019.09.25.01.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 01:35:27 -0700 (PDT)
Date:   Wed, 25 Sep 2019 16:35:16 +0800
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
Message-ID: <20190925083516.GQ28074@xz-x1>
References: <20190923122454.9888-1-baolu.lu@linux.intel.com>
 <20190923122454.9888-3-baolu.lu@linux.intel.com>
 <20190923203102.GB21816@araj-mobl1.jf.intel.com>
 <9cfe6042-f0fb-ea5e-e134-f6f5bb9eb7b0@linux.intel.com>
 <20190925043050.GK28074@xz-x1>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D58F018@SHSMSX104.ccr.corp.intel.com>
 <20190925052402.GM28074@xz-x1>
 <1713f03c-4d47-34ad-f36d-882645c36389@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D58F4EA@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D58F4EA@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 07:32:48AM +0000, Tian, Kevin wrote:
> > From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> > Sent: Wednesday, September 25, 2019 2:52 PM
> > 
> > Hi Peter and Kevin,
> > 
> > On 9/25/19 1:24 PM, Peter Xu wrote:
> > > On Wed, Sep 25, 2019 at 04:38:31AM +0000, Tian, Kevin wrote:
> > >>> From: Peter Xu [mailto:peterx@redhat.com]
> > >>> Sent: Wednesday, September 25, 2019 12:31 PM
> > >>>
> > >>> On Tue, Sep 24, 2019 at 09:38:53AM +0800, Lu Baolu wrote:
> > >>>>>> intel_mmmap_range(domain, addr, end, phys_addr, prot)
> > >>>>>
> > >>>>> Maybe think of a different name..? mmmap seems a bit weird :-)
> > >>>>
> > >>>> Yes. I don't like it either. I've thought about it and haven't
> > >>>> figured out a satisfied one. Do you have any suggestions?
> > >>>
> > >>> How about at least split the word using "_"?  Like "mm_map", then
> > >>> apply it to all the "mmm*" prefixes.  Otherwise it'll be easily
> > >>> misread as mmap() which is totally irrelevant to this...
> > >>>
> > >>
> > >> what is the point of keeping 'mm' here? replace it with 'iommu'?
> > >
> > > I'm not sure of what Baolu thought, but to me "mm" makes sense itself
> > > to identify this from real IOMMU page tables (because IIUC these will
> > > be MMU page tables).  We can come up with better names, but IMHO
> > > "iommu" can be a bit misleading to let people refer to the 2nd level
> > > page table.
> > 
> > "mm" represents a CPU (first level) page table;
> > 
> > vs.
> > 
> > "io" represents an IOMMU (second level) page table.
> > 
> 
> IOMMU first level is not equivalent to CPU page table, though you can
> use the latter as the first level (e.g. in SVA). Especially here you are
> making IOVA->GPA as the first level, which is not CPU page table.
> 
> btw both levels are for "io" i.e. DMA purposes from VT-d p.o.v. They
> are just hierarchical structures implemented by VT-d, with slightly
> different format.

Regarding to the "slightly different format", do you mean the
extended-accessed bit?

Even if there are differences, they do look very similar.  If you see
the same chap 9.7 table, the elements are exactly called PTE, PDE,
PDPE, and so on - they're named exactly the same as MMU page tables.
With that, IMHO it still sounds reasonable if we want to relate this
"1st level iommu page table" with the existing MMU page table using
the "mm" prefix...

Regards,

-- 
Peter Xu
