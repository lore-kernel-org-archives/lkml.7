Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6E0C19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30694229EB
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lw+MGCG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfHGIRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:17:51 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35987 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbfHGIRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:17:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id i21so5374144ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 01:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=uZ71/IjfnhtwBPFF6THZcvtecPOI1brQIp9ai2NeI1k=;
        b=lw+MGCG53qlHD6l00B/7Hr2jQ5KNOzTe/Gk4nJidoMcAM/PCuqYZNE5tCopKN5tIB9
         ybdrmwbQq5dr9qON9O8J8tGMHldp8JlCb68Ac2C0JgrkXcGwvDALxCGgpGaA82m0RYXA
         zDX6S/ynK0N53ICsuuEg/6wrYFCVbJ2HCDDXtR42Frjtd5oq48/dnaIr00RzlNlkR7gP
         Dui88b7Dhs5Iyz7jNvscReYjqxYvEeRM5v4NIkWqclUCYLi2XkMxH0PRxVxOG9bZJv2L
         5QY+LkAUXXOj7VzSwILoN2j9w6heWQ+OyEsdpqqgtZUaF4YL1FkoK0LlSOT4PJM4xtNO
         sGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uZ71/IjfnhtwBPFF6THZcvtecPOI1brQIp9ai2NeI1k=;
        b=PcN9A9kOo83AtUiJ7Cmn7sBD3VuaGi4gDlQAZNVJa91h1gVPxDi1Bpjb52EIItiVKj
         pN8gd8mbFgS8nKtGb8Ia9emzxjALto0sSVOkURh8tfYcwckFuFVg20lxXAt9bi8iyUDz
         yTertKTQ0oqFxVj1jPlpl5zzx91eB48g1qYlVJE40cwE36EoNVNgsgMDSWKdvMl1aKfY
         2eQc9BZLB0659E8KzS5Ug1jVYjtI57FZODgKaHTidsJSTkfdfapp8oEbA3/oJbndIat/
         q+5aQHAq25fPq92wad21zZs03LRu5gHMcWsJlgKcRZIs4NxPUJs6Yw5N9Dtn4ZtNRY4Y
         Ndhg==
X-Gm-Message-State: APjAAAUfOkAQCwWNJywObnZWJ9/EXtIvYrbp1IVX1litpTAg06UlyPhL
        1iYCyl1ffdsW97VkRZzZ1I0Gn0Yq+9V4iHJuXqVg0Q==
X-Google-Smtp-Source: APXvYqwBt9zZPEZS9Zv/S7dA7gva1bRM0PXxxk+aEKCKsKDg9IuOsBbotspesjzG8OPcsmVa9uK3w9BCohv4bn1xoHc=
X-Received: by 2002:a2e:87d0:: with SMTP id v16mr4116786ljj.24.1565165868639;
 Wed, 07 Aug 2019 01:17:48 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 7 Aug 2019 13:47:37 +0530
Message-ID: <CA+G9fYus+cW4775Y2_Xqpc+G6YP_KfjGeCMzoSQq6o2yVY8Q3w@mail.gmail.com>
Subject: next-20190806: arm64: adv7511 3-0039: failed to find dsi host
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>, mchehab@kernel.org,
        robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-media@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, agross@kernel.org,
        david.brown@linaro.org, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 devices dragonboard 410c (QC410E) and hi6220-hikey running Linux
next-20190806 loading modules causing floods of kernel messages.

We have enabled few extra kernel configs for testing.
CONFIG_DRM_I2C_ADV7511=m
CONFIG_DRM_I2C_ADV7511_CEC=y
...

Please find below boot log and config file link.

[    0.000000] Linux version 5.3.0-rc3-next-20190806 (oe-user@oe-host)
(gcc version 7.3.0 (GCC)) #1 SMP PREEMPT Tue Aug 6 05:49:36 UTC 2019
[    0.000000] Machine model: Qualcomm Technologies, Inc. APQ 8016 SBC
....
[   10.051193] adv7511 3-0039: 3-0039 supply dvdd not found, using
dummy regulator
[   10.051633] adv7511 3-0039: 3-0039 supply pvdd not found, using
dummy regulator
[   10.076257] adreno 1c00000.gpu: Adding to iommu group 0
[   10.090929] adv7511 3-0039: 3-0039 supply a2vdd not found, using
dummy regulator
[   10.101703] msm_mdp 1a01000.mdp: Adding to iommu group 1
[   10.102563] msm_mdp 1a01000.mdp: No interconnect support may cause
display underflows!
[   10.139492] adv7511 3-0039: failed to find dsi host
...
[   33.065744] adv7511 3-0039: failed to find dsi host
[   33.076721] msm 1a00000.mdss: 1a00000.mdss supply vdd not found,
using dummy regulator
[   33.078344] msm_mdp 1a01000.mdp: [drm:mdp5_bind [msm]] MDP5 version v1.6
[   33.083862] msm 1a00000.mdss: bound 1a01000.mdp (ops mdp5_ops [msm])
[   33.090892] msm_dsi 1a98000.dsi: 1a98000.dsi supply gdsc not found,
using dummy regulator
[   33.097756] msm_dsi 1a98000.dsi: 1a98000.dsi supply gdsc not found,
using dummy regulator
[   33.106606] msm_dsi_manager_register: failed to register mipi dsi
host for DSI 0
[   33.114579] msm 1a00000.mdss: failed to bind 1a98000.dsi (ops
dsi_ops [msm]): -517
[   33.121263] msm 1a00000.mdss: master bind failed: -517
[   33.135547] adv7511 3-0039: 3-0039 supply dvdd not found, using
dummy regulator
[   33.139360] adv7511 3-0039: 3-0039 supply pvdd not found, using
dummy regulator
[   33.143646] adv7511 3-0039: 3-0039 supply a2vdd not found, using
dummy regulator

Full test log
https://lkft.validation.linaro.org/scheduler/job/860208#L956

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git commit: 958eb4327c1761c609bde8e9f7c04e9d1c6fbb96
  git describe: next-20190806
  make_kernelversion: 5.3.0-rc3
  kernel-config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/dragonboard-410c/lkft/linux-next/579/config
  kernel-defconfig:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/dragonboard-410c/lkft/linux-next/579/defconfig
  build-location:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/dragonboard-410c/lkft/linux-next/579

Best regards
Naresh Kamboju
