Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB179C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 19:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95FDF24677
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 19:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVVaTJgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfLGTCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 14:02:25 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:45181 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfLGTCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 14:02:25 -0500
Received: by mail-pj1-f68.google.com with SMTP id r11so4112272pjp.12
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 11:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+O3tniQbreYjLt+qRLs4KvW/hWdvmqmN88mvSWKL64=;
        b=rVVaTJgX4MHCY/8CFIFmhOsoZFiInVECkykdIg2MsO5pH4XXKOQDO8K1Jm57yB+PQ/
         wsFnIkh+F/RTBKMIL8FfTU2F+u5zlQDO/FJlfELaV/RZT0EHLzojQbYSPxtTcXL982z4
         B/Amfn9DbBNp8o/T8u/HQHojc8WTfoBaB9i7oZg+nutiSdKSjxafTwOO3ywZe0j5vH6U
         /T4v5STwef9ZVOq6msPvWw1wVjP68kMFXuocJIxckvOhb7zCE03/dKuvcS6cxsQOXGAE
         sT33JVfCcXi3NAyNnGhG1mIdJlBv1L7IEisS9DCGGciaqMrVnoQdJxgE+Ab6JDfue5OG
         VWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+O3tniQbreYjLt+qRLs4KvW/hWdvmqmN88mvSWKL64=;
        b=EsOETkomOOyKsU5EdHEbaMXE7OMBz0MBHes30tDlhZIrVsUkf8/t7tLdIeCzCxWHqe
         +J04M2K49haaHA6i6K6RBY6bxdFpRLBcUhId1jdbBawOYfMbfxW6Wp25XYj3u4GY9Hhu
         DIsKWBRyOP1D6qy28x5Tw6VZ/3ujqQQ+kMtMocbXuo1NrLftVLp0afDsNqvRRUQuI0Ii
         /yd6q+ryvUHP2LSGweg9uZD3gcXxHqt47uh37cciKRYjYNZJFTA3YiVQujHTP1SBs+cd
         SDBy0svZPQlvfA9Ohv1ZCgEwXeCbG4L0A9xE4AJe2gu+cJkTALmxyvou/HLIaR7mZ/Kv
         mPBQ==
X-Gm-Message-State: APjAAAUrAWULgaFkadkl40wvYVAFUWDQGUWqXbofZ+8mV2o7Gex55v8o
        dcVj9U/3hu5dAYxuF8xJCMFSTLBPet8kdh9JpuxperB+ovQ=
X-Google-Smtp-Source: APXvYqysY6iW4Z7Hdm6HS9R4fuevTm5nuSeGPWXJaMlAouvKIhvTrtrexltFr2BdaGBJPCL/1A04ltY9ZFoWxhzOsWE=
X-Received: by 2002:a17:90a:30a4:: with SMTP id h33mr22854724pjb.50.1575745344201;
 Sat, 07 Dec 2019 11:02:24 -0800 (PST)
MIME-Version: 1.0
References: <20191207034409.25668-1-yuehaibing@huawei.com>
In-Reply-To: <20191207034409.25668-1-yuehaibing@huawei.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Sat, 7 Dec 2019 11:02:13 -0800
Message-ID: <CAM_iQpVUZ2Hbk2=sJbjJ2gL9WHRFPGWwhYhSQAFFpRyjdgCYOw@mail.gmail.com>
Subject: Re: [PATCH -next] tracing: remove set but not used variable 'buffer'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 7:46 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> kernel/trace/trace_events_inject.c: In function trace_inject_entry:
> kernel/trace/trace_events_inject.c:20:22: warning: variable buffer set but not used [-Wunused-but-set-variable]
>
> It is never used, so remove it.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Right, this should be a leftover after I removed ring_buffer_nest_start().
And my compiler failed to catch this.

Acked-by: Cong Wang <xiyou.wangcong@gmail.com>

Thanks.
