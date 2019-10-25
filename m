Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CB8CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD70222BE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dTbh5kRF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394938AbfJYOBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:01:09 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36189 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394907AbfJYOBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:01:02 -0400
Received: by mail-lf1-f65.google.com with SMTP id u16so1864833lfq.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 07:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=e7m0bUbtXBnv2hG0jP20Z7UVOAvXLu5pS/p16iFFTtw=;
        b=dTbh5kRFKAeUJ02fzEg55m56Or2mkpSYde3jDq4pzWcZwd6/SrI4odBoyFcvBrKJad
         MhcMpgr3O0oAZZi3DXy8C0rzsg1+6LGICBjQjKU9L00oBicm1Z89mTIIXksUId9S1nrk
         f0ixzXz/Y1sx/3389MQyaVOt7o0opef11dj2UdvvbBPYnplJrsC/0VDqJ6NTQNo3L0iu
         t7yKps03RIs8WKtfmgDnJx//L7LHMLWvUXeEMbDR3ZWw4zmUjuz8pdCI0eiPyMU/zoQq
         fgvKgJJAa95yE98rAMyuhS+Swp+ffMkPcZ3ANDoHaotRv6M0wyQfAxr7PL7oQu8sazyp
         QDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e7m0bUbtXBnv2hG0jP20Z7UVOAvXLu5pS/p16iFFTtw=;
        b=gkYOQfhV0Yt1abgtpO46woh2gyyQQ5qc/9bJDXeERBXiYy+RL/jgPOsze57xEWavM4
         a2ze8HNbI8NsMyGFpImjZ48XBkxrnpEq889WxlN/Bebp8twhOhA/IUhEmfUcyMXJDaCu
         IDgJAPVnkQMgdZu7aVWHD85+75/Lq/Akk5izDTrzMiy0Bp+S430RVtNsGjzFa4N7gcU1
         PkqyCwKyCLh6hP4NkKY9Xx03AJ3IOYXq91zkGUzHXEsY1D5EMFxxwNFP7nw5oSP5k7zq
         P1pBID/lHeUrAYHUtMuwgx90qKTUGvuzXMTQuV5h0BUtObITuH48d/9rf5dVA7J5CfSZ
         haoQ==
X-Gm-Message-State: APjAAAWhAz05zlzkyvGVnp6WxEFCNwmqXlcuOfVSj7+/8NOlsyDDhk8h
        JtW0gvHNq9Sf5jNpwMNmB0WwQQ==
X-Google-Smtp-Source: APXvYqzUu4gv63DpUe1KdnUYahz+kl9nNDKPV19VnKiZ/1tr8k6IFuBIcP79aFsZaoepqv8RnWLI1Q==
X-Received: by 2002:ac2:5108:: with SMTP id q8mr2996751lfb.150.1572012059852;
        Fri, 25 Oct 2019 07:00:59 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id x17sm811970lji.62.2019.10.25.07.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 07:00:59 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.4-rc5
Date:   Fri, 25 Oct 2019 16:00:58 +0200
Message-Id: <20191025140058.10668-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.4-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 7d194c2100ad2a6dded545887d02754948ca5241:

  Linux 5.4-rc4 (2019-10-20 15:56:22 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.4-rc4

for you to fetch changes up to 2bb9f7566ba7ab3c2154964461e37b52cdc6b91b:

  mmc: mxs: fix flags passed to dmaengine_prep_slave_sg (2019-10-21 16:16:38 +0200)

----------------------------------------------------------------
MMC host:
 - mxs: Fix flags passed to dmaengine_prep_slave_sg
 - cqhci: Add a missing memory barrier
 - sdhci-omap: Fix tuning procedure for temperatures < -20C

----------------------------------------------------------------
Faiz Abbas (2):
      mmc: sdhci-omap: Fix Tuning procedure for temperatures < -20C
      mmc: cqhci: Commit descriptors before setting the doorbell

Sascha Hauer (1):
      mmc: mxs: fix flags passed to dmaengine_prep_slave_sg

 drivers/mmc/host/cqhci.c      | 3 ++-
 drivers/mmc/host/mxs-mmc.c    | 7 ++++---
 drivers/mmc/host/sdhci-omap.c | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)
