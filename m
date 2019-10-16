Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D798C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDAEC20873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rx7dicTG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391167AbfJPHk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:40:58 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46081 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbfJPHk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:40:57 -0400
Received: by mail-yb1-f193.google.com with SMTP id h202so7469694ybg.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DrfvktYJgAyHta/Fz913K8rareDdtUbK//eXrFywXHc=;
        b=Rx7dicTGbigHVFli33Z0CCDjnpeCZSVCs8WSkbB0h9qQ9s3NUhpJmYM1+CskI4USTO
         U8lEW6L/BvXQ3hliCs1oMJxRlt8oYNtn8Zlb3tXcBhwlm7E9dQgdutJHonBKZ6tp8rUR
         zyZB2MKVFN3H3fiGcXpxl54HXEJpjTcml8wzFj6g4AtR21H/k1HKGbLKG8+THhhONegW
         XWvbyaZ+3Y/yvnNCXQFfUiltiaFsb59NapoZlTmDZ3y0ejKXkAPYtze17pT7nZjEX4OJ
         5MY8JsigNfkZLBCuebrCtVwxYD0KLKQWD24PQjDPIICGFiP7xfiY4rBGct6d7906CSK/
         tbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DrfvktYJgAyHta/Fz913K8rareDdtUbK//eXrFywXHc=;
        b=Z81TfrOmaBKCpwlzpLS10+LoQn5HVdwWHuCQvVuixLNIPVd9eiKaE9n/ERm5CxthEJ
         VoGdTKjAu5n/Fa0RjACFF9gANo8GXnHwM/ZW9USWl5V1NnX4yPvelSD1GSpgqf2FhuxE
         ajy1P6vPBxnX8wrnKdSXqIkjwBpFgLPzkTbyHQYMW4CMztT3K5YEcQx2NEYBQ3FViIWn
         bgy1Ps0eUiUvF4zaSKQw3+psA4pOkiVVlXQThPrdyjjhtlqsw1TSoEgTXJRM2BGbUKcy
         UwUc20vmVDA/9fmKpCO8vuQXRxVL+ZJ9C/wgrPX34aEX3MTensNlkRSlUN0JQGYtqWYx
         1DeA==
X-Gm-Message-State: APjAAAUadRcCjWKHboc+ELs79JTMffYG/3gXx6ikm9THUM+TPsLmQmfW
        N/zz3WEjE9kAQy7vNBepF3KE7INm19x+tePQWW0=
X-Google-Smtp-Source: APXvYqycJt2YiaXwNjBOltfUHwxfdgZ2fpnSS5NnUnC+6uOaN53bFDpsPUaRNgTPEVTBEloZi/YepjgE6HpyhrRkP4g=
X-Received: by 2002:a5b:4c5:: with SMTP id u5mr14131584ybp.25.1571211656797;
 Wed, 16 Oct 2019 00:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191015212526.1775-1-jcmvbkbc@gmail.com> <20191016070827.GA23051@lst.de>
In-Reply-To: <20191016070827.GA23051@lst.de>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 16 Oct 2019 00:40:45 -0700
Message-ID: <CAMo8BfLz5R=nXb3Ycw-xs9qfxHjBiKS2--mS3pr7=7rgwBeO_Q@mail.gmail.com>
Subject: Re: [PATCH] xtensa: implement arch_dma_coherent_to_pfn
To:     Christoph Hellwig <hch@lst.de>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Wed, Oct 16, 2019 at 12:08 AM Christoph Hellwig <hch@lst.de> wrote:
> On Tue, Oct 15, 2019 at 02:25:26PM -0700, Max Filippov wrote:
> > Add trivial implementation for arch_dma_coherent_to_pfn.
> > This change enables communication with PCI ALSA devices through mmapped
> > buffers.
>
> This looks fine, although I'd much rather convert xtensa to the
> generic DMA remap / uncached segment support.

Thanks for the review.

> Do you want this fix for 5.4?  If so please queue it up ASAP so that
> I can do the proper thing for 5.5.  If you don't need it that urgent
> I'd rather go straight to the generic code.

There's no rush, I'll keep my version privately and will switch to the
generic version once it's available.

-- 
Thanks.
-- Max
