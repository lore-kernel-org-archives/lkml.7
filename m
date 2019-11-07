Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2311C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 18:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D072084C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 18:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JEB1F12i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfKGSrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 13:47:23 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:45067 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfKGSrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 13:47:23 -0500
Received: by mail-il1-f196.google.com with SMTP id o18so2744339ils.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 10:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LlH/emK43X7VQlux0XjazW6nVpP1+OhxUnqAKnN/vBs=;
        b=JEB1F12iTYfjJYno9PiUHEyIvfvFi+cWQhuSPBKHPuy1ugZuXn4+uxYA3Ey4McDqlF
         PvDtJzEOxJSnnwrAitdgUXRRfeq3SlbXPFIE6k67sa3xWjywqkMIXl2xZ9MziBmUPsAl
         QX+sIqfsd0HwsZoDRs/WK9nqC6eBfcG0Vm9gLGk8eQg56BI/CqY5tritxhJkvt3pb2a5
         uCR5rJtp8GXjIT4bMlrgdU4gghxt2xZNnrZRtp0lqc0S4lQ5JDbicq98gKRi039be6sD
         LumACIvxVvtdh2nbwrwLoZJm2SfXnunI5xJzIHARQGFZ8A8Qw0M/nwMrX0Oah7XPbLBt
         FE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LlH/emK43X7VQlux0XjazW6nVpP1+OhxUnqAKnN/vBs=;
        b=mOacFJ5rDo2iB0VYaw/4BWky0i+j1mzmgX9dPxKrETulzAbkGVbE9IyK0b+l4LQoUF
         CLptwjldOimejnbBOtZAcm2lQL6lDnhsevgB2tLwurXqSKAIf8T4oetZgbzZ7leLtlGE
         DFkliAra1x53BzfvQPgt847KknpKj/xQxxETY8fDcPCsRoSz9GNuzpAlqmanUX7bvEpe
         Fc5Y7uv2MavcjhiWcfc4gU7yru1hdw1t6nE54To77lVutUCVlQCD/x23ij7kkxQ8vQle
         8jAbMoI/jYq2t70Wi989Te63hwGwBAkDzFE0mznP25qQhvInB0shiSBMrVhw2RyQxmWw
         GP8Q==
X-Gm-Message-State: APjAAAW7KfxZBk3JYFOtluY4iiw5zCwF2KQjVlHvawNQHIuS9rytx0t/
        SY89/QAxV/eCBzI/UDYdf+C+RyfXyXRAeZHoz4KusQ==
X-Google-Smtp-Source: APXvYqzAVWigadbsfFuHoFmMfkvGVyLArpcA4tXnCqWDWZyByyzokkk8+aogfdz1WchCA9laZjOZIHtQihQ5pjFV66o=
X-Received: by 2002:a92:350a:: with SMTP id c10mr6317836ila.140.1573152441970;
 Thu, 07 Nov 2019 10:47:21 -0800 (PST)
MIME-Version: 1.0
References: <20191106115651.113943-1-weiyongjun1@huawei.com>
In-Reply-To: <20191106115651.113943-1-weiyongjun1@huawei.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 7 Nov 2019 11:47:11 -0700
Message-ID: <CANLsYkxKAC9FLYkFjuehj_oFHTVyd=8_R8bAKjPxTXQyAGkwYw@mail.gmail.com>
Subject: Re: [PATCH -next] coresight: replicator: Fix missing spin_lock_init()
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Yabin Cui <yabinc@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2019 at 04:57, Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> The driver allocates the spinlock but not initialize it.
> Use spin_lock_init() on it to initialize it correctly.
>
> This is detected by Coccinelle semantic patch.
>
> Fixes: 0093875ad129 ("coresight: Serialize enabling/disabling a link device.")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/hwtracing/coresight/coresight-replicator.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 43304196a1a6..e7dc1c31d20d 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -248,6 +248,7 @@ static int replicator_probe(struct device *dev, struct resource *res)
>         }
>         dev->platform_data = pdata;
>
> +       spin_lock_init(&drvdata->spinlock);

I have applied both patches but removed the "Fixes" line since the
commit is only visible in my local coresight next tree.

Thanks,
Mathieu

>         desc.type = CORESIGHT_DEV_TYPE_LINK;
>         desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_SPLIT;
>         desc.ops = &replicator_cs_ops;
>
>
>
