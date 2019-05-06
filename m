Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91175C04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661A32087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ZO0IGp0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfEFSSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 14:18:33 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:37412 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfEFSSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 14:18:33 -0400
Received: by mail-ed1-f44.google.com with SMTP id w37so16228066edw.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 11:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HayB7sQuY+v6EOo4zgx5AzoxFFOqeB4N5OR8XF6r5Uc=;
        b=ZO0IGp0OlSdXA+IWacCTnCe28YL0KDN5WLR0iOy2RQwLUXZVopK4KJfjY+7Q/z9X6s
         SjuXLmGb7eUbUPJHlvDgd+B3s08Ybui1oQ9ioaIhBcDsAz6stlJCXGs9JZSL5YKh43lu
         Nwu+fb1XhtGFgnaFbhK852KIcA+Hirr1L1Uu2CPoxojTIdKceAWJbAZ7TBO6HNLfSXLH
         IqZeQ9Y3ShvtCySSy+qfuIwbk91roy5qHtFp8zbKkADnaXx4F2yKU1KCdSog3LdNJZ0V
         /oPFwD9Z4Ilb/jEbM5g4Mp2y3Hs7tChLQ697C0ly3r+YHVZPXTFzV9DXetIRIhfLCKSy
         AKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HayB7sQuY+v6EOo4zgx5AzoxFFOqeB4N5OR8XF6r5Uc=;
        b=ZFu/xHdKqpWYdoJEhgwcsVu3B5y51HRXy2gF1PNYGm59UWQgcA2evCHBEbL82wnCe6
         rAscL/beP9kpVzUgmgX8ze7hJggG5RluH0Vv4tIGmzUx/bl1tBL+YZ3RrUiwLxN9htYr
         eBNYAVSbJoaamyzDGhxM5dT0zb/kJtrTN3Gj0GlEo0LeIMYimpZKzvlR0Q0oIkO8q3PF
         1pAJfxjScu1iatC+pjXKwi2dKuTDSho2ma7fSBDyNXV+mCshRfAuJ2tHw5YYfPFfRW7z
         lGmcyAKmKLdLujaFUAxZGD/i9mKcovG3s9wAYl7QLPJGkBEf9Bz9rsi2OHO6tSwtkQa/
         ySLw==
X-Gm-Message-State: APjAAAU/N0nRe97SDsxMTtjTZUCypG7uy9prSs4/3UVUfL6dhkgdnFLk
        /c9SJc7zOOrJsJag4zJArqOF+hksNamYWL9dVInSfg==
X-Google-Smtp-Source: APXvYqwHXBTigtDuKWMtEhHCcYHo0Ym7KuPj7imSV/QN0gZyF9gZvmtmygbEq5LNv1SmyCzL2+klGlSO4LgamYmNN1E=
X-Received: by 2002:a17:906:5c0f:: with SMTP id e15mr20354898ejq.151.1557166711352;
 Mon, 06 May 2019 11:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190502184337.20538-1-pasha.tatashin@soleen.com>
 <20190502184337.20538-3-pasha.tatashin@soleen.com> <cac721ed-c404-19d1-71d1-37c66df9b2a8@intel.com>
 <CAPcyv4greisKBSorzQWebcVOf2AqUH6DwbvNKMW0MQ5bCwYZrw@mail.gmail.com> <cf793443-c14a-a1e0-856e-15e416c7f874@intel.com>
In-Reply-To: <cf793443-c14a-a1e0-856e-15e416c7f874@intel.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 6 May 2019 14:18:20 -0400
Message-ID: <CA+CK2bAfjXCtRRV2DWy8huCvJ-y0L5cMvOh+9CS40WZfhx-aeg@mail.gmail.com>
Subject: Re: [v5 2/3] mm/hotplug: make remove_memory() interface useable
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
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

On Mon, May 6, 2019 at 2:04 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 5/6/19 11:01 AM, Dan Williams wrote:
> >>> +void __remove_memory(int nid, u64 start, u64 size)
> >>>  {
> >>> +
> >>> +     /*
> >>> +      * trigger BUG() is some memory is not offlined prior to calling this
> >>> +      * function
> >>> +      */
> >>> +     if (try_remove_memory(nid, start, size))
> >>> +             BUG();
> >>> +}
> >> Could we call this remove_offline_memory()?  That way, it makes _some_
> >> sense why we would BUG() if the memory isn't offline.
> > Please WARN() instead of BUG() because failing to remove memory should
> > not be system fatal.
>
> That is my preference as well.  But, the existing code BUG()s, so I'm
> OK-ish with this staying for the moment until we have a better handle on
> what all the callers do if this fails.

Yes, this is the reason why I BUG() here. The current code does this,
and I was not sure what would happen if we simply continue executing.
Of course, I would prefer to return failure, so the callers can act
appropriately, but let's make one thing at a time, this should not be
part of this series.

Thank you,
Pasha
