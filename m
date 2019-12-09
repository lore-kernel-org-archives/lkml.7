Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEE3C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7536320726
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6LUxwqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfLILpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:45:01 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32972 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfLILpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:45:01 -0500
Received: by mail-pg1-f193.google.com with SMTP id 6so7012843pgk.0;
        Mon, 09 Dec 2019 03:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IPlVvddAVkBLckSB5xQwsO5FlMrHgcla5wmGZLf2wA0=;
        b=O6LUxwqG2ZiFRETIdI+pR6KDi4khLs4++dVjnKtHH9f1Iz8ORTxeRv88a6K9grAx2d
         ZL9S2dF5SHg03oZFGIgJ+ofhfjDsb6r3UgKMwgtKyfQ1FAiLBFchgbu3SO0DKEflPtCz
         nZ0lpRPPLkTBiQVI4rb3sqvErbnzKL/jVTh40alilx2Z/6Fsqgy4x8mRL34Y42PneeyY
         tRBhlB5gqPAzNK8E3dqvTXoeSn+KgV9eQ2b23l73fCWBfp7DuiXF+vAa+iSP7xQ8h7l3
         qf7lhk97X2tC3Qmi2YNtAGCgj3Qw8eTkkZrrDOv50jhKDg27SHj6TDK98VkhVuW6jq/3
         AsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IPlVvddAVkBLckSB5xQwsO5FlMrHgcla5wmGZLf2wA0=;
        b=UDoRPx4LtR+YT3OqCb7p9c9QBQRvVbC5VpW0CFoytcHftQn+0nN1kfWpsaZCC0OxcM
         LlkYBCDfnPF0s+zwB0v1v1BWyqRoKmJzaLQlGFHy/1jwL4LM03MeJkB8T2wgxvBXNlJK
         o/p/bD4YyglQHFve4NnttQ72h+L81icjib98uEO0YoQphKgYKLLXSQ5QaUyBDWqk4OWe
         OQJcq2dGNLqsRoO9SLVDw5zpzFReHXHv6lzqrF0GRhx+qGA51FRCbzfoE5W0W5OEsvez
         i9oGIVi7FKKbvVyJzGFKdc5gzGJqTHoFoNhDRL7uUmj064LSAaJ06ga9tPLijzIePcfX
         HTVg==
X-Gm-Message-State: APjAAAVHQQJhuhFxzUsXSz9tH66am+N0Rt5vZFj77NbbCOB2EnRLmmlt
        kQh8Br99xe6tD96zueMZgBEvdA7x
X-Google-Smtp-Source: APXvYqyOvhZf0WvxvjusSfLsbdBKS5NIkM7Dlh2IsBYF7/Ve9lehAruLioZ4qFv7hQpDyW18O/ZdqA==
X-Received: by 2002:aa7:9f94:: with SMTP id z20mr23171842pfr.111.1575891900131;
        Mon, 09 Dec 2019 03:45:00 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c8sm27805289pfj.106.2019.12.09.03.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 03:44:59 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH v4 0/3] Add Unisoc's SC9863A support
Date:   Mon,  9 Dec 2019 19:44:01 +0800
Message-Id: <20191209114404.22483-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SC9863A has Octa-core ARM Cortex A55 application processor. Find more
details about it on the website: http://www.unisoc.com/sc9863a

Changes from v3:
* Rebased on v5.5-rc1;
* Fix the cpu-map to put all cpus into the single cluster;
* Fixed a bindings error.

Changes from v2:
* Discard some dt-bindings patches which have been applied by Rob Herring.
* Added a new dt-binding file for sprd global-regs, also added a vendor directory for sprd.
* Moved sprd.yaml to the vendor directory.
* Addressed comments from Rob:
- fixed dtbs_check errors;
- move gic under to the bus node;
- removed msi-controller from gic, sinceSC9863A doesn't provide ITS;
- added specific compatible string for syscon nodes;
- cut down registers range of syscon nodes;
- removed unnecessary property "sprd,sc-id";
- added earlycon support in devicetree.

Changes from v1: 
- Convert DT bindings to json-schema.

Chunyan Zhang (3):
  dt-bindings: arm: sprd: add global registers bindings
  dt-bindings: arm: move sprd board file to vendor directory
  arm64: dts: Add Unisoc's SC9863A SoC support

 .../bindings/arm/sprd/global-regs.yaml        |  34 ++
 .../bindings/arm/{ => sprd}/sprd.yaml         |   2 +-
 arch/arm64/boot/dts/sprd/Makefile             |   3 +-
 arch/arm64/boot/dts/sprd/sc9863a.dtsi         | 523 ++++++++++++++++++
 arch/arm64/boot/dts/sprd/sharkl3.dtsi         | 148 +++++
 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts     |  39 ++
 6 files changed, 747 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/sprd/global-regs.yaml
 rename Documentation/devicetree/bindings/arm/{ => sprd}/sprd.yaml (92%)
 create mode 100644 arch/arm64/boot/dts/sprd/sc9863a.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/sharkl3.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts

-- 
2.20.1

