Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715C5C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D913207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="nLkSN0Dd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbfCYXhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:37:20 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34115 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfCYXhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 19:37:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id k21so8399400otf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 16:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iOEBRSaUhydJ0VsiYrBtWnd84J72N11uWSTNWpUMqGM=;
        b=nLkSN0Dd4GMq5L3T02MkvgHF8Qjfl5hqxMU1jViaI5ZMY4AAUV8ZHWWfpy0vxrHIhL
         LIEN2mgdPNuffbj6PmJIhlJGRYJ0wIbM5jgg33U2srGNKlbnZODcZ6f9IBWDMN0gtpEP
         hXV/K4iCKV4Z3Im93Bt0m9KT540iYAexqfQ2K6Idqu6vwlz8qHPvGGon7xViDUJ6qsZg
         J8/IQM9uG4fb5VnD7AqXnv8IY0K4XEXaZDsXd16h5rhblA3fv583+GUhI1i9PxXOCB8b
         DfajQVlPTYDFXp/LD6aZTfAM+scqCRx1vX6t82+N/Zqyn5t0DyOJO1OZPj+DbdBH00P1
         LArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iOEBRSaUhydJ0VsiYrBtWnd84J72N11uWSTNWpUMqGM=;
        b=oWaiWcgYBvRlWxLJeFsA4SZKMVcUmyvk9/edcAU/O3bkZCJwfKNqlNus0Nk8lBmzeH
         RAlDravFlIpzDIdWmjMMwiodpaFhbufiL3efXB0OvkQFni3kM5KNmbVRhl1SQk56PFXO
         y/OxKVmz5cfYyj/JPXD1RbiEJxR2f0zM5L5q2L5IwrFcbiIEPFGTPUTwRkmQj0jjGMIp
         /TRf/kivGoijVxreXTSKf4nOsSzMj3T8ajfxeIeCYhUf92mKmKWjxqAApzoudHxJVMVD
         j+QrF92m6FFlf3/fIrgDQYuMAfDYcgzhMPbTWv60MHDF7kjZVYvyCw/GjhyxL9Ool9A4
         GggA==
X-Gm-Message-State: APjAAAWRYzG9mSXHLZ/4Q+Ys0fvEltSR7rr2jADcRxZz2yE/RUenErIv
        sIBpG5fFKMJXOWOH22nOYsdtSavnVlBiv4O+2yBtRg==
X-Google-Smtp-Source: APXvYqw/QIkPeyK1F3pTQoERs2s+6UGl+RbMp7/gwTUqs0w4dcWtOPjrWt2swBwwV/ZhlF4hO6SEk/UMuJYePQW/4lY=
X-Received: by 2002:a9d:6a4f:: with SMTP id h15mr9650954otn.353.1553557039692;
 Mon, 25 Mar 2019 16:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
 <cc6f44e2-48b5-067f-9685-99d8ae470b50@inria.fr> <CAPcyv4it1w7SdDVBV24cRCVHtLb3s1pVB5+SDM02Uw4RbahKiA@mail.gmail.com>
 <3df2bf0e-0b1d-d299-3b8e-51c306cdc559@inria.fr> <CAPcyv4gNrFOQJhKUV7crZqNfg8LQFZRVO04Z+Fo50kzswVQ=TA@mail.gmail.com>
 <ac409eac-d2fa-8e93-6a18-14516b05632f@inria.fr>
In-Reply-To: <ac409eac-d2fa-8e93-6a18-14516b05632f@inria.fr>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 25 Mar 2019 16:37:07 -0700
Message-ID: <CAPcyv4imk02wme0PsY0rUePax8SOq2-=+objYT-x4bxthLkKkQ@mail.gmail.com>
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

On Mon, Mar 25, 2019 at 4:09 PM Brice Goglin <Brice.Goglin@inria.fr> wrote:
>
>
> Le 25/03/2019 =C3=A0 20:29, Dan Williams a =C3=A9crit :
> > Perhaps "path" might be a suitable replacement identifier rather than
> > type. I.e. memory that originates from an ACPI.NFIT root device is
> > likely "pmem".
>
>
> Could work.
>
> What kind of "path" would we get for other types of memory? (DDR,
> non-ACPI-based based PMEM if any, NVMe PMR?)

I think for memory that is described by the HMAT "Reservation hint",
and no other ACPI table, it would need to have "HMAT" in the path. For
anything not ACPI it gets easier because the path can be the parent
PCI device.
