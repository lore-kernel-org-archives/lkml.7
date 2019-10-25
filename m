Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2397CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965D52070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GiYeg5EZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410308AbfJYLko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:40:44 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33285 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbfJYLko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:40:44 -0400
Received: by mail-ot1-f66.google.com with SMTP id u13so1893929ote.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 04:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FdnXWQrBWp11eHpW5nLjm/7o2FpjH0uI65tjveIQMxQ=;
        b=GiYeg5EZVfgQNFeTasX4Dh5mPkqAM+PzcZgSQYy0fMXTVkHh2HSVMIYZtQOoT51SNS
         piObUpn70xttAIPr0K3W98IxImoYBnZhwvTqaxOIZ+R1twT9TEDxE9rZoKwWShX90++q
         Syrgqt13KJrLOmpnv9FSVPy/8eAmgGZzfEauq7dQEb6Q/u4ZiC1fEeS5iJZR0Z3Yc1xG
         T0KAJdJWoCp7uYXw4OHR0s7+JnWdE3wTsBFkP2FSw/JO0wHkYKDkpspZyGMjmBvmv26H
         c9qqxDTI24R6uxS5eEN90Atjz+w0x6TYU519oOMK5h9+73XhBpuba6LuPntEBvqa7NlA
         yD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FdnXWQrBWp11eHpW5nLjm/7o2FpjH0uI65tjveIQMxQ=;
        b=sGI/XHBI8Sm2QcP/nfMDCEJ6ojXPMQ2n3tZa7YFdrYd6TjkA6ZNaVEr1eKi4mxFS2d
         zYfqfXov9OV2p5WeFdsH4ZU3MumPIVcK/aXYhuo5fZwlZ43QKwioxEWUVsNSfraUOnpQ
         +dJHi1DpuRpZGAzxAPG3BwWpmvjaXqKl4OAzZNHaAuLxBiADHLqh71o97lK7AoruCPBO
         Ha+1n1pu2WdkCHSnwZ+hkN+PNU5NczIFE+HlUAlC1tmKCu7KtT4Vt6slfNCOacHE8Cz/
         4m4I+C7CZIjEjNVblTbxp6Ey3h9Z5MOy27sz83dAWRnAzC00/ngQe11I8ib0iBujkpur
         0Psg==
X-Gm-Message-State: APjAAAXKJmUcQ5vDKYDIPz4PE0EpDh06V4jjS/Jc05TyLQEn/We7J2rp
        quNrYJh4IAL2kCRZk4dixkEpyu1URwAU348nlNTExQ==
X-Google-Smtp-Source: APXvYqz4J5ScWj3iZZctdQ+jZmPezR1BazaXr3j4A2XTePYUVA9ELHNtDKlaIBDfwqHYJSmYM7CLFOE4j3Hu65GtSe8=
X-Received: by 2002:a9d:39a5:: with SMTP id y34mr2393532otb.36.1572003281036;
 Fri, 25 Oct 2019 04:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191021190310.85221-1-john.stultz@linaro.org> <CAO_48GHk8b=7Rs2CYZvnki2EMpeo_4FRy+_3F0Mv_nAK42MpgQ@mail.gmail.com>
In-Reply-To: <CAO_48GHk8b=7Rs2CYZvnki2EMpeo_4FRy+_3F0Mv_nAK42MpgQ@mail.gmail.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Fri, 25 Oct 2019 17:04:30 +0530
Message-ID: <CAO_48GGCaTPrZg1xWmojHHqXu2eioWsVJQtZmoXKCXX7Dg8KoQ@mail.gmail.com>
Subject: Re: [PATCH v13 0/5] DMA-BUF Heaps (destaging ION)
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Hillf Danton <hdanton@sina.com>,
        DRI mailing list <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Oct 2019 at 11:26, Sumit Semwal <sumit.semwal@linaro.org> wrote:
>
> Hi John,
>
> On Tue, 22 Oct 2019 at 00:33, John Stultz <john.stultz@linaro.org> wrote:
> >
> > Lucky number 13! :)
> >
> > Last week in v12 I had re-added some symbol exports to support
> > later patches I have pending to enable loading heaps from
> > modules. He reminded me that back around v3 (its been awhile!) I
> > had removed those exports due to concerns about the fact that we
> > don't support module removal.
> >
> > So I'm respinning the patches, removing the exports again. I'll
> > submit a patch to re-add them in a later series enabling moduels
> > which can be reviewed indepently.
>
> This looks good to me, and hasn't seen any more comments, so I am
> going to merge it via drm-misc-next today.
Done; merged to drm-misc-next.

<snip>

Best,
Sumit.
