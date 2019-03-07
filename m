Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9FEC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A641920840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CSt/QH8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfCGQxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:53:07 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:33069 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfCGQxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:53:06 -0500
Received: by mail-vk1-f196.google.com with SMTP id l62so3873942vkh.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 08:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cGSn2eNrDy4WdnvfwM9w2+qEWAhOE74mBjW4gFWJicE=;
        b=CSt/QH8YQHqHVk5MS6EMTWGzxV5gjZTy9jaGQcSjcr/gLYMLyVOgiSX3bGVRPQgGUx
         bmJ1ggSyhBk85wesqt4BNHg+NDWY5SjZ8F5pxQ/9eqwO/ceyLYBzO0M/j/QGUhtWwWGg
         WK97lyCZddWxOafOu11Gc7D8xFGTcgYOOr/T8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cGSn2eNrDy4WdnvfwM9w2+qEWAhOE74mBjW4gFWJicE=;
        b=iBJA6xrgIaxr5qFTe3vzXsztwDRY+kmUrsg5mDHI2AgwplC6zO8KLcK/41PaH7uM71
         PBivqnJ+JDMukRW5TefMIcXh0KqY1MJGpDzP9aWuZw6H9NLqUKSCU8AE7i+7Vkv9Pae2
         9Wfy2kXSsdU6+soMk8bvrie7da0VUvVErvE6dZvcztl+AeFn8BsPlnAc4KEOGBdJgFJs
         3kMoTnT/SGfhEdsJnf74TfxE+zrXTrg/NYLpmCwXCpixLJ/GvAKbC3wnRYQjVpYioXdU
         /Quc9ohHlk09+1Um0Cw/p0G0EaorQLnZVTs8AqD+j1x3fZLq0H1hbSOUD6dC3N+ewna7
         eeaQ==
X-Gm-Message-State: APjAAAUeYPcCb6L+FxcePQpGsDlq+8Q+Rm8muu5Q4+rsrvhu55oIFszW
        wXUqRTrxZ7Gh0cy+oLpfHOMZU8cPmfY=
X-Google-Smtp-Source: APXvYqzCSv1AU/TTIeBgQofIdfcW0dRHP4p5gHrLLX0wH9KJDQY+FL/LD5jJGMH7izThSWQrzOG5eg==
X-Received: by 2002:a1f:91c4:: with SMTP id t187mr6747797vkd.86.1551977585352;
        Thu, 07 Mar 2019 08:53:05 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id q12sm1973329vkf.42.2019.03.07.08.53.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 08:53:04 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id c5so10413181uaq.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 08:53:03 -0800 (PST)
X-Received: by 2002:ab0:6556:: with SMTP id x22mr7329756uap.10.1551977583073;
 Thu, 07 Mar 2019 08:53:03 -0800 (PST)
MIME-Version: 1.0
References: <20190307010153.81157-1-bvanassche@acm.org> <20190307012417.GU1758@mellanox.com>
 <8a5bd9ae-ebfe-687c-2868-d0f2a610d1e0@acm.org> <20190307072428.GJ1789@mtr-leonro.mtl.com>
 <4d90c392-5b6a-fea0-e6cf-c49ac19fdf30@acm.org> <20190307154020.GN1789@mtr-leonro.mtl.com>
In-Reply-To: <20190307154020.GN1789@mtr-leonro.mtl.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 7 Mar 2019 08:52:51 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLBPpKOT-NV1P0nuFeSQYfoNY_8B0V4gcQg18xHPUVbhQ@mail.gmail.com>
Message-ID: <CAGXu5jLBPpKOT-NV1P0nuFeSQYfoNY_8B0V4gcQg18xHPUVbhQ@mail.gmail.com>
Subject: Re: [PATCH] Avoid that check_shl_overflow() triggers a compiler
 warning when building with W=1
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 7:40 AM Leon Romanovsky <leonro@mellanox.com> wrote:
>
> On Thu, Mar 07, 2019 at 06:53:54AM -0800, Bart Van Assche wrote:
> > On 3/6/19 11:24 PM, Leon Romanovsky wrote:
> > > My simple patch passes too :).
> >
> > Can you repost your patch?
>
> https://patchwork.kernel.org/patch/10841079/
>
> As Rasmus wrote, the thing is to avoid a < 0 check. In my patch,
> I converted a <= 0 to !(a > 0 || a == 0) expression.

I'd be happy either way. Is there a larger benefit to having a safe
"is_non_negative()" helper, or should we go with the minimal change to
the shl macro?

-Kees

-- 
Kees Cook
