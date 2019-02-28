Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B1CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C282171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="glTBa+KW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbfB1OWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:22:43 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38212 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731169AbfB1OWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:22:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id j19so17292707ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 06:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WsxJDFLqBtROseFW7TnhgCk49FBOOYJuBW2arOxBIGw=;
        b=glTBa+KW0tg+8KakoVydAqUszUCi/eRNRoLcMhnCHQZaQ6Yq+rXrX/pslcKL3i5gJr
         Dncf8jb95XoZEwsi64q/1pYfEqIbC2KT4300R6q06IGvR5jZP69vbamewkXNCtjOdOhM
         VGYxCca2wVEQn6z938igyMvrXpc9RJ1TAJHHnvabGwCxVGTjPXFyMCuTs5HkxnSPRRPq
         B54pR+AjPmgc6VcEkbYbsPxgBhLdqXNWg0+7OBK222tj2/tGvX0vP11/VbDOexoqALJq
         58QfmtPJmssWOfe73aeouUDsM7r7KuTuOKMrecc0BTtVqYVsuDwmQwOSstUSNiOhKJK0
         VrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WsxJDFLqBtROseFW7TnhgCk49FBOOYJuBW2arOxBIGw=;
        b=Vm4TivcnAkRdhBkv0OOBgGYiK4UNpVWs+BfFAgTA4uX7vZlS1yaJDXkUK2mhuiGKv/
         sIhKIZlcTzTvn4SBJI6pAgku5hobqIpWRvf7Jb10Vw8Dgc0pJA0VG/5rzAmfPHkhzveM
         S/uebMCkZJd03HRSC+7WgN7nTaeBLm9dmQGDij0xUpUfGvg9XRU9YVvePJi49ZIJWBBO
         Op2FkS1e/2VZRe06xiFtkCsSGrrBl9Y2BWnQkNuW+thBpfXuji1yVnGQmeQeEBsgAHls
         M4TG8J+gktYRemUAU8hUI7r1GFggKXKU49dTUMpNMAKxdfgwS/WMniBLLcayjwYqbgH+
         +Siw==
X-Gm-Message-State: AHQUAuZumw58RJkRB0XtX/v7ontTlyIICNYlNdO3MQMgMcYc49RE17Fc
        4wWoWijPe2AZSa+A1GeoMwOnSw==
X-Google-Smtp-Source: AHgI3IbphyV90vbDsoOOrz7Wzx1fPLJKtxcYBu6wiOgDhg8JYArjc5UfNbUcI9COiZ8atsWi2bi7lQ==
X-Received: by 2002:a2e:9cc7:: with SMTP id g7mr4836293ljj.33.1551363760598;
        Thu, 28 Feb 2019 06:22:40 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id m26sm4024029lji.22.2019.02.28.06.22.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 06:22:40 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.0-rc9
Date:   Thu, 28 Feb 2019 15:22:39 +0100
Message-Id: <20190228142239.4078-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.0-rc9 (final). Details
about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 5908e6b738e3357af42c10e1183753c70a0117a9:

  Linux 5.0-rc8 (2019-02-24 16:46:45 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.0-rc8

for you to fetch changes up to e30be063d6dbcc0f18b1eb25fa709fdef89201fb:

  mmc: sdhci-esdhc-imx: correct the fix of ERR004536 (2019-02-28 12:18:31 +0100)

----------------------------------------------------------------
MMC core:
 - Fix NULL ptr crash for a special test case
 - Align max segment size with logical block size to prevent bugs in
   v5.1-rc1.
MMC host:
 - cqhci: Minor fixes
 - tmio: Prevent interrupt storm
 - tmio: Fixup SD/MMC card initialization
 - spi: Allow card to be detected during probe
 - sdhci-esdhc-imx: Fixup fix for ERR004536

----------------------------------------------------------------
Alamy Liu (2):
      mmc: cqhci: fix space allocated for transfer descriptor
      mmc: cqhci: Fix a tiny potential memory leak on error condition

BOUGH CHEN (1):
      mmc: sdhci-esdhc-imx: correct the fix of ERR004536

Jonathan Neuschäfer (1):
      mmc: spi: Fix card detection during probe

Ming Lei (1):
      mmc: core: align max segment size with logical block size

Ritesh Harjani (1):
      mmc: core: Fix NULL ptr crash from mmc_should_fail_request

Sergei Shtylyov (1):
      mmc: tmio_mmc_core: don't claim spurious interrupts

Takeshi Saito (1):
      mmc: tmio: fix access width of Block Count Register

 drivers/mmc/core/block.c                 |  6 ------
 drivers/mmc/core/core.c                  |  2 +-
 drivers/mmc/core/queue.c                 |  9 ++++++++-
 drivers/mmc/host/cqhci.c                 | 13 +++++++++++--
 drivers/mmc/host/mmc_spi.c               |  1 +
 drivers/mmc/host/renesas_sdhi_sys_dmac.c |  1 +
 drivers/mmc/host/sdhci-esdhc-imx.c       |  9 +++++----
 drivers/mmc/host/tmio_mmc.h              |  5 +++++
 drivers/mmc/host/tmio_mmc_core.c         | 17 ++++++++++++-----
 9 files changed, 44 insertions(+), 19 deletions(-)
