Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C27EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552702083B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="cOaWk12t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfF1Q14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:27:56 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36771 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfF1Q1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:27:55 -0400
Received: by mail-ot1-f67.google.com with SMTP id r6so6568944oti.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 09:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1m5eUNW/8O3Uia+UgF1DOs7nZbA/5lPFN6ZbyXe0/Ls=;
        b=cOaWk12t9PR+wM1gV05bVlfR0S1JSjfvb0hJ6JHo5ppfgDNgrz3BIflcx5b+w4agLb
         brYamehqIiFRGAjIKCUe6+Q53dn3hCuKVsdvquxg1/zCaxiJNgcnspoK9aZ9PKMXCUax
         piwsxxk5ZVG0/OrqNggRtsNENyTRYeAIsTv0w6rRIv8xEx0MB8nULTH+IB0NC3xJ3BeI
         w9h4nLRfPNokhqWP61aJrHtY0lfJBXalafI60Q5aBVAiBp99b8Xbt//EkmWeTAvVPTH8
         cyXy8F6iRDlqKv+0BbiPuN3y3R6N6GvMZWeSpv1agBiqh/rGomhhdkAUvQejKMcw69mS
         wn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1m5eUNW/8O3Uia+UgF1DOs7nZbA/5lPFN6ZbyXe0/Ls=;
        b=G0VkPb4UF3VMC2shwSC6pD5YX7IyNFFaDcn56yVbMcjTyWqfOsguMTeU2oHrIfqAtQ
         CDX/b6Y4TH6Anq67cIPrJhHS1J+2M8ICHDEGnsSV0aDxcbvjERYTP4jADaq0BkZVfrUW
         ze1mQNY503cpdgasGiwVSQfYBYr6C4z3BAmaVpxyFKe9E1njqoQqc4zGu3zgzzSaadNd
         C6jLpYHdUoaa810cqsfUsHUGVHCAOU7i2ZjMBZudi+g54DCVYATmsKMcO62Tfx69z2WB
         jibjpoUJsBwEpRDQNtcszM0jbdVx22a+wykBLKuhGPYs6oEHeueJl7/a/Z8bNfUqYKX9
         fUXQ==
X-Gm-Message-State: APjAAAWLXIvA1A1rLVs/PeULDoSCIPBhpvBB37RrfMyExE9oQLuufANP
        zjb/KZ6y3naCL5vvsjpTuqrXG//w+PscRMWG5KZa1A==
X-Google-Smtp-Source: APXvYqzpE+Kqyx1ivu95dqxD5Xmw+1dAtjgOIlYl2JIyAfPlIWR3aLAm88Jb4Ju/vM/swOByZ/3NEnMvyOQmHp503wY=
X-Received: by 2002:a9d:7248:: with SMTP id a8mr9100984otk.363.1561739275009;
 Fri, 28 Jun 2019 09:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190626122724.13313-1-hch@lst.de> <20190626122724.13313-17-hch@lst.de>
 <20190628153827.GA5373@mellanox.com>
In-Reply-To: <20190628153827.GA5373@mellanox.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 28 Jun 2019 09:27:44 -0700
Message-ID: <CAPcyv4joSiFMeYq=D08C-QZSkHz0kRpvRfseNQWrN34Rrm+S7g@mail.gmail.com>
Subject: Re: [PATCH 16/25] device-dax: use the dev_pagemap internal refcount
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 8:39 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Wed, Jun 26, 2019 at 02:27:15PM +0200, Christoph Hellwig wrote:
> > The functionality is identical to the one currently open coded in
> > device-dax.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  drivers/dax/dax-private.h |  4 ----
> >  drivers/dax/device.c      | 43 ---------------------------------------
> >  2 files changed, 47 deletions(-)
>
> DanW: I think this series has reached enough review, did you want
> to ack/test any further?
>
> This needs to land in hmm.git soon to make the merge window.

I was awaiting a decision about resolving the collision with Ira's
patch before testing the final result again [1]. You can go ahead and
add my reviewed-by for the series, but my tested-by should be on the
final state of the series.

[1]: https://lore.kernel.org/lkml/CAPcyv4gTOf+EWzSGrFrh2GrTZt5HVR=e+xicUKEpiy57px8J+w@mail.gmail.com/
