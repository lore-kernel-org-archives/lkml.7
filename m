Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12F5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0BC20811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="1mdk+MBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbfCYTaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:30:00 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33873 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbfCYTaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 15:30:00 -0400
Received: by mail-ot1-f65.google.com with SMTP id k21so7802049otf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 12:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hXTt04+uP3CF2N6BhBBgJjHnEUj/7PvEFKIa60d+Aqg=;
        b=1mdk+MBy7JP5R/Slb3flUfuhDER9hIZOWP46hDJe4hA2ypCGSWakbhLIz+M86ZE5bs
         aOlurSVep85tCgTR1UQb/q6fr5Iwc+Wn7GO2M7iZ9MHdokXYk4cjabJofPmsycdAw4/S
         N31aGtC9FFAbwvAMOaZtnxe8vfDu5ROV/RUu13S2iAV44eJRiFXYJCVAyheQw0FbA3kL
         6yPvH8c5oxG4U6Qkq5/jjQMOHYbjexhhDqFUxBFQc8p2NkV9GlPJt2vtA8j4UGaw3XJm
         U5RgW2tclPEMtg+IkqJve0Uo3wMTR+hazLxQYs20HbwPGSdMb6u4l3/grQ0RUnYvq04x
         jGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hXTt04+uP3CF2N6BhBBgJjHnEUj/7PvEFKIa60d+Aqg=;
        b=VhN/ILNLy1XXzfBcOoZJhXf5X3qgrnj9x9njVaD5RH7EiXDcHhHYeREGU0p5nBX5Dj
         g7xj3KGqHkRJulI4nmZxq6tj2P8754jdt2iMAUFvUkQfYwfxMOFOyjbTXHWoGiZLTQ3O
         Ozo6+ZOkj5FdubWbin53b/PUXyExJf5GF2RDrKt/jdy8kFRYDSOQ2Zel/NuT3ktvvHnD
         QKeii91poZTI4JWcemHXwj9IN9C6peEHasfg0ZcT320BJ2qyuK9wLxNNjOay5i0wFb0G
         SMbS9jKZfgZSENbKRUp2gJgp923ZiuDwsZ6j7CIfqr4PhEiFyxoqsuAQmUuNycILZLm7
         HqHg==
X-Gm-Message-State: APjAAAXdsh9ABIe4nisvoSpOUfd11O2vVwrm2b4duvzHBOZ+psvHzDcE
        Hg5kzLLljSuVjzVUE1aTsWNeJan8hlykohOl2lfDqg==
X-Google-Smtp-Source: APXvYqzta2v2fqC1QO5NTeyuYEcNckY9JIm9c1OXKwXu+ldirLp79DrEZBPZu7PqPXrr+kF52rLsHn7QgzxoalBkCmE=
X-Received: by 2002:a9d:224a:: with SMTP id o68mr20030389ota.214.1553542199941;
 Mon, 25 Mar 2019 12:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
 <cc6f44e2-48b5-067f-9685-99d8ae470b50@inria.fr> <CAPcyv4it1w7SdDVBV24cRCVHtLb3s1pVB5+SDM02Uw4RbahKiA@mail.gmail.com>
 <3df2bf0e-0b1d-d299-3b8e-51c306cdc559@inria.fr>
In-Reply-To: <3df2bf0e-0b1d-d299-3b8e-51c306cdc559@inria.fr>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 25 Mar 2019 12:29:48 -0700
Message-ID: <CAPcyv4gNrFOQJhKUV7crZqNfg8LQFZRVO04Z+Fo50kzswVQ=TA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/10] Another Approach to Use PMEM as NUMA Node
To:     Brice Goglin <Brice.Goglin@inria.fr>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        "Du, Fan" <fan.du@intel.com>, "Huang, Ying" <ying.huang@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 10:45 AM Brice Goglin <Brice.Goglin@inria.fr> wrote=
:
>
> Le 25/03/2019 =C3=A0 17:56, Dan Williams a =C3=A9crit :
> >
> > I'm generally against the concept that a "pmem" or "type" flag should
> > indicate anything about the expected performance of the address range.
> > The kernel should explicitly look to the HMAT for performance data and
> > not otherwise make type-based performance assumptions.
>
>
> Oh sorry, I didn't mean to have the kernel use such a flag to decide of
> placement, but rather to expose more information to userspace to clarify
> what all these nodes are about when userspace will decide where to
> allocate things.

I understand, but I'm concerned about the risk of userspace developing
vendor-specific, or generation-specific policies around a coarse type
identifier. I think the lack of type specificity is a feature rather
than a gap, because it requires userspace to consider deeper
information.

Perhaps "path" might be a suitable replacement identifier rather than
type. I.e. memory that originates from an ACPI.NFIT root device is
likely "pmem".

> I understand that current NVDIMM-F are not slower than DDR and HMAT
> would better describe this than a flag. But I have seen so many buggy or
> dummy SLIT tables in the past that I wonder if we can expect HMAT to be
> widely available (and correct).

That's always a fear that the platform BIOS will try to game OS
behavior. However, that was the reason that HMAT was defined to
indicate actual performance values rather than relative. It is
hopefully harder to game than the relative SLIT values, but I'l  grant
you it's now impossible.

> Is there a safe fallback in case of missing or buggy HMAT? For instance,
> is DDR supposed to be listed before NVDIMM (or HBM) in SRAT?

One fallback might be to make some of these sysfs attributes writable
so userspace can correct the situation, but I'm otherwise unclear of
what you mean by "safe". If a platform has hard dependencies on
correctly enumerating memory performance capabilities then there's not
much the kernel can do if the HMAT is botched. I would expect the
general case is that the performance capabilities are a soft
dependency. but things still work if the data is wrong.
