Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AABC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 23:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DA22082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 23:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="wZXK/rGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfFTXNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 19:13:17 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42140 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFTXNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 19:13:16 -0400
Received: by mail-oi1-f193.google.com with SMTP id s184so3371606oie.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 16:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s1U8b9i28hLJayWU6+c6YVAvl2Rop3SMymokvtyzh0o=;
        b=wZXK/rGx3xr+u7oi//RllS+oGNo9Tzry/ML+vUVpgS/Zv+UVNj64dDUV96UYUd1Jn3
         HTEz2HrWATyMseQ9ESDNMngt9dsb1UfHOlUe8zE/5wDSyS1AVE4ZRpittyrzTTchLos5
         4eYsM6eY6GbydQyeJ5021LQYq2W4FXOMsUpMRrhldyeNx0gkDVyn8cVP0JPDGRXYNHA0
         Khcxwe9CepLmmm4wC6aJwDUSLxUAkLS7QB/OjbTbUQGW9ZgOSJMHsxAIyonm6fZ1Gisx
         DP1+rtOY4WuxwcsaUVn8PkaGb7RTOOyiGjDW9YizTilPtgcvoQvLQUcgY/Zjj7YawYJt
         OuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s1U8b9i28hLJayWU6+c6YVAvl2Rop3SMymokvtyzh0o=;
        b=nDj7k6/cnpEkd/nZaFbtDqY1sK80zwlPKKj6fLFrSROLWLR0z6u8v9iVUWfzDPOyJx
         i+vA66pH7zn3wMkZfC8zkA1dCBZsjjOXE79YaX3pVZyWSUQ731blYGkCnoM1YA566MLE
         MF6p2jIgYCUea+aBsrVWp9sDPbcAoD3KkEPVbE6PUz6V4ilo0kL9M5b+kfAV2Kq/KTrO
         xtoGKWS00p7oEBSrl7cd0qENWOsQXm047NXVCFWyCDbTVcrYnjM7NqnUuWCr7LLj8pw4
         /MgWsT6kMiVlZlI32MubEyW/y1e1UpPEW3/wclAfESvy4oHdat8M4veiSfCdl60ctSx0
         zAGQ==
X-Gm-Message-State: APjAAAW7d3+Q2/JIzI690YFQcpU/3S5Ahu+i/R4XLDjhSNggIZ1GEpJx
        IhMdIS6wyjUr6Iof7WiaVHtbHSujTfNasARcUMwQ4Q==
X-Google-Smtp-Source: APXvYqxf0VmRIyLU90bg8tJ1rHATTJ0aCa2jorETk2j+MQarpeuMzOl/bF99+OKywGM9BxnPQWWwQHFQhni6/xxki/w=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr917887oii.0.1561072395816;
 Thu, 20 Jun 2019 16:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190613045903.4922-1-namit@vmware.com> <20190613045903.4922-4-namit@vmware.com>
 <20190617215750.8e46ae846c09cd5c1f22fdf9@linux-foundation.org>
 <98464609-8F5A-47B9-A64E-2F67809737AD@vmware.com> <8072D878-BBF2-47E4-B4C9-190F379F6221@vmware.com>
 <CAErSpo5eiweMk2rfT81Kwnpd=MZsOa01prPo_rAFp-MZ9F2xdQ@mail.gmail.com>
 <CAPcyv4iAbWnWUT2d2VhnvuHvJE0-Vxgbf1TYtOPjkR6j3qROtw@mail.gmail.com> <8736k49c57.fsf@firstfloor.org>
In-Reply-To: <8736k49c57.fsf@firstfloor.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 20 Jun 2019 16:13:04 -0700
Message-ID: <CAPcyv4i1YYExVtXXdkCMgRvjqoeTkZdjwDVjf=sJN-qPF1LEtg@mail.gmail.com>
Subject: Re: [PATCH 3/3] resource: Introduce resource cache
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Nadav Amit <namit@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Borislav Petkov <bp@suse.de>,
        Toshi Kani <toshi.kani@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Kleen, Andi" <andi.kleen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 2:31 PM Andi Kleen <andi@firstfloor.org> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
> >
> > The underlying issue is that the x86-PAT implementation wants to
> > ensure that conflicting mappings are not set up for the same physical
> > address. This is mentioned in the developer manuals as problematic on
> > some cpus. Andi, is lookup_memtype() and track_pfn_insert() still
> > relevant?
>
> There have been discussions about it in the past, and the right answer
> will likely differ for different CPUs: But so far the official answer
> for Intel CPUs is that these caching conflicts should be avoided.
>

Ok.

> So I guess the cache in the original email makes sense for now.

I wouldn't go that far, but it does mean that if we go ahead with
caching the value as a dax_device property there should at least be a
debug option to assert that the device value conforms to all the other
mappings.

Another  failing of the track_pfn_insert() and lookup_memtype()
implementation is that it makes it awkward to handle marking mappings
UC to prevent speculative consumption of poison. That is something
that is better handled, in my opinion, by asking the device for the
pgprot and coordinating shooting down any WB mappings of the same
physical page.
