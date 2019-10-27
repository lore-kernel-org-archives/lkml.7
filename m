Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1C8CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D54B21726
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211428;
	bh=txFVa3o1tO0XS4afHK4M0KfRj3uMT4moVpCZDTRCnuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zTt07SjJa/2AbEuh/9JS9MSVCNoJcyYXlvoDUwMTi9FKinWFMKwTyWTcDkuIl/fD4
	 2renaa26k/V5uuw2iJLU9OVRCA3ObqgqGEyTvUaLGocj+9JlC7pY2k6rSN9dYUdKHQ
	 UPOgHVfGnE9JiCWr+W54kBS4jH28FH0M9IqEHufM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731758AbfJ0VXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:23:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731704AbfJ0VXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:23:31 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1ED0205C9;
        Sun, 27 Oct 2019 21:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211411;
        bh=txFVa3o1tO0XS4afHK4M0KfRj3uMT4moVpCZDTRCnuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=toZ10yMHw7FOdT58aXlKPLd4MpdK+BSI+A1ACI8JlWqFzlZI3XSFtY4QlOqBkiqjO
         SAMFN911EWUz+5uODWqo5Bs0au8VHblTTnv/u6nx/gAS8ETnwZaGLOq5Tj4L+wFXeh
         eLFp64ddHgq/Cc1qxb+XMmGBD66bYc+PdQ40MX8k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Faiz Abbas <faiz_abbas@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.3 143/197] mmc: sdhci-omap: Fix Tuning procedure for temperatures < -20C
Date:   Sun, 27 Oct 2019 22:01:01 +0100
Message-Id: <20191027203359.418304808@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Faiz Abbas <faiz_abbas@ti.com>

commit feb40824d78eac5e48f56498dca941754dff33d7 upstream.

According to the App note[1] detailing the tuning algorithm, for
temperatures < -20C, the initial tuning value should be min(largest value
in LPW - 24, ceil(13/16 ratio of LPW)). The largest value in LPW is
(max_window + 4 * (max_len - 1)) and not (max_window + 4 * max_len) itself.
Fix this implementation.

[1] http://www.ti.com/lit/an/spraca9b/spraca9b.pdf

Fixes: 961de0a856e3 ("mmc: sdhci-omap: Workaround errata regarding SDR104/HS200 tuning failures (i929)")
Cc: stable@vger.kernel.org
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-omap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -372,7 +372,7 @@ static int sdhci_omap_execute_tuning(str
 	 * on temperature
 	 */
 	if (temperature < -20000)
-		phase_delay = min(max_window + 4 * max_len - 24,
+		phase_delay = min(max_window + 4 * (max_len - 1) - 24,
 				  max_window +
 				  DIV_ROUND_UP(13 * max_len, 16) * 4);
 	else if (temperature < 20000)


