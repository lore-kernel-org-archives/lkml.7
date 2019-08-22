Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9274C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCD0214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EiLc/GcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbfHVHQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 03:16:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45442 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfHVHQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 03:16:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id o13so3004694pgp.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 00:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JK3L3Hqr/8Xg50nCZ0FXXSpFdZR5QIulIGOZeZmHggM=;
        b=EiLc/GcU7XZnILAvYq1syTuw0MukalyQvUnG3R9+KnXPUHbxmvq8l/yoahVRd/i7Fm
         xjlcu/r8TwyjjjJNu4MGy2E5xIBVCQUtqmzBZFkEjJne0wFk9Cr+NkkQr3zpj4js4Q4E
         UwECKoGeBLp+bUtI5kXQFVSEFsidPCBiJom0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JK3L3Hqr/8Xg50nCZ0FXXSpFdZR5QIulIGOZeZmHggM=;
        b=THxmx0Ig0cim9lpDTPMaCW6VIYn8969wCabtoZAdC/IKCEmT2LBUXfSC9mwDecv36c
         ln8FDGRBABepxdszanqlxVOqEY2BeTqmBV6phg+qu7xkSBu3VmtgB9Hh/jRv8pCcsAMI
         wR+QY4uhpGBxWcrLJ6/mLQI4mNyRztzN7aA2U4klNOcjyvZijZTvoHwlpgl3MAjFI4MZ
         nz1t/KiKn6YncW299gjoJ5no08FCbDepKp15O70oy3kbDcOKfTvRsRjtp6n/WNjPDks/
         2Y3rwIiHA6WgcsTpC9SKkMCjXMHoGCtN3AGUYWzSXyNWTV/65SaHQA5boZ7965s8A7ss
         3fdA==
X-Gm-Message-State: APjAAAWmd3xD9kdmifmDhOwPklaTQj2ibnhgFZy66wNJA1fcDAp9R+j+
        9GFIbUU1h1URr/EsXDZ0Kk+Vvg==
X-Google-Smtp-Source: APXvYqzgiOjQYo8YhmIX8UhyIea+1X8EJIUFpmdSU2TcnCh1KEfDPRymW8ekcY4pLeiuHvSePR5xsw==
X-Received: by 2002:a65:6497:: with SMTP id e23mr31338387pgv.89.1566458185379;
        Thu, 22 Aug 2019 00:16:25 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id w26sm30233450pfq.100.2019.08.22.00.16.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Aug 2019 00:16:24 -0700 (PDT)
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
Subject: [PATCH v9 0/3] add support for rng-seed
Date:   Thu, 22 Aug 2019 15:15:20 +0800
Message-Id: <20190822071522.143986-1-hsinyi@chromium.org>
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
 drivers/char/Kconfig                   | 10 ++++++++++
 drivers/char/random.c                  | 15 +++++++++++++++
 drivers/of/fdt.c                       | 14 ++++++++++++--
 include/linux/random.h                 |  1 +
 9 files changed, 66 insertions(+), 23 deletions(-)

--
Change from v8:
* Add a new interface add_bootloader_randomness
--
2.20.1

