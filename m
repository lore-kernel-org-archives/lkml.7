Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C094C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7834205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HgPIxNQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfEFWxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 18:53:53 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:36811 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEFWxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 18:53:53 -0400
Received: by mail-pl1-f177.google.com with SMTP id cb4so3173371plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 15:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1G76/DxVX8XerrNaCDJMZeudedstwh/R3GkpjdOBYaU=;
        b=HgPIxNQoQ7WPi8RBCI5jFsPgd1973w+K+pCqvgkEMJ6Eah1Fj4wiL883e6jIIfFwkZ
         oD2jHsyCGWUnyaRJVSKniXM1V9+CIRKx6389ym/P+/Tgk3/5i+eCJE0/SW9aSGmb0ca3
         6GeBhCV2odpQVKuIpNewx63ojFQGWVf6hv1MI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1G76/DxVX8XerrNaCDJMZeudedstwh/R3GkpjdOBYaU=;
        b=k77I4x4hBAPOk57jOlJ93XqD9kuNJj9xC4i1/lbx4Gm+PY6voir/KntRZQKcPYKRfv
         Eroad4h3AWN7j1KqlipACAyEUreox0SPMPaUGtcTtpxuZDNPNl98aa24R3rLRA4S58WK
         If4qHMp9i60X3kkvDGkKvOw/6jXnv9m97liIC2O1PP7oAenh48KVj/lzeYF61kulAp74
         SXx2yCj/YrIPkwrn3Jgkq6lYbW8Mo0311SZLNMvygfGZCZm5mFhYK7Huw2DP+QrX9ETp
         0J7t0ntBH5QGJHkjlOFmWLYjOAgM0x8wbeXu1XZxozowS7imkc0Q36XosFDl9iYaZaTJ
         qi0A==
X-Gm-Message-State: APjAAAVcchnXbhsCAoG9oJH79yYYRHpRS5/BL+N7zy1Ss+JP4B2vCPfj
        qSBDB0F6mn32XE0hBAu+r5veFg==
X-Google-Smtp-Source: APXvYqw+uLEtzDx68/COSJ+nWC5ZbK9OR4doJuY4FqNoViZrmKJ07/lsqeABZjsIVq7jsMMxrNh8Mw==
X-Received: by 2002:a17:902:bc85:: with SMTP id bb5mr36085795plb.310.1557183232854;
        Mon, 06 May 2019 15:53:52 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id i15sm16052204pfr.8.2019.05.06.15.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 15:53:51 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Naveen M <naveen.m@intel.com>,
        Sathya Prakash <sathya.prakash.m.r@intel.com>,
        Ben Zhang <benzh@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, Jenny TC <jenny.tc@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jie Yang <yang.jie@linux.intel.com>
Subject: [PATCH v1 0/2] ASoC: Intel: Add Cometlake PCI IDs
Date:   Mon,  6 May 2019 15:53:19 -0700
Message-Id: <20190506225321.74100-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This small series adds PCI IDs for Cometlake platforms, for a
dazzling audio experience.


Evan Green (2):
  ASoC: SOF: Add Comet Lake PCI ID
  ASoC: Intel: Skylake: Add Cometlake PCI IDs

 sound/soc/intel/Kconfig                |  9 +++++++++
 sound/soc/intel/skylake/skl-messages.c |  8 ++++++++
 sound/soc/intel/skylake/skl.c          |  5 +++++
 sound/soc/sof/intel/Kconfig            | 16 ++++++++++++++++
 sound/soc/sof/sof-pci-dev.c            |  4 ++++
 5 files changed, 42 insertions(+)

-- 
2.20.1

