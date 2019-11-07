Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07EAFA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C587222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="copQUNDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387804AbfKGJOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:14:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35619 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733170AbfKGJOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:14:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id p2so2144820wro.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 01:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7K7YoIYgw7JdacC27X2sH2EjT8nUDr5g8s63hMYcu2Q=;
        b=copQUNDg7TKgKe0J9AW2lkN2cblLvluVigND33aoXjvHBqxr4I3qypxfQEqmeAeZAJ
         wukXNLJEvqmqQLeKJbYsXh7WfsL+mAYxm1uYFr/cdOqii3fnufAMxmGejf92i6TogtBt
         tCwuNuuBpZL2vk+i3PfpCEmPMBDorZRm01BdgAvhRGppmXIl4Vt74o/xIb5eDzXHg9eB
         3dVsO1miJko+GsGxnfYdOB0TvzyTyCkb6kYpgf/5hD9qlT+skpu3MRWMcsGKMoEnsvYK
         HcBqYDQpMp+B4GUmfawPYmBtDD+LRn5dq/Jtu2nF2zXOXwCUFKu8bL+MsXhsPkl2h3+P
         +4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7K7YoIYgw7JdacC27X2sH2EjT8nUDr5g8s63hMYcu2Q=;
        b=ClEncA7JtPkoCQMK6d94rslC5qh4A1+anDWD/7K1AeuB/W1T+ACn9NdIyiD8YbFL2r
         5rGHsgXb/NSXHCRyAqNJg1vJ8/KPvBwO12U2cxavnWCGXDapxwiUBpXNhiEODqVgmSgv
         mRJMbia7vkeVd94BvExgSw7KbyxiNYQHb8azmht3auEvHqPH5lzdMM8LMHyA+inrI7iK
         ReDA1aPo9cV2uMw0iQI6bxa3Uu9BUM6vbOYeoVNXDdmGFBAezqtp+27VPggE3Rqoe2sj
         GEgtFOSXB8sTpFM9IRMkTjgdjprHNgqobZuDYXtKnXq6S9ltqi0JdLHl2JrrVWtm3ztR
         npSA==
X-Gm-Message-State: APjAAAWd+jqo7j0S2LGAs6mKS1Tdyo+lL7O0Ga6jorQ4nNKp3z48w1II
        Tz6r+/+7+QBw1Sv6Std/2tNKPw==
X-Google-Smtp-Source: APXvYqz1PbaaJSwiXIzks4vT1uOP1l38fexk9BqIHq1AkW/Lq/U8t494PzjWrTOHv/GzbGtu4QIf/w==
X-Received: by 2002:adf:e286:: with SMTP id v6mr1828592wri.241.1573118041913;
        Thu, 07 Nov 2019 01:14:01 -0800 (PST)
Received: from lophozonia ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id h8sm2304162wrc.73.2019.11.07.01.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 01:14:01 -0800 (PST)
Date:   Thu, 7 Nov 2019 10:13:59 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] iommu: Permit modular builds of ARM SMMU[v3] drivers
Message-ID: <20191107091359.GA3752186@lophozonia>
References: <6e457227-ca06-2998-4ffa-a58ab171ce32@arm.com>
 <20191030155444.GC19096@willie-the-truck>
 <CAGETcx9ogWQC1ZtnS_4xC3ShqBpuRSKudWEEWC22UZUEhdEU4A@mail.gmail.com>
 <20191031193758.GA2607492@lophozonia>
 <CAGETcx-MuMVvj0O-MFdfmLADEq=cQY_=x+irvhgwHhG4VeeSdg@mail.gmail.com>
 <6994ae35-2b89-2feb-2bcb-cffc5a01963c@huawei.com>
 <CAGETcx-9M8vvHA2Lykcv0hHWoC2OAw5kfBrjcNJN2CYCwR4eWQ@mail.gmail.com>
 <47418554-e7a7-f9f3-8852-60cecef3d5c7@huawei.com>
 <7e2429ed-6b25-a452-5e4d-51a5195b872f@arm.com>
 <CAGETcx8QYBfGOBNtUTR+Lq_g+bmBxMOe0q=3U5UxvVqi+640Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx8QYBfGOBNtUTR+Lq_g+bmBxMOe0q=3U5UxvVqi+640Xw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 10:11:55PM -0800, Saravana Kannan wrote:
> > Right, in short the fundamental problem is that of_iommu_configure() now
> > does the wrong thing. Deferring probe of the entire host bridge/root
> > complex based on "iommu-map" would indeed happen to solve the problem by
> > brute force, I think, but could lead to a dependency cycle for PCI-based
> > IOMMUs as Jean points out.
> 
> Sorry for the late reply. Got caught up on other work.
> 
> I didn't think the SMMU itself was PCI based in the example Jean gave.
> I thought it just happened to be the case where the SMMU probes after
> the pcieport but before the other children. If the SMMU itself is a
> child of the pcieport, how can it be required for the parent to
> function? How will suspend/resume even work?! I feel like I'm missing
> some context wrt to PCI that everyone else seems to know (which isn't
> surprising).

The Arm SMMU isn't PCI based, it always appears as an independent MMIO
device. John's problem is something different if I understand correctly,
where the probe order between pcieport and endpoint shouldn't affect the
IOMMU grouping, but currently does.

Two other IOMMU models are PCI based, though, AMD IOMMU and virtio-iommu
(which is a purely virtual device). In theory they can have their
programming interface anywhere in the PCI config space, but to ensure
proper software support they should be at the top of the PCI hierarchy.
AMD strongly recommends that the IOMMU is a root-complex device (4.5 -
Software and Platform Firmware Implementation Issues). Within a PCIe
system the IOMMU would have to be a Root Complex integrated Endpoint, not
be a child of a root port.

Thanks,
Jean
