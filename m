Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83ED5CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE39208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572373652;
	bh=/E2fVhCHekOqPKt9Ps7vbQev1xOf+FN9GA5rs0TsWL8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hlZPT3askJBn4exA4O9EZxeNSAElx5pa1V5m9/ZhSNTj1gSZjANgGHEZYYy/yaOzb
	 rlLuIFleD5K0nhtJSCQc2p3//dvkCurZ/sUHLSu9e8rapKiaqCN507t8N5hWTwa/9p
	 q4sBMgFuhYO+wshfRbpW07DRMcl8xFovo6EqV63E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbfJ2S1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 14:27:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbfJ2S1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 14:27:31 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31D8C208E3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 18:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572373650;
        bh=/E2fVhCHekOqPKt9Ps7vbQev1xOf+FN9GA5rs0TsWL8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bavd8bzTkyChea7ixRdZiKHrN1CkaRznY/Rwwkp91boGKkdf3LRQBOQ/6q48Adzp3
         twS2gWAvrXw1muN9kEfzCfc+mkpAtWvC1/VIOwMl333yg7fSGDoLMAVi7IvFc1q8aU
         caq7MnWmwi1Mz2y62iJltZ+f477oQeLqACCf7g0I=
Received: by mail-yb1-f181.google.com with SMTP id b2so1167616ybr.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 11:27:30 -0700 (PDT)
X-Gm-Message-State: APjAAAVJ5bd5jGUx4mgKfxcu1r4fHwErsbpitu0qk1EeJXppNX4cESK6
        izESdrQXDC/yistfa/FD27ctH39Ufe3Z5+6Caw==
X-Google-Smtp-Source: APXvYqxRyyqPo2+lGJYLHZpSU0d/i9I6p739hIebEMvjXrssaV6r1vzGfDhydNzp51UWwcKohxGJRazXeypZW+DZ0iA=
X-Received: by 2002:a25:bc04:: with SMTP id i4mr19282746ybh.427.1572373649289;
 Tue, 29 Oct 2019 11:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <9a0b09e6b5851f0d4428b72dd6b8b4c0d0ef4206.1572293305.git.robin.murphy@arm.com>
In-Reply-To: <9a0b09e6b5851f0d4428b72dd6b8b4c0d0ef4206.1572293305.git.robin.murphy@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 29 Oct 2019 13:27:17 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLfKOQrut_i=038zFF6Bb8vGNRjuG2sE2m2GsoWo6vr4g@mail.gmail.com>
Message-ID: <CAL_JsqLfKOQrut_i=038zFF6Bb8vGNRjuG2sE2m2GsoWo6vr4g@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Don't dereference bogus MMU pointers
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 3:08 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> It seems that killing an application while faults are occurring
> (particularly with a GPU in FPGA at a whopping 40MHz) can lead to
> handling a lingering page fault after all the address space contexts
> have already been freed. In this situation, the LRU list is empty so
> addr_to_drm_mm_node() ends up dereferencing the list head as if it were
> a struct panfrost_mmu entry; this leaves "mmu->as" actually pointing at
> the pfdev->alloc_mask bitmap, which is also empty, and given that the
> fault has a high likelihood of being in AS0, hilarity ensues.
>
> Sadly, the cleanest solution seems to involve another goto. Oh well, at
> least it's robust...
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to drm-misc-fixes

Rob
