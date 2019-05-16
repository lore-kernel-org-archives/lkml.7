Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E877C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A06D2070D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="JK0kNXwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfEPVvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 17:51:53 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41290 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfEPVvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 17:51:53 -0400
Received: by mail-ot1-f65.google.com with SMTP id g8so4892494otl.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 14:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q9BJIUmtXvGA8NYL+nEThmnX3fsQkDEf9gjJHVtWFbw=;
        b=JK0kNXwowOzM74+Om7kEhXLK+rOIMCMEPEAa6Fk0D93qKu8M2dq0YJm2ZfDxgTeCiU
         ZnpolSVQFmjdgAGuHgNPUQKcuPGJMBEDpFs5OvgWHO2/r1lUKUoq+r79dmC3nusASLwW
         b7J6BtVgy9HYQwcAKkLHQsoshwVUNWjVqol42iFhSJKjgsIi6Dc+SwbzWrocF4PuQV9M
         IYPIajeB7RxjAFAl9a4GWlG5H5AeA23IEp+6x25xZR+whf8n/MJa5cQu6cdcsWrU1TDn
         /Arr+Bi1p3leIaZVgocYnoMbwVUjOA/IIrN5CFkLQKwwu660ooYhVCJaHs5KP3OXWCL+
         YIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q9BJIUmtXvGA8NYL+nEThmnX3fsQkDEf9gjJHVtWFbw=;
        b=uf91QmsVv0OabbiwSVNhMaaIQn1GifjXLPVfRIAd5bkckkhNLeYCeZh2FJ+u1nXI91
         UBvJsujKjJrXq6E0X2Jm2WHthxKC1XAl3/62LujgC/Iuxs7DLNIbzi9aaJJmaLfFhNj6
         Zs+ai/0MA24FN3jLwSqeyNazZgb1JIf1hkSfVXu6z5DO5gOA/e9TuWvjzt4mx9rSX7al
         3n+XhRJDEZNdLJobljgWH5C5yYwZJf1mNPAB8BnDvV8z8Q5Xd4K0qzZoVG6JpxKNwvHJ
         quCtGeGnFqQ82aAqAAMNQuIXgGJreS4Ze42xqk0684+a0opIeNSm7ENLgq3ACye1w7CR
         Tmzg==
X-Gm-Message-State: APjAAAVaWLpLLHVP017tSUHwu8TzsFqXDJrKPh71jxGaruJ5Boqbn7Sv
        STQzTfeYDcBQU6EeGIsYgCHEmLtofK+kNb7hailLjQ==
X-Google-Smtp-Source: APXvYqzibKwOyLJegIvrnmsMGvcFID1N0Mw2/FEB7rFcTHdA1PYSfF3HR1ZbWMzElybqvVBCcqSrRsrG3NhAGtjgYjo=
X-Received: by 2002:a9d:2f0:: with SMTP id 103mr30133978otl.126.1558043512432;
 Thu, 16 May 2019 14:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <155727335978.292046.12068191395005445711.stgit@dwillia2-desk3.amr.corp.intel.com>
 <059859ca-3cc8-e3ff-f797-1b386931c41e@deltatee.com> <17ada515-f488-d153-90ef-7a5cc5fefb0f@deltatee.com>
 <8a7cfa6b-6312-e8e5-9314-954496d2f6ce@oracle.com> <CAPcyv4i28tQMVrscQo31cfu1ZcMAb74iMkKYhu9iO_BjJvp+9A@mail.gmail.com>
 <6bd8319d-3b73-bb1e-5f41-94c580ba271b@oracle.com> <d699e312-0e88-30c7-8e50-ff624418d486@oracle.com>
In-Reply-To: <d699e312-0e88-30c7-8e50-ff624418d486@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 16 May 2019 14:51:40 -0700
Message-ID: <CAPcyv4hujnGHtTwE78gvmEoY3Y6nLsd1AhJfeKMwHrxLvStf9w@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm/devm_memremap_pages: Fix page release race
To:     Jane Chu <jane.chu@oracle.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 9:45 AM Jane Chu <jane.chu@oracle.com> wrote:
>
> Hi,
>
> I'm able to reproduce the panic below by running two sets of ndctl
> commands that actually serve legitimate purpose in parallel (unlike
> the brute force experiment earlier), each set in a indefinite loop.
> This time it takes about an hour to panic.  But I gather the cause
> is probably the same: I've overlapped ndctl commands on the same
> region.
>
> Could we add a check in nd_ioctl(), such that if there is
> an ongoing ndctl command on a region, subsequent ndctl request
> will fail immediately with something to the effect of EAGAIN?
> The rationale being that kernel should protect itself against
> user mistakes.

We do already have locking in the driver to prevent configuration
collisions. The problem looks to be broken assumptions about running
the device unregistration path in a separate thread outside the lock.
I suspect it may be incorrect assumptions about the userspace
visibility of the device relative to teardown actions. To be clear
this isn't the nd_ioctl() path this is the sysfs path.


> Also, sensing the subject fix is for a different problem, and has been
> verified, I'm happy to see it in upstream, so we have a better
> code base to digger deeper in terms of how the destructive ndctl
> commands interacts to typical mission critical applications, include
> but not limited to rdma.

Right, the crash signature you are seeing looks unrelated to the issue
being address in these patches which is device-teardown racing active
page pins. I'll start the investigation on the crash signature, but
again I don't think it reads on this fix series.
