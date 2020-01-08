Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4171C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F4220678
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="s9NJQtCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgAHTAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 14:00:03 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36542 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729669AbgAHTAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 14:00:02 -0500
Received: by mail-ot1-f68.google.com with SMTP id 19so4652829otz.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 11:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XKG1nbVwzj/tRpstff6fH6LSUuwV4sjHhIFUgWIlV+U=;
        b=s9NJQtCqnectin8Ti+6PJbbfj1iVC29kijEEVzBm9eYM0xqovEdSIvUBRa5QV+2Qzf
         uMjhO+nADZCdf/v+dinki4tHGe/eBYjmY78A0B9gngLOIJZSvsYSGQUcFghNBkzajBm+
         002VIJLs2HYb6/7/565YtsSdwQ7BoFsW7F2g/8JhRZm5aaupLnZ+WjxKHOUtdugZXa+v
         M5Cfg0EYtVYHOoLi8prNlcRFGlvf0CrScWNFvhySDu/GUL/m4BLe/M+OqS31fpVqrUm6
         /h5oOCVTEniuxvpSTmawQh4xsO4jXbtbwJSxpi9ba8XLCoKCbuSjDDKpfn0F41JYkU5K
         2q8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKG1nbVwzj/tRpstff6fH6LSUuwV4sjHhIFUgWIlV+U=;
        b=ob+s+646v7avd7ajQEAaDtjk2QWrNFlPrVWekif75hMHduHtyMqtZcIKYvqIJ09fTX
         IwgOg/NI2wA3lw+mTwIBFUqhzq8xtv2Cs+ROY7EcuZI2tUy6LfzIbfw5IQED+129CrJg
         hpakN1qTKHY41hGxhoTkTNyD2kWbCvArjdnRFCN0zeT8KfGj8dFZ3kJ9gJr00bBAKEDN
         9C0b3GgPmLWWwjB4e/0b2ZJnofIG2s/HcQweHxOHIHf83L60B637MuxW/G2LH9ODTKfT
         dMoQULyYi8s7CZFBDYCM04hFEZgM+JA8hqP/XA1RsXnwP/RF1r21Hh7wMtpcgdWCPzXV
         CV2A==
X-Gm-Message-State: APjAAAWKLm+zW1kai8eQ0Q9RR+TWkqAmX9Vttd2PQu19MB2pTutHqkyy
        Ya5FTUNOMJg6JyhHn9p9C2HWyVAZPvqXPO9u3ML8Sg==
X-Google-Smtp-Source: APXvYqxCuOUFRmTIFvW4iH38UfBo5T8KUr6T2q9RXS3eopOSB7fDf5LWtiL93/r45iWPoVq/UfuDWeRs67v8mZX9sdI=
X-Received: by 2002:a9d:68d3:: with SMTP id i19mr4939869oto.71.1578510001998;
 Wed, 08 Jan 2020 11:00:01 -0800 (PST)
MIME-Version: 1.0
References: <20200107205959.7575-1-logang@deltatee.com> <20200107205959.7575-3-logang@deltatee.com>
 <3e432695-e3a9-2aae-e9f5-1b6454886c06@redhat.com> <eef4ec73-8823-9f20-93ed-5c09f18c437a@deltatee.com>
In-Reply-To: <eef4ec73-8823-9f20-93ed-5c09f18c437a@deltatee.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 8 Jan 2020 10:59:51 -0800
Message-ID: <CAPcyv4hdpMs5om4_VrYUz98aWDJ9eRhj7WJr312Jwn6LCmAm9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] mm/memory_hotplug: Rename mhp_restrictions to mhp_modifiers
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Badger <ebadger@gigaio.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 9:17 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2020-01-08 5:28 a.m., David Hildenbrand wrote:
> > On 07.01.20 21:59, Logan Gunthorpe wrote:
> >> The mhp_restrictions struct really doesn't specify anything resembling
> >> a restriction anymore so rename it to be mhp_modifiers.
> >
> > I wonder if something like "mhp_params" would be even better. It's
> > essentially just a way to avoid changing call chains rough-out all archs
> > whenever we want to add a new parameter.
>
> Sure, that does sound a bit nicer to me. I can change it for v3.

Oh, I was just about to chime in to support "modifiers" because I
would expect all parameters to folded into a "params" struct. The
modifiers seem to be limited to the set of items that are only
considered in a non-default / expert memory hotplug use cases.
