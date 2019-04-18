Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C98C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 02:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5302184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 02:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="sWBJ4MP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387871AbfDRCJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 22:09:25 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45987 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfDRCJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 22:09:25 -0400
Received: by mail-oi1-f194.google.com with SMTP id y84so373351oia.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 19:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrLS7c6kahvwclZJMhG+EEBp9/3p/FOJcV7sIRhk688=;
        b=sWBJ4MP4aMbDjfMOL2XmESU3BP1NUeCYIIgWZvm8bnnn2yTsIA4nOkaJ4ujF3TGAQL
         V7Bvewsg7Z+zFnK7uufCUElZo1lFGESS6DPnGlrzZo57bY7JtK/xauERnePYfPo1QDVH
         R7W5isQJDZBGsz+/Z/QRdBGGahMkJ1wjjC/51vqskOVhveFg3ETdoXFkYfJhvFyO/VY1
         Oh8zwzYpMOaFxrQ92EVfnBRB7oY6ydppKS6DaSBozcTfRk8OJTF/q5RivIIZBRulYXFf
         qnEnAcBSLCYeKnMyRYBUwzt0WqFSYWJSm9HihsaqQE6JrXV5WOCM6wal7q8J1yD08aXs
         o12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrLS7c6kahvwclZJMhG+EEBp9/3p/FOJcV7sIRhk688=;
        b=I08NWbyAv8XspULG31UQqeNaVcBwttpHVMMd4FrLuKfc26gN5jdkTq3zdOsh5tywSt
         b8ux99QZSIuukA2zi+FXiwL8gYRugsCL0v2iMbcvRMZKXPPugJ82O82sssGnScqDMA+u
         TpgK+kCHjH1sBv7ldaz2OWTv/MKA9Pmu7tayfo6koG2XMusnI2KMShkybD5fBwEOqU3c
         fpHSFyEfAkB6ni+j+illj9u1/wI/UIMHJH5J5jMHz7ceK/ZGGPakujxR5njtr/EehcNa
         eJ5uGCQBY+EKPA3xwj1q0dEI+Mmw+3djG4UhPe1lJfyfI6m3cug+gHPeAcnK2HiBQX7k
         zl6Q==
X-Gm-Message-State: APjAAAVM6sOzpvkJhEq3GDdE/m6ayHWd4qDuuvK2QyqnV9zI/QV5kPK3
        vrMMkNR1QXzyo4+IA9tYuMeUx/Sz5zLB5UzsBA+8Xw==
X-Google-Smtp-Source: APXvYqxBRLry2uehHtUIkQ1eBS/Fg07FCXB2FZ6fmtn5pcgldkBocOuARUVj5a3Sv2b8a/RLFyKNOhEvUY0nxxYuSLU=
X-Received: by 2002:aca:f581:: with SMTP id t123mr443431oih.0.1555553364394;
 Wed, 17 Apr 2019 19:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190417150331.90219ca42a1c0db8632d0fd5@linux-foundation.org> <CAPcyv4hB47NJrVi1sm+7msL+6dJNhBD10BJbtLPZRcK2JK6+pg@mail.gmail.com>
In-Reply-To: <CAPcyv4hB47NJrVi1sm+7msL+6dJNhBD10BJbtLPZRcK2JK6+pg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 17 Apr 2019 19:09:12 -0700
Message-ID: <CAPcyv4iW=xhhUQbg0bt=xCgVaR_jUvATeLxSoCfvzG5gTEAX6A@mail.gmail.com>
Subject: Re: [PATCH v6 00/12] mm: Sub-section memory hotplug support
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Jeff Moyer <jmoyer@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        stable <stable@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 3:59 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Apr 17, 2019 at 3:04 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 17 Apr 2019 11:38:55 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > > The memory hotplug section is an arbitrary / convenient unit for memory
> > > hotplug. 'Section-size' units have bled into the user interface
> > > ('memblock' sysfs) and can not be changed without breaking existing
> > > userspace. The section-size constraint, while mostly benign for typical
> > > memory hotplug, has and continues to wreak havoc with 'device-memory'
> > > use cases, persistent memory (pmem) in particular. Recall that pmem uses
> > > devm_memremap_pages(), and subsequently arch_add_memory(), to allocate a
> > > 'struct page' memmap for pmem. However, it does not use the 'bottom
> > > half' of memory hotplug, i.e. never marks pmem pages online and never
> > > exposes the userspace memblock interface for pmem. This leaves an
> > > opening to redress the section-size constraint.
> >
> > v6 and we're not showing any review activity.  Who would be suitable
> > people to help out here?
>
> There was quite a bit of review of the cover letter from Michal and
> David, but you're right the details not so much as of yet. I'd like to
> call out other people where I can reciprocate with some review of my
> own. Oscar's altmap work looks like a good candidate for that.

I'm also hoping Jeff can give a tested-by for the customer scenarios
that fall over with the current implementation.
