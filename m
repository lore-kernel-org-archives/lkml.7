Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BE6C7618D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 05:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B006F20838
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 05:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuCj5ogP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfGOFnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 01:43:35 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39002 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfGOFnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 01:43:35 -0400
Received: by mail-yb1-f196.google.com with SMTP id z128so2370973yba.6;
        Sun, 14 Jul 2019 22:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x1fTuAZhIfrlETbUSsP1dpVtOtalwzPUJBl71LNvF/I=;
        b=kuCj5ogPMdv0UR/QbaMvt17fr1Kks7yEIQad2BJdVAokAZGlp1pIrgGLGzQdE0T1RV
         He4TDIBNF2P9i7c1V/dsB/e3IQveyT5EDel5NOC4W7KrSmfeqlqj6hkp7T2KAeplDFAE
         A/Ey/a40RVJy2pswyCyrxpPA6hUPt+ZRXoqg/v8a+5C15YZtMf9Niyg638/l0aneZsUV
         8NqbReKDtdSyFKHPPXkLvAoe8VjQSr7oeTUH3hxoxVsn6Va/r+CZ3OLFdRA4Hv04sVEh
         /67D9sbCHe9uCbd9vvLLbgobLk+mhRSNo0VSMRzb70MGGgT7y6W+BUlhjVkbja4k4vyZ
         lzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x1fTuAZhIfrlETbUSsP1dpVtOtalwzPUJBl71LNvF/I=;
        b=kLsJixhDpK3lpb0ge9nEA+cNaXDLpnTVyqi5heSCk7ZoGsK8mZ/NwIR8Q2rv/Szxkg
         pIwN9gW5S/ITcjDci8L+82xaYlhw5nbDZHorottW6SWqyjnDFcirAQG8kzeJzgJrqE3j
         BrhVGk5Q4bv+O/UJyVMlbwPMIsn6PmyLDZXcMNtnqgw6a6GgR/DCjxJFG18LwsTtJ98t
         HtpxgDZCrBdNBXszjFyWKUUcPUzns7zx4O26EO20EvEmaOw6mqHXmS6TaTfUXhfZ63dQ
         oc8LKkQe94++e/uy276KLxqM7WDEcWPd4VgWdUGlvgqL7P2kRjqd3he7cmPCUaDxJ//a
         0C1g==
X-Gm-Message-State: APjAAAUtSS8vyg7Rv9ziYB2WcHOF9Xp9I/1vLSwBJCu1Etti2MoJABzT
        JiPuI9+Fg9WVy6hvEA/ZeQ/uc+7lPmbjc83MEnU=
X-Google-Smtp-Source: APXvYqxAyT0M6B1ZXmetW6nzhOPqBX2DjnMDBB77OGQIp1Q/u6NBc/ONz4SQsmC8fZf4oF3b4dFRdlG5OJHS/2lqFY0=
X-Received: by 2002:a25:d10c:: with SMTP id i12mr14015312ybg.395.1563169414192;
 Sun, 14 Jul 2019 22:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190715031723.6375-1-huangfq.daxian@gmail.com> <72c45b14-f0c0-9d1c-0953-eea70ce513a0@kernel.org>
In-Reply-To: <72c45b14-f0c0-9d1c-0953-eea70ce513a0@kernel.org>
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Date:   Mon, 15 Jul 2019 13:43:23 +0800
Message-ID: <CABXRUiQXweOLRTpdyhx9xT_B1VBmoSoNm=_+Qr4prmz7u1QRFA@mail.gmail.com>
Subject: Re: [PATCH v3 04/24] dmaengine: qcom_hidma: Remove call to memset
 after dmam_alloc_coherent
To:     Sinan Kaya <Okaya@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sinan Kaya <Okaya@kernel.org> =E6=96=BC 2019=E5=B9=B47=E6=9C=8815=E6=97=A5=
=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8812:17=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 7/14/2019 11:17 PM, Fuqian Huang wrote:
> > In commit 518a2f1925c3
> > ("dma-mapping: zero memory returned from dma_alloc_*"),
> > dma_alloc_coherent has already zeroed the memory.
> > So memset is not needed.
> >
> > Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
>
> I don't see SWIO or ARM64 IOMMU drivers getting impacted by
> the mentioned change above (518a2f1925c3).
>
> How does this new behavior apply globally?
>
In the last version patch set, I referenced the commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of
git://git.infradead.org/users/hch/dma-mapping")
in the commit log.
The merged commit mentions that
"ensure dma_alloc_coherent returns zeroed memory to
avoid kernel data leaks through userspace.
We already did this for most common architectures,
but this ensures we do it everywhere."
dma_alloc_coherent has already zeroed the memory during allocation
and the commit also deprecates dma_zalloc_coherent.
Greg and other maintainer told me to use the actual commit
rather than the merged commit.
So I reference the commit that ensures the dma_alloc_coherent to
returns zeroed memory every where.
Maybe this belongs to the `most common achitectures` and is not impacted
by the mentioned change.
Should I rewrite the commit log? Just mention that dma_alloc_coherent
has already
zeroed the memory and not to reference the commit?
