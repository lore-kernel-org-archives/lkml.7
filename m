Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FC9C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6C020684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuMy49No"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfCFQMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:12:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35014 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfCFQML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:12:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id j5so8979721pfa.2;
        Wed, 06 Mar 2019 08:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rwUk3uI8ypW71O/xZmIDWY3UgJWvUA2fe4eQVT1hRmk=;
        b=FuMy49NotC4VrQ0czfJAjc+Ud+6SGSMOvdDIu8d2GVnRc+ksKWoaEPgjKLhT3D9dPE
         u3VmO5iRSlYPFEFlmeWvx+LWdcLqcvqzWgYrTCfpzyAmXKOFizNfNK017zs3+oCfQdI+
         a8Mpj5AURJ5fw3iyGJamBGKDaC1X//VU7XZ0LdBrYn0YQCVzXuyHHoRoRO/7PnXWWSPC
         0gYIqIlfTFfU4ZGPlO1eZs8gOpd+VrUDxfCCEWSmCnLnIM/YyglFXSLE2ZWU+mR31Wq6
         NDjq/3noNw+3+fpVrGSp8kZzS7JWU9uJsQc84diAgzUb9wkqAwRkoOBnT4weF2z3YPu8
         /2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rwUk3uI8ypW71O/xZmIDWY3UgJWvUA2fe4eQVT1hRmk=;
        b=sZMocfbNyMFzsfFWW+sYe1n8jSxl4jWqUbkCvL+AvL5LcSFU0Q7Sm3qz5E9Pz6EMNX
         wY/f2bUKUYvv3BADwVXlVLC+rcKSXIOf8zCpFN0e5NtIyy3XSBgwJRJ52VfS8JaW/ac3
         KDIPTOlvbw2LZSZ+HePNx6vh0pALCSPnY/KUnQlexaFwQFvdKtfeu3Ba8QFsPplQHFaV
         v8+9DnlAat0MLf/pF3UFsaZ7Z3AxvWCsoFOHaK8+ZVf/0YfH834/LhxagFjXqBp4VTNj
         k0/1SmDcqsLU95UBgW7aYZPr5LAoxNKTwqqI2mbhBwfT3Cwsc4aBWk8yJuZGd0o2WqoP
         Nm4w==
X-Gm-Message-State: APjAAAViEM5WnUU3Fmx3dkNwfBAAKkncYKnxgov+W70Y9F2NFoHuIYBM
        AbxwaxNQC4ESyh7Tlo9mjjzaDS1I
X-Google-Smtp-Source: APXvYqxFnN9pYM1EGZGEIQH0oMuJRzvFy2i9Yy0gxJ/Lqn0jqZJywa8vNQb5QqljJQFMaDPsEooPdw==
X-Received: by 2002:a17:902:2884:: with SMTP id f4mr6995033plb.203.1551888730023;
        Wed, 06 Mar 2019 08:12:10 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id s6sm4875475pgm.90.2019.03.06.08.12.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 08:12:09 -0800 (PST)
Date:   Wed, 6 Mar 2019 08:12:09 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rui Zhang <rui.zhang@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Thermal-SoC management changes for v5.1-rc1
Message-ID: <20190306161207.GA7365@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please consider the following thermal soc changes for v5.1-rc1.

The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:

  Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus

for you to fetch changes up to 6269e9f790e8d442b3e1529bf3b3de452dd4ac92:

  thermal: rcar_gen3_thermal: Register hwmon sysfs interface (2019-02-20 17:23:40 -0800)

Kernel CI output:
Full Boot Summary: https://kernelci.org/boot/all/job/evalenti/branch/for-kernelci/kernel/v5.0-rc5-15-g6269e9f790e8/
Full Build Summary: https://kernelci.org/build/evalenti/branch/for-kernelci/kernel/v5.0-rc5-15-g6269e9f790e8/

Specifics:
- mediatek thermal now supports MT8183
- broadcom thermal now supports Stingray
- qoirq now supports multiple sensors
- fixes on different drivers: rcar, tsens, tegra

Some new drivers are still pending further review and I chose to leave them
for the next merge window while still sending this material.

BR,

----------------------------------------------------------------
Marek Vasut (1):
      thermal: rcar_gen3_thermal: Register hwmon sysfs interface

Michael Kao (7):
      thermal: mediatek: fix register index error
      thermal: mediatek: add common index of vts settings.
      thermal: mediatek: add calibration item
      thermal: mediatek: add thermal controller offset
      thermal: mediatek: add flag for bank selection
      dt-bindings: thermal: add binding document for mt8183 thermal controller
      thermal: mediatek: add support for MT8183

Peng Hao (1):
      thermal/qcom/tsens-common : fix possible object reference leak

Pramod Kumar (2):
      dt-bindings: thermal: Add binding document for SR thermal
      thermal: broadcom: Add Stingray thermal driver

Wei Ni (3):
      thermal: tegra: remove unnecessary warnings
      thermal: tegra: fix memory allocation
      thermal: tegra: add get_trend ops

Yuantian Tang (1):
      thermal: qoriq: add multiple sensors support

 .../bindings/thermal/brcm,sr-thermal.txt           | 105 +++++++
 .../bindings/thermal/mediatek-thermal.txt          |   1 +
 drivers/thermal/Kconfig                            |   3 +-
 drivers/thermal/broadcom/Kconfig                   |   9 +
 drivers/thermal/broadcom/Makefile                  |   1 +
 drivers/thermal/broadcom/sr-thermal.c              | 121 ++++++++
 drivers/thermal/mtk_thermal.c                      | 316 +++++++++++++++++----
 drivers/thermal/qcom/tsens-common.c                |  33 ++-
 drivers/thermal/qoriq_thermal.c                    | 104 +++----
 drivers/thermal/rcar_gen3_thermal.c                |  19 ++
 drivers/thermal/tegra/soctherm.c                   |  38 ++-
 11 files changed, 620 insertions(+), 130 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
 create mode 100644 drivers/thermal/broadcom/sr-thermal.c
