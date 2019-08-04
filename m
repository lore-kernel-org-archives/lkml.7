Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E945C433FF
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 20:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE252070D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 20:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="udRZwvBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfHDUh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 16:37:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39379 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfHDUh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 16:37:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id u25so60740367wmc.4;
        Sun, 04 Aug 2019 13:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=614oQfNECnBl76zZMuP6DD7lsJ4uFIehr7gg2GuUSuc=;
        b=udRZwvBy56EHj8w5FiQd5HmvHtoeIayI3x/yvR6sDJ+Ewn7z6yi6mu6NWlwcZAmS8D
         WtiBRgG2YRRcKwLv9ELIX1/WwhbIuGA3JDAmeEeDqydM0Qigb41mROG+XqaZs6JgDKeG
         aZiHbcZzbbtS3Wdmk4sivf6kI0cuBaeOc/0YiFZYn2QEy71YOfDiE0YTlvXUHcoKXwga
         yqY9MZsRA5iUHQvgvqyw31kKMRL5MRmOT8Ub3f3s79jEmAj0QJagrIvlYSpnyA6irJRo
         tY+ILDpiR09VHgcAF5dmquq+hnRhMYccvKffAcSmQB+ZW+z04xOzeor4jZU8bKwMAdFP
         vauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=614oQfNECnBl76zZMuP6DD7lsJ4uFIehr7gg2GuUSuc=;
        b=pphna/jYAuwTopmwpiDJVYAfrsQits0d1rFDQPSxZSGiw5HDN845vR5LpHZ1+raJ6C
         5OjVB4KjhKBDSUahKrqLtLXPj5V+RLX/QKpHNWW4fbnCwO436259geUR6IspVVooJcD6
         GY9BkwnGI/56HcoJpV0qyOhnNzqpkbyTMz9PAo6pP+TpDce4BkbalJUcqft1kYN34mDu
         AenWoughFsReyaktXJb5GMuZNSPBsIe8HTRT7ZiMCKyaClvAainHYmpND9wEssFSzbAy
         hapqp454xHytnKyv8fhGwDlrWB4zOQpTF6BTTy0ld3BCMEE6b1acKBjI5yfWMBFDncLB
         zPMQ==
X-Gm-Message-State: APjAAAU/rHir25pqAH7SIWM0+0/exJ28gLXSInbABnrfwDcE251XTwj+
        SeZiljmsDS53wuXdoqzJdVY=
X-Google-Smtp-Source: APXvYqxWQqaUp9OfLwLuDJf120aVTFuhjtTQ9WayyTg2GRXAT9S11eHNFLdnTlvX3jYer7/a2+NswA==
X-Received: by 2002:a05:600c:2146:: with SMTP id v6mr14194434wml.59.1564951074997;
        Sun, 04 Aug 2019 13:37:54 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id v16sm75542601wrn.28.2019.08.04.13.37.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 13:37:54 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] drm/tegra: dc: Turn off and reset hardware across suspend-resume
Date:   Sun,  4 Aug 2019 23:37:02 +0300
Message-Id: <20190804203702.16073-1-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drivers core bumps runtime PM refcount during of entering into
suspend to workaround some problem where parent device may become turned
off before its children. For now CRTCs are only getting disabled on
suspend and in order to actually suspend the display controllers hardware,
the runtime PM needed to be "forced" into suspend mode.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 4a75d149e368..6c8f5222d558 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -2572,6 +2572,8 @@ static int tegra_dc_resume(struct device *dev)
 
 static const struct dev_pm_ops tegra_dc_pm_ops = {
 	SET_RUNTIME_PM_OPS(tegra_dc_suspend, tegra_dc_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 };
 
 struct platform_driver tegra_dc_driver = {
-- 
2.22.0

