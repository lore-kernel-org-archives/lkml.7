Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805B9CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545F32084D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zVPQ4vLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbfKDTVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 14:21:34 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39088 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbfKDTVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 14:21:34 -0500
Received: by mail-ot1-f67.google.com with SMTP id e17so6889619otk.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 11:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7y4ipuWmdaUi9fFnH1wHoo3ikrWXbFhBkhRytiSTYvM=;
        b=zVPQ4vLmRwkhdd0deIKHT+LjfpSu5/1hNMNrNyCY5UyhgmQipJ3kXUzGIJuFkl/dNU
         HdpL8bcUL77aYoY+kohtMB6aXbjOEwuUHr8jZTJ0mgGXwlNntn4N/nsps4YDowaZIJWA
         DeLbG7z94g3xeyjqijOwgvQnKtts/1Y14A42VqZq/VcLXvgkUId5HzK+jMR8qqRm/UTE
         pgE2orq6ejxaiuwBzJtm/2YBf8DrrkEfoHEUd3uHNEtt7TL7mvqzqSn6bTqvkQzrlz1+
         5ug4sXR4YSdZ7Iqfs8jDpvXpVY9RWekZ1tsK+UKlHupS1IH7MURM3yP2qU/xLi4GCk7n
         jXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7y4ipuWmdaUi9fFnH1wHoo3ikrWXbFhBkhRytiSTYvM=;
        b=QbD2F9WxvuAisNr3R3hVRGUtqtIeOsOMHC1x440bqEpWHnmha5rNKYHWnKN0WKPPZw
         ieEYqDk6u8sttfWrXFn2qQywTgFQ06bpjClbDLAcPUWrAc4cmRoKKEYaBDmkg0AuX7uY
         USmJC5OfmSS03Fmf5QA23C7Lsb/rPjsXCFfK2OK9IWjLNnRgtjbAttufGONiKsVn2rrn
         wgrI3gb3vKfVO5+MD2g11mw+1z7L+9dmcZ/J96ZF8/KFsYLu+xSr9lsKnpJw0/mEKHYi
         54/FAQGv8x/N+6TTBPXF7JUr0KsAUCTxsf09PxWkIOKiiMAo760egKno+W5EyT9cP8Yk
         HXoQ==
X-Gm-Message-State: APjAAAVpP1tZKKCdHtf4aHXOVSzLoAggCAy48e5+2+w9BarhSMTICgVj
        JjRsrPcpDcyP5T+BNcqu0A4GNm3VxMVy5JKbP8n0vQ==
X-Google-Smtp-Source: APXvYqwovk2ws6gw1x2ffiii11kkOdQ/I1Hg2skTx4vPM9AnnETFCFUC9S25MTgg9Czm7z5Rwb5icomH1IGIUSXKBjE=
X-Received: by 2002:a9d:5a0b:: with SMTP id v11mr18805680oth.102.1572895292765;
 Mon, 04 Nov 2019 11:21:32 -0800 (PST)
MIME-Version: 1.0
References: <20191101214238.78015-1-john.stultz@linaro.org> <20191104101807.79503286@eldfell.localdomain>
In-Reply-To: <20191104101807.79503286@eldfell.localdomain>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 4 Nov 2019 11:21:21 -0800
Message-ID: <CALAqxLXYUKNGebU6ZBVsX5xQ_hUL+imxcyOkuV5M10UxdpZuSA@mail.gmail.com>
Subject: Re: [PATCH v14 0/5] DMA-BUF Heaps (destaging ION)
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Sandeep Patil <sspatil@google.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>,
        Christoph Hellwig <hch@infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Andrew F . Davis" <afd@ti.com>,
        Hridya Valsaraju <hridya@google.com>,
        Pratik Patel <pratikp@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 12:18 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> On Fri,  1 Nov 2019 21:42:33 +0000
> John Stultz <john.stultz@linaro.org> wrote:
>
> > This again? I know!
> >
> > Apologies to all who hoped I'd stop bothering them with this
> > patch set, but I ran afoul of the DRM tree rules by not
> > getting the userland patches properly reviewed prior to the
> > patches landing (I mistakenly was waiting for the patches to
> > land upstream before pushing the userland patches). Thus,
> > these were correctly reverted from the drm-misc-next tree.
>
> Hi John,
>
> mind, you have to get userland patches reviewed and accepted but *not
> pushed*.
>
> You cannot push/merge userland patches before the kernel patches have
> properly landed, that bit you got right. But the supposedly confusing
> bit is that for kernel patches to land, the userspace patches must be
> reviewed and accepted first.
>
> I just wanted to clarify this since you wrote "before pushing the
> userland patches" above.

Yea. Sorry, "pushed" isn't a very clear term. In AOSP, one must push a
patch to Gerrit before it is reviewed.
However, once something is reviewed it usually is merged immediately
(pending automated precommit testing).

So I tend to use the term "pushed for review" as submitting patches
for review as ready to be merged. In this case, technically I had
actually "pushed" the changes to Gerrit, but hadn't added anyone to
review, to ensure the patches were not' accidentally reviewed and
merged.
But If you look at the Gerrit log now, you'll see I've added reviewers
and provided a note explicitly to not merge the changes.

So apologies for the confusion. I do believe I understand the
requirement now, and am doing my best to adhere to them.

That said, given different userland projects use different approaches,
I do find it a little strange on the insistence that userland patches
cannot be merged to their project before the kernel changes land.
Obviously no interface is final and any userland that does so has some
risk that it will change and break, but there are many cases where
distros support new features in their userland not yet merged
upstream.  Ensuring there is a real opensource user for the kernel
feature is important, but I'm not sure I understand why the kernel is
dictating rules as to how userspace merges code.

thanks
-john
