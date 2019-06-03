Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91D1C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 23:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADBF266D2
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 23:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wq61tK1U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfFCX7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 19:59:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38785 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfFCX7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 19:59:46 -0400
Received: by mail-lj1-f195.google.com with SMTP id o13so17912721lji.5;
        Mon, 03 Jun 2019 16:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iLI33PWY4RayWc4+RDodbHUftFLrLjYjOlOE4x7nHGA=;
        b=Wq61tK1UIJMjPwtuP+c98memmM8swNGb9jNmWOhXSU+4lYcj3+Em7QOGXwJr1HTdkk
         URnQNWNCLJSIySBJE7ebjSarvuZlFuYone8LKn7IBChh84tJNZVDZlWF3vVvAMT/yoHb
         vaGa2yqE1VIX0fE+DGge5OqeeKIs1hAF2/GUFG6D+AVMnlvJAZw6eJkIDL/DfNHi4lt0
         5OA8s4rc9eE7A7sZo0KRaDEmYTd5MXvo0VXfiQxa0aUKaOXqRnDDg3hsqnDZLkcYWugP
         Zkyb19bMel+JNmB+LkptWtkbNePUCdVj0mXqgiqFKRTmy8CEgPmRPsHhPX5lW2AUxxJt
         LA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iLI33PWY4RayWc4+RDodbHUftFLrLjYjOlOE4x7nHGA=;
        b=XnrkZoCzap6tshP7XD8fLB3KdBpawgaBVCuX2Olxg+crHWumePjhz+A7KH7dZ/Rk30
         p7adUcy7hgnNmkMCIVxLHBGax/WDcbqEma2evQfrAiB4eh4KUogQKiYkFsOup6GpJKwA
         cxTPDJaNArdEMq6lu2BTIclPMLWCS2l+qDLhI8Sd3efvjDovks4hGOSu+BewGEaRkRKK
         E7bwbZxxca7bXaYubRGpxpcg8Ru0kHh5FZO3waAXSSTuVE2N3Dgp8OKAfTFypS9N9Mee
         0QAlTdQyjvzywpOs7ed3eEP/OsrmBuYSEblaC+yNOFiRI6SU0LHb0P/FG65xIM0hAPfQ
         CWvQ==
X-Gm-Message-State: APjAAAUrxy7dB1OrPNIIzNM39s5g94JNw4i5DvrhEtPaDK2wGGee6VAM
        WDp3eJCf3Z2Vuz5ufVk24kQ=
X-Google-Smtp-Source: APXvYqwBYDxdQDZQkSjquZc65ex4DkOMb/zSC9BckjTcjMAqmug2OlzDBADeydRy7AKhvMgxqXbNJA==
X-Received: by 2002:a2e:b04c:: with SMTP id d12mr179877ljl.218.1559606383862;
        Mon, 03 Jun 2019 16:59:43 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id n7sm2943151lfi.68.2019.06.03.16.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 16:59:42 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] Introduce customized regulators coupling
Date:   Tue,  4 Jun 2019 02:58:56 +0300
Message-Id: <20190603235904.19097-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series introduces a way of specifying a customized regulators coupler
which is necessary for cases like a non-trivial DVFS implementation. For
now I'm primarily targeting the CPUFreq driver of NVIDIA Tegra20 and Tegra30
SoC's to get into a better shape, such that things like CPU voltage scaling
could be supported. Both these SoC's have voltage-coupled regulators, one of
the coupled regulators powers CPU and other(s) power SoC peripherals. CPU and
each of the SoC's peripherals have it's own demand for a minimal voltage
(which basically depends on the clock rate), hence regulators voltage shall
not get lower than the minimum value required by one of peripherals (or CPU).
Right now none of peripheral drivers support voltage scaling in the upstream
kernel and voltages are statically specified in board device-trees via
minimum voltage values of the regulators. In order to implement a full-featured
DVFS, all drivers should gain support for voltage scaling and then there should
be some solution for having disabled drivers and hardware that is left in
enabled state by bootloader. That is not an easy problem to solve, so I'm
trying to start easy by getting some basics to work at first.

NVIDIA Tegra20 SoC's have a quite straight-forward voltage coupling between 3
regulators and the customized coupler is needed to address the missing
support of a full-featured system-wide DVFS, support for coupling of more than
2 regulators and support for a "min-spread" voltage. Probably it should be
possible to switch to a generic coupler later on, but for now it will be
much easier to start with a custom coupler that has all necessary features
in a simplified form.

NVIDIA Tegra30 SoC's have a bit more complicated coupling rules due to
variable dependency between the regulators (min-spread value depends on
a voltage of one of the coupled regulators).

This series has been tested on multiple devices by different people without
any known issues. CPUFreq voltage scaling works perfectly well with it and
voltage of peripherals is maintained at a good level. In a result thermal
sensors show that SoC package is a less warm by few degrees during of CPU
idling.

Changelog:

v2: The coupler's registration is now done in a more generic fashion and
    allow multiple couplers to be registered in a system.

    Added device-tree binding document for NVIDIA Tegra20/30 SoC's that
    describes hardware specifics of these SoC's in regards to regulators
    voltage coupling. In a result coupled regulators that are dedicated to
    SoC could be distinguished from each other, which in turns is also useful
    for the customized couplers implementation.

    The customized couplers got some more polish and now have a bit more
    stricter checkings for coupling rules violation.

The initial v1 of this series could be found here:

	https://lore.kernel.org/patchwork/project/lkml/list/?series=390439

This series, along with CPUFreq and other "in-progress" patches, could be
found here:

	https://github.com/grate-driver/linux/commits/master

Dmitry Osipenko (8):
  regulator: core: Introduce API for regulators coupling customization
  regulator: core: Parse max-spread value per regulator couple
  regulator: core: Expose some of core functions
  regulator: core Bump MAX_COUPLED to 3
  dt-bindings: regulator: Document regulators coupling of NVIDIA
    Tegra20/30 SoC's
  regulator: core: Don't attach generic coupler to Tegra SoC regulators
  soc/tegra: regulators: Add regulators coupler for Tegra20
  soc/tegra: regulators: Add regulators coupler for Tegra30

 .../nvidia,tegra-regulators-coupling.txt      |  65 ++++
 drivers/regulator/core.c                      | 143 +++++--
 drivers/regulator/of_regulator.c              |  49 ++-
 drivers/soc/tegra/Kconfig                     |  12 +
 drivers/soc/tegra/Makefile                    |   2 +
 drivers/soc/tegra/regulators-tegra20.c        | 348 ++++++++++++++++++
 drivers/soc/tegra/regulators-tegra30.c        | 300 +++++++++++++++
 include/linux/regulator/driver.h              |  46 ++-
 include/linux/regulator/machine.h             |   3 +-
 9 files changed, 916 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/nvidia,tegra-regulators-coupling.txt
 create mode 100644 drivers/soc/tegra/regulators-tegra20.c
 create mode 100644 drivers/soc/tegra/regulators-tegra30.c

-- 
2.21.0

