Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43596C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 03:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1410F20659
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 03:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ez8MWVdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbfGHD3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 23:29:03 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36283 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbfGHD3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 23:29:03 -0400
Received: by mail-qt1-f196.google.com with SMTP id z4so13232875qtc.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 20:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AK79VDL+Vgenq/SIz4Re5O9aUU8flN86KP1/GJSoiLE=;
        b=ez8MWVdvAiNAzrPrfFi/OIQyqlh22yAZ/zH+VWz8JN6ZEaGDfCi2GG42eDqeMtgSkh
         1sqvjYom7xaqRKO9p7Q7pFOSyV5DgCWI6XAyo4PPH5AQXeGYTykL5UWwgdYYa1z5adoB
         KoeneGqzCXCplkbOtzanZacHSkKv1pX/0vonQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AK79VDL+Vgenq/SIz4Re5O9aUU8flN86KP1/GJSoiLE=;
        b=JjXyq5ZqTeUw2nfQBDqQtTDpXciFIJ+hs/Rv0jqPx3jwn7pNPlJKZlqQoamh3Khocx
         X/akmlm+v+O74mxfC4gziW4FLLP2C+ez5Lbei8vBhfqCVvPwJuSDDv3/H5yDZ9qfKYi7
         5XSd2/J+D3cu9t+n7vvfWjlXmjwn7F3Ci4hropIrpvjR2hEz6UDDMt3l4culgnovXaJH
         ATNBbts1zy0Fl71/3y1WMnXGeyI8c4VPI7bsA6Jok5nKwIUxRPVCyiyRh6Gfozkl4jkA
         fh+rhLSoheLC/Gaa21dVlfV8d4LqXYXrftehi5oaaR1neCdY+wal+1kz+VLuTR+fmRi3
         GWCA==
X-Gm-Message-State: APjAAAXg1ZX0iF0Xon+AANfsGi0zdhCHEIhzWpKYzJ1pTg0w1yVWYvJt
        KCHh7eKZFdTlHGqkJdPqswDNgC6MBBHzAUEUFr8Y/Q==
X-Google-Smtp-Source: APXvYqwS+agaC1kW4fS2QvA9PLe7B8m9Obzbo4GMUG8V7F6612I0p2pqiO5MLu/JXxuE3ADTeouCu6Uj8N29MxKn+jU=
X-Received: by 2002:a0c:baa1:: with SMTP id x33mr13371081qvf.200.1562556542563;
 Sun, 07 Jul 2019 20:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190328152822.532-1-sibis@codeaurora.org> <20190328152822.532-3-sibis@codeaurora.org>
In-Reply-To: <20190328152822.532-3-sibis@codeaurora.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 8 Jul 2019 11:28:36 +0800
Message-ID: <CAJMQK-gcBC=ZyscuHzOe4t6xQzviTYo9W9_DSsppoaTZuiEOcw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] OPP: Export a number of helpers to prevent code duplication
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>, andy.gross@linaro.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        david.brown@linaro.org, Mark Rutland <mark.rutland@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-msm-owner@vger.kernel.org, devicetree@vger.kernel.org,
        rnayak@codeaurora.org, Chanwoo Choi <cw00.choi@samsung.com>,
        linux-pm@vger.kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, dianders@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 3:28 PM Sibi Sankar <sibis@codeaurora.org> wrote:

> +
> +/* The caller must call dev_pm_opp_put() after the OPP is used */
> +struct dev_pm_opp *dev_pm_opp_find_opp_of_np(struct opp_table *opp_table,
> +                                            struct device_node *opp_np)
> +{
> +       return _find_opp_of_np(opp_table, opp_np);
> +}
Hi Sibi,

Though this is not the latest version, we've seen following issue:

We would get lockdep warnings on this:
[   79.068957] Call trace:
[   79.071396]  _find_opp_of_np+0xa0/0xa8
[   79.075136]  dev_pm_opp_find_opp_of_np+0x24/0x30
[   79.079744]  devfreq_passive_event_handler+0x304/0x51c
[   79.084872]  devfreq_add_device+0x368/0x434
[   79.089046]  devm_devfreq_add_device+0x68/0xb0
[   79.093480]  mtk_cci_devfreq_probe+0x108/0x158
[   79.097915]  platform_drv_probe+0x80/0xb0
[   79.101915]  really_probe+0x1b4/0x28c
[   79.105568]  driver_probe_device+0x64/0xfc
[   79.109655]  __driver_attach+0x94/0xcc
[   79.113395]  bus_for_each_dev+0x84/0xcc
[   79.117221]  driver_attach+0x2c/0x38
[   79.120788]  bus_add_driver+0x120/0x1f4
[   79.124614]  driver_register+0x64/0xf8
[   79.128355]  __platform_driver_register+0x4c/0x58
[   79.133049]  mtk_cci_devfreq_init+0x1c/0x24
[   79.137224]  do_one_initcall+0x1c0/0x3e0
[   79.141138]  do_initcall_level+0x1f4/0x224
[   79.145225]  do_basic_setup+0x34/0x4c
[   79.148878]  kernel_init_freeable+0x10c/0x194
[   79.153225]  kernel_init+0x14/0x100
[   79.156705]  ret_from_fork+0x10/0x18
[   79.160270] irq event stamp: 238006
[   79.163750] hardirqs last  enabled at (238005):
[<ffffffa71fdea0a4>] _raw_spin_unlock_irqrestore+0x40/0x84
[   79.173391] hardirqs last disabled at (238006):
[<ffffffa71f480e78>] do_debug_exception+0x70/0x198
[   79.182337] softirqs last  enabled at (237998):
[<ffffffa71f48165c>] __do_softirq+0x45c/0x4a4
[   79.190850] softirqs last disabled at (237987):
[<ffffffa71f4bc0d4>] irq_exit+0xd8/0xf8
[   79.198842] ---[ end trace 0e66a55077a0abab ]---

In _find_opp_of_np()[1], there's
lockdep_assert_held(&opp_table_lock);

[1] https://elixir.bootlin.com/linux/latest/source/drivers/opp/of.c#L75

But in governor passive.c#cpufreq_passive_register(), it call
dev_pm_opp_find_opp_of_np() directly, so it wouldn't access
opp_table_lock lock.

Another similar place is in dev_pm_opp_of_add_table(), most devfreq
would call this to get opp table.
dev_pm_opp_of_add_table
 -->   _opp_add_static_v2
    -->    _of_opp_alloc_required_opps  // would goes here if opp
table contains "required-opps" property.
        -->    _find_opp_of_np
cpufreq-map governor needs devfreq to have "required-opps" property.
So it would also trigger above lockdep warning.


The question is: Is lockdep_assert_held(&opp_table_lock); needed in
above use cases? Since they don't need to modify device and opp lists.

Thanks
