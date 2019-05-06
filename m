Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F28C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930362087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IJoGSDvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfEFRBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:01:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46770 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfEFRBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:01:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id j11so7067558pff.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 10:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ceVsLMW4pfAgwTpw+rjemHyYbwaBaIjRgX4iRGavJHw=;
        b=IJoGSDvYrsZ99JwAf7C6iZ2JWVjNHgQibe0U3pb8+t/jqt6kk6G/+6PxzM9g7rboPM
         QGSnG11S94h9GKIwo7c0Sn1l4/8RnlREfgdA1GIu7Y2tYGNXrhTlJ5oPJlCzsQJXnQnk
         m5+54t8FOV9jzC0zJdF7MtqG6cLSntjJs40Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ceVsLMW4pfAgwTpw+rjemHyYbwaBaIjRgX4iRGavJHw=;
        b=XZw6zom+edcjuLItwLJoGpVakDizfEdi4YQpK8izlRrh/gplcIyjyFz0vaHULS1ttf
         qanrlbXXbLuQOyBe0mOSqeMXSZaqYBiWqDx9wCnHnjW5VXTIFhdQm6pH/CDk2E3JmtdT
         TooqQQ4cqETjn1ddnnHDjA6O+uLviykp0cu3f7xozuWP89fyxqB52Xa5ULrD7Y2eQEPU
         J4uba1Ux+wnx7QpK/70OoxexlWCP7uIssK4eZx3vto1Nmtpo/kxsAjKp8KnOuGGRbikp
         uwhzfbZhmtu9bxO8WZam/Ca8MYYFDFwerLLjvllXrZlF5PLa4N9F75ewStErSB9bIzHQ
         NeSw==
X-Gm-Message-State: APjAAAWD/EfaRDHiwpMt80PXf/5UJQ7Ptp+zPpwGV7z3F8AgR2GnL+8d
        yUn2BtmGCopwWfzauuI2eaqU4Q==
X-Google-Smtp-Source: APXvYqw/1HqR1LsbVe6kB0/Yd+43VTyRK/c5VjhNsOI8oAj0vDaiRaaZ9GTE0t03D4ztVzojI9HfiQ==
X-Received: by 2002:aa7:9214:: with SMTP id 20mr34245323pfo.202.1557162091742;
        Mon, 06 May 2019 10:01:31 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l23sm4555644pgh.68.2019.05.06.10.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 10:01:30 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH 0/2] mmc: sdhci-iproc: fixes for HS50 data hold time
Date:   Mon,  6 May 2019 10:01:13 -0700
Message-Id: <20190506170115.10840-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes data hold timing issues for various sdhci-iproc
ip blocks that do not meet the HS50 data hold time.  NO_HISPD bit is set
in quirks.

Trac Hoang (2):
  mmc: sdhci-iproc: cygnus: Set NO_HISPD bit to fix HS50 data hold time
    problem
  mmc: sdhci-iproc: Set NO_HISPD bit to fix HS50 data hold time problem

 drivers/mmc/host/sdhci-iproc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.17.1

