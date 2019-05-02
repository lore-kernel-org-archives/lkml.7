Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F90C04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 23:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD44E2064A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 23:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="sWawHLNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfEBXVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 19:21:16 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34744 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfEBXVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 19:21:16 -0400
Received: by mail-ot1-f67.google.com with SMTP id n15so3754279ota.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 16:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0i5+J/OZLL+JOOwALn6I5uwFawiDlG+N57qbnmaBmtk=;
        b=sWawHLNMKR0Z8Wcp0xOaPFpIrQ6QpmbbM6zigcIzNj1WJvbeh+Sjw9n6tIJoHgDaA6
         GgHltRLQSt1agn1TOVUOGI46HUvE24ww/7wBYRHYRdNKiWzKHHbf5etMXZ20pnRvnGIT
         QxTurydSSdEyMyi2Qabh03VR59K4+NgTK148H0EFCAUUYSf8o8pEDxzDGjdTWBY4TUca
         UWHAuYyxKgs+/C5mYh4EOm/HxHdIMEG82VoybqBmlv5jAXSswdNp6xkxYFfh4c5dXIip
         rrOFS4TWce+QrFAoelxpv3OXDps3RdQeyQdRCaSHgv7pxXJ8hfmeq4/ufkrHiwBWMeqm
         VKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0i5+J/OZLL+JOOwALn6I5uwFawiDlG+N57qbnmaBmtk=;
        b=fJTE/mZkKSOfl3vC1CKuMjttV3ilPLY3YwwjbkWem3m0BsgMFzJ1WElX8ErJm+ZT7r
         GOLbM2ePFn03ooh8Qkv6J+Cj8D81yXer39YIjHwaDXy2V9zTvm4Iui549OZn2gch4Lnz
         pk2L3l4h1zvBmCt2gvxQqware/hZPZEtVBH8hPj4mHcdb9ojPWdItz/SKm9rvN4DDTk2
         Jo1NwehhvmQhxgOcLmitZ8JvxihEvqTN1GFufi3fpn2dKf4F4/ldolIs0R7lJdS8d0Eq
         GCus2RgWNgoAZ7+5nt/olsa4kns0r7NpLO/LvINSFcQhN1NknH5Q2T/zSScLo2iOpjVD
         ADvA==
X-Gm-Message-State: APjAAAXh81OayeKXg2X41hbrkq0elpQK5E8eVUVMcK6BNgTIhs1DEDg+
        XyG/HgId7C4Wq3HWGBWU4T3eGNIcHI4LD30iXpcwfw==
X-Google-Smtp-Source: APXvYqw0TgWpuTZRL+SCcmgsjTeKduMjL6fHbHh+v1JzAjaquiFt8e1uuHJEKU0m3H+lLNeHniLWZoNoGl8pEH0sriQ=
X-Received: by 2002:a9d:222c:: with SMTP id o41mr4495514ota.353.1556839275827;
 Thu, 02 May 2019 16:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+CK2bBT=goxf5KWLhca7uQutUj9670aL9r02_+BsJ+bLkjj=g@mail.gmail.com> <CAPcyv4gWZxSepaACiyR43qytA1jR8fVaeLy1rv7dFJW-ZE63EA@mail.gmail.com>
In-Reply-To: <CAPcyv4gWZxSepaACiyR43qytA1jR8fVaeLy1rv7dFJW-ZE63EA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 2 May 2019 16:21:05 -0700
Message-ID: <CAPcyv4j1221GA6xQww741v-RdZame5D0q60qcxO5u=tv9MDoRw@mail.gmail.com>
Subject: Re: [PATCH v6 00/12] mm: Sub-section memory hotplug support
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Jeff Moyer <jmoyer@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        stable <stable@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 4:20 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Thu, May 2, 2019 at 3:46 PM Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
> >
> > Hi Dan,
> >
> > How do you test these patches? Do you have any instructions?
>
> Yes, I briefly mentioned this in the cover letter, but here is the
> test I am using:

Sorry, fumble fingered the 'send' button, here is that link:

https://github.com/pmem/ndctl/blob/subsection-pending/test/sub-section.sh
