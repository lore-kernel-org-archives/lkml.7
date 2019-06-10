Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7C2C31E43
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E644B20820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5P5/aH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfFJQsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 12:48:22 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33775 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfFJQsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 12:48:21 -0400
Received: by mail-ed1-f67.google.com with SMTP id h9so15442744edr.0;
        Mon, 10 Jun 2019 09:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j3h84NSaTkFu6Uv0SKats11wFiFF0h143HuYgUGuRqE=;
        b=I5P5/aH1ZEVMpLlREl6deIyYZL3L/UOc0GjF7sM6HE0KdE3gIsK+/GG93fOwgTxoxY
         TxXPKY6WxzlVG5zuQtNi5o2Cj+TyGRc4On5AMuORsB0VDQomI0scOoCYXz51hUL7bxhT
         KtgJ5KII3Tx5vcVxO7TDLfmYer6gHExdvGPcmc4eg+ZPKfzxSyY78ot0TBqm/fhLi5ND
         nI4NFjEgVIhMnKxj3V47h1U9+pwV2Bypis6TFVrgEF2iL9zqU4gqlZlmW+SP9qgEBmzD
         ciefdGbisQI4kuO1I6HwaDMtsdTyxYtEXqeEckOl+Mtk5N631IIL8UBSyqfWlVaKvkV6
         s2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j3h84NSaTkFu6Uv0SKats11wFiFF0h143HuYgUGuRqE=;
        b=K2Ut5xeodc4hIFOgn9G4y5HfErbup8pcuuXhIK5j/Ewot51NKdyVLRZsyX2AR/nVh9
         W4DI0ZS30lbD3IFFcx6tTSk2gQBvTYao3TJ+TT9etDkn/3eP2MVz3ddiYRZhEfxL78MK
         v2ANGwkSP0qFVHxT7earDkexBVXczQ/PxyASsXGAPEkvc93i/HTTioNoXOGp+tmSRLVO
         jq22nGVlR9RWVNlisQpsfd+vQgAvNhNbNxxGII90xI7Rvd60lWZ/DAJ0fKx3mXn8iKPF
         Seye1nTrkSpdQYO7F+0GhOA8kUg4G+tLfz+cf1lhDeQxUkN0iB8Fxgnlv8rVKKP3lIuS
         X/Lw==
X-Gm-Message-State: APjAAAW8do71GPQtLVEX5zsUy/GTP8aDHd7BhkU55+WfLSt9Mb36+0GE
        tK4uOr/iwyuL/vLNl+WRr3c=
X-Google-Smtp-Source: APXvYqyQNnMgnO7RCcBBNA8dsWEBVtgx/ft6pFxBCg02eg1aIRMpbKitPj/ecSJuKQbVCFjuPpFgmw==
X-Received: by 2002:a50:972a:: with SMTP id c39mr39634199edb.46.1560185300056;
        Mon, 10 Jun 2019 09:48:20 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id a9sm3075799edc.44.2019.06.10.09.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 09:48:19 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] Few more cleanups for tegra-timer
Date:   Mon, 10 Jun 2019 19:43:54 +0300
Message-Id: <20190610164400.11830-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This a followup to [0] that includes some more fixes and further
prettifies the driver's code.

[0] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=111529

Changelog:

v2: Fixed a bug that was introduced by [0] in a newly added patch:
    "Restore timer rate on Tegra210".

    Fixed potential problem in regards to error handling in another new
    patch: "Restore base address before cleanup".

    Added new patch "Add verbose definition for 1MHz constant" as per
    Daniel's Lezcano recommendation.

    Fixed a code typo that was made in "Remove duplicated use of per_cpu_ptr"
    of v1.

Dmitry Osipenko (6):
  clocksource/drivers/tegra: Restore timer rate on Tegra210
  clocksource/drivers/tegra: Remove duplicated use of per_cpu_ptr
  clocksource/drivers/tegra: Set and use timer's period
  clocksource/drivers/tegra: Drop unneeded typecasting in one place
  clocksource/drivers/tegra: Add verbose definition for 1MHz constant
  clocksource/drivers/tegra: Restore base address before cleanup

 drivers/clocksource/timer-tegra.c | 59 +++++++++++++++++++------------
 1 file changed, 37 insertions(+), 22 deletions(-)

-- 
2.21.0

