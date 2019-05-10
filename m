Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65726C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3708F217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ETEZBKP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfEJWjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 18:39:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41159 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfEJWji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 18:39:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id l132so3929789pfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 15:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xq1TpWdwTDp+vPr9dbSF7ibV0/5bhRTpDmSdefETpPs=;
        b=ETEZBKP8eV+KAtuYVJR87nKOwtbsH1T4CVkJShS5AlHxEAKWOFe1ChqZRhLq8qFsMr
         RbAyFSpHkFqVhw8m5nHAhvswwsJd7oP5twzJWaRlLmYiIkKunPYOSyCQWBL8vM8TVO0u
         EAEieXP5ZqLVl+SdDL0ZsgPOSbj8/K2AUlRgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xq1TpWdwTDp+vPr9dbSF7ibV0/5bhRTpDmSdefETpPs=;
        b=lpPyXSfydmDw+Xdk5TVZjM+cYAt3tli+9FRX9OiRwlGilFU1QIE7BU7wsvED/9IdJg
         DdnsrExUQekFsoi9b38Eh6rZZLUSNb8y5NHrg8EG1qhMiRwUYDyod9vRr4g9TmxdamtA
         zGlFVbrHh0MyM3JM9i3htFzs7IY7TPD3IVNw8+iwa7rH2Q68CFdblfwRGzVYky3MME/A
         3kNclGqXoaJnyfMdIMvhRkIsbrGuN/QzgXdjAQ5TLXj6GFlN1ugDcLVSRq5N7cQzJmgx
         uSkkmKNZXDYsto2yZ1mmzew7zmYzaGbwWQbH0B9042VKQ42wbjV84nvvq254AhFELnIC
         4jgg==
X-Gm-Message-State: APjAAAUe40iDwZ+0YTC/TtCYSv3y8cpnL7aSMJioazDhjU8p4/NANwH9
        XSyx0qVBX+GLFy9lQVeExW+Xnw==
X-Google-Smtp-Source: APXvYqyRS+XRwoalvlFcJf99Yk4/x47QLraCe/Go1TtMh7YgQMUXhQBX3eabXg/Gd4jvAvDCFASbzQ==
X-Received: by 2002:a62:5103:: with SMTP id f3mr18196839pfb.146.1557527978098;
        Fri, 10 May 2019 15:39:38 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id u66sm13300540pfa.36.2019.05.10.15.39.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 May 2019 15:39:37 -0700 (PDT)
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
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jie Yang <yang.jie@linux.intel.com>
Subject: [PATCH v3 0/2] ASoC: Intel: Add Cometlake PCI IDs
Date:   Fri, 10 May 2019 15:39:27 -0700
Message-Id: <20190510223929.165569-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This small series adds PCI IDs for Cometlake platforms, for a
dazzling audio experience.

This is based on linux-next's next-20190510.

Changes in v3:
- Copy cnl_desc to new cml_desc, and avoid selecting cannonlake (Pierre-Louis)
- Don't select CML_* in SND_SOC_INTEL_SKYLAKE (Pierre-Louis)

Changes in v2:
- Add CML-H ID 0x06c8 (Pierre-Louis)
- Add 0x06c8 for CML-H (Pierre-Louis)

Evan Green (2):
  ASoC: SOF: Add Comet Lake PCI IDs
  ASoC: Intel: Skylake: Add Cometlake PCI IDs

 sound/soc/intel/Kconfig                | 16 +++++++++++++
 sound/soc/intel/skylake/skl-messages.c | 16 +++++++++++++
 sound/soc/intel/skylake/skl.c          | 10 ++++++++
 sound/soc/sof/intel/Kconfig            | 32 ++++++++++++++++++++++++++
 sound/soc/sof/sof-pci-dev.c            | 28 ++++++++++++++++++++++
 5 files changed, 102 insertions(+)

-- 
2.20.1

