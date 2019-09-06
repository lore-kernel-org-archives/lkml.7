Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366B1C00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161AA2070C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567756369;
	bh=winWBgL5TQGcDxGKWAnYQDvbmLb4EaB1sIi2qiT87RM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eYcY8nfhhqYQqxNB4pLPEWOOWQv4nf/uSfkgLX0TarjXsVauEGbC2ioRHJFRV+hrH
	 TzqWhN/l5bF/aNLwavWOc8cheFmL77q/Ulqkpwc0zOYORxzxMqjIIYmwgkPUbfy8q8
	 +KE8BxZXYyeZffrNoPs5Q3DkH/er7pI/Uz6v5NXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbfIFHws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 03:52:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbfIFHws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 03:52:48 -0400
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D010220842;
        Fri,  6 Sep 2019 07:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567756367;
        bh=winWBgL5TQGcDxGKWAnYQDvbmLb4EaB1sIi2qiT87RM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I3iTW5c2Sy3Jw3wH3U8rb8Ck6BcfVtTSx7cY9quGWXplqe9xYiY/t/Nf5QupucKIi
         iUeiD70snyQwk4hk104xe5tiV4oH5Pw/Q75/xbvl7ljpqZ/lac5ciPTi3u1zolMh8b
         TivWfpZrPerwQ+Cmmd6uuu7x8vFE6WEGFX38/GsU=
Received: by mail-lj1-f170.google.com with SMTP id y23so4778124ljn.5;
        Fri, 06 Sep 2019 00:52:46 -0700 (PDT)
X-Gm-Message-State: APjAAAVaTFIB2zKjg6HVOLRw0kTq6ELq0kSLkZoRP0JgqawjiGnr9SsH
        yMfCYh3DpfsKVyEi0LJeicKaubXlWeb4kYGzpBo=
X-Google-Smtp-Source: APXvYqwlILqYRT4xGA2lf0NyhxXTFgqTN26f5VG4eIgJJFkGkypXCZxvH9/zNmt7h0mx2yp1J0eOPraYUnXRWZw8Ud8=
X-Received: by 2002:a2e:8091:: with SMTP id i17mr4913713ljg.13.1567756364930;
 Fri, 06 Sep 2019 00:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAF-0O_5TSO04M=0kdghhGKTs54QVEYn5mBh7e83EusFjS_Hg3Q@mail.gmail.com>
In-Reply-To: <CAF-0O_5TSO04M=0kdghhGKTs54QVEYn5mBh7e83EusFjS_Hg3Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 6 Sep 2019 09:52:33 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdSmCbkUxbhuoEG8+0U_o1=heHrOeWjrddgy7bedN8Rag@mail.gmail.com>
Message-ID: <CAJKOXPdSmCbkUxbhuoEG8+0U_o1=heHrOeWjrddgy7bedN8Rag@mail.gmail.com>
Subject: Re: cpuidle big_little driver on Odroid-xu4
To:     Jaafar Ali <jaafarkhalaf@gmail.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kgene@kernel.org, sam@ravnborg.org, linux-clk@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Sep 2019 at 15:19, Jaafar Ali <jaafarkhalaf@gmail.com> wrote:
>
> Dear Sylwester,
> Kernel 5.3rc1
> Hardware Odroid-XU4
> cpuidle-big_little driver for exynos 5422 of odroid-xu3/4 is not working.
> when I enable it in the defconfig , CONFIG_ARM_BIG_LITTLE_CPUIDLE=y,
> the device will not boot and the heartbeat blue LED stops.
> when the powerdown state[1] is removed form cpuidle-big_little driver
> or the function bl_enter_powerdown is disabled by early return, the
> kernel boots successfully and I can see cpuidle driver inside
> /sys/devices/system/cpu/cpuidle/current_driver
> both cpuidle-big_little power down state (exynos5420) and suspend
> stuff are using mcpm_cpu_suspend() which in turn calls
> mcpm_cpu_power_down() eventually.
> while suspend stuff is working correctly and the cpu can
> suspend/resume without problems, the cpuidle-bl is not working
> the few difference between suspend.c and cpuidle-big_little that I
> found are suspend.c do some more preparations such as storing resume
> entry point "mcpm_entry_point" into S5P_INFORM0, reset
> EXYNOS5420_CPU_STATE and save and restore some other registers.
> Can we repeat the scenario of suspend in cpuidle-big_little

Hi Jaafar,

Thank you for the report. I am not sure whether big-little cpuidle was
working properly before... (before v5.3-rc1) I added your report to
https://exynos.wiki.kernel.org/todo_tasks

Best regards,
Krzysztof
