Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32946C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003122177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="G0hT4HBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfCMOKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:10:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33006 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfCMOKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:10:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id i8so2185824wrm.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 07:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Om43o3QGlbzQeBRSo4/K8t97wwo+604Xu/lrnbkUV6U=;
        b=G0hT4HBM9kOji92JSSQnQY5hQYBt5SxbRBvSwNZJIf9gY3mDuhquZzgqsVSK2sGf/Z
         +r94dK1EF7IJlOYZNtPderfGb20LydJQNLHtt5FbSgRaGlgqXKy+Px7KUUeCUyg400XA
         dL1HtOGJItIC3bfHIHUtIc+C2QoLNMBtBgA9Bauh5pYw0QXmPNawTKCSyu/f1Uq0Mvgf
         DiD1yrChR/HyL23fDZPB1O2ThdQiZuGweP2gcasnq8jkHoas/irObXvU4n4TAQpkxOma
         NTNcP1ExjvRAnaVei++Rsk/mUS2RHSNa+/0795GKMp8Y5xnyNhwh2m/qw6yNyReGDBQC
         C7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Om43o3QGlbzQeBRSo4/K8t97wwo+604Xu/lrnbkUV6U=;
        b=RiC3dmESBMu02wxzaUTRzMvjPA7V/5R4WqWdHkm2l7m0MQ1oss+xhr5Yw3fQIYW1TA
         fbpQVcQjwZgDiaxqK5zG+rfr5oNiyLR7ig+IYFmjt9rrwkDTGPRcdWEl2PmWzF5fqWXQ
         hp1a+lQlpIe13OrX9URbnR47pFnMqicB/h4/m+ELD4DB6yHUdFG9XfEG5gYkNq13L8mE
         ua0B2fd9YCkMp1DZgoyhZOyYmbSrtmPlrKw2YRRjH2QaUU79BOY64/qw0NWTD22PH0y8
         ODoiSpDc6OIF4ldOqQAkGtb9nZmGWoAv+TXka/3pYcaExYYp4EU08P/Xpe4jQVg+7htq
         Nx6Q==
X-Gm-Message-State: APjAAAVZTsvyCewXW3ey3wVfJWK87XisNiNCUNbVeuQMcASCI+azjDKz
        aEUg/7Rwe8jdvzRxvVhX4w/e/g==
X-Google-Smtp-Source: APXvYqz6rOCst2JaCzL9Yit5kUCMRU/5sLK8apQuVakVpx/da7nsKl+nl9Z70YR/pSRWFxHL7S8D2A==
X-Received: by 2002:adf:efca:: with SMTP id i10mr27846110wrp.265.1552486233005;
        Wed, 13 Mar 2019 07:10:33 -0700 (PDT)
Received: from localhost.localdomain (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id u17sm37300087wrg.71.2019.03.13.07.10.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Mar 2019 07:10:32 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] dt-bindings: meson: Add G12A display bindings
Date:   Wed, 13 Mar 2019 15:10:27 +0100
Message-Id: <20190313141030.5958-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the G12A specific bindings for the Display VPU
and VPU Power Control.

The Amlogic Meson G12A Display module is based on the Meson GXM SoC
with an updated Plane Blender, thus VPU architecture and interconnect
is the same.

Implementation then DT nodes will come in a further patchsets.

Neil Armstrong (3):
  dt-bindings: display: amlogic,meson-vpu: Add G12A compatible and ports
  dt-bindings: display: amlogic,meson-dw-hdmi: Add G12A compatible and
    ports
  dt-bindings: power: amlogic,meson-gx-pwrc: Add G12A compatible

 .../devicetree/bindings/display/amlogic,meson-dw-hdmi.txt     | 4 ++++
 .../devicetree/bindings/display/amlogic,meson-vpu.txt         | 4 ++++
 .../devicetree/bindings/power/amlogic,meson-gx-pwrc.txt       | 4 +++-
 3 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.20.1

