Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE96C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3228206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HWnloX5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfEGVyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 17:54:22 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43711 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfEGVyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 17:54:22 -0400
Received: by mail-pl1-f196.google.com with SMTP id n8so8828496plp.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 14:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T8iPOh43LeF/Se1Y76x73AwSuweJCr7k4OGy4sOIQEw=;
        b=HWnloX5ezxx1+FCdhKHjIgkqobYpi3WYwACg2K5hiq9SrdKkWWHLiShB6IYEB+SpKB
         2jSsU9cMH80QAzcv5ZTzBNo2TyOddHfuWc+okSAz1zq3oq0b1OBiqXOJ2dfuEFEQoYZF
         64Db0DQFhoMW1KjqVs6oA21JkkS/e+XEQ92s8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T8iPOh43LeF/Se1Y76x73AwSuweJCr7k4OGy4sOIQEw=;
        b=BS+zWhCPkvt3m4HnJmrY3r7jr+1tGPM7qyH3fI5+15BbCVy0QBOqSgd/HzCksbAUaI
         9fWZDutPZ1nfms2cSz8+Clv0Hm1Ube1/yQAtkaJ+tcObboO1UdyJSWj465lifmRWnRZB
         is3bgJIc98wE1U1hNDN502qH0Hvx9+cvvVgZIfP/FFPbpS12fOZ//EIuiRMxfgadVqFf
         q8r60KwVrsCKO+0nwGPcudYXRyMxDgTrmbI2kixmU4Onh0sU9x1GfjgRC9W5EpHHOqn4
         ifYnKLaSByYVdT7mi8Y1AREqOvvgl3vbKvF3DRhu0DyqX31haccgHWxhrbFTXcMpFnBw
         fgaQ==
X-Gm-Message-State: APjAAAUFi43MLezGfIheEH9JZxLiz+xM22MX3OBhbf6jxu/UvLcq9jo+
        yqI2cHf8m3dFXBBiMu+/4CvrDQ==
X-Google-Smtp-Source: APXvYqymdg/V3cUAtSSzvdjSrSl09Rw6XIzWsSApCyPQBtsTfbAja4SLC0nfRvUkdcksymC3eMeAGA==
X-Received: by 2002:a17:902:7047:: with SMTP id h7mr43645697plt.177.1557266061649;
        Tue, 07 May 2019 14:54:21 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id 19sm36854191pfs.104.2019.05.07.14.54.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 May 2019 14:54:20 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Naveen M <naveen.m@intel.com>,
        Sathya Prakash <sathya.prakash.m.r@intel.com>,
        Ben Zhang <benzh@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Takashi Iwai <tiwai@suse.com>, Jenny TC <jenny.tc@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jie Yang <yang.jie@linux.intel.com>
Subject: [PATCH v2 0/2] ASoC: Intel: Add Cometlake PCI IDs
Date:   Tue,  7 May 2019 14:53:57 -0700
Message-Id: <20190507215359.113378-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This small series adds PCI IDs for Cometlake platforms, for a
dazzling audio experience.

Changes in v2:
- Add CML-H ID 0x06c8 (Pierre-Louis)
- Add 0x06c8 for CML-H (Pierre-Louis)

Evan Green (2):
  ASoC: SOF: Add Comet Lake PCI IDs
  ASoC: Intel: Skylake: Add Cometlake PCI IDs

 sound/soc/intel/Kconfig                | 18 +++++++++++++++
 sound/soc/intel/skylake/skl-messages.c | 16 +++++++++++++
 sound/soc/intel/skylake/skl.c          | 10 ++++++++
 sound/soc/sof/intel/Kconfig            | 32 ++++++++++++++++++++++++++
 sound/soc/sof/sof-pci-dev.c            |  8 +++++++
 5 files changed, 84 insertions(+)

-- 
2.20.1

