Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29BBC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7154820663
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="qOPiNtjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfDLTNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 15:13:02 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45537 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfDLTNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 15:13:02 -0400
Received: by mail-oi1-f193.google.com with SMTP id y84so8855432oia.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 12:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cjb/Jw1kYT3CwdkCeHpw/B4B9pOzyujTUh9p8dSWf7g=;
        b=qOPiNtjhfsHHrcivyLQFuR8OxLUM441a/pqFDJ7Ihm23VNLXYRnNEf5ZCadtXfy1Bb
         bH/+WtbDeAv1BI5bE2bCLzjj6MAW7Lz9sN0irIl+eFKNM/AireWatNsg9DoUgJDe97AH
         x50W6yKuoX4s6Z/mmGcke/PvP+TGPwFvXhujik17ueQj3kGTVkrsqO0h0CCfZWpXDG1L
         VCJnD5jSlG00/ERDeLIJaK7KW/12x8qrzv3rxm3B1Upq9Dty1k30Zoil2MhCZzsziSLX
         Rdlygg4wxhOGAXpvC7j3dNN96kNtrI8bfA1b99bLzW6Q7EwqIABx3SYH/3W7XCF3/Bbp
         Nrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cjb/Jw1kYT3CwdkCeHpw/B4B9pOzyujTUh9p8dSWf7g=;
        b=SFT5ZFPiAdsCDNWjYHCvF6MFZdqA0+ivLD1Gr2DmLz1fZj/UwB9Qg9lfW8S7hIoKq1
         BeD3PiNnGFWwSGBVcX7Fq9NVkDCSrOL4aS3DmEInzt+xKmfi+BWkl2z6W5joBKgPl6+r
         mZR5YcE3JgK35GRlxvU3p/kk+zH9rrx1ex914EKl2Tm2C6GSO1MrW2pMjTnHbDL/23u/
         xNdTI9xfErEe2KfqKMyIQNyzD7cywpTzSEIni1s5yQxc/4tAuitVnz7dO3C8guS4ANzo
         d8XRMH2EFTAM0eHk7hmhjw0QWGr5e724NQrq9eV/mzzmf4/P98psLYSUekeo7CxyTICW
         irNQ==
X-Gm-Message-State: APjAAAWCNGoI+cJ6yq7RlX0fM2B7OtPxKYok2BIvAABM4idNPuDa+9ga
        V7aRGkLCju4LSkA4khsy3PVPpfJ/LByKP+Kd/a1J3g==
X-Google-Smtp-Source: APXvYqyTMfUJpFFuq8fWP7BFdKu7wN/l6+qXM5aSFSP3dYO5Xa1B6man/nth6r/rgs3JIUo7K4mVyjLLDGZmpOQzsOM=
X-Received: by 2002:aca:f581:: with SMTP id t123mr11899459oih.0.1555096381187;
 Fri, 12 Apr 2019 12:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555093412.git.robin.murphy@arm.com> <029d4af64642019a6d73c804d362d840f4eb0941.1555093412.git.robin.murphy@arm.com>
In-Reply-To: <029d4af64642019a6d73c804d362d840f4eb0941.1555093412.git.robin.murphy@arm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 12 Apr 2019 12:12:49 -0700
Message-ID: <CAPcyv4iYgwPJZpwUzM-ehc5F3gjO5TJ4AOz3f21ou8NrRCsEKA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm/memremap: Rename and consolidate SECTION_SIZE
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Linux MM <linux-mm@kvack.org>, "Weiny, Ira" <ira.weiny@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        ohall@gmail.com, X86 ML <x86@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 11:57 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Trying to activatee ZONE_DEVICE for arm64 reveals that memremap's

s/activatee/activate/

> internal helpers for sparsemem sections conflict with and arm64's
> definitions for hugepages, which inherit the name of "sections" from
> earlier versions of the ARM architecture.
>
> Disambiguate memremap (and now HMM too) by propagating sparsemem's PA_
> prefix, to clarify that these values are in terms of addresses rather
> than PFNs (and because it's a heck of a lot easier than changing all the
> arch code). SECTION_MASK is unused, so it can just go.

Looks good to me. So good that it collides with a similar change in
the "sub-section" support series.

Acked-by: Dan Williams <dan.j.williams@intel.com>
