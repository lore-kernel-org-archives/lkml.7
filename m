Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B9DC31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88C720652
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="PDyW8TAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbfFRGoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 02:44:46 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36923 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfFRGoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:44:46 -0400
Received: by mail-ot1-f67.google.com with SMTP id s20so12746177otp.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 23:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VK+Tna/iV8U0LWobX7frBvdux+Mmk/3A07T2dRSet2o=;
        b=PDyW8TAofhvqUW/2GACnAY5YkBvkFVU1w+wB59R0SpjrzCuk/bYvX8yNt8LtLzjEsY
         KUaeC+Fjq02TdAYL44zIwo6tZt+JNdRpWOlSZ/c0vKdSfjFJtazzXqfvqlSS3jgrw5sE
         fTR8RMwTGWygNypc4YyM31o8c0fSxpdSdqQnxT36Xiqik7NuWvXCL/qsaKFNuvGqmOaT
         KM4d2hz1PXB41WsBA0f0aPullp5tjm/OXKAkHS7zSO2tyAvSxoA53zEucxdlBpHh67Kc
         P61dfDC8g2EaJmY+aCM8S6vcLFqPyumX+jYhfnDEHBsiaDR5xE406kWXsSvQj7iNEKwY
         WD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VK+Tna/iV8U0LWobX7frBvdux+Mmk/3A07T2dRSet2o=;
        b=T+NIldBYeNQeIfK8haUgPQ22N8eJKEzDioRNNW6bA6l1Pci8U+/GLI58xekvaE3wzJ
         GmbPK4vNeaFLyd9iT2JxztNfteFO6jx9yrqmoEWkgZkVhNlwt+4JJooPOWhtH4Qtqol+
         XzoIih+tjMn3dYEV+Fr1+deLBmpIWWJuLHNovn2CfiXHxAk9ajZs/ldOagdYNbm6NtQe
         eXNO4f3bbc5TmbebKKCqpgfDJo77p+3vxWYA/PieZL3/CDpk7cojQbasNjrB41cJLceA
         gu41ir8X1EpQd7+71AuHeTv9H2StGmTVB65dXETLP+ghpduSfIgai4V1GbeYSijA43tI
         EivA==
X-Gm-Message-State: APjAAAVZ7BufF6lJgPMJe4W4fy7+Kw6dj8qHl05Q5QhcHDi0UHc5hN//
        in0wQjTLo0S6Rcedk1qKbqtmLuh482zgFPeaM1413Q==
X-Google-Smtp-Source: APXvYqyaFChW+2Y3LxLrxij/hGfBTYgPu7CeqLIDpIpJp5MqTEPAxGlNYhpNDoo6MTuAem3A7Ef0h9Bg2W4wMyFdxyk=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr28328925otf.126.1560840285119;
 Mon, 17 Jun 2019 23:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190613045903.4922-1-namit@vmware.com>
In-Reply-To: <20190613045903.4922-1-namit@vmware.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 17 Jun 2019 23:44:34 -0700
Message-ID: <CAPcyv4hpWg5DWRhazS-ftyghiZP-J_M-7Vd5tiUd5UKONOib8g@mail.gmail.com>
Subject: Re: [PATCH 0/3] resource: find_next_iomem_res() improvements
To:     Nadav Amit <namit@vmware.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Borislav Petkov <bp@suse.de>,
        Toshi Kani <toshi.kani@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 9:59 PM Nadav Amit <namit@vmware.com> wrote:
>
> Running some microbenchmarks on dax keeps showing find_next_iomem_res()
> as a place in which significant amount of time is spent. It appears that
> in order to determine the cacheability that is required for the PTE,
> lookup_memtype() is called, and this one traverses the resources list in
> an inefficient manner. This patch-set tries to improve this situation.

Let's just do this lookup once per device, cache that, and replay it
to modified vmf_insert_* routines that trust the caller to already
know the pgprot_values.
