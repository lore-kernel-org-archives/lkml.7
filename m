Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA968C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9E0243C4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ps1O4Mtb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfFCSh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 14:37:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37631 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfFCSh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:37:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id 20so8781617pgr.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 11:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YZsnBAN22tVtHFJc56q+rxbdD8fX8T8HXkSym7OyHiQ=;
        b=Ps1O4MtbD2rEMRtRw6yvXGSxDXrH7HjPdY7KCq/lSlW7htShDFp+u033WFVJDjOXPb
         OLNlYon0Wpzph3sUz2BCPyDgUNjVZMpJf1kV0lUidQnpFyFPagCNB03AVdSVyyqUvAr/
         bxUU+BnIId5lrXnzJ6D/l5svsqW8IvWW9U+R8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YZsnBAN22tVtHFJc56q+rxbdD8fX8T8HXkSym7OyHiQ=;
        b=MFpW3EECqSP9V6WOS3mM9BvMY89pdMY5Yj5a/QsAd2zr/7tF0icNVSpoHJxuO13T94
         /7Ki/9GVPmmBQ9yZJ5T/fwpue2KrGxsG3YGhjThhazFyuI+azJwWEmERAJbcBifGdz49
         U6meYuUywVZaTOKlBK0dz9JHkgGYvEz/cIByF0FTA2bZhSQQBLQVSYtvg3x0BQr3DevE
         8yOYeesB8ToMF6d5pCdwk7WhbKQ0C6b2GdAiqQeh4JkCGxMN3z871YANSr77ssmoYUI6
         WDHzDGVJScMORdKtCO0U6MQT4cukTzugUHe1Y539MBqoQaJL+t4l8gyhOfdU+SpaFAlB
         VaGA==
X-Gm-Message-State: APjAAAWRFaGgnVJNryaTUGQWpRVu53ZUjbx1GQ0ouf6CYx1aZJAvWyMv
        DN76xnt5zowt4gstx/C+K9a3ug==
X-Google-Smtp-Source: APXvYqwbLiM1y3Cof2KgcMMeZ8t9NIYK+vbdXny/5bFAdCAVPmxQ/CP9Y2AV9T+xZdprrAWMKhZjdw==
X-Received: by 2002:a62:764d:: with SMTP id r74mr9422273pfc.110.1559587076759;
        Mon, 03 Jun 2019 11:37:56 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id t2sm14808969pfh.166.2019.06.03.11.37.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:37:56 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     brcm80211-dev-list.pdl@broadcom.com,
        linux-rockchip@lists.infradead.org,
        Double Lo <double.lo@cypress.com>, briannorris@chromium.org,
        linux-wireless@vger.kernel.org,
        Naveen Gupta <naveen.gupta@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>, mka@chromium.org,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        netdev@vger.kernel.org, brcm80211-dev-list@cypress.com,
        Douglas Anderson <dianders@chromium.org>,
        linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Franky Lin <franky.lin@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 0/3] brcmfmac: sdio: Deal better w/ transmission errors waking from idle
Date:   Mon,  3 Jun 2019 11:37:37 -0700
Message-Id: <20190603183740.239031-1-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series attempts to deal better with the expected transmission
errors that we get when waking up (from idle) the SDIO-based WiFi on
rk3288-veyron-minnie, rk3288-veyron-speedy, and rk3288-veyron-mickey.

Some details about those errors can be found in
<https://crbug.com/960222>, but to summarize it here: if we try to
send the wakeup command to the WiFi card at the same time it has
decided to wake up itself then it will behave badly on the SDIO bus.
This can cause timeouts or CRC errors.

When I tested on 4.19 and 4.20 these CRC errors can be seen to cause
re-tuning.  Since I am currently developing on 4.19 this was the
original problem I attempted to solve.

On mainline it turns out that you don't see the retuning errors but
you see tons of spam about timeouts trying to wakeup from sleep.  I
tracked down the commit that was causing that and have partially
reverted it here.  I have no real knowledge about Broadcom WiFi, but
the commit that was causing problems sounds (from the descriptioin) to
be a hack commit penalizing all Broadcom WiFi users because of a bug
in a Cypress SD controller.  I will let others comment if this is
truly the case and, if so, what the right solution should be.

There wasn't a good resolution on v1 and it's been a while, so I'm
sending out a v2.  Other than changing patch #1 to a full revert, the
only other changes here are just to the patch descriptions.

Changes in v2:
- A full revert, not just a partial one (Arend).  ...with explicit Cc.
- Updated commit message to clarify based on discussion of v1.

Douglas Anderson (3):
  Revert "brcmfmac: disable command decode in sdio_aos"
  mmc: core: API for temporarily disabling auto-retuning due to errors
  brcmfmac: sdio: Disable auto-tuning around commands expected to fail

 drivers/mmc/core/core.c                       | 27 +++++++++++++++++--
 .../broadcom/brcm80211/brcmfmac/sdio.c        |  9 +++----
 include/linux/mmc/core.h                      |  2 ++
 include/linux/mmc/host.h                      |  1 +
 4 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.22.0.rc1.311.g5d7573a151-goog

