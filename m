Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FB6C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6941B218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="cAwbB9Jr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbfDXVe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:34:58 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44921 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731689AbfDXVe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:34:57 -0400
Received: by mail-ed1-f68.google.com with SMTP id i13so17286618edf.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 14:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y/Haum+Q0Tq67LT+lgDVhjDSLBZNQProc5ALAzxiJIE=;
        b=cAwbB9JrYP5QxhlwvuMdvdpA/ZsEiPfp9Oo18cK5lc1PLwGEuU52GQ5fgDi7K9on6l
         /VnQBR8ptusfL7wNOtbygpxerdwYUYrO+4a/VaSSSD/weFcWpLVTmaIZlhOUq3ehQGlW
         hSYXwrddTV4ayCT07Suk56HCGoGeNg+YXSnNd33lPboBbs98njPt7+JEfTQbv/es4Iji
         R91OTj1zR1fJNbeDlcVyuAJ3fqsG6Fv1AlVNh5k5TkhqSXFYMVoVmHo/eFPvb6YlC900
         mVArULVKGxcnY620A6h8WEBJ1JA7yMNtfccwIARWCHT48RM0hX+SWfTSiw+5ze9XmIoY
         nBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y/Haum+Q0Tq67LT+lgDVhjDSLBZNQProc5ALAzxiJIE=;
        b=KeCs5ijjEAyO/llJD+gO2l31bvQlVuHgPx+TR8MT5lgJATwc3WRhL3q1BiGrbRtOoX
         LIqGoyX3e10jYxRcdzgXUUVIvnMq45AMpHlQFSv1r3XCMvoOY3JVGhKouuT3HUFEBhVx
         lUjFvYbBAk6my0xKM3JzQRDYeGbSNu52XFNDXbABb2P6xUlpJ2jGUtf7vwCP9e8v4ETv
         kRtdiJM215jDGWnTssigG8wzvubVaMEv0RpdKHWaM1F6eVMxNQTauaTVrOKqUhhzHVQ1
         1pzHgT7fQS/1bZ33aFk/zhcpikjOfjWpHcQSJ46Wvw0Y5NRHA50NiTRlVoEzYxciUuLZ
         CXBg==
X-Gm-Message-State: APjAAAV9SSXzf1EGC9wZgUbVg0E1OaOqOyU11OoanIDUloQRleJL3fff
        iF2+RPreeclL1gpEOeSmySN9TmEJhjrXEuk9nPUO+g==
X-Google-Smtp-Source: APXvYqyw22yehyfckHGABFZjJ9k6UmdAua6ix/uaYi0Qv9TrVQhsLWKpvHjhVIsMkfhz6j7gMzL0YwmKiJYpYflTGzk=
X-Received: by 2002:a17:906:944b:: with SMTP id z11mr1125008ejx.151.1556141696280;
 Wed, 24 Apr 2019 14:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190421014429.31206-1-pasha.tatashin@soleen.com>
 <20190421014429.31206-3-pasha.tatashin@soleen.com> <4ad3c587-6ab8-1307-5a13-a3e73cf569a5@redhat.com>
 <CAPcyv4h3+hU=MmB=RCc5GZmjLW_ALoVg_C4Z7aw8NQ=1LzPKaw@mail.gmail.com>
In-Reply-To: <CAPcyv4h3+hU=MmB=RCc5GZmjLW_ALoVg_C4Z7aw8NQ=1LzPKaw@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 24 Apr 2019 17:34:45 -0400
Message-ID: <CA+CK2bDB5o4+NMc7==_ipVAZoEo7fdrkjZ4etU0LUCqxnmN-Rg@mail.gmail.com>
Subject: Re: [v2 2/2] device-dax: "Hotremove" persistent memory that is used
 like normal RAM
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
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
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +static int
> > > +offline_memblock_cb(struct memory_block *mem, void *arg)
> >
> > Function name suggests that you are actually trying to offline memory
> > here. Maybe check_memblocks_offline_cb(), just like we have in
> > mm/memory_hotplug.c.

Makes sense, I will rename to check_memblocks_offline_cb()

> > > +     lock_device_hotplug();
> > > +     rc = walk_memory_range(start_pfn, end_pfn, dev, offline_memblock_cb);
> > > +     unlock_device_hotplug();
> > > +
> > > +     /*
> > > +      * If admin has not offlined memory beforehand, we cannot hotremove dax.
> > > +      * Unfortunately, because unbind will still succeed there is no way for
> > > +      * user to hotremove dax after this.
> > > +      */
> > > +     if (rc)
> > > +             return rc;
> >
> > Can't it happen that there is a race between you checking if memory is
> > offline and an admin onlining memory again? maybe pull the
> > remove_memory() into the locked region, using __remove_memory() instead.
>
> I think the race is ok. The admin gets to keep the pieces of allowing
> racing updates to the state and the kernel will keep the range active
> until the next reboot.

Thank you for noticing this. I will pull it into locking region.
Because, __remove_memory() has this code:

1868   ret = walk_memory_range(PFN_DOWN(start), PFN_UP(start + size - 1), NULL,
1869   check_memblock_offlined_cb);
1870   if (ret)
1871      BUG();

Basically, panic if at least something is not offlined.

Pasha
