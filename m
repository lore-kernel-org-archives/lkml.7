Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A37BC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCD82173E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfHZHUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 03:20:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbfHZHUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:20:38 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 96B67356CE
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 07:20:37 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id a17so9252119wrr.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 00:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Qr6ks7uI6Ob3HfkdqYZ1mV0jtXig91Oji7qUddOHKkE=;
        b=RhPgz6F2JjTRW4aAfsRwlIf99TwovthXeN/51i3zLna5R4ZP+TJZrx8CR62QMiXI7T
         gHny+Q2R+chDmvPzJJz2XnGhvGvDnC0cV7sNydNnU7WRPOtjJ8lWvLDe0S2bs0QUKJwX
         a5xf7aPMw3rK0x90N/N59g0tWGL/T2BFgNgxPKmY1eJcIMYFSVqCNBi98U4mZcjGDBuV
         aPJc+79p/6GH1DCrHvswaeyBiH4eRDJ3n2qtdyK9qpy/WUinwbTUuFv2a/5i9o/UWIIK
         qF+IBY3k2xcFYWGJbIeNqapfF0tqdxBBo45h+bXZI8GEyF9heGWP8FMD258XadZQyYJn
         c99A==
X-Gm-Message-State: APjAAAVb9Va0J1eWq5Y//TpriVVsA+1ls4aguxXCZyrqd3seaZLq9dkS
        pbldlzekBfCFCkFSzXdEu7CyZWBUoYl8Lh40j0vXx8riv63s91GTEwdd8t7gKqg+kyjNHOtDKTE
        jdoW+V79NwnCGjR4c5zSb26fH
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr20655986wrw.185.1566804036283;
        Mon, 26 Aug 2019 00:20:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwt/GrvvkTFE9kWbOoAuRkBgia1BmCyyHEBCO8VYyM5xQx/69FBatjunWTDdFQMflwDVGrC1w==
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr20655953wrw.185.1566804036055;
        Mon, 26 Aug 2019 00:20:36 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-161-20.net.upcbroadband.cz. [89.176.161.20])
        by smtp.gmail.com with ESMTPSA id e14sm8994700wma.37.2019.08.26.00.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 00:20:35 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     lantianyu1986@gmail.com, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        daniel.lezcano@linaro.org, michael.h.kelley@microsoft.com,
        tglx@linutronix.de
Subject: Re: [PATCH] x86/Hyper-V: Fix build error with CONFIG_HYPERV_TSCPAGE=N
In-Reply-To: <20190824151218.GM1581@sasha-vm>
References: <20190822053852.239309-1-Tianyu.Lan@microsoft.com> <87zhk1pp9p.fsf@vitty.brq.redhat.com> <20190824151218.GM1581@sasha-vm>
Date:   Mon, 26 Aug 2019 09:20:36 +0200
Message-ID: <87d0gso0jf.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sasha Levin <sashal@kernel.org> writes:

> On Thu, Aug 22, 2019 at 10:39:46AM +0200, Vitaly Kuznetsov wrote:
>>lantianyu1986@gmail.com writes:
>>
>>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>>
>>> Both Hyper-V tsc page and Hyper-V tsc MSR code use variable
>>> hv_sched_clock_offset for their sched clock callback and so
>>> define the variable regardless of CONFIG_HYPERV_TSCPAGE setting.
>>
>>CONFIG_HYPERV_TSCPAGE is gone after my "x86/hyper-v: enable TSC page
>>clocksource on 32bit" patch. Do we still have an issue to fix?
>
> Yes. Let's get it fixed on older kernels (as such we need to tag this
> one for stable). The 32bit TSC patch won't come in before 5.4 anyway.
>
> Vitaly, does can you ack this patch? It might require you to re-spin
> your patch.
>

Sure, no problem,

Acked-by: Vitaly Kuznetsov <vkuznets@redhat.com>

I, however, was under the impression the patch fixes the issue with the
newly introduced sched clock:

commit b74e1d61dbc614ff35ef3ad9267c61ed06b09051
Author: Tianyu Lan <Tianyu.Lan@microsoft.com>
Date:   Wed Aug 14 20:32:16 2019 +0800

    clocksource/hyperv: Add Hyper-V specific sched clock function

(and Fixes: tag is missing)

and this is not in mainline as of v5.3-rc6. In tip/timers/core Thomas
already picked my "clocksource/drivers/hyperv: Enable TSC page
clocksource on 32bit" which also resolves the issue.

So my question is - which older/stable kernel do you have in mind?

-- 
Vitaly
