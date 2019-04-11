Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F0DC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F262082E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eXbjzF+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfDKInA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:43:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40827 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfDKInA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:43:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so3070156plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 01:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hw5qdrAr+Kv7cDjy4/CIwJXkovlyibz0/pjwMu26vkg=;
        b=eXbjzF+GSM9ixQ+JHw51zbNK3ONlZsfL5tdVaAqWEm+GlVdA5X3Rc5ms/k507LZJAo
         evtgOr42DlMhQQ4p09iYuZjkrj8sXtja6gV7mGFl8hJSAskouM4d4qX9cukdT+5LamTw
         MxLzBjI6Op20PPU1STt5QQ4R4r/VLizLNx0kpr1DQkujrHh9Ga8qh9LCNScKRGg73h3Y
         B0B4ydL+LIgGbC4dp0EOGOIZ6+9oTh+e+r8WDU/Ti5hLqyy2vrLarbGdVzI8hcm+fGPl
         ACnpNFt4D0XZwKS8YlRNYZ7KCFPRMqJGMT40TWzFe03bGmlq4kYZwrIsNq8iXsN+3BSK
         OdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hw5qdrAr+Kv7cDjy4/CIwJXkovlyibz0/pjwMu26vkg=;
        b=gk0UbM3hIArTUg1RDY67M2vmWXgfayHvoSEtEPhd36yI3EQN7EdKVo/PxhRyTO4xo7
         0gEmjAN0WnNBKTv/AUXwgaQBHV3q49bdpy9gSP70hV8om9W/oJ6gB2vI5WTo/mpqX5nw
         vZd7bBMSDm9LI/tkgKpya0fTXRg6/IE1iZ9aFA4woZtO/oaJJaAgZ4bJziKjp/Dlqzax
         t+SwndpEUnMqXNbhpEBoxA5/hHlRpQAQH2Z9ZemagtHlvHe6pTemxJdwt2aGwCwkFCe7
         xhJRruw8xSd+prymolqXlZJLKdFxagbtWyn4h30gS3n5Uwjk+dVQzeS9BZ45Oifcdw8E
         DP6A==
X-Gm-Message-State: APjAAAWQpIvmCoXSXZMd+z0nIXIIUVQIbGwVt3GCcjjph9Pi6+XI25zS
        KppSQU7cmpJanOXwwBDY+RkI5OdiT0o=
X-Google-Smtp-Source: APXvYqwmMljoQ+JYSiHg0hE4ueiZqAmq4zr9cwazrci1v8vuz3pOAMxKXmalha6pw0pfh6EWLOAp/g==
X-Received: by 2002:a17:902:7b96:: with SMTP id w22mr49206547pll.28.1554972179330;
        Thu, 11 Apr 2019 01:42:59 -0700 (PDT)
Received: from viisi.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id q10sm46514745pgh.93.2019.04.11.01.42.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 01:42:58 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v2 0/6] arch: riscv: add board and SoC DT file support
Date:   Thu, 11 Apr 2019 01:42:37 -0700
Message-Id: <20190411084242.4999-1-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for building flattened DT files from DT source files under
arch/riscv/boot/dts.  Follow existing kernel precedent from other SoC
architectures.  Start our board support by adding initial support for
the SiFive FU540 SoC and the first development board that uses it, the
SiFive HiFive Unleashed A00.

This second version of the patch set fixes several errors in the
original patch set, switches to an initial YAML-based description for CPU,
board SoC selection, and incorporates feedback from Rob Herring
<robh@kernel.org>.

Rob: it would be helpful if you could take a look at the YAML files to
make sure I'm not doing anything explicitly broken; I'm pretty naive
about the new YAML json-schema format.  The patches here are meant to
be starting points which will undoubtedly be refined later.  Similarly
we'll plan to convert our IP block binding documentation to the YAML
format over time as we develop more experience with it.

Boot-tested on v5.1-rc4 on a HiFive Unleashed A00 board, using the
BBL and open-source FSBL, with modifications to pass in the DTB
file generated by these patches.

This patch series can be found, along with the PRCI patch set
and the DT macro prerequisite patch, at:

https://github.com/sifive/riscv-linux/tree/dev/paulw/dts-v5.1-rc4


- Paul


Paul Walmsley (6):
  arch: riscv: add support for building DTB files from DT source data
  dt-bindings: riscv: sifive: add YAML documentation for the SiFive
    FU540
  dt-bindings: riscv: convert cpu binding to json-schema
  riscv: dts: add initial support for the SiFive FU540-C000 SoC
  riscv: dts: add initial board data for the SiFive HiFive Unleashed
  riscv: defconfig: enable ARCH_SIFIVE

 .../devicetree/bindings/riscv/cpus.yaml       | 274 ++++++++++++++++++
 .../devicetree/bindings/riscv/sifive.yaml     |  26 ++
 MAINTAINERS                                   |   9 +
 arch/riscv/Kconfig                            |   2 +
 arch/riscv/Kconfig.platforms                  |   8 +
 arch/riscv/boot/dts/Makefile                  |   2 +
 arch/riscv/boot/dts/sifive/Makefile           |   2 +
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi    | 207 +++++++++++++
 .../dts/sifive/hifive-unleashed-a00-fu540.dts |  69 +++++
 arch/riscv/configs/defconfig                  |   1 +
 10 files changed, 600 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/cpus.yaml
 create mode 100644 Documentation/devicetree/bindings/riscv/sifive.yaml
 create mode 100644 arch/riscv/Kconfig.platforms
 create mode 100644 arch/riscv/boot/dts/Makefile
 create mode 100644 arch/riscv/boot/dts/sifive/Makefile
 create mode 100644 arch/riscv/boot/dts/sifive/fu540-c000.dtsi
 create mode 100644 arch/riscv/boot/dts/sifive/hifive-unleashed-a00-fu540.dts

-- 
2.20.1

