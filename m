Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D968C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3FF206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="mrS+amgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfHPVsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 17:48:25 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:44365 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfHPVsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 17:48:24 -0400
Received: by mail-ot1-f54.google.com with SMTP id w4so10836671ote.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 14:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LyElFB/DQKr6Gizru8u06ztJ06NwMdbnhXlNaM4nxfY=;
        b=mrS+amgv8MUZtXXjJgioy8ife407MwfpV3HzSJJM97stHaySnNcwdMkTrTmdO42TYK
         mUXUzfAuYL56dOpVKrZt05dICfv+fI8pIKUkLoB5gQS7fIMA6VnmaZtqpu9yzur2D52u
         LBrXk8ygWWjZ4FpncAY6ObVGddD32Crqr5bzzOhGaPJ93LP4y7Z4pFxkMRd6W/qhzGfa
         PVa4MQVGxMg4/5XN3/SAYycOiedKl5K2505hnWWZdBfrl4KYNov4c0Gpp35IRPTqtVMZ
         vK/09rXwd8ggXEKI8s7m22aN7Zk8QYG7+wbSQ7oyz0uPAgtAeOWiv4nUyaMJzO4hBrPb
         czfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LyElFB/DQKr6Gizru8u06ztJ06NwMdbnhXlNaM4nxfY=;
        b=kdX2ROguGA20otASIzDU329leOcsbjgl79ExDJy0RhLWfMdv7sa0vshFOu4L5EjICQ
         US7kNaIkfRhAVhCUdyPSF4Er4jgxlMUg4SIrC3M4uFHgaaoZsALJxHXZvWL+GDpmPWSC
         JmJ6OkCMtujY2uawT/8yFUEq9Utc4Uzc5xKpEUoOj65sBLppvrCHypDrJoE3HPsDf203
         FA0zluX6RMpY+UtdONX+po0UBzVGBh/DfLuwe/1PMhJl2uPaVrZbXbtkMYrXkHVy6N19
         LDv2899zYCkBzbqVtV0Zjs5X4j7hQ8SSrBRmBsj5ttQAjlAdt77q0PDxUdIlReEt/Fel
         FPTg==
X-Gm-Message-State: APjAAAWry3gxHALd0bMxS4dmMaBsiQaqbXWp6RlDS1MD3GkfddijKE4B
        GiQQAlzXN0OpcuLkUTLKcr+u35CR97EG1f+DCe3JNg==
X-Google-Smtp-Source: APXvYqyDpwbVXFlvMymCKEQxblapyLZJ2uTf8kCcMCHUlKmdPHMPy2wDX6J/Yo2/rZ+OzbU3y2tiV4thup6lKoyweVk=
X-Received: by 2002:a05:6830:1e05:: with SMTP id s5mr8439514otr.247.1565992103975;
 Fri, 16 Aug 2019 14:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <1565991345.8572.28.camel@lca.pw>
In-Reply-To: <1565991345.8572.28.camel@lca.pw>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 16 Aug 2019 14:48:11 -0700
Message-ID: <CAPcyv4i9VFLSrU75U0gQH6K2sz8AZttqvYidPdDcS7sU2SFaCA@mail.gmail.com>
Subject: Re: devm_memremap_pages() triggers a kasan_add_zero_shadow() warning
To:     Qian Cai <cai@lca.pw>
Cc:     Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 2:36 PM Qian Cai <cai@lca.pw> wrote:
>
> Every so often recently, booting Intel CPU server on linux-next triggers this
> warning. Trying to figure out if  the commit 7cc7867fb061
> ("mm/devm_memremap_pages: enable sub-section remap") is the culprit here.
>
> # ./scripts/faddr2line vmlinux devm_memremap_pages+0x894/0xc70
> devm_memremap_pages+0x894/0xc70:
> devm_memremap_pages at mm/memremap.c:307

Previously the forced section alignment in devm_memremap_pages() would
cause the implementation to never violate the KASAN_SHADOW_SCALE_SIZE
(12K on x86) constraint.

Can you provide a dump of /proc/iomem? I'm curious what resource is
triggering such a small alignment granularity.

Is it truly only linux-next or does latest mainline have this issue as well?
