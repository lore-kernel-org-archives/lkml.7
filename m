Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2148C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C956620854
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YgHnUrQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390673AbfIFKVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 06:21:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40014 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388443AbfIFKVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:21:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id 7so5477762ljw.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 03:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1XE2iMKxqeBeswKR1xzlvsta7f6sdclLOJUEbI6gihw=;
        b=YgHnUrQFNAnUFKkSbc+ykNP3SwrMbo4pz/pL3+7+Qx9w+CAWd+tNrsn2u0v+YLkekQ
         dCwgypVInxxZ5mQfogIfnoLu+yPJ1WI3NVcVIm8FBMQjHrmC37Fh6i7jV4g32cjj5mL9
         b12VsfeTm1Hz70kyn6v+HJyIRkOjafMVsu2S0DoguhuHantMkAfnktdV8qrXwIuha5z+
         zdj72rwfsCx2X/Iq4keEi4fIV1V5tQlHGQhJvS9zmzHvTfHyEOKcUBqxD0Uj99WtrNHV
         IqS+HISWroSfN/+i+orD93kB3ndJXJdpI5IpLje5PFWW1GqT3KtyuJuZytxLWxfoPapy
         g+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1XE2iMKxqeBeswKR1xzlvsta7f6sdclLOJUEbI6gihw=;
        b=fXTdHADVXp6oFufD6xJLIOkMuVfRPPK0+vZju7Jw7cLjiTWsjIfm01jZ4+ZhLUf8G0
         WjijvbRLEn5ZuX6W6vpUD94ppNIGg42m4TL+2kakZliPsO2Yq+qdd8k5pCppA5xWqpql
         TK/AOdksIsus0YkyQWLVdTd2ygsA0anOpHDpMFGSy74ypqEZJGI86RgIMzPbefIo6icx
         ztKklp/L+TRQ12hi+x390lGsRc83kY56DjAUqstRoKqE4CFUf3i7Kv0iL6ukiEroJQF4
         Ekp6PDYw6wdvqS+kxfCB7F2z99n0tPLM3//Y8TcIhmiWlHGjptrLODYDQiy6hwtoASyO
         GIDQ==
X-Gm-Message-State: APjAAAXAlPgNlZ861yEoPXg0yh/ld14DTjMvIS/ClyECZZF28TJRLwcv
        ZorrMgMtzsIbyU0p2FBH3kE98u6umTc=
X-Google-Smtp-Source: APXvYqztTS4qpegFJb8eFFnKk7dV5idrDYMnWk/xNLDWvDE9Uz5saL21N7D+aNgevoeKewjXLExpzg==
X-Received: by 2002:a2e:50b:: with SMTP id 11mr5314059ljf.11.1567765299406;
        Fri, 06 Sep 2019 03:21:39 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id s7sm855763lji.26.2019.09.06.03.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 03:21:38 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.3-rc8
Date:   Fri,  6 Sep 2019 12:21:37 +0200
Message-Id: <20190906102137.637-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with an MMC fix intended for v5.3-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 089cf7f6ecb266b6a4164919a2e69bd2f938374a:

  Linux 5.3-rc7 (2019-09-02 09:57:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc7

for you to fetch changes up to 8ad8e02c2fa70cfddc1ded53ba9001c9d444075d:

  Revert "mmc: core: do not retry CMD6 in __mmc_switch()" (2019-09-03 16:53:28 +0200)

----------------------------------------------------------------
MMC core:
 - Fix card init for some eMMCs that need retries for CMD6

----------------------------------------------------------------
Jan Kaisrlik (1):
      Revert "mmc: core: do not retry CMD6 in __mmc_switch()"

 drivers/mmc/core/mmc_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
