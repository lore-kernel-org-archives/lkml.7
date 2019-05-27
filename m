Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AD1C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44AA02075B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YTCdyhEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfE0HC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 03:02:59 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36063 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfE0HC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 03:02:59 -0400
Received: by mail-qk1-f196.google.com with SMTP id o2so16022204qkb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 00:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4klAjhyMj3pDesqfbfHy9JnpOrfAt9Rbw9O+NZ+oyR8=;
        b=YTCdyhEkTTb+XfSmUaF+Wr2ShZygzLKSn0Jl9+GYsEqfyYSG63Pn0xUFU4TVyNJhwm
         YDDK8Slg8ih74pBO3yczWhVijhKGYnV3YmvxEcG4cVN8P4qxjolS9w4F22KUSmlHAiA9
         uplCxb9RRIUrPw5oi4Kw4n3TesyQLbBlnsSEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4klAjhyMj3pDesqfbfHy9JnpOrfAt9Rbw9O+NZ+oyR8=;
        b=QXEtr0LxV/v/GVpjwQqDtBbT/RXg1cWq98mWuVWUYJ4EyF1mkZqKG9BgAL0GdmjvYB
         Oi1ZTML2EZYU3LD0VTJNypGRfZOVMnW5WZPAC7DQKRJvNMID6CACtJ6VBsEqqn0HDegO
         fVkYcFXpH7omp3ilJ6gAYA05kWoOojTnlO4WaWERQv0MAAm8lYKQERE53NYuUdbvPd4I
         LwLJmaUO2f1+36yMUGFStAvWy/XYUISekDL/uAN8mPLPi/z30cxT/fmYKIg/cmENzrbA
         Pj68nIrbbb5kB2+pgkaDiDfTnY1637r4kkwydta+cKMXBhRr3j733dHx+hDwVZ79kyyV
         YJPg==
X-Gm-Message-State: APjAAAXqsULspkVK47OfNvg1V7iIRw2P23RDCm7E+hHopyueol1PQ8rq
        tN8ESV9KGCo7L0JWRjy+XQlwdR5ndTE7H8lhFFt4Uw==
X-Google-Smtp-Source: APXvYqxQpDPZWhNOSnuQJLc9CTe0oWkb+0Cqhm60NUHHGKbieCA+KLJc7eBSXpQumDQqyyWQgQDoEboMrXnk6DvIO6Q=
X-Received: by 2002:ac8:3f33:: with SMTP id c48mr94820424qtk.347.1558940577990;
 Mon, 27 May 2019 00:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <1557997725-12178-1-git-send-email-andrew-sh.cheng@mediatek.com> <1557997725-12178-8-git-send-email-andrew-sh.cheng@mediatek.com>
In-Reply-To: <1557997725-12178-8-git-send-email-andrew-sh.cheng@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 27 May 2019 15:02:32 +0800
Message-ID: <CAJMQK-j+J4_j7zwKEzAwUBzzPvZ2Q=G_jw=RsW6ZJM6YjVrVfw@mail.gmail.com>
Subject: Re: [PATCH 7/8] cpufreq: mediatek: add opp notification for SVS support
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        linux-pm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        fan.chen@mediatek.com, linux-mediatek@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 9:08 AM Andrew-sh.Cheng
<andrew-sh.cheng@mediatek.com> wrote:
>         bool need_voltage_tracking;
> +       struct mutex lock; /* avoid notify and policy race condition */
> +       struct notifier_block opp_nb;
> +       int opp_cpu;
> +       unsigned long opp_freq;
>  };
>
>  static LIST_HEAD(dvfs_info_list);
> @@ -239,6 +243,7 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>         vproc = dev_pm_opp_get_voltage(opp);
>         dev_pm_opp_put(opp);
>
> +       mutex_lock(&info->lock);

Should init mutex, otherwise it'll get lockdep warning:
[    0.587055] Call trace:
[    0.587069]  dump_backtrace+0x0/0x168
[    0.587077]  show_stack+0x20/0x2c
[    0.587086]  dump_stack+0xe4/0x134
[    0.587095]  register_lock_class+0x3e8/0x4b0
[    0.587103]  __lock_acquire+0xac/0x14e8
[    0.587110]  lock_acquire+0x1d0/0x208
[    0.587118]  __mutex_lock_common+0xc0/0xb40
[    0.587126]  mutex_lock_nested+0x40/0x50
[    0.587135]  mtk_cpufreq_set_target+0xcc/0x2a8
[    0.587143]  __cpufreq_driver_target+0x438/0x4d8
[    0.587150]  cpufreq_online+0x5b4/0x6e0
[    0.587156]  cpufreq_add_dev+0x4c/0x84
[    0.587164]  subsys_interface_register+0xb8/0x10c
[    0.587171]  cpufreq_register_driver+0x11c/0x1c0
[    0.587178]  mtk_cpufreq_probe+0x378/0x4b8
[    0.587185]  platform_drv_probe+0x80/0xb0
[    0.587192]  really_probe+0x114/0x28c
[    0.587198]  driver_probe_device+0x64/0xfc
[    0.587205]  __device_attach_driver+0xb8/0xd0
[    0.587211]  bus_for_each_drv+0x88/0xd0
[    0.587218]  __device_attach+0xb0/0x134
[    0.587224]  device_initial_probe+0x20/0x2c
[    0.587230]  bus_probe_device+0x34/0x94
[    0.587238]  device_add+0x520/0x5b4
[    0.587245]  platform_device_add+0x17c/0x208
[    0.587252]  platform_device_register_full+0xc0/0x100
[    0.587261]  mtk_cpufreq_driver_init+0x8c/0xdc
[    0.587268]  do_one_initcall+0x1c0/0x3e0
[    0.587276]  do_initcall_level+0x1f4/0x224
[    0.587282]  do_basic_setup+0x34/0x4c
[    0.587288]  kernel_init_freeable+0x10c/0x194
[    0.587295]  kernel_init+0x14/0x100
[    0.587302]  ret_from_fork+0x10/0x18
[    0.587510] cpufreq: cpufreq_online: CPU4: Unlisted initial
frequency changed to: 1248000 KHz
