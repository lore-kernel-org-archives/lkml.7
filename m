Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00811C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF76218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BbfdCkoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfCUUQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:16:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40644 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbfCUUQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:16:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id t5so8051871wri.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 13:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pqC8bFm2Wf1s8GpzzZo76PBATWaK/VBLqxdzhGES4Sc=;
        b=BbfdCkoZWQ7XoPU6Mmyhas0B+RKZef2OyTgBD3IqDyxO33oyUtPfXCMYrlmmG73sqI
         IfwphO3mLJEto26um/XfvikHG+J7mCV6pPkHy7+3ZtUNP2a1Ia9n3ioJL/nqz6ZGTUFR
         9829YR4qpmDsfMe5YDdIxdvo7wQYq+eZYJFfZ0RoeTHbA9kpk3vR8iuaFOOPwCSGN7sa
         PsrzGGMrVqhbn8beEI5DUA9Shsx297pw57NoCnxhGUwNexnjQJfJ5+v+ubLSH6u5rDWp
         5c7BtT4JtcEJqAKBSADkdTWVV6qlsfJiD2bLcbZwKiAOz0I0Zv6iyUn6YNtjM3xWGg23
         xVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pqC8bFm2Wf1s8GpzzZo76PBATWaK/VBLqxdzhGES4Sc=;
        b=aIgIts8IzGnjYYyaMzfwoVV/IcVbiTRJHuGluturcCaPkuu7uMiSGQnUESOoKGryWt
         D6gmiS6YbigU7bp0K5fjEQMTMoD3euJIELMc/PXCPJZnWmrj98w9s9JnAGqSGrWl276V
         YrW9MiBzN8/fPXnz4p16UB7Lj8PiUo6LvwzIxPmKpl+hQemvzbeZn3Cn3+U0lf6KqpP8
         xYIqa5JGWyuQ1dEh9QFdW1tynqBhr04c0VorRDDBeW0Ayvv/Cmd5NitYHHD7J6Dl2ZkA
         KcCNt7fp9ACfnd+ZfIYQ5QD9dlfRZ4KRRTLx6gdUnGxqu6WFF2gbnjxyTUrji7c/Vh2j
         MDVA==
X-Gm-Message-State: APjAAAUveNWMPbBH8u5pukE6L1QMR6Ot4fPikxmvjUrI+7AWLrLbT2ok
        MqhuVoObk7rdrTmD66I6Um5AEUVV8w2LQ/a4mBBwEA==
X-Google-Smtp-Source: APXvYqxMZ6rLkaYnnt92pn0fadNDe9pmy/HxRpxlXIW4Xc+tV2gaMeGsv7iySH9S3WlvRV3xb/+2qME9hbgcILjqbcU=
X-Received: by 2002:adf:cd90:: with SMTP id q16mr3745478wrj.75.1553199363177;
 Thu, 21 Mar 2019 13:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-5-git-send-email-john.stultz@linaro.org> <CA+M3ks4ekiNc=BDYn=ZvRoaCCbY8d_NJx9jgPw-=U6xdK_o-HQ@mail.gmail.com>
In-Reply-To: <CA+M3ks4ekiNc=BDYn=ZvRoaCCbY8d_NJx9jgPw-=U6xdK_o-HQ@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 21 Mar 2019 13:15:52 -0700
Message-ID: <CALAqxLX4H_uGkhXpRN3Vnh86y1fodzbE5bF8ufPtGXkO45WqAQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 4/5 v2] dma-buf: heaps: Add CMA heap to dmabuf heapss
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 8:05 AM Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:
> Le mar. 5 mars 2019 =C3=A0 21:54, John Stultz <john.stultz@linaro.org> a =
=C3=A9crit :
> > +#define to_cma_heap(x) container_of(x, struct cma_heap, heap)
>
> Even if I had write this macro years ago, now I would prefer to have a
> static inline function
> to be able to check the types.
>
> with that:
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

Thanks for the suggestion! I've reworked that and the other
container_of macro I had in the patch series to be inline functions.

thanks again!
-john
