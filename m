Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2F8C2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 09:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D76206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 09:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQD5dm/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfLWJaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 04:30:09 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38926 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfLWJaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 04:30:08 -0500
Received: by mail-pj1-f65.google.com with SMTP id t101so7231398pjb.4;
        Mon, 23 Dec 2019 01:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E6Rxt5mTP6uQSUFNQdkev/Gx4HMwNUXESrGV3msFxjU=;
        b=AQD5dm/xrPHJRAbvT0ND3uDS924lgRAjufBAD0in06aCdKyS8PoMQlAgoLVTB5x9kq
         5WBUEtv7kOfWTCV8C6nVlEqNhJT8101sSqVa4T/jQdNR6qdrCL/t33h25ozeJNrzOFu9
         CmUJTvyhr2qFN54ImlAljnueIFqfztbOE8I9cF+4GTCYthxj7zBzCPfxNU94ZTi2iKI+
         0irJdkHqf6lppHTzYgptMkLnk1U1jL2uyrCoVmlM7tFW3/vdl/8GhvS8TvnOvCi3nKKP
         c6SH8LreWdQFnTZ1/UyB/uJCNlQKU6tfv+tAdOWjIxEQo1D42WGHq7468Ty13dVgUlNx
         QTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E6Rxt5mTP6uQSUFNQdkev/Gx4HMwNUXESrGV3msFxjU=;
        b=sWNbNA8q2+/VZWRp6RenTgO/33mwGMcbVhjR+7m0BPEfaPz214zmm5pPbObnVaBF6f
         uZ1HofmCeTb00R8Mo+hokxpM0kXzpnieqFueH2iFmMCryewq4DaXMECowPxI7EeKk6hw
         VwZpqaMZmZp4LXOMxF2oupcdxiEebSrMJgrJaAHvvbUpnhyMbaAa/BoGwIgSMVILo1+0
         VCWuhtIxwiOaTq7/XgHWONAbIcA6vzs1hD+7UO1Q63KULpwFq9tNPZYj9JixTCB6V7XJ
         8NPNkThG0pu4T7dDPDNCv1LqaJb9zWUkyDf+b6vurRUOaa6kEsyqJFuN0Eu4Fj+DRPKJ
         P4pg==
X-Gm-Message-State: APjAAAUXSqrOeIWaSNRtTpyp6r7NJ5bR3dkAr5AhYc1MkVT3TbpblQnn
        7Emtpkqn5E9hv7+tsIeFhhM=
X-Google-Smtp-Source: APXvYqyaaI7uOGrpKdqVEHRttrmOmOL34BXrpCBwgAATEruJifXFkHyfN+Sit9JuGuxyNXhDQH+s8w==
X-Received: by 2002:a17:902:265:: with SMTP id 92mr29128079plc.313.1577093407770;
        Mon, 23 Dec 2019 01:30:07 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id i127sm24625970pfc.55.2019.12.23.01.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 01:30:06 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v5 0/3] Add Unisoc's SC9863A support
Date:   Mon, 23 Dec 2019 17:29:45 +0800
Message-Id: <20191223092948.24824-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

SC9863A has Octa-core ARM Cortex A55 application processor. Find more
details about it on the website: http://www.unisoc.com/sc9863a

Changes from v4:
* Removed syscon nodes which should be added when used.
* Added Acked-by from Rob Herring.

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
 arch/arm64/boot/dts/sprd/sharkl3.dtsi         |  78 +++
 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts     |  39 ++
 6 files changed, 677 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/sprd/global-regs.yaml
 rename Documentation/devicetree/bindings/arm/{ => sprd}/sprd.yaml (92%)
 create mode 100644 arch/arm64/boot/dts/sprd/sc9863a.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/sharkl3.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts

-- 
2.20.1

