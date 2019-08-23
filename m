Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE02C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 06:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8E72070B
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 06:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dh+RaFUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391329AbfHWG1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 02:27:18 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39321 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731346AbfHWG1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 02:27:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id z3so5000795pln.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 23:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GhjRfjhMwINY908SCrXL1aDBLnxIvIs4Y71zc0rRgRU=;
        b=dh+RaFUCw0uw79iT30CYn2FWwnL24m0shKCCYpFZVygUMcYvPN83NN7ROJNqa3sh3P
         4CvH9sJoWVNk5/JHKRogK6iczeRLwh2qeDj1pX8wfj5lYpWuQcsVx1/PB6hyw20ySi1r
         QeuQixRWgAV0BmcQMikTTokcwuFWkKCO2HDRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GhjRfjhMwINY908SCrXL1aDBLnxIvIs4Y71zc0rRgRU=;
        b=pcibJr2WqIotpIvWYV/BbU5Z+9aHiY1/ZH06dGrQpc1PNuO83Y6E50drw/+3aEEcSn
         44KqEo8Cm3t6BrnGwb2Jr3DhMDKHCoJ52Fp1tXIvcLizqws8Y92RTFnmQHwMhbWVKWaY
         o+mk/kx77HcyOd9+6N8zwFT3T4nEfhGPYn07HAILPlqov91jJTZckvqSskxqZ/ORQUNl
         6z09aB09yh5AKAz4ABlmADhgIN0khKj35R6eEnrW69iAvZ8lY4X9m967UrYaEd6Ehmy7
         aWtjPqijj34ys+k+XAhT+9sJJ/wHgy6x9LiwQkjHqnF9wtHFy7bZfl7PEUFBtm9w31tK
         dP0g==
X-Gm-Message-State: APjAAAWBPZCbiSsy1aT0/vp8I8bPJsIdkNsyUUpXoVc4kzfNwTWb7I7s
        EdMCf22hF2aNYqSS285agB2MOw==
X-Google-Smtp-Source: APXvYqxsGxrRqSSIoxb1SULucqZZIslLOBDGEU9/wOXaFvOn3E0EpM+vtjgQYhxackVeD+CPnWS7YQ==
X-Received: by 2002:a17:902:9b8f:: with SMTP id y15mr3055556plp.194.1566541636820;
        Thu, 22 Aug 2019 23:27:16 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id q13sm2139671pfl.124.2019.08.22.23.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Aug 2019 23:27:15 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org,
        "Theodore Y . Ts'o" <tytso@mit.edu>
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Li <liwei391@huawei.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Waiman Long <longman@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Grzegorz Halat <ghalat@redhat.com>,
        Len Brown <len.brown@intel.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Yury Norov <ynorov@marvell.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Mukesh Ojha <mojha@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 0/3] add support for rng-seed
Date:   Fri, 23 Aug 2019 14:24:49 +0800
Message-Id: <20190823062452.127528-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing a chosen node, rng-seed, which is an entropy that can be
passed to kernel called very early to increase initial device
randomness. This can be used for adding sufficient initial entropy
for stack canary. Especially architectures that lack per-stack canary.

Hsin-Yi Wang (3):
  arm64: map FDT as RW for early_init_dt_scan()
  fdt: add support for rng-seed
  arm64: kexec_file: add rng-seed support

 arch/arm64/include/asm/mmu.h           |  2 +-
 arch/arm64/kernel/kaslr.c              |  5 +----
 arch/arm64/kernel/machine_kexec_file.c | 18 +++++++++++++++++-
 arch/arm64/kernel/setup.c              |  9 ++++++++-
 arch/arm64/mm/mmu.c                    | 15 +--------------
 drivers/char/Kconfig                   |  9 +++++++++
 drivers/char/random.c                  | 14 ++++++++++++++
 drivers/of/fdt.c                       | 14 ++++++++++++--
 include/linux/random.h                 |  1 +
 9 files changed, 64 insertions(+), 23 deletions(-)

-- 
2.20.1

