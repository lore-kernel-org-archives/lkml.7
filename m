Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D41AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C723E20868
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552066694;
	bh=XYsRox82NDP3getUxjaRjEkzdHPK7d5fGfrFvOtxLd8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IUVmlqtBliNv9UHEHKXx8xDWLvM92AMdHX09nYG4HayJaRA0AImf/+Qc0E+vyRA7c
	 B/cE4PNWusrKco4PKfAuJYGXuiFnQUV7i4hpKEJY28kYL/XZ02X3lhVDCEnTGl0Sr8
	 SQ69W3it0/g4C6qD4rpZSylJHZCq3dyqty6j2Xyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfCHRiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:38:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbfCHRiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:38:13 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 790F52146F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2019 17:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552066692;
        bh=XYsRox82NDP3getUxjaRjEkzdHPK7d5fGfrFvOtxLd8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m7KIFR/UEcuxRhT8d0c4uTQ7i0TryaIm6a6aYUo7SQ6t5jkxqOD7OMLCjpWHguGB7
         wOFV3HQAH+FLSk9YuDhEVqLVWSQ9BrC3dh8tVNxIqrwZi+9erc+kfJ8XBFneYGypwm
         KSZa1Gv6sukfqvWwrRpzf0AdydIcNe2T0p9bOyUc=
Received: by mail-qt1-f180.google.com with SMTP id z39so22117335qtz.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 09:38:12 -0800 (PST)
X-Gm-Message-State: APjAAAWa8O3Eck2rX/hM4uvMjWKILvj2sumAcJAF9uxAZRR1MpOBwXBd
        bCh+JxwVSY4cG1/wOs3FHYQUKAyj+UkGNpO9VQ==
X-Google-Smtp-Source: APXvYqy2+ba/tRg2IwMhEbAvOHKuOQpAWQlgNV/RShLVjlLMnAFsnaqDx2OZVZvzB+UmMm9IjpLxfGLB7gvIH7izD5Q=
X-Received: by 2002:a0c:ecc5:: with SMTP id o5mr16255794qvq.106.1552066691703;
 Fri, 08 Mar 2019 09:38:11 -0800 (PST)
MIME-Version: 1.0
References: <20190308161716.2466-1-eric@anholt.net> <20190308161716.2466-5-eric@anholt.net>
In-Reply-To: <20190308161716.2466-5-eric@anholt.net>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 8 Mar 2019 11:38:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJZHmHaxi1iK8qPin3QD36J7Tzz7XJCU0TQCpdAhcuj3A@mail.gmail.com>
Message-ID: <CAL_JsqJZHmHaxi1iK8qPin3QD36J7Tzz7XJCU0TQCpdAhcuj3A@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/v3d: Use the new shmem helpers to reduce driver boilerplate.
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        david.emett@broadcom.com, thomas.spurden@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 10:17 AM Eric Anholt <eric@anholt.net> wrote:
>
> Depends on
> https://patchwork.freedesktop.org/patch/290754/?series=57669&rev=1 --
> Rob and I have been talking about adding some more help for the
> dma_map_sg() code in v3d_mmu.c (which panfrost has a similar version
> of), but this already seems like a good cleanup.

There's an updated version here with the helper[1].

Rob

[1] https://gitlab.freedesktop.org/robh/linux-panfrost/commit/403e85012e9ee0a2a113bec757f545df193cfb7a
