Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863C8C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5609420881
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="KHiq4DTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfENTEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 15:04:51 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45403 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfENTEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 15:04:51 -0400
Received: by mail-oi1-f194.google.com with SMTP id w144so7465546oie.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 12:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3MJ8G8iFv7+woc8MxzlUA/t0B24IADDceJ2Iwj8h/Xc=;
        b=KHiq4DTxHeWZ7ZhUHDu3H0zQSi38koEkJT4e3DrcIHpodiGs1HmKFmBuIkUh6+Jaa6
         Y/6A3+PwUYWdyOE3xHPlQjkdirSldkEQvcF+hSK5PhGF+ve9zGZzPoeGLFq3W6qtz6NA
         kemlQvGyqbc8CBla4gR77VFkJN2TIyWfePCyJM6m/C4rSu7hdxOK6qSS5wXzCwiLJPjR
         EFV9Qt/uXDgOed+YJWpYGiaa+/VXmapf3qo/gqjYzLasnINwuvH9MOZ9oX19+TJjCCEw
         7PVMvruc5jDesaE1Kc1h+pAZwRVdmIsHKWevuatJQOKhRbc7N2LS+/XL5FBeHjMz/aOi
         iGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3MJ8G8iFv7+woc8MxzlUA/t0B24IADDceJ2Iwj8h/Xc=;
        b=fVQZdD22nDHx3IAsLdgRP02QXimePRAqgyQvgBDnqYsqVm8pG/aMmaBfU5ExE2DSqN
         CjKSESpnYy4VagWzkwLDeN0QkxKSE8vDtd3koFvZ/0ArOQvjHMGSCML4GDOtA6r6aBFZ
         gKFqj613zQO4Pk7x6MY3nhaQ6hUgCTKW1Apxk9aUMAxjnLsQ4qYhUtBL/IsjpqCJq9yA
         BZNQHI7o2/RfJ/Lt59iNjOYlkf3qwlc5xK0pzes5RrafCVxpxi4epLALgL/7WSK/ZyCQ
         rLKHQpYCnXXSUZ/EjK78JszBUfY9P+HIYIzSimk9yQJ3n1H60+Szb1SXfYn70Z+EZvvu
         u2fA==
X-Gm-Message-State: APjAAAW4R1oir+EKkS5n0STHYYxjonWh6VvyuXtv+3R1CGn0MbvptMO7
        3HWNELy9nc+9wVpGEQlOs8vSmP8XWFOgA5asMYm7XQ==
X-Google-Smtp-Source: APXvYqx10sN10v6S3En1NMksHnyYHTQr2N9LW12pza7Vp5Lf8RW1bTEysUgnoVyxZuM89zNVotYaW0eHbtxS8r7LtXQ=
X-Received: by 2002:aca:ab07:: with SMTP id u7mr73100oie.73.1557860689951;
 Tue, 14 May 2019 12:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <155727335978.292046.12068191395005445711.stgit@dwillia2-desk3.amr.corp.intel.com>
 <059859ca-3cc8-e3ff-f797-1b386931c41e@deltatee.com> <17ada515-f488-d153-90ef-7a5cc5fefb0f@deltatee.com>
 <8a7cfa6b-6312-e8e5-9314-954496d2f6ce@oracle.com>
In-Reply-To: <8a7cfa6b-6312-e8e5-9314-954496d2f6ce@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 14 May 2019 12:04:38 -0700
Message-ID: <CAPcyv4i28tQMVrscQo31cfu1ZcMAb74iMkKYhu9iO_BjJvp+9A@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm/devm_memremap_pages: Fix page release race
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 11:53 AM Jane Chu <jane.chu@oracle.com> wrote:
>
> On 5/13/2019 12:22 PM, Logan Gunthorpe wrote:
>
> On 2019-05-08 11:05 a.m., Logan Gunthorpe wrote:
>
> On 2019-05-07 5:55 p.m., Dan Williams wrote:
>
> Changes since v1 [1]:
> - Fix a NULL-pointer deref crash in pci_p2pdma_release() (Logan)
>
> - Refresh the p2pdma patch headers to match the format of other p2pdma
>    patches (Bjorn)
>
> - Collect Ira's reviewed-by
>
> [1]: https://lore.kernel.org/lkml/155387324370.2443841.574715745262628837.stgit@dwillia2-desk3.amr.corp.intel.com/
>
> This series looks good to me:
>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>
> However, I haven't tested it yet but I intend to later this week.
>
> I've tested libnvdimm-pending which includes this series on my setup and
> everything works great.
>
> Just wondering in a difference scenario where pmem pages are exported to
> a KVM guest, and then by mistake the user issues "ndctl destroy-namespace -f",
> will the kernel wait indefinitely until the user figures out to kill the guest
> and release the pmem pages?

It depends on whether the pages are pinned. Typically DAX memory
mappings assigned to a guest are not pinned in the host and can be
invalidated at any time. The pinning only occurs with VFIO and
device-assignment which isn't the common case, especially since that
configuration is blocked by fsdax. However, with devdax, yes you can
arrange for the system to go into an indefinite wait.

This somewhat ties back to the get_user_pages() vs DAX debate. The
indefinite stall issue with device-assignment could be addressed with
a requirement to hold a lease and expect that a lease revocation event
may escalate to SIGKILL in response to 'ndctl destroy-namespace'. The
expectation with device-dax is that it is already a raw interface with
pointy edges and caveats, but I would not be opposed to introducing a
lease semantic.
