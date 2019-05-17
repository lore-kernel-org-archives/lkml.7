Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C4EC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A09B21734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="N6AVNHwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbfEQSKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 14:10:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36898 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfEQSKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 14:10:17 -0400
Received: by mail-ed1-f66.google.com with SMTP id w37so11807137edw.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 11:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0RAJ8dFkgMXY5OQlUUJ6T1gPWQG4AjdkRmpcqOy8B8o=;
        b=N6AVNHwED44tjfNeBflxf/4LK+NXnqWsv17JWf6m0n56Z8TxPCSc5PmhLfxKM9WFrq
         YbKovej0m6JAq0uY+V0fukul3/8snNc7VVGW3uaJCYOv9kESzesDs34u+v4WAStgHP3c
         sBeltk1m46EU7g2kMwLBL1Xlc9O9R/OxZjl/+/qkgn3IyGRlBAhWR9BgYqAdPvWtybzJ
         IgFGR1LpSroJPjuo0A0Qc1QBzB29kPQIib6uBuK0f/3Wx8viB4rvGm7IMOZPK6bLo+in
         ON8O8uP2Me8M1QHTOgHYyJqE46rojKl0mOXRMk3JP5y+xtGruIDjYea+Vte5dqNdk7pj
         Jbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0RAJ8dFkgMXY5OQlUUJ6T1gPWQG4AjdkRmpcqOy8B8o=;
        b=CgQHtdWql8uKzfd5WLs6YbOx/KzUvFhFckZX3KyrFzeIH+XKUJVG0F7PBBosRiwYQc
         Dhrz0vZ5E9naGLXZ87lAZ8STmdZrKnz7nK4Yo2LRjfTb3stkxJnpfnuTGT/1eZ0JOIVm
         CoDfNVX0lbeN8c7x8t61W+losEeKlGh52qPSrwtJNg312aSiQXfTYvZ8+ksthflF3nvh
         18mFyu16TKieLJXrg1u+gK/tgHQdk0vol0vGk1/iRPDTsB4stVCFUNRgUF187JTV/R6f
         WysBAE6h24MbJe/YvFMD1RWxp3GqAYEYGV2gIpl080QnbFSAI7SgAEkeAGcAoHYKz1fB
         Wk6w==
X-Gm-Message-State: APjAAAU8lzQ0Sjn8in6BeJimFXoazU5G2x2IK6sAAMuZ8pm0uQJpnkij
        8dVHRmML51WeDfE01h9gF/vUNvlyynrdUm3J1ZadJg==
X-Google-Smtp-Source: APXvYqy265H8YTRxW0fmCC2I6ZxM8EIDTEHONdgksak2H40jR89a0QYHQFohoS/iSUfnFLtzqxC5+RMenGd+voNYkNc=
X-Received: by 2002:a50:ee01:: with SMTP id g1mr58841265eds.263.1558116615828;
 Fri, 17 May 2019 11:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190502184337.20538-1-pasha.tatashin@soleen.com>
 <20190502184337.20538-3-pasha.tatashin@soleen.com> <cac721ed-c404-19d1-71d1-37c66df9b2a8@intel.com>
 <CAPcyv4greisKBSorzQWebcVOf2AqUH6DwbvNKMW0MQ5bCwYZrw@mail.gmail.com>
In-Reply-To: <CAPcyv4greisKBSorzQWebcVOf2AqUH6DwbvNKMW0MQ5bCwYZrw@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 17 May 2019 14:10:04 -0400
Message-ID: <CA+CK2bAeLJFRDTNnUrz_JCP5DVqM2N8+09q1TX7+OCE7b5v+1A@mail.gmail.com>
Subject: Re: [v5 2/3] mm/hotplug: make remove_memory() interface useable
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Takashi Iwai <tiwai@suse.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thank you very much for your review, my comments below:

On Mon, May 6, 2019 at 2:01 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, May 6, 2019 at 10:57 AM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > > -static inline void remove_memory(int nid, u64 start, u64 size) {}
> > > +static inline bool remove_memory(int nid, u64 start, u64 size)
> > > +{
> > > +     return -EBUSY;
> > > +}
> >
> > This seems like an appropriate place for a WARN_ONCE(), if someone
> > manages to call remove_memory() with hotplug disabled.

I decided not to do WARN_ONCE(), in all likelihood compiler will
simply optimize this function out, but with WARN_ONCE() some traces of
it will remain.

> >
> > BTW, I looked and can't think of a better errno, but -EBUSY probably
> > isn't the best error code, right?

-EBUSY is the only error that is returned in case of error by real
remove_memory(), so I think it is OK to keep it here.

> >
> > > -void remove_memory(int nid, u64 start, u64 size)
> > > +/**
> > > + * remove_memory
> > > + * @nid: the node ID
> > > + * @start: physical address of the region to remove
> > > + * @size: size of the region to remove
> > > + *
> > > + * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
> > > + * and online/offline operations before this call, as required by
> > > + * try_offline_node().
> > > + */
> > > +void __remove_memory(int nid, u64 start, u64 size)
> > >  {
> > > +
> > > +     /*
> > > +      * trigger BUG() is some memory is not offlined prior to calling this
> > > +      * function
> > > +      */
> > > +     if (try_remove_memory(nid, start, size))
> > > +             BUG();
> > > +}
> >
> > Could we call this remove_offline_memory()?  That way, it makes _some_
> > sense why we would BUG() if the memory isn't offline.

It is this particular code path, the second one: remove_memory(),
actually tries to remove memory and returns failure if it can't. So, I
think the current name is OK.

>
> Please WARN() instead of BUG() because failing to remove memory should
> not be system fatal.

As mentioned earlier, I will keep BUG(), because existing code does
that, and there is no good handling of this code to return on error.

Thank you,
Pavel
