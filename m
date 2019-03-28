Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F392C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBC6206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LpGvEsB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfC1CgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 22:36:13 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34892 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfC1CgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 22:36:13 -0400
Received: by mail-yw1-f66.google.com with SMTP id d132so1724181ywa.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 19:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QT3x1Md3mQTDphty4tkPRUZzz248zgaCTuckeZqsUjQ=;
        b=LpGvEsB6dlfpQOKvvPfB3+q5ULiSGoNG26QkPtBXP/NDXHfBWq8vLnciWdKJJMbI6G
         zOEyzGRCCB0leDNuEcTFWIDg1fi4oRc0+lZd3FgfxZAd9S+W+nsCukD/wqthhtAZuKzE
         zR4msgSUnx7Lf2fmppjxHqKqnG9lPp8aq86JbNi4Z+g8bSwKI8gHsgZkLZX9dp/jUbU2
         5CwERI0hva8BKfS+20vgd6a+9td1mZYUS6/gkvMhi2s3WhfyeNV7zKkM9iGG65Sm5Jgx
         Dy2LDDdOp1NsQCPPKD7K7HKy/9k1a12L5YD7v9bhC+gCuc3l445YZsX3cQXdgxTohY1L
         BBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QT3x1Md3mQTDphty4tkPRUZzz248zgaCTuckeZqsUjQ=;
        b=uczbTb2bIJ+J4sunEbOI5zp9fRGK5TuNeLu5fkcfXD0PIT/Qu0ZpT6Pp8BJDc/wf5C
         /NQE4zJfFgXXfW4ebWAtOewLCniDNMnNEEHwZuO1ER6JXgW55laEAfeV4Tzqznelb29O
         2Wukgzpn7ovVGWyyxm6ATD/EUwMMHfLJL1vFdNjq6Ii+C5EGYTxXZdV/I+0t6PsF2LW2
         BX9hmkAcp96EYbyhxF4zyBQRTmqSU0gi4OPCi4u6EqTCmbukYbAuvAUjR+AZ99g5NFZI
         +RJl8UpuCtVipxCYM0jRt2gC9UDMlFYrbnqgbftgZNPdNuRr/Kezy4fKjEZjPwd5A9lI
         otYQ==
X-Gm-Message-State: APjAAAVwImxqtvOKu9RDX/Uh3YzDeJ9SixXweIOs18nMVsRV3GJvF/9z
        r7G3XUPVkK7kfRyPS6tL7X5feg==
X-Google-Smtp-Source: APXvYqww0WDhhqu9a+k9QwyccHe3JPrz2TpCQzNjWwPrOiKfeAoSFx6K4hDl1FLCCwzLOsA/ZsJU2Q==
X-Received: by 2002:a25:2a0d:: with SMTP id q13mr4363916ybq.257.1553740572635;
        Wed, 27 Mar 2019 19:36:12 -0700 (PDT)
Received: from localhost.localdomain (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id t71sm16272787ywc.4.2019.03.27.19.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 19:36:10 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        Wanglai Shi <shiwanglai@hisilicon.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 0/2] CoreSight: Support static funnel
Date:   Thu, 28 Mar 2019 10:35:07 +0800
Message-Id: <20190328023509.22242-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since before there have no platforms use static funnel in mainline
kernel (though maybe some in-house SoC has used it but didn't upstream
for mainline kernel yet so we don't be aware for it), when enable
CoreSight DT binding for hikey960, we found the SoC uses the static
funnel in the link path and but it's not supported in CoreSight funnel
driver.

So the first patch is to update DT documentation to support static
funnel (we call it as non-configurable funnel in documentation); the
second patch is to support the static funnel in the CoreSight funnel
driver.

Credits to Suzuki shared code for CoreSight replicator refactoring,
the static funnel related implementation heavily follows up the same
fashion in Suzuki's replicator code.

This patch set has been rebased on CoreSight next branch [1] with
latest commit d5d246a56af0 ("coresight: Merge the static and dynamic
replicator drivers") and tested on Hikey960 with perf commands:

  # perf record -e cs_etm/@20010000.etf/ --per-thread ./main
  # perf report --tui

P.s. in this version, Hikey960 CoreSight DT binding has not been
included and will be sent out separately.

[1] https://git.linaro.org/kernel/coresight.git/log/?h=next


Leo Yan (2):
  dt-bindings: arm: coresight: Support static funnel
  coresight: funnel: Support static funnel

 .../devicetree/bindings/arm/coresight.txt     |  45 ++++++-
 .../hwtracing/coresight/coresight-funnel.c    | 112 +++++++++++++-----
 2 files changed, 127 insertions(+), 30 deletions(-)

-- 
2.17.1

