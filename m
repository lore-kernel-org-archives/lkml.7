Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9296FC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB5620882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="WAdLf+oA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbfDDU6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:58:23 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42809 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730103AbfDDU6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:58:23 -0400
Received: by mail-ot1-f66.google.com with SMTP id 103so3660445otd.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 13:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qafkl+RucsJKe13LIlXobuTdVgqu/oF51yHT8KcUWbc=;
        b=WAdLf+oA+P/wpBu5Pjl44qrdlHaOV2iP7oRPTstlMdt40fThdirzxyUc6aqHEhmVal
         pxCiHwSA82rPNahu4jHqT742OswANbaGqdKWmNwUFJNXhbvSkHK+5f7UQkjDCAFyzUue
         3O8+8w88xLv9me1UXzUorHxybGBhIeLOyeXrbSzSj5fcm65YReoYfz3WkJApxvyBXE7x
         dvv+Ro4iMC6N8xOnmImpwyU5PSGMQ0SDkS1wJe6mu2Ov8XImba+jLAG3nB8l9aV1up0t
         B2LQkCeWlxvgdpV54gPzh6pNMo94J2rpU1GadrXUWZhgaVWMr8jK7MM1SAuiUnIqJF0a
         l57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qafkl+RucsJKe13LIlXobuTdVgqu/oF51yHT8KcUWbc=;
        b=lV8Iqmw+h30DImoal590XfoXXSwpruGJdytkEKfym4/WKh5g8chO1bIP92Z8LZ0Ixi
         qVt2VR0KoiaM9xF58E8Dj8cXrpc/CG2hSvCwsrmiKcOsb2HUlZ94MY8Xh4UCOJYnQezv
         AzohWegh4K/XL35rZA8GXEFJo3IrwiyXz/fQL0qif1AqEhCtqQ9VWvfgRMlTEL4I0SQy
         OYVuqhsEKfDkFbRYAeV9+1a5O1+ElphF6sK8ji+Ad9xCOACwq1gUKQUch0UD98XjZ0A2
         fIYUx0KASnJfkQe8cF/2L2ANHuGlOGCHam+n6k9LRPzVYeNmjv21bm+Yy+3mnQgCgdzx
         YdAw==
X-Gm-Message-State: APjAAAXiDXVizgnHNjMWeLxBFePGf+H+YxkxhnTuShej68JDhST6aTbu
        znmoLA8r5boSc9fRWS1R4qZqtT9tM6pRcYEH4+SuodF+
X-Google-Smtp-Source: APXvYqxRkFGg4ofNBLeQIKRis7QOSDDVNGXKbjmC9eM589A4kZD0glRjlwj1jb40vyH+x86CEjmxTX8YszdahENoq0Q=
X-Received: by 2002:a9d:7a83:: with SMTP id l3mr5518812otn.285.1554411502925;
 Thu, 04 Apr 2019 13:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <155440490809.3190322.15060922240602775809.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155440492414.3190322.12683374224345847860.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190404205818.GC24499@localhost.localdomain>
In-Reply-To: <20190404205818.GC24499@localhost.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 4 Apr 2019 13:58:12 -0700
Message-ID: <CAPcyv4jua8GeyL7jNOZoEf9MhNXADvQX2T+h1D5FRRd9GLwNeA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] acpi/hmat: Track target address ranges
To:     Keith Busch <kbusch@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        X86 ML <x86@kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 1:56 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Thu, Apr 04, 2019 at 12:08:44PM -0700, Dan Williams wrote:
> > As of ACPI 6.3 the HMAT no longer advertises the physical memory address
> > range for its entries. Instead, the expectation is the corresponding
> > entry in the SRAT is looked up by the target proximity domain.
> >
> > Given there may be multiple distinct address ranges that share the same
> > performance profile (sparse address space), find_mem_target() is updated
> > to also consider the start address of the memory range. Target property
> > updates are also adjusted to loop over all possible 'struct target'
> > instances that may share the same proximity domain identification.
>
> Since this may allocate multiple targets with the same PXM,
> hmat_register_targets() will attempt to register the same node multiple
> times.
>
> Would it make sense if the existing struct memory_target adds a resource
> list that we can append to as we parse SRAT? That way we have one target
> per memory node, and also track the ranges.

That sounds reasonable to me.
