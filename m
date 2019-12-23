Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDCCC2D0D0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 16:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660292073A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 16:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QeposXQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfLWQfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 11:35:53 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:36964 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfLWQfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 11:35:53 -0500
Received: by mail-wr1-f49.google.com with SMTP id w15so4574281wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 08:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6pYALjvCMONqPlKDdfwUfxSZqlLUSb8zwcvL/ighjfc=;
        b=QeposXQXkhj29XcZaTg19lPt95+VRwICWCIHRIUV17SKXN9vNqUfOATigRv3DO4zTI
         NPfzlSctWIqyUiV7iR1sEvmj7G/f/4B1Esw/H7Z23M9OWtCqc5VpRD4nTNDp4Ks0jWgs
         2UR1naPPgcyNcZE6RWA0iEbF8TV0fluMyoERI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6pYALjvCMONqPlKDdfwUfxSZqlLUSb8zwcvL/ighjfc=;
        b=U3iGD3JpvwM508hZbOk4xc6ASJCo0MvDIAbUTWSm+FD/myNnGTy5owCsHLBK3CO7Oz
         B9jcDx26FJwmPm0oUphW0+o8BBT/VJCtlJe1Oq1JCE33bOKT57KxL03zfQHcS8vOU9ZL
         K7GEcwGHgucBuDaPD+A8xcPLDQNZXJePpfACPXNsAFFK5k/y5d702eybXIfsvse2GbRh
         TFdSAx4kcVm2SXakqj20q3nEACAmkFHUmLD81diUgkQomVem4EVr+4vRk8DQm5obh/9A
         4VyimDUWuW+0LhBDcvnJnbQ3sbKWRdpUcDfOJ/0E55D9jbdTgvAst0LP4XXkct687yje
         vulg==
X-Gm-Message-State: APjAAAWD+tMpkfNxtzsFcIyD4YeNhiNt8Aiy1fVQFeGFXOM/jymRm64b
        o/yxhdLhrcs4FXtMfSF08L3RFA==
X-Google-Smtp-Source: APXvYqx6phOTxFluVkbXRrN7JXc5+NhmvV4f/omDkOTdewNBC0PpQPfOtn+hhlM6OPsEf2czRVf39Q==
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr30584003wrq.396.1577118950458;
        Mon, 23 Dec 2019 08:35:50 -0800 (PST)
Received: from localhost.localdomain ([37.160.152.81])
        by smtp.gmail.com with ESMTPSA id s8sm20412498wrt.57.2019.12.23.08.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 08:35:49 -0800 (PST)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org
Subject: [PATCH 0/3] Engicam icore fixes
Date:   Mon, 23 Dec 2019 17:35:43 +0100
Message-Id: <20191223163546.29637-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix ethernet in imx6dl-icore-1.5 mipi developent kit. Adjust ethernet
reset in icore boards

Michael Trimarchi (3):
  ARM: dts: imx6dl: Fix typo in i.CoreM6 1.5 Dual MIPI starter kit
  ARM: dts: imx6dl: Remove duplication in Engicam i.CoreM6 1.5 Quad/Dual
    MIPI
  arm: dts: imx6qdl: Move the phy reset at device level

 arch/arm/boot/dts/imx6dl-icore-mipi.dts  |  2 +-
 arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi |  2 --
 arch/arm/boot/dts/imx6qdl-icore.dtsi     | 15 ++++++++++++++-
 3 files changed, 15 insertions(+), 4 deletions(-)

-- 
2.17.1

