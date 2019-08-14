Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B30C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11FC2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="VGmsuSut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfHNOsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:48:39 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38284 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfHNOsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:48:39 -0400
Received: by mail-ot1-f67.google.com with SMTP id r20so33082993ota.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 07:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TuidyYaeRyKNuzkufRgN6Ec9LRr2Ifgbce3UwZKDqAk=;
        b=VGmsuSutDmh/CjlBsd4sxqgbi8um+dCHzh+K0g76f30mKTKa4vnjEUi5IghOvDT2TU
         IiuduD1hp/FbpMVaMr/e7wBsaqMWdJ6XHtQ/1mBsBItSP4Wnk6xfU27TabVrZ7CxNxNQ
         xk36x4tWlqqM3zgQ+imkzsVY04ipeNiKK+QA1YnFVauQbb2Je88bjQTJ7UYiJXdobeSQ
         8yXovyKKvS5GfjCCiA8ng2LVaXxNaFUycGFOD1MJp5B3wtPnD6SMS1YSM8AN/j0ewy4K
         946ksv8AZDHbxIlpfzizsK/Ykelqs/5V6AZKhURom457TIKDaqNjmkxGJQw/75l6BLCF
         rGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TuidyYaeRyKNuzkufRgN6Ec9LRr2Ifgbce3UwZKDqAk=;
        b=HANDBtMW8EKKlY8RsbtcK/opd8nFpcOjjc8E1wsJkZxuqyEaV+fwAUy77+Foclk+5v
         WK+JYK3pZr47fRuc3MsfwJyxdnC6ukZOeBcFWXSdN859GDR2GY3k/WdOhUCSPYvi1NUw
         9s/ZCDBxgLuU8IZ9VOtVpFOLMdX6fDs2HJpKz5bsZxYYYZHfVrhbc8Y7g1yAMoPV+Zr1
         3lmrCp2lJnAzZuyRG45Lp8s7oF5GIJj6ZFKNgqiqr8fXJ9QA3dTzQ5Xbo53+a5i+Fgbf
         It04ijXzWNcLpB/WO0d4mPxIs3TK/6LwHRs2/B0QEwwOl7YVqMDPi58S0a1Bc4pNDtRR
         SnCQ==
X-Gm-Message-State: APjAAAWqQIc21CBS0Jyxiwda/OoaXT5ktcusY5aXx2DrQeODaDjPJaOl
        jheW8DMkcaBSqzsjq69W18rfofU1GBq1QALdj2XFxg==
X-Google-Smtp-Source: APXvYqz7zm4exw86gTxj/ItuLHdqDfdPZkzMbuPMtbbm6xwrB+umcFhlOUSiQC4HRsH79R5rtenZdkZ3lrgt5XcFI70=
X-Received: by 2002:a9d:6b96:: with SMTP id b22mr2732383otq.363.1565794118373;
 Wed, 14 Aug 2019 07:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190806160554.14046-1-hch@lst.de> <20190806160554.14046-5-hch@lst.de>
 <20190807174548.GJ1571@mellanox.com> <CAPcyv4hPCuHBLhSJgZZEh0CbuuJNPLFDA3f-79FX5uVOO0yubA@mail.gmail.com>
 <20190808065933.GA29382@lst.de> <CAPcyv4hMUzw8vyXFRPe2pdwef0npbMm9tx9wiZ9MWkHGhH1V6w@mail.gmail.com>
 <20190814073854.GA27249@lst.de> <20190814132746.GE13756@mellanox.com>
In-Reply-To: <20190814132746.GE13756@mellanox.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 14 Aug 2019 07:48:28 -0700
Message-ID: <CAPcyv4g8usp8prJ+1bMtyV1xuedp5FKErBp-N8+KzR=rJ-v0QQ@mail.gmail.com>
Subject: Re: [PATCH 04/15] mm: remove the pgmap field from struct hmm_vma_walk
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 6:28 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Wed, Aug 14, 2019 at 09:38:54AM +0200, Christoph Hellwig wrote:
> > On Tue, Aug 13, 2019 at 06:36:33PM -0700, Dan Williams wrote:
> > > Section alignment constraints somewhat save us here. The only example
> > > I can think of a PMD not containing a uniform pgmap association for
> > > each pte is the case when the pgmap overlaps normal dram, i.e. shares
> > > the same 'struct memory_section' for a given span. Otherwise, distinct
> > > pgmaps arrange to manage their own exclusive sections (and now
> > > subsections as of v5.3). Otherwise the implementation could not
> > > guarantee different mapping lifetimes.
> > >
> > > That said, this seems to want a better mechanism to determine "pfn is
> > > ZONE_DEVICE".
> >
> > So I guess this patch is fine for now, and once you provide a better
> > mechanism we can switch over to it?
>
> What about the version I sent to just get rid of all the strange
> put_dev_pagemaps while scanning? Odds are good we will work with only
> a single pagemap, so it makes some sense to cache it once we find it?

Yes, if the scan is over a single pmd then caching it makes sense.
