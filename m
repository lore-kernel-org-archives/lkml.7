Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC01C4320D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20CB214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="va8yIct1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731706AbfIYJwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 05:52:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42030 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfIYJws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 05:52:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id z12so2898119pgp.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 02:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TV3RT1yNKXy5j0AoE4e6keZibU6Zrl0Z4HmWZXehpjw=;
        b=va8yIct1jAIbfCuT/3sEP4exm22IQ2TSwWZP2+TsQD7Czgf2QXVgxepvptPTgLoifq
         5r/FRHyIQOdjDoO5V+eirOa4qQ5m5BXLaK0Jc+RM6BD8Edgv9isDVFsB3SwVDyL/+8mW
         s6axDG4Eti4ok2rYzMLd/40V9QkKJEHTx+7q/KUEWYKzi84PeWgSjNOMUYp2EGX7VEdn
         daIsmeq4cDoSg85xqv9HhaCnxKuPz2KJBDNiSb8+6It47l89jyS3m7xe/EhL8qnfHRx7
         JJnNtE22qP4BEFxoOCaOPhlXs2Wh8b8y8tYKZda6+/4/ZMa0oNQbDPQcjzVrutR+SOFO
         IuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TV3RT1yNKXy5j0AoE4e6keZibU6Zrl0Z4HmWZXehpjw=;
        b=lkT5yse2IS0pOrBi+87DFDvkmnDxvn4e8OCXQVkm9ch3nA3U5+Qo53U6IVfGWBk/f5
         VV9NR66eDm7bGsoMKvZutrqIh1KYoceh6SXToxBl7M5iB9tntpW8BO3YU1ZMIqz/i+ao
         EghGG721jtMkHg+zwP6n+GCgDEbaz8VNVr/L0sSsRTB2U3+EKn8jVcl7PM56ZqSFy8hF
         33FeVXz3tU23Zok3XdZCnf62Ev8SZiyhk9aqHhcFe0jqrTk6ANrOqoo20bPkkjnARQG8
         2WpuRAaqE8QAWA/JdHKCVjYMg5iT3ON9ntP2c9VlrZfi1Ex500PtvKmcloYFUMMSg+DW
         4RGQ==
X-Gm-Message-State: APjAAAUz87T/3M0NP35jaV7+AUmDJV/RcDPS57lu7PPYNNTrue8kJjGB
        Qprew09yF2i1GrntqpTcBMKI4A==
X-Google-Smtp-Source: APXvYqxAi3M7mauapLMsR6LDIGh2upipMbm+6rwiwwDaLqwegdnLSJD1q1FWwqTsxI1Xn5NqnSB2mQ==
X-Received: by 2002:a63:d908:: with SMTP id r8mr8046960pgg.263.1569405167866;
        Wed, 25 Sep 2019 02:52:47 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p20sm4037221pgj.47.2019.09.25.02.52.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Sep 2019 02:52:46 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     stable@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        linus.walleij@linaro.org, natechancellor@gmail.com, sre@kernel.org
Cc:     longman@redhat.com, linux-gpio@vger.kernel.org,
        david@lechnology.com, linux-pm@vger.kernel.org, arnd@arndb.de,
        baolin.wang@linaro.org, orsonzhai@gmail.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.19.y 0/3] Candidates from Spreadtrum 4.14 product kernel
Date:   Wed, 25 Sep 2019 17:52:26 +0800
Message-Id: <cover.1569404757.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With Arnd's script [1] help, I found some bugfixes in Spreadtrum 4.14 product
kernel, but missing in v4.19.75:

513e1073d52e locking/lockdep: Add debug_locks check in __lock_downgrade()
957063c92473 pinctrl: sprd: Use define directive for sprd_pinconf_params values
87a2b65fc855 power: supply: sysfs: ratelimit property read error message

[1] https://lore.kernel.org/lkml/20190322154425.3852517-19-arnd@arndb.de/T/

David Lechner (1):
  power: supply: sysfs: ratelimit property read error message

Nathan Chancellor (1):
  pinctrl: sprd: Use define directive for sprd_pinconf_params values

Waiman Long (1):
  locking/lockdep: Add debug_locks check in __lock_downgrade()

 drivers/pinctrl/sprd/pinctrl-sprd.c       |    6 ++----
 drivers/power/supply/power_supply_sysfs.c |    3 ++-
 kernel/locking/lockdep.c                  |    3 +++
 3 files changed, 7 insertions(+), 5 deletions(-)

-- 
1.7.9.5

