Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AD7C3A5A8
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 13:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97C121744
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 13:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jB9FDimY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfIANTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 09:19:04 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37123 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbfIANTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 09:19:04 -0400
Received: by mail-io1-f68.google.com with SMTP id r4so8797264iop.4;
        Sun, 01 Sep 2019 06:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Oy9vbVSjk4JRk5gZtaXEHlSIoXq+rSlaq2jhBh5Gric=;
        b=jB9FDimYiKWkYoSdSws6i2oCvHgvDv9kst7x48wNIh1jRcOwL/68qaH3tPBKQt92vI
         LBcSqlIFydSUHScYQ8/IzKNWJsLAO22qMtpcSNrvm6VxzE4I6devfchF/bSB9G+BfaoO
         XtIs74xkt/ciyiMGazA4+2tuLegPkjzbmDAsVlC6ZGKiBi8EPGK59ldKYzsp/bUFVHwU
         Wtlsim8pT2IDJTUUKtMSbfxTxVVY/3xfgFVFOna4t5+wKA+Gz4gQvkqEP0grMMiX4EXD
         NaayUKBDI+4CAZ2ssU0xjpdTvusNCjXo3pI2XLI+wVrkZQ0Or4K7yQ/QIh7p1DB/60ff
         wgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Oy9vbVSjk4JRk5gZtaXEHlSIoXq+rSlaq2jhBh5Gric=;
        b=C2jCrm1BdmHRQQwo2Pu0wVGL+nMubXSR8orARapq2gnn/vV2Mc1e1IkH7IQXpkrlCM
         eJqfg9aLmBeAkLKtufAy6ntqmroYFMx4GrZkKqUbcUspMxeiqi6W3kaUB2tzUhCAp7dX
         csV2nT7F18iETySSbuDCbAveuxwcavfpQ+R2ofpfSI7ZwDHHz46TtsgXdCl5c9hA/HaK
         D5ttvAOCY9qvMgJZO23PyBvuzVKUPBPrm+m95NBqwgLmIH+dy503/rNkb/nMPkHtIybS
         0mNY3oU4r/a41LMhALbu+lsCJtiWUdKVSo0w1ZCJXMa4T0/eFI40w0YHIpzMrGI0UxAl
         JOwg==
X-Gm-Message-State: APjAAAWscU5p/th2sjcTkf/wLb710XC94JmXqiRxFW0mUmLYcGx2s601
        bZyxOA1hsv+4mKV+i5IcOaWMGCLU0cpAszCV0X0=
X-Google-Smtp-Source: APXvYqxW5iZcY2aF9i2m1ABpcKzHtbm1+gFP5irmLny6GEH/tT20b38UfJjaTAm/6K6c5zO/0G+jSg9StO8YJE0DBrE=
X-Received: by 2002:a5d:8c8b:: with SMTP id g11mr30622237ion.134.1567343943040;
 Sun, 01 Sep 2019 06:19:03 -0700 (PDT)
MIME-Version: 1.0
From:   Jaafar Ali <jaafarkhalaf@gmail.com>
Date:   Sun, 1 Sep 2019 16:13:03 +0300
Message-ID: <CAF-0O_5TSO04M=0kdghhGKTs54QVEYn5mBh7e83EusFjS_Hg3Q@mail.gmail.com>
Subject: cpuidle big_little driver on Odroid-xu4
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kgene@kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        sam@ravnborg.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sylwester,
Kernel 5.3rc1
Hardware Odroid-XU4
cpuidle-big_little driver for exynos 5422 of odroid-xu3/4 is not working.
when I enable it in the defconfig , CONFIG_ARM_BIG_LITTLE_CPUIDLE=y,
the device will not boot and the heartbeat blue LED stops.
when the powerdown state[1] is removed form cpuidle-big_little driver
or the function bl_enter_powerdown is disabled by early return, the
kernel boots successfully and I can see cpuidle driver inside
/sys/devices/system/cpu/cpuidle/current_driver
both cpuidle-big_little power down state (exynos5420) and suspend
stuff are using mcpm_cpu_suspend() which in turn calls
mcpm_cpu_power_down() eventually.
while suspend stuff is working correctly and the cpu can
suspend/resume without problems, the cpuidle-bl is not working
the few difference between suspend.c and cpuidle-big_little that I
found are suspend.c do some more preparations such as storing resume
entry point "mcpm_entry_point" into S5P_INFORM0, reset
EXYNOS5420_CPU_STATE and save and restore some other registers.
Can we repeat the scenario of suspend in cpuidle-big_little

Best Regards
-- 
Jaafar Khalaf
